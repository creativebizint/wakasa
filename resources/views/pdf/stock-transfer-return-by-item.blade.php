<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    
</head>


<body>
    <table>
        <tr><td colspan="2"><h2>Report Stock Transfer Return By Item</h2></td></tr>
        <tr><td>Date :</td><td>{{$filters['start_date'] }} - {{ $filters['end_date']}}</td></tr>
        <tr><td>Warehouse :</td><td>{{$filters['from_warehouse_name']}}</td></tr>
    </table>
    <br><br>
    <table style='border:1px solid #000;padding:0px;border-width:0px;margin:0px;border-collapse: collapse;font-size:10px;' width='100%'>
        <thead>
        <th>Stock Transfer Return Date</th>
        <th>Stock Transfer Return No</th>
        <th>Brand</th>
        <th>Code</th>
        <th>Name</th>
        <th>Category</th>
        <th>Color</th>
        <th>Group</th>
        <th>Remark</th>
        <th>Quantity</th>
        <th>Unit Price</th>
        <th>Satus Price</th>
        <th>Sub Total</th>
        <th>Discount</th>
        <th>Total</th>
        </thead>
        <tbody>
        <?php
        $total = 0;
        foreach($data as $key =>$data_detail){?>
            <tr><td colspan='15' style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px'><b>{{$key}}</b></td></tr>
            <?php 
            $total = 0;
            foreach($data_detail as $data_detail_){
              
                $total += $data_detail_['subtotal'];
                ?>
              <tr>
                  <td style='text-align:center;'>{{\Carbon\Carbon::parse($data_detail_['order_date'])->setTimezone($datetime['timezone'])->format($datetime['format'])}}</td>
                  <td style='text-align:center;'>{{$data_detail_['invoice_number']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['brand_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['item_code']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['category_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['color_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['group_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['notes']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['quantity']}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['single_unit_price'])}}</td>
                  <td style='text-align:right;'>{{$data_detail_['price_type']}}</td>
                  <td style='text-align:right;'>{{number_format(($data_detail_['quantity']*$data_detail_['single_unit_price']))}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['total_discount'])}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['subtotal'])}}</td>
              </tr>
              <?php }?>
              <tr>
                  <td colspan='14' style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>Total</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total)}}</td>
              </tr>
        <?php }?>
        </tbody>
    </table>

    @if($print)
    <script>
      window.onload = function() { window.print(); }
    </script>
    @endif
</body>

</html>
