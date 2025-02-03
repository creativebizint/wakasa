<?php

namespace App\Http\Controllers\Api;

use App\Classes\Common;
use App\Http\Controllers\ApiBaseController;
use App\Http\Requests\Api\StockHistory\IndexRequest;
use App\Models\OrderItem;
use App\Models\ProductDetails;
use App\Models\StockAdjustment;
use App\Models\StockHistory;
use App\Models\Lang;
use App\Models\Translation;
use App\Models\Company;
use App\Models\Warehouse;
use App\Exports\ExcelExport;
use Examyou\RestAPI\ApiResponse;
use Illuminate\Http\Request;
use Carbon\Carbon;
use Maatwebsite\Excel\Facades\Excel;

class StockHistoryController extends ApiBaseController
{
    protected $model = StockHistory::class;

    protected $indexRequest = IndexRequest::class;

    public function modifyIndex($query)
    {
        $request = request();

        // Product Filters
        if ($request->has('product_id') && $request->product_id != "") {
            $query = $query->where('product_id', $request->product_id);
        }

        // Dates Filters
        if ($request->has('dates') && $request->dates != "") {
            $dates = explode(',', $request->dates);
            $startDate = $dates[0];
            $endDate = $dates[1];

            $query = $query->whereRaw('created_at >= ?', [$startDate])
                ->whereRaw('created_at <= ?', [$endDate]);
        }

        return $query;
    }

    public static function stockChanges()
    {
        $processingStartTime = microtime(true);
        $request = request();
        $warehouse = warehouse();
        $company = company();
        $datetime_format = 'Y-m-d';

        $startDate = $request->start_date ? Carbon::parse($request->start_date)->setTimezone($company->timezone)->format($datetime_format) : null;
        $endDate = $request->end_date ? Carbon::parse($request->end_date)->setTimezone($company->timezone)->format($datetime_format) : null;

         \Illuminate\Support\Facades\Log::debug($endDate);

        $item = Common::getProductStockChanges($warehouse->id, Common::getIdFromHash($request->product_id), $startDate, $endDate);
        $results = $item['stock_changes'];

        $meta = ['paging'=>['total'=> count($results)],'time'=>round(microtime(true) - $processingStartTime, 3)];
        return ApiResponse::make(null, $results, $meta);
    }

    public function StockHistoryReportExport()
    {
        $request = request();
        $warehouse = warehouse();
        $company = company();
        $type = $request->type;
        $langKey = $request->lang;

        $datetime_format = 'Y-m-d';
        $datetime_filename_format = 'Ymd';

        // Dates Filters
        $startDate = $request->start_date ? Carbon::parse($request->start_date)->setTimezone($company->timezone)->format($datetime_format) : null;
        $endDate = $request->end_date ? Carbon::parse($request->end_date)->setTimezone($company->timezone)->format($datetime_format) : null;

        $item = Common::getProductStockChanges(Common::getIdFromHash($request->warehouse_id), Common::getIdFromHash($request->product_id), $startDate, $endDate);
        $product = $item['product_details']->product;
        $stockHistory = $item['stock_changes'];

        $lang = Lang::where('key', $langKey)->first();
        if (!$lang) {
            $lang = Lang::where('key', 'en')->first();
        }

        $invoiceTranslation = Translation::where('lang_id', $lang->id)
            ->whereIn('group', ['product', 'menu', 'common', 'stock'])
            ->pluck('value', 'key')
            ->toArray();

        $totalQuantityIn = 0;
        $totalQuantityOut = 0;
        foreach ($stockHistory as $history) {
            $totalQuantityIn += $history['operation'] == 'add' ? $history['quantity'] : 0;
            $totalQuantityOut += $history['operation'] == 'subtract' ? $history['quantity'] : 0;
        }

        $view_name = 'stock-history';
        $download_name = $view_name.'-report-'.date($datetime_filename_format);
        $exportData = [
            'startDate' => $startDate ? $startDate : date($datetime_format, strtotime($request->start_date)),
            'endDate' => $endDate ? $endDate : date($datetime_format, strtotime(Carbon::now())),
            'processDate' => Carbon::now()->format($datetime_format),
            'traslations' => $invoiceTranslation,
            'company' => Company::with('currency')->find($company->id),
            'warehouse' => $warehouse,
            'product' => $product,
            'stockHistory' => $stockHistory,
            'totalQuantityIn' => $totalQuantityIn,
            'totalQuantityOut' => $totalQuantityOut,
        ];
        
        $pdf = app('dompdf.wrapper');
        $pdf->setPaper('A4', 'landscape');

        $html = view('stock-history', $exportData);
        $pdf->loadHTML($html);

        if ($type == 'pdf') {
            return $pdf->download($download_name . '.pdf');
        } elseif ($type == 'print') {
            $pdf->render();
            return $pdf->stream();
        } elseif ($type == 'excel') {
            if (ob_get_contents()) {
                ob_end_clean();
            }
            $excelHeading = [];
            $excelHeading[] = ['Stock History'];
            $excelHeading[] = ['Period :', $exportData['startDate'] . ' - ' . $exportData['endDate']];
            $excelHeading[] = ['Warehouse :', $warehouse->name];
            $excelHeading[] = [
                'Item :',
                count($stockHistory) > 0 ? $product->item_code . ' / ' . $product->name . ' / ' . $product->color->name : '',
                '',
                '',
                'Date :',
                $exportData['processDate']
            ];
            $excelHeading[] = [''];
            $excelHeading[] = [
                'OrderDate',
                'Invoice Number',
                'Order Type',
                'Quantity In',
                'Quantity Out',
                'Balance',
            ];

            $sheetName = $view_name.'-sheet';

            $excelData = [];
            if (count($stockHistory)) {
                foreach($stockHistory as $key => $record){
                    // From
                    if (($record['order_type'] == "purchases" || $record['order_type'] == "sales-returns") && $record['user'] != null) {
                        $from = $record['user'];
                    } elseif (($record['order_type'] == "purchase-returns" || $record['order_type'] == "sales") && $record['warehouse'] != null) {
                        $from = $record['warehouse'];
                    } elseif (($record['order_type'] == "stock-transfers" || $record['order_type'] == "stock-transfer-returns") && $record['from_warehouse'] != null) {
                        $from = $record['from_warehouse'];
                    } else {
                        $from = "-";
                    }

                    // To
                    if (($record['order_type'] == "purchases" || $record['order_type'] == "sales-returns" || $record['order_type'] == "stock-transfers" || $record['order_type'] == "stock-transfer-returns") && $record['warehouse'] != null) {
                        $to = $record['warehouse'];
                    } elseif (($record['order_type'] == "purchase-returns" || $record['order_type'] == "sales") && $record['user'] != null) {
                        $to = $record['user'];
                    } else {
                        $to = "-";
                    }
                       
                    // Quantity In
                    if ($record['operation'] == "add") {
                        $quantityIn = $record['quantity'];
                    } else {
                        $quantityIn = 0;
                    }

                    // Quantity Out
                    if ($record['operation'] == "subtract") {
                        $quantityOut = $record['quantity'];
                    } else {
                        $quantityOut = 0;
                    }

                    // Balance
                    $balance = $record['balance'];

                    $excelData[] = [
                        $record['order_date'],
                        $record['invoice_number'],
                        $exportData['traslations'][str_replace('-', '_', $record['order_type'])],
                        $from,
                        $to,
                        $quantityIn . ' ' . $product->unit->short_name,
                        $quantityOut . ' ' . $product->unit->short_name,
                        $balance . ' ' . $product->unit->short_name,
                    ];
                }
                $excelData[] = [
                    '',
                    '',
                    '',
                    '',
                    '',
                    $totalQuantityIn . ' ' . $product->unit->short_name,
                    $totalQuantityOut . ' ' . $product->unit->short_name,
                    '',
                ];
            }

            $filename = $download_name . '.xlsx';

            return Excel::download(new ExcelExport($excelData, $excelHeading, $sheetName), $filename);
        }
    }
}
