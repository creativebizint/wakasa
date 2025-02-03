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
    <table style='border:1px solid #000;padding:0px;border-width:0px;margin:0px;border-collapse: collapse;' width='100%'>
        <thead>
        <th>Nomor</th>
        <th>Tanggal</th>
        <th>Warehouse</th>
        <th>Keterangan</th>
        <th>Kode</th>
        <th>Name</th>
        <th>Brand</th>
        <th>Category</th>
        <th>Color</th>
        <th>Group</th>
        <th>Quantity</th>
        <th>Type</th>
        </thead>
        <tbody>
        <?php
        foreach($data as $key =>$data_detail){?>
          <tr>
              <td style='text-align:center;'>{{$data_detail['invoice_number']}}</td>
              <td style='text-align:center;'>{{\Carbon\Carbon::parse($data_detail_['date'])->setTimezone($datetime['timezone'])->format($datetime['format'])}}</td>
              <td style='text-align:center;'>{{$data_detail['warehouse_name']}}</td>
              <td style='text-align:center;'>{{$data_detail['notes']}}</td>
              <td style='text-align:center;'>{{$data_detail['item_code']}}</td>
              <td style='text-align:center;'>{{$data_detail['name']}}</td>
              <td style='text-align:center;'>{{$data_detail['brand_name']}}</td>
              <td style='text-align:center;'>{{$data_detail['category_name']}}</td>
              <td style='text-align:center;'>{{$data_detail['color_name']}}</td>
              <td style='text-align:center;'>{{$data_detail['group_name']}}</td>
              <td style='text-align:center;'>{{$data_detail['quantity']}}</td>                  
              <td style='text-align:center;'>{{$data_detail['adjustment_type']}}</td>                  
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
