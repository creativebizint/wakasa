<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\Purchase\IndexRequest;
use App\Http\Requests\Api\Purchase\StoreRequest;
use App\Http\Requests\Api\Purchase\UpdateRequest;
use App\Http\Requests\Api\Purchase\DeleteRequest;
use App\Http\Requests\Api\Purchase\IndexPlacementInItemRequest;
use App\Http\Requests\Api\Purchase\IndexPlacementOutItemRequest;
use App\Models\Order;
use App\Traits\OrderTraits;
use Session;

class PurchaseController extends ApiBaseController
{
	use OrderTraits;

	protected $model = Order::class;

	protected $indexRequest = IndexRequest::class;
	protected $storeRequest = StoreRequest::class;
	protected $updateRequest = UpdateRequest::class;
	protected $deleteRequest = DeleteRequest::class;

	public function __construct()
	{
		parent::__construct();

		$this->orderType = "purchases";
	}
        
    public function indexPlacementInItem(IndexPlacementInItemRequest $request)
    {

        $query = \App\Models\OrderItem::join('orders','orders.id','=','order_items.order_id')
                ->join('products','products.id','=','order_items.product_id')
                ->leftJoin('warehouses','warehouses.id','=','orders.warehouse_id')
                ->leftJoin('users','users.id','=','orders.user_id')
                ->where('order_type', 'purchases')
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
    
    public function indexPlacementOutItem(IndexPlacementOutItemRequest $request)
    {
        $user = Session::get('user');
        $user_id = $this->getIdFromHash($user['xid']); 
        $name = $user['name'];
        
        $query = \App\Models\OrderItem::join('orders','orders.id','=','order_items.order_id')
                ->join('products','products.id','=','order_items.product_id')
                ->leftJoin('warehouses','warehouses.id','=','orders.warehouse_id')
                ->leftJoin('users','users.id','=','orders.user_id')
                ->where('order_type', 'sales_order')
                ->whereRaw("JSON_CONTAINS(CAST(picker_by AS JSON), ?, '$')", [json_encode((int) $user_id)])
                ->select('orders.invoice_number','orders.order_date as date','products.item_id','order_items.quantity_scanned','order_items.quantity','orders.priority',
                        'orders.warehouse_id','warehouses.code as warehouse_code','warehouses.name as warehouse_name','orders.user_id','users.name as user_name',
                        'users.code as user_code','order_items.product_id','order_items.id','order_items.picker_by','order_items.picker_by_name','products.text2');
        
        if ($request->has('item_id')) {
            $query->where('products.item_id','like','%'.$request->item_id.'%');
        }
        if ($request->has('priority') && $request->priority == 0) {
            $query->where(function ($query) {
                 $query->whereNotIn('orders.priority',['segera','pesawat','ditunggu']);
             });
        }
        elseif ($request->has('priority') && $request->priority == 1) {
            $query->where(function ($query) {
                 $query->whereIn('orders.priority',['segera','pesawat','ditunggu']);
             });
        }
        
        if ($request->has('user_id')) {
            $query->where('orders.user_id','=',$this->getIdFromHash($request->user_id));
        }
        if ($request->has('dates')) {
            $date_arr = explode(',',$request->dates);
            $query->whereBetween('orders.order_date',$date_arr);
        }
        
        if($request->has('priority')){
            $query->orderBy('priority','desc');
        }
        else{
            $query->orderBy('orders.id','desc');
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
        
        foreach($result as $i => $result_data){
            if($result_data['picker_by_name'] != ''){
                $picker_by_name = implode(',',json_decode($result_data['picker_by_name'],1));
                $result[$i]->picker_by_name = $picker_by_name;
            }
            
        }
        
        return [
            'data' => $result,
            'meta' => ['paging'=>['links'=>$link,'total' => $total]]
        ];
    }
    
    function updateWeight(IndexPlacementOutItemRequest $request){
        $order_id = $this->getIdFromHash($request->order_id);
        Order::where('id',$order_id)->update(['weight' => $request->weight]);
        $order = Order::where('id',$order_id)->first();
        return [
            'data' => $order,
            'order_id'=> $order_id,
        ];
    }
        
}
