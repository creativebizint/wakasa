<?php

namespace App\Http\Controllers\Api;

use App\Classes\Common;
use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\Sales\IndexRequest;
use App\Http\Requests\Api\Sales\StoreRequest;
use App\Http\Requests\Api\Sales\UpdateRequest;
use App\Http\Requests\Api\Sales\DeleteRequest;
use App\Models\Customer;
use App\Models\FrontWebsiteSettings;
use App\Models\Product;
use App\Models\ProductDetails;
use App\Models\Order;
use App\Models\User;
use App\Models\UserDetails;
use App\Models\Warehouse;
use App\Models\Store;
use App\Models\PickingAssignment;
use App\Models\PickingAssignmentItem;
use Examyou\RestAPI\ApiResponse;
use Examyou\RestAPI\Exceptions\ApiException;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use App\Imports\StockInImport;
use App\Imports\StockOutImport;
use App\Models\OrderItem;
use Maatwebsite\Excel\Facades\Excel;
use App\Http\Requests\Api\ProductPlacement\ImportRequest;
use App\Exports\ExcelExport;
use Illuminate\Support\Facades\Cache;
use Illuminate\Http\Request;
use PDF;
use PHPExcel_Style_Fill;
use App\Http\Requests\Api\Sales\IndexItemRequest;
use App\Http\Requests\Api\Sales\QcPickingRequest;
use Session;

class pickingAssignmentController extends ApiBaseController
{
    protected $model = PickingAssignment::class;

    protected $indexRequest = IndexRequest::class;
    protected $storeRequest = StoreRequest::class;
    protected $updateRequest = UpdateRequest::class;
    protected $deleteRequest = DeleteRequest::class;

    
    public function modifyIndex($query)
    {
        $request = request();
    
        $query = $query->with('items')
                        ->join('users', 'users.id', '=', 'picking_assignment.user_id')
                        ->select('picking_assignment.*','users.name');
        $this->modifySelect = true;
        return $query;
    }
    
    public function save(Request $request){
        $user_id = $this->getIdFromHash($request->user_id);
        $pa_code = Common::getTransactionNumber('picking-assignment');
        
        $picking_assignment = new PickingAssignment();
        $picking_assignment->user_id = $user_id;
        $picking_assignment->code = $pa_code;
        $picking_assignment->save();
        
        foreach($request->selected_ids as $order_id){
            $picking_assignment_item = new PickingAssignmentItem();
            $picking_assignment_item->picking_assignment_id  = $picking_assignment->id;
            $picking_assignment_item->order_item_id = $this->getIdFromHash($order_id);
            $order_item = OrderItem::where('order_items.id',$this->getIdFromHash($order_id))
                          ->join('orders','orders.id','=','order_items.order_id')
                          ->select('product_id','quantity','orders.invoice_number')
                          ->first();
            $picking_assignment_item->invoice_number = $order_item->invoice_number;
            $picking_assignment_item->product_id = $order_item->product_id;
            $picking_assignment_item->qty = $order_item->quantity;
            $picking_assignment_item->save();
            
            OrderItem::where('order_items.id',$this->getIdFromHash($order_id))->update(['picker_by' => $user_id]);
        }
        
        
         return ApiResponse::make('Picking Assignment In successfull', [
                'unique_id' => $picking_assignment->id, 
                'code' => $picking_assignment->$pa_code, 
            ]);
    }
    
    public function pickingAssignmentExport(){
        $request = request();
        $type = isset($request->type) ? $request->type : '';
        $code = isset($request->code) ? $request->code : '';
        $view_name = 'picking-assignment';
        $datetime_filename_format = 'Ymd';
        $download_name = $view_name.'-'.date($datetime_filename_format);
        $pickingAssignment = PickingAssignment::where('picking_assignment.code',$code)
                    ->join('users','users.id','=','picking_assignment.user_id')
                    ->select('picking_assignment.*','users.name')
                    ->first();
         $pdf_data = [
           'pickingAssignment' => $pickingAssignment
         ];
        if($type == 'pdf'){
            $pdf = PDF::setOptions(['isHtml5ParserEnabled' => true, 'isRemoteEnabled' => true])
            ->setPaper('a4', 'landscape')
            ->loadView('pdf.'.$view_name, array_merge($pdf_data, ['print' => false]));

            return $pdf->download($download_name . '.pdf');
        }
    }
    public function qcPickingExport(){
        $request = request();
        $type = isset($request->type) ? $request->type : '';
        $code = isset($request->code) ? $request->code : '';
        $view_name = 'qc-picking';
        $datetime_filename_format = 'Ymd';
        $download_name = $view_name.'-'.date($datetime_filename_format);
        $order = Order::where('orders.invoice_number',$code)
                ->leftJoin('users','users.id','=','orders.user_id')
                ->select('order_date','invoice_number','users.name as user_name','orders.order_status','orders.id')
                ->first();
        $order_items = OrderItem::where('order_items.order_id',$order->id)
                    ->join('products','products.id','=','order_items.product_id')
                    ->select('products.item_id','picker_by_name','quantity','quantity_scanned')
                    ->get();
        
        foreach($order_items as $k => $order_items_){
            if($order_items_->picker_by_name != ''){
                $order_items[$k]->picker_by_name = json_decode($order_items_->picker_by_name);
                $order_items[$k]->picker_by_name = implode(',',$order_items[$k]->picker_by_name);
            }
        }
        
         $pdf_data = [
           'qcPicking' => $order,
           'items' => $order_items
         ];
        if($type == 'pdf'){
            $pdf = PDF::setOptions(['isHtml5ParserEnabled' => true, 'isRemoteEnabled' => true])
            ->setPaper('a4', 'landscape')
            ->loadView('pdf.'.$view_name, array_merge($pdf_data, ['print' => false]));

            return $pdf->download($download_name . '.pdf');
        }
    }
    
    public function indexItem(IndexItemRequest $request)
    {
        $order_id = $this->getIdFromHash($request->order_id);
        
        $query = \App\Models\OrderItem::join('orders','orders.id','=','order_items.order_id')
                ->join('products','products.id','=','order_items.product_id')
                ->leftJoin('warehouses','warehouses.id','=','orders.warehouse_id')
                ->leftJoin('users','users.id','=','orders.user_id')
                ->where('orders.id', $order_id)
                ->where('order_type', 'sales_order')
                ->select('orders.invoice_number','orders.order_date as date','products.item_id','order_items.quantity_scanned','order_items.quantity',
                        'orders.warehouse_id','warehouses.code as warehouse_code','warehouses.name as warehouse_name','orders.user_id','users.name as user_name',
                        'users.code as user_code','order_items.product_id','order_items.id')
                ->orderBy('orders.id','desc');
        
        if ($request->has('item_id')) {
            $query->where('products.item_id','like','%'.$request->item_id.'%');
        }
        
        if ($request->has('user_id')) {
            $query->where('orders.user_id','=',$this->getIdFromHash($request->user_id));
        }
        if ($request->has('dates')) {
            $date_arr = explode(',',$request->dates);
            $query->whereBetween('orders.order_date',$date_arr);
        }
        
        $total = $query->count();
        // Apply pagination
        $offset = $request->input('offset', 0);
        $limit = $request->input('limit', 10);

        $result = $query->skip($offset)->take($limit)->get();
        $next = (($offset+1)*$limit);
        $next_url = url()->current().'?offset='.$next;
        $previous = (($offset-1)*$limit);
        $previous_url = url()->current().'?offset='.$previous;
        if($previous <=0){
            $link = ['next' => $next_url];
        }
        else{
            $link = ['next' => $next_url,'previous' => $previous_url];
        }
        
        return [
            'data' => $result,
            'meta' => ['paging'=>['links'=>$link,'total' => $total]]
        ];
    }
    
    public function qcPicking(QcPickingRequest $request)
    {
        $invoice_number = $request->invoice_number;
        
        $query = \App\Models\Order::join('warehouses','warehouses.id','=','orders.warehouse_id')
                ->leftJoin('users','users.id','=','orders.user_id')
                ->where('order_type', 'sales_order')
                ->where('order_status', 'picking')
                ->select('orders.invoice_number','orders.order_date as date','orders.id',
                        'orders.warehouse_id','warehouses.code as warehouse_code','warehouses.name as warehouse_name','orders.user_id','users.name as user_name',
                        'users.code as user_code','orders.order_status')
                ->orderBy('orders.id','desc');
        
        if ($request->has('invoice_number')) {
            $query->where('orders.invoice_number','like','%'.$invoice_number.'%');
        }
        
        if ($request->has('item_id')) {
            $query->where('products.item_id','like','%'.$request->item_id.'%');
        }
        
        if ($request->has('user_id')) {
            $query->where('orders.user_id','=',$this->getIdFromHash($request->user_id));
        }
        if ($request->has('dates')) {
            $date_arr = explode(',',$request->dates);
            $query->whereBetween('orders.order_date',$date_arr);
        }
        
        $total = $query->count();
        // Apply pagination
        $offset = $request->input('offset', 0);
        $limit = $request->input('limit', 10);

        $result = $query->skip($offset)->take($limit)->get();
        $next = (($offset+1)*$limit);
        $next_url = url()->current().'?offset='.$next;
        $previous = (($offset-1)*$limit);
        $previous_url = url()->current().'?offset='.$previous;
        if($previous <=0){
            $link = ['next' => $next_url];
        }
        else{
            $link = ['next' => $next_url,'previous' => $previous_url];
        }
        
        foreach($result as $k=>$result_){
            $result[$k]->items = OrderItem::where('order_id',$result_->id)
                                ->join('products','products.id','order_items.product_id')
                                ->select('products.item_id','order_items.quantity_scanned','order_items.quantity','order_items.picker_by_name','order_items.id')
                                ->get();
        }
        
        return [
            'data' => $result,
            'meta' => ['paging'=>['links'=>$link,'total' => $total]]
        ];
    }
    
    public function assignPicking(Request $request){
        $data  = $request->all();
        
        $order_item_ids = $request->item_ids;
        $order_id = $this->getIdFromHash($request->order_id);
        $user = Session::get('user');
        $user_id = $this->getIdFromHash($user['xid']); 
        $name = $user['name']; 
        $order_item_ids_real = [];
        foreach($order_item_ids as $item_id){
            $order_item_id = $this->getIdFromHash($item_id);
            $order_item_ids_real[] = $order_item_id;
            $order_item = OrderItem::where('id',$order_item_id)->first();
            
            $picker_by = json_decode($order_item->picker_by,1);
            if($picker_by != '' && !in_array($user['id'],$picker_by)){
                $picker_by[] = $user['id'];
            }
            else{
                $picker_by = array($user['id']);
            }
            
            $picker_by_name = json_decode($order_item->picker_by_name,1);
            if($picker_by_name != '' && !in_array($user['name'],$picker_by_name)){
                $picker_by_name[] = $user['name'];
            }
            else{
                $picker_by_name = array($user['name']);
            }
             
            OrderItem::where('id',$order_item_id)->update(['picker_by'=> json_encode($picker_by),'picker_by_name'=>json_encode($picker_by_name)]);
        }
        Order::where('id',$order_id)->update(['order_status'=>'picking']);
        
        return $order_item_ids_real;
    }
    
    public function assignPickingAll(Request $request){
        $data  = $request->all();
        $order_id = $this->getIdFromHash($data['order_id']);
        $user = Session::get('user');
        $user_id = $this->getIdFromHash($user['xid']); 
        $name = $user['name'];
        
        $order_items = OrderItem::where('order_id', $order_id)->get();
        foreach($order_items as $order_item){
            $picker_by = json_decode($order_item->picker_by,1);
            if($picker_by != '' && !in_array($user['id'],$picker_by)){
                $picker_by[] = $user['id'];
            }
            else{
                $picker_by = array($user['id']);
            }
            
            $picker_by_name = json_decode($order_item->picker_by_name,1);
            if($picker_by_name != '' && !in_array($user['name'],$picker_by_name)){
                $picker_by_name[] = $user['name'];
            }
            else{
                $picker_by_name = array($user['name']);
            }
             
            OrderItem::where('id',$order_item->id)->update(['picker_by'=> json_encode($picker_by),'picker_by_name'=>json_encode($picker_by_name)]);
        }
        
        Order::where('id',$order_id)->update(['order_status'=>'picking']);
        
        return $order_id;
    }
    
    public function unassignPicking(Request $request){
        $data  = $request->all();
        
        $order_item_ids = $request->item_ids;
        $order_id = $request->order_id;
        $user = Session::get('user');
        $user_id = $this->getIdFromHash($user['xid']); 
        $name = $user['name']; 
        foreach($order_item_ids as $item_id){
            $order_id = $this->getIdFromHash($item_id);
            $order_item = OrderItem::where('id',$order_id)->first();
            
            $picker_by = json_decode($order_item->picker_by,1) ?? [];
            if(in_array($user['id'],$picker_by)){
                 $picker_by = array_values(array_diff($picker_by, [$user['id']]));
            }
            
            $picker_by_name = json_decode($order_item->picker_by_name,1) ?? [];
            if(in_array($user['name'],$picker_by_name)){
                $picker_by_name[] =  $picker_by = array_values(array_diff($picker_by_name, [$user['name']]));
            }
             
            OrderItem::where('id',$order_id)->update(['picker_by'=> json_encode($picker_by),'picker_by_name'=>json_encode($picker_by_name)]);
        }
        
        
        return $user;
    }
    
}
