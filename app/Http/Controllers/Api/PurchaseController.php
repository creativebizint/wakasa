<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\Purchase\IndexRequest;
use App\Http\Requests\Api\Purchase\StoreRequest;
use App\Http\Requests\Api\Purchase\UpdateRequest;
use App\Http\Requests\Api\Purchase\DeleteRequest;
use App\Http\Requests\Api\Purchase\IndexPlacementInItemRequest;
use App\Models\Order;
use App\Traits\OrderTraits;

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
        $query = Order::query()
            ->where('order_type', 'purchases')
            ->with([
                'items' => function ($query) {
                    $query->select(
                        'id',
                        'order_id',
                        'product_id',
                        'quantity',
                        'quantity_scanned' // Assuming this field exists; adjust if necessary
                    );
                },
                'items.product' => function ($query) {
                    $query->select('id', 'item_id', 'name');
                },
                'user' => function ($query) {
                    $query->select('id', 'name');
                }
            ])
            ->select(
                'id',
                'invoice_number',
                'order_date'
            );

        // Apply sorting
        if ($request->has('order')) {
            $orderParts = explode(' ', $request->input('order'));
            $query->orderBy($orderParts[0], $orderParts[1]);
        } else {
            $query->orderBy('id', 'desc');
        }

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
        
}
