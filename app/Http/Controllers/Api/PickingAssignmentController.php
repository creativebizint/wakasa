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
}
