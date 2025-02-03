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
        <tr><td colspan="2"><h2>Report Purchase By Date</h2></td></tr>
        <tr><td>Date :</td><td>{{ $filters['start_date'] }} - {{ $filters['end_date'] }}</td></tr>
        <tr><td>Warehouse :</td><td>{{$filters['warehouse_name']}}</td></tr>
        <tr><td>Supplier :</td><td>{{$filters['supplier_name']}}</td></tr>
    </table>
    <br><br>
    
    <?php
      foreach($data as $key =>$data_detail){
    ?>
    <h2>{{$key}}</h2>
    <table style='border:1px solid #000;padding:0px;border-width:0px;margin:0px;border-collapse: collapse;font-size:10px;' width='100%'>
        <thead>
        <th>No. Dokumen</th>
        <th>Tangggal</th>
        <th>Supplier</th>
        <th>Kategori</th>
        <th>Kode</th>
        <th>Artikel</th>
        <th>Color</th>
        <th>Qty</th>
        <th>Unit Price</th>
        <th>BDC</th>
        <th>Total Price</th>
        <th>Total BDC</th>
        </thead>
        <tbody>
        <?php
        foreach($data_detail as $key2 =>$data_detail_){?>
            <tr><td colspan='12' style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px'><b>{{$key2}}</b></td></tr>
              <?php
              $total_qty = $total_price = $total_bdc = 0;
              foreach($data_detail_ as $ke => $data_detail__){
                $total_qty += $data_detail__['quantity'];
                
                $total_bdc += $data_detail__['purchase_price'] * $data_detail__['quantity'];
                
                if($data_detail__['retail_counter_price'] > 0){
                  $unit_price = $data_detail__['retail_counter_price'];
                }
                else{
                  $unit_price = $data_detail__['retail_online_price'];
                }
                
                $total_price += $unit_price * $data_detail__['quantity'];
                ?>
              <tr>
                  <td style='text-align:center;'>{{$data_detail__['invoice_number']}}</td>
                  <td style='text-align:center;'>{{\Carbon\Carbon::parse($data_detail__['order_date'])->setTimezone($datetime['timezone'])->format($datetime['format'])}}</td>
                  <td style='text-align:center;'>{{$data_detail__['supplier_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail__['category_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail__['item_code']}}</td>
                  <td style='text-align:center;'>{{$data_detail__['name']}}</td>
                  <td style='text-align:center;'>{{$data_detail__['color_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail__['quantity']}}</td>
                  <td style='text-align:right;'>{{number_format($unit_price)}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail__['purchase_price'])}}</td>
                  <td style='text-align:right;'>{{number_format($unit_price * $data_detail__['quantity'])}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail__['purchase_price'] * $data_detail__['quantity'])}}</td>
              </tr>
              <?php }?>
              <tr>
                  <td colspan='7' style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>Total</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{$total_qty}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'></td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'></td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_price)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_bdc)}}</td>
              </tr>
              <?php }?>
        </tbody>
    </table>
    <?php }?>
  
    @if($print)
    <script>
      window.onload = function() { window.print(); }
    </script>
    @endif
        
</body>

</html>
