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
        <tr><td colspan="2"><h2>Report Stock Adjustment</h2></td></tr>
        <tr><td>Date :</td><td>{{$filters['start_date'] }} - {{ $filters['end_date']}}</td></tr>
    </table>
    <br><br>
    <?php
      foreach($data as $key =>$data_detail){
        if($key == 'add'){
          $key = 'Adjustment Ingoing';
        }
        else{
          $key = 'Adjustment Outgoing';
        }
    ?>
    <h2>{{$key}}</h2>
    <table style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;margin:0px;border-collapse: collapse;' width='100%'>
        <thead>
        <th>Item Code</th>
        <th>Name</th>
        <th>Category</th>
        <th>Brand</th>
        <th>Color</th>
        <th>Group</th>
        <th>Quantity</th>
        </thead>
        <tbody style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;margin:0px;border-collapse: collapse;'>
            <?php 
            foreach($data_detail as $key2 => $data_detail_){
                ?>
              <tr style='border-bottom:1px solid #000;padding:0px;margin:0px;border-collapse: collapse;'>
                  <td style='text-align:center;'>{{$data_detail_['item_code']}}</td>
                  <td style='text-align:left;padding-left:10px;'>
                      {{$data_detail_['name']}}<br>
                      <b>No Dokumen : {{$data_detail_['invoice_number']}}</b><br>
                      <b>Keterangan : {{$data_detail_['notes']}}</b>
                  </td>
                  <td style='text-align:left;padding-left:10px;'>{{$data_detail_['category_name']}}<br>
                      <b>Tanggal : {{\Carbon\Carbon::parse($data_detail_['date'])->setTimezone($datetime['timezone'])->format($datetime['format'])}}</b><br>
                      <b>Warehouse : {{$data_detail_['warehouse_name']}}</b>
                  </td>
                  <td style='text-align:center;'>{{$data_detail_['brand_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['color_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['group_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['quantity']}}</td>
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
