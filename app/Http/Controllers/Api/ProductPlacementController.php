<?php

namespace App\Http\Controllers\Api;

use App\Classes\Common;
use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\ProductPlacement\IndexRequest;
use App\Http\Requests\Api\ProductPlacement\StoreRequest;
use App\Http\Requests\Api\ProductPlacement\UpdateRequest;
use App\Http\Requests\Api\ProductPlacement\DeleteRequest;
use App\Http\Requests\Api\ProductPlacement\UpdateOnlineStoreStatusRequest;
use App\Models\Customer;
use App\Models\FrontWebsiteSettings;
use App\Models\Product;
use App\Models\ProductDetails;
use App\Models\ProductPlacementFloor;
use App\Models\ProductPlacementRow;
use App\Models\ProductPlacementShelfNumber;
use App\Models\ProductPlacementShelfGroup;
use App\Models\User;
use App\Models\UserDetails;
use App\Models\Warehouse;
use App\Models\ProductPlacement;
use App\Models\Store;
use App\Models\Placement;
use App\Models\PlacementItem;
use Examyou\RestAPI\ApiResponse;
use Examyou\RestAPI\Exceptions\ApiException;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use App\Imports\StockInImport;
use App\Imports\StockOutImport;
use Maatwebsite\Excel\Facades\Excel;
use App\Http\Requests\Api\ProductPlacement\ImportRequest;
use App\Exports\ExcelExport;
use Illuminate\Support\Facades\Cache;

class ProductPlacementController extends ApiBaseController
{
    protected $model = ProductPlacement::class;

    protected $indexRequest = IndexRequest::class;
    protected $storeRequest = StoreRequest::class;
    protected $updateRequest = UpdateRequest::class;
    protected $deleteRequest = DeleteRequest::class;

    
    public function modifyIndex($query)
    {
        $request = request();
    
        if(isset($request->type) && $request->type == 'summary'){
            $query = $query->join('products', 'products.id', '=', 'product_placements.product_id')
                        ->join('product_placement_floor','product_placement_floor.id','=','product_placements.floor')
                        ->join('product_placement_row','product_placement_row.id','=','product_placements.row')
                        ->join('product_placement_shelf_group','product_placement_shelf_group.id','=','product_placements.shelf_group')
                        ->join('product_placement_shelf_number','product_placement_shelf_number.id','=','product_placements.shelf_number')
                        ->leftJoin('brands','brands.id','products.brand_id')
                        ->select('product_placements.id','product_placement_floor.value as floor','product_placement_shelf_group.value as shelf_group',
                                'product_placement_shelf_number.value as shelf_number','product_placement_row.value as row','product_placements.product_id', 
                                'product_placements.warehouse_id', 'brands.name as brand_name', 'products.item_id',
                                'products.item_code',DB::raw('count(*) as total'));
            if(isset($request->start_date) && isset($request->end_date) && $request->start_date != '' && $request->end_date != ''){
              $query->whereBetween('product_placements.created_at',[$request->start_date,$request->end_date]);
            }

            $query = $query->groupBy('product_placement_floor.value','product_placement_shelf_group.value',
                                    'product_placement_shelf_number.value','product_placement_row.value','product_placements.product_id', 
                                    'product_placements.warehouse_id', 'brands.name', 'products.item_id',
                                    'products.item_code');
        }
        else{
            $query = $query->join('products', 'products.id', '=', 'product_placements.product_id')
                        ->join('product_placement_floor','product_placement_floor.id','=','product_placements.floor')
                        ->join('product_placement_row','product_placement_row.id','=','product_placements.row')
                        ->join('product_placement_shelf_group','product_placement_shelf_group.id','=','product_placements.shelf_group')
                        ->join('product_placement_shelf_number','product_placement_shelf_number.id','=','product_placements.shelf_number')
                        ->leftJoin('brands','brands.id','products.brand_id')
                        ->select('product_placements.id','product_placement_floor.value as floor','product_placement_shelf_group.value as shelf_group',
                                'product_placement_shelf_number.value as shelf_number','product_placement_row.value as row','product_placements.product_id', 
                                'product_placements.warehouse_id', 'brands.name as brand_name', 'products.item_id',
                                'products.item_code');
            if(isset($request->start_date) && isset($request->end_date) && $request->start_date != '' && $request->end_date != ''){
              $query->whereBetween('product_placements.created_at',[$request->start_date,$request->end_date]);
            }
        }
                
        $query = $query->orderBy('products.name','ASC'); 
        $this->modifySelect = true;
        return $query;
    }
    
    public function save(){
        $request = request();
        $loggedInUser = user();
        $warehouse = warehouse();

        $obj = $request->all();
        $rules = [
          'shelf_group'=>'required',
          'shelf_number'=> 'required',
          'row'=> 'required',
          'floor'=> 'required',
          'warehouse_id'=> 'required',
        ];
        $validator = Validator::make($obj, $rules);
        if($validator->fails()) {
          throw new ApiException($validator->errors()->first());
        }
    
        $product_items = $request->product_items;
        $company = company();
        
        DB::beginTransaction();
        try{
            $placement = new Placement();
            $placement->company_id = $company->id;
            $placement->invoice_number = '';
            $placement->unique_id = Common::generateOrderUniqueId();
            $placement->invoice_type = "product-placement";
            $placement->placement_type = "in";
            $placement->placement_date = Carbon::now();
            $placement->warehouse_id = $obj['warehouse_id'];
            $placement->notes = $obj['notes'];
            $placement->staff_user_id = $loggedInUser->id;
            $placement->user_id = $loggedInUser->id;
            $placement->total_items = $obj['total_items'];
            $placement->total_quantity = 0;
            $placement->save();

            $type = 'product-placement-in';
            $placement->invoice_number = Common::getTransactionNumber($type);
            $placement->save();
            $total_qty = 0;
            foreach($product_items as $product_item){
                $placement_item = new PlacementItem();
                $placement_item->user_id = $loggedInUser->id;
                $placement_item->placement_id = $placement->id;
                $placement_item->product_id = $this->getIdFromHash($product_item['xid']);
                $placement_item->unit_id = $this->getIdFromHash($product_item['x_unit_id']);
                $placement_item->floor = $this->getIdFromHash($obj['floor']);
                $placement_item->shelf_group = $this->getIdFromHash($obj['shelf_group']);
                $placement_item->shelf_number = $this->getIdFromHash($obj['shelf_number']);
                $placement_item->row = $this->getIdFromHash($obj['row']);
                $placement_item->qty = $product_item['quantity'];
                $placement_item->save();
                
                $total_qty += $product_item['quantity'];
                
                for($i = 1; $i<=$product_item['quantity'];$i++){
                    $product_placement = new ProductPlacement();
                    $product_placement->user_id = $loggedInUser->id;
                    $product_placement->placement_id = $placement->id;
                    $product_placement->product_id = $this->getIdFromHash($product_item['xid']);
                    $product_placement->unit_id = $this->getIdFromHash($product_item['x_unit_id']);
                    $product_placement->floor = $this->getIdFromHash($obj['floor']);
                    $product_placement->shelf_group = $this->getIdFromHash($obj['shelf_group']);
                    $product_placement->shelf_number = $this->getIdFromHash($obj['shelf_number']);
                    $product_placement->row = $this->getIdFromHash($obj['row']);
                    $product_placement->warehouse_id = $obj['warehouse_id'];
                    $product_placement->save();
                }
                
                
            }

            $placement->total_quantity = $total_qty;
            $placement->save();
        } catch (\Exception $e) {
            DB::rollback();
            throw new ApiException($e->getMessage());
        }
            
         DB::commit();   
        
         return ApiResponse::make('Product Placement In successfull', [
                'unique_id' => $placement->unique_id 
            ]);
    }
    
    public function out(){
        $request = request();
        $loggedInUser = user();
        $warehouse = warehouse();

        $obj = $request->all();
        $product_items = $request->product_items;
        $company = company();
        
        DB::beginTransaction();
          $items = [];
          $total_items = $total_quantity = 0;
          foreach($product_items as $product_item){
            if(isset($items[$product_item['product']['xid'].'-'.$product_item['floor'].'-'.$product_item['shelf_group'].'-'.$product_item['shelf_number'].'-'.$product_item['row']])){
              $items[$product_item['product']['xid'].'-'.$product_item['floor'].'-'.$product_item['shelf_group'].'-'.$product_item['shelf_number'].'-'.$product_item['row']]['qty'] += 1;
            }
            else{
              $items[$product_item['product']['xid'].'-'.$product_item['floor'].'-'.$product_item['shelf_group'].'-'.$product_item['shelf_number'].'-'.$product_item['row']] = $product_item;
              $items[$product_item['product']['xid'].'-'.$product_item['floor'].'-'.$product_item['shelf_group'].'-'.$product_item['shelf_number'].'-'.$product_item['row']]['qty'] = 1;
              $total_items += 1; 
            }
            $total_quantity += 1;
          }
          
            $placement = new Placement();
            $placement->company_id = $company->id;
            $placement->invoice_number = '';
            $placement->unique_id = Common::generateOrderUniqueId();
            $placement->invoice_type = "product-placement";
            $placement->placement_type = "out";
            $placement->placement_date = Carbon::now();
            $placement->warehouse_id = $obj['warehouse_id'];
            $placement->notes = $obj['notes'];
            $placement->staff_user_id = $loggedInUser->id;
            $placement->user_id = $loggedInUser->id;
            $placement->total_items = $total_items;
            $placement->total_quantity = $total_quantity;
            $placement->save();
            
            $type = 'product-placement-out';
            $placement->invoice_number = Common::getTransactionNumber($type);
            $placement->save();
            $total_qty = 0;
            
            //insert placement id
            foreach($items as $item){
              $floor_detail = ProductPlacementFloor::where('value',$item['floor'])->first();
              $floor_id = $floor_detail->id;
              $shelf_group_detail = ProductPlacementShelfGroup::where('value',$item['shelf_group'])
                                    ->where('product_placement_floor_id',$floor_id)
                                    ->first();
              if($shelf_group_detail == null){
                DB::rollback();
                throw new ApiException('Shelf group '.$item['shelf_group'].' is not available, please check your shelf group combination');
              }
              $shelf_group_id = $shelf_group_detail->id;
              $shelf_number_detail = ProductPlacementShelfNumber::where('value',$item['shelf_number'])
                                      ->where('product_placement_shelf_group_id',$shelf_group_id)
                                      ->first();
              if($shelf_number_detail == null){
                DB::rollback();
                throw new ApiException('Shelf number '.$item['shelf_number'].' is not available, please check your shelf number combination');
              }
              $shelf_number_id = $shelf_number_detail->id;
              $row_detail = ProductPlacementRow::where('value',$item['row'])
                            ->where('product_placement_shelf_number_id',$shelf_number_id)
                            ->first();
              if($row_detail == null){
                DB::rollback();
                throw new ApiException('Row '.$item['row'].' is not available, please check your row combination');
              }
              $row_id = $row_detail->id;
              
              //check availability
              $availability_placement = ProductPlacement::where('id',$this->getIdFromHash($product_item['xid']))->first();
              if($availability_placement == null){
                DB::rollback();
                throw new ApiException('Item Code '. $product_item['item_code'] .' is out of stock.',null,null,null,null,['xid'=>$product_item['xid'], 'id' => $this->getIdFromHash($product_item['xid'])]);
              }
              $placement_item = new PlacementItem();
              $placement_item->user_id = $loggedInUser->id;
              $placement_item->placement_id = $placement->id;
              $placement_item->product_id = $this->getIdFromHash($item['product']['xid']);
              $placement_item->unit_id = 1;
              $placement_item->floor = $floor_id;
              $placement_item->shelf_group = $shelf_group_id;
              $placement_item->shelf_number = $shelf_number_id;
              $placement_item->row = $row_id;
              $placement_item->qty = $item['qty'];
              $placement_item->save();
            }
            
            //remove placement_items
            foreach($product_items as $product_item){
               ProductPlacement::where('id',$this->getIdFromHash($product_item['xid']))->delete();       
            }
             
         DB::commit();   
        
         return ApiResponse::make('Product Placement In successfull', [
                'unique_id' => $placement->unique_id 
            ]);
    }
    
    public function floor(){
      $processingStartTime = microtime(true);
      $results = ProductPlacementFloor::select('id','value as floor')->get()->toArray();
      $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)]; 

      return ApiResponse::make(null, $results,$meta);
    }
    
    public function shelfGroup($floor_id){
      $processingStartTime = microtime(true);
      if($floor_id == ''){
        $results = [];
        $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)];    
        return ApiResponse::make(null, $results,$meta);
      }
      $floor_id = Common::getIdFromHash($floor_id);
      $results = ProductPlacementShelfGroup::select('id','value as shelf_group')->where('product_placement_floor_id',$floor_id)->get()->toArray();
      $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)];        
            

      return ApiResponse::make(null, $results,$meta);
    }
    
    public function shelfNumber($shelf_group_id = ''){
      $processingStartTime = microtime(true);
      if($shelf_group_id == ''){
        $results = [];
        $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)];    
        return ApiResponse::make(null, $results,$meta);
      }
      $shelf_group_id = Common::getIdFromHash($shelf_group_id);
      
      $results = ProductPlacementShelfNumber::where('product_placement_shelf_group_id',$shelf_group_id)
                  ->select('id','value as shelf_number')
                  ->get()
                  ->toArray();
      $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)];        
            

      return ApiResponse::make(null, $results,$meta);
    }
    
    public function row($shelf_number_id){
      $processingStartTime = microtime(true);
      if($shelf_number_id == ''){
        $results = [];
        $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)];    
        return ApiResponse::make(null, $results,$meta);
      }
      $shelf_number_id = Common::getIdFromHash($shelf_number_id);
      $results = ProductPlacementRow::where('product_placement_shelf_number_id',$shelf_number_id)
            ->select('id','value as row')->get()->toArray();
      $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)];        
            

      return ApiResponse::make(null, $results,$meta);
    }
    
    public function stockIn(){
      $processingStartTime = microtime(true);
      $request = request();
      $order = isset($request->order) ? $request->order : 'placement_date desc';
      $filters = isset($request->filters) ? str_replace('lk','like',$request->filters) : '';
      $filters = str_replace(' eq ',' between ',$filters);
      $filters = str_replace(',','" and "',$filters);
      $filters = str_replace('dates','placement_date',$filters);
      $order_arr = explode(' ', $order);
      
      $results = Placement::where('placement_type','in')
                ->join('warehouses','warehouses.id','=','placements.warehouse_id')
                ->leftJoin('users','users.id','=','placements.staff_user_id')
                ->select('placements.*','warehouses.name as warehouse_name','users.name as createdby_name')
                ->orderBy($order_arr[0],$order_arr[1]);
      if($filters != ''){
        $results->whereRaw($filters);  
      }
      $results = $results->get()->toArray();
      foreach($results as $i => $result){
          $results[$i]['items'] = PlacementItem::where('placement_id',Common::getIdFromHash($result['xid']))
                  ->join('barcode','barcode.id','placement_items.barcode_id')
                  ->join('products','products.item_id','barcode.item_id')
                  ->join('product_placement_row','product_placement_row.id','=','placement_items.row')
                  ->leftjoin('product_placement_shelf_number','product_placement_shelf_number.id','=','product_placement_row.product_placement_shelf_number_id')
                  ->leftjoin('product_placement_shelf_group','product_placement_shelf_group.id','=','product_placement_shelf_number.product_placement_shelf_group_id')
                  ->leftjoin('product_placement_floor','product_placement_floor.id','=','product_placement_shelf_group.product_placement_floor_id')
                  
                  
                  ->select('placement_id','products.item_id','products.name','products.item_code','category_id','brand_id','description',
                          'barcode.qty_bungkus as qty','warehouse_id','product_placement_floor.id as floor_id', 'product_placement_floor.value as floor',
                          'product_placement_row.id as row_id', 'product_placement_row.value as row',
                          'product_placement_shelf_group.id as shelf_group_id', 'product_placement_shelf_group.value as shelf_group', 
                          'product_placement_shelf_number.id as shelf_number_id', 'product_placement_shelf_number.value as shelf_number')
                  ->get()->toARray();
      }
      
      
      $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)];        
            

      return ApiResponse::make(null, $results,$meta);
    }
    
    public function stockOut(){
      $processingStartTime = microtime(true);
      $request = request();
      $order = isset($request->order) ? $request->order : 'placement_date desc';
      $filters = isset($request->filters) ? str_replace('lk','like',$request->filters) : '';
      $filters = str_replace('eq','between',$filters);
      $filters = str_replace(',','" and "',$filters);
      $filters = str_replace('dates','placement_date',$filters);
      $order_arr = explode(' ', $order);
      
      $results = Placement::where('placement_type','out')
                ->join('warehouses','warehouses.id','=','placements.warehouse_id')
                ->leftJoin('users','users.id','=','placements.staff_user_id')
                ->select('placements.*','warehouses.name as warehouse_name','users.name as createdby_name')
                ->orderBy($order_arr[0],$order_arr[1]);
      if($filters != ''){
        $results->whereRaw($filters);  
      }
      $results = $results->get()->toArray();
      foreach($results as $i => $result){
          $results[$i]['items'] = PlacementItem::where('placement_id',Common::getIdFromHash($result['xid']))
                  ->join('products','products.id','placement_items.product_id')
                  ->join('product_placement_floor','product_placement_floor.id','=','placement_items.floor')
                  ->join('product_placement_row','product_placement_row.id','=','placement_items.row')
                  ->join('product_placement_shelf_group','product_placement_shelf_group.id','=','placement_items.shelf_group')
                  ->join('product_placement_shelf_number','product_placement_shelf_number.id','=','placement_items.shelf_number')
                  ->select('placement_id','product_id','name','slug','item_code','category_id','brand_id','description',
                          'qty','warehouse_id','product_placement_floor.id as floor_id', 'product_placement_floor.value as floor',
                          'product_placement_row.id as row_id', 'product_placement_row.value as row',
                          'product_placement_shelf_group.id as shelf_group_id', 'product_placement_shelf_group.value as shelf_group', 
                          'product_placement_shelf_number.id as shelf_number_id', 'product_placement_shelf_number.value as shelf_number')
                  ->get()->toARray();
      }
      
      
      $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)];        
            

      return ApiResponse::make(null, $results,$meta);
    }

    public function importStockIn(ImportRequest $request)
    {
          if ($request->hasFile('file')) {
                Cache::forget('import-current-row');
                Excel::import(new StockInImport, request()->file('file'));
          }

          return ApiResponse::make('Imported Successfully', []);
    }
    
    public function importStockOut(ImportRequest $request)
    {
          if ($request->hasFile('file')) {
                Cache::forget('import-current-row');
                Excel::import(new StockOutImport, request()->file('file'));
          }

          return ApiResponse::make('Imported Successfully', []);
    }
    
    public function stockInExport()
    {
          $company = company();
          $request = request();
          $datetime_format = 'Y-m-d';
          $start_date = isset($request['start_date']) && $request['start_date'] != '' ? $request['start_date'] : '';
          $end_date = isset($request['end_date']) && $request['end_date'] != '' ? $request['end_date'] : '';
          $t_start_date = $start_date != '' ? Carbon::parse($start_date)->setTimezone($company->timezone)->format($datetime_format) : '';
          $t_end_date = $end_date != '' ? Carbon::parse($end_date)->setTimezone($company->timezone)->format($datetime_format) : '';
          
          $results = Placement::where('placement_type','in')
                    ->join('warehouses','warehouses.id','=','placements.warehouse_id')
                    ->select('placements.*','warehouses.name as warehouse_name')
                    ->orderBy('id','asc');
          if($start_date != '' && $end_date != ''){
            $results->whereBetween('placement_date',[$start_date, $end_date]);  
          }
          $results = $results->get()->toArray();
          foreach($results as $i => $result){
          $results[$i]['items'] = PlacementItem::where('placement_id',Common::getIdFromHash($result['xid']))
                  ->join('barcode','barcode.id','placement_items.barcode_id')
                  ->join('products','products.item_id','barcode.item_id')
                  ->join('product_placement_row','product_placement_row.id','=','placement_items.row')
                  ->leftjoin('product_placement_shelf_number','product_placement_shelf_number.id','=','product_placement_row.product_placement_shelf_number_id')
                  ->leftjoin('product_placement_shelf_group','product_placement_shelf_group.id','=','product_placement_shelf_number.product_placement_shelf_group_id')
                  ->leftjoin('product_placement_floor','product_placement_floor.id','=','product_placement_shelf_group.product_placement_floor_id')
                  
                  
                  ->select('placement_id','products.item_id','products.name','products.item_code','category_id','brand_id','description',
                          'barcode.qty_bungkus as qty','warehouse_id','product_placement_floor.id as floor_id', 'product_placement_floor.value as floor',
                          'product_placement_row.id as row_id', 'product_placement_row.value as row',
                          'product_placement_shelf_group.id as shelf_group_id', 'product_placement_shelf_group.value as shelf_group', 
                          'product_placement_shelf_number.id as shelf_number_id', 'product_placement_shelf_number.value as shelf_number')
                  ->get()->toARray();
      }

          if (ob_get_contents()) {
            ob_end_clean();
          }
          $setHeadingsExportExcel = [];
          $setHeadingsExportExcel[] = ['Report Stock In'];
          $setHeadingsExportExcel[] = ['Date :', $t_start_date .' - '. $t_end_date];
          $setHeadingsExportExcel[] = [''];
          $view_name = 'stock-in';
          $sheetNameExportExcel = $view_name.'-sheet';

          $data_excel = [];
          $data_excel[] = [''];
          $data_excel[] = [
            'Invoice Number',
            'Warehouse',
            'Placement Date',
            'Notes',
            'Total Items',
            'Total Quantity',
          ];
          
          foreach($results as $result){
            $data_excel[] = [
              $result['invoice_number'],
              $result['warehouse_name'],
              Carbon::parse($result['placement_date'])->setTimezone($company->timezone)->format($datetime_format),
              $result['notes'],
              $result['total_items'],
              $result['total_quantity'],
            ];            
          }
          
        $filename = 'stock-in.xlsx';

        return Excel::download(new ExcelExport($data_excel, $setHeadingsExportExcel, $sheetNameExportExcel), $filename);
    }
    
    public function stockOutExport()
    {
          $company = company();
          $request = request();
          $datetime_format = 'Y-m-d';
          $start_date = isset($request['start_date']) && $request['start_date'] != '' ? $request['start_date'] : '';
          $end_date = isset($request['end_date']) && $request['end_date'] != '' ? $request['end_date'] : '';
          
          $t_start_date = $start_date != '' ? Carbon::parse($start_date)->setTimezone($company->timezone)->format($datetime_format) : '';
          $t_end_date = $end_date != '' ? Carbon::parse($end_date)->setTimezone($company->timezone)->format($datetime_format) :  '';
          
          $results = Placement::where('placement_type','out')
                    ->join('warehouses','warehouses.id','=','placements.warehouse_id')
                    ->select('placements.*','warehouses.name as warehouse_name')
                    ->orderBy('id','asc');
          if($start_date != '' && $end_date != ''){
            $results->whereBetween('placement_date',[$start_date, $end_date]);  
          }
          $results = $results->get()->toArray();
          foreach($results as $i => $result){
              $results[$i]['items'] = PlacementItem::where('placement_id',Common::getIdFromHash($result['xid']))
                      ->join('products','products.id','placement_items.product_id')
                      ->join('product_placement_floor','product_placement_floor.id','=','placement_items.floor')
                      ->join('product_placement_row','product_placement_row.id','=','placement_items.row')
                      ->join('product_placement_shelf_group','product_placement_shelf_group.id','=','placement_items.shelf_group')
                      ->join('product_placement_shelf_number','product_placement_shelf_number.id','=','placement_items.shelf_number')
                      ->select('placement_id','product_id','name','slug','item_code','category_id','brand_id','description','qty','warehouse_id','product_placement_floor.id as floor_id', 'product_placement_floor.value as floor',
                              'product_placement_row.id as row_id', 'product_placement_row.value as row',
                              'product_placement_shelf_group.id as shelf_group_id', 'product_placement_shelf_group.value as shelf_group', 
                              'product_placement_shelf_number.id as shelf_number_id', 'product_placement_shelf_number.value as shelf_number')
                      ->get()->toARray();
          }

          if (ob_get_contents()) {
            ob_end_clean();
          }
          $setHeadingsExportExcel = [];
          $setHeadingsExportExcel[] = ['Report Stock Out'];
          $setHeadingsExportExcel[] = ['Date :', $t_start_date .' - '. $t_end_date];
          $setHeadingsExportExcel[] = [''];
          $view_name = 'stock-in';
          $sheetNameExportExcel = $view_name.'-sheet';

          $data_excel = [];
          $data_excel[] = [''];
          $data_excel[] = [
            'Invoice Number',
            'Warehouse',
            'Placement Date',
            'Notes',
            'Total Items',
            'Total Quantity',
          ];
          
          foreach($results as $result){
            $data_excel[] = [
              $result['invoice_number'],
              $result['warehouse_name'],
              Carbon::parse($result['placement_date'])->setTimezone($company->timezone)->format($datetime_format),
              $result['notes'],
              $result['total_items'],
              $result['total_quantity'],
            ];            
          }
          
        $filename = 'stock-out.xlsx';

        return Excel::download(new ExcelExport($data_excel, $setHeadingsExportExcel, $sheetNameExportExcel), $filename);
    }
    
    public function stockInvoiceExport()
    {
      $request = request();
      $invoice = isset($request['invoice']) && $request['invoice'] != '' ? $request['invoice'] : '';
      $result = Placement::where('invoice_number',$invoice)->first();
      $result_items = PlacementItem::where('placement_id',$result->id)
                      ->join('products','products.id','placement_items.product_id')
                      ->join('product_placement_floor','product_placement_floor.id','=','placement_items.floor')
                      ->join('product_placement_row','product_placement_row.id','=','placement_items.row')
                      ->join('product_placement_shelf_group','product_placement_shelf_group.id','=','placement_items.shelf_group')
                      ->join('product_placement_shelf_number','product_placement_shelf_number.id','=','placement_items.shelf_number')
                      ->leftJoin('brands','brands.id','products.brand_id')
                      ->select('placement_id','product_id','products.name','products.slug','products.item_code','products.category_id','products.brand_id','products.description','qty','warehouse_id','product_placement_floor.id as floor_id', 'product_placement_floor.value as floor',
                              'product_placement_row.id as row_id', 'product_placement_row.value as row',
                              'product_placement_shelf_group.id as shelf_group_id', 'product_placement_shelf_group.value as shelf_group', 
                              'product_placement_shelf_number.id as shelf_number_id', 'product_placement_shelf_number.value as shelf_number',
                              'brands.name as brand_name'
                            )
                      ->get();
      if (ob_get_contents()) {
        ob_end_clean();
      }
      $setHeadingsExportExcel = [];
      $setHeadingsExportExcel[] = ['Stock Invoice'];
      $setHeadingsExportExcel[] = ['Invoice Number :', $invoice];
      $setHeadingsExportExcel[] = [''];
      $view_name = 'stock-invoice';
      $sheetNameExportExcel = $view_name.'-sheet';

      $data_excel = [];
      $data_excel[] = [''];
      $data_excel[] = [
        'Item Code',
        'Name',
        'Brand',
        'Floor',
        'Shelf Group',
        'Shelf Number',
        'Row',
        'qty',
      ];

      foreach($result_items as $result){
        $data_excel[] = [
          $result['item_code'],
          $result['name'],
          $result['brand_name'],
          $result['floor'],
          $result['shelf_group'],
          $result['shelf_number'],
          $result['row'],
          $result['qty'],
        ];            
      }

    $filename = 'stock-invoice.xlsx';

    return Excel::download(new ExcelExport($data_excel, $setHeadingsExportExcel, $sheetNameExportExcel), $filename);
  }
}
