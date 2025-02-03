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
        <tr><td colspan="2"><h2>Report Purchase By Item</h2></td></tr>
        <tr><td>Date :</td><td>{{$filters['start_date'] }} - {{ $filters['end_date']}}</td></tr>
        <tr><td>Warehouse :</td><td>{{$filters['warehouse_name']}}</td></tr>
        <tr><td>Category :</td><td>{{$filters['category_name']}}</td></tr>
    </table>
    <br><br>
    <?php
      foreach($data as $key =>$data_detail){
    ?>
    <h2>{{$key}}</h2>
    <table style='border:1px solid #000;padding:0px;border-width:0px;margin:0px;border-collapse: collapse;' width='100%'>
        <thead>
        <th>Item Code</th>
        <th>Name</th>
        <th>Category</th>
        <th>Brand</th>
        <th>Color</th>
        <th>Group</th>
        <th>Quantity</th>
        <th>Unit Price</th>
        <th>Discount</th>
        <th>Total</th>
        </thead>
        <tbody>
            <?php 
            $total = $total_qty = 0;
            foreach($data_detail as $key2 => $data_detail_){
                $total += $data_detail_['subtotal'];
                $total_qty += $data_detail_['quantity'];
                ?>
              <tr>
                  <td style='text-align:center;'>{{$data_detail_['item_code']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['category_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['brand_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['color_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['group_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['quantity']}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['unit_price'])}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['total_discount'])}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['subtotal'])}}</td>
              </tr>
              <?php }?>
              <tr>
                  <td colspan='6' style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>Total</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:center;'>{{$total_qty}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'></td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'></td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total)}}</td>
              </tr>
        </tbody>
    </table>
    <?php }?>


</body>

</html>
