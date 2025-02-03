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
        <tr><td colspan="2"><h2>E-Faktur</h2></td></tr>
        <tr><td>Date :</td><td>{{$filters['start_date'] }} - {{ $filters['end_date']}}</td></tr>
        <tr><td>Warehouse :</td><td>{{$filters['warehouse_name']}}</td></tr>
    </table>
    <br><br>
    <table style='border:1px solid #000;padding:0px;border-width:0px;margin:0px;border-collapse: collapse;font-size:10px;' width='100%'>
        <thead>
        <th>No Dokumen</th>
        <th>Tanggal</th>
        <th>Kode</th>
        <th>Artikel</th>
        <th>Color</th>
        <th>Quantity</th>
        <th>Unit Price</th>
        <th>Subtotal</th>
        <th>Diskon</th>
        <th>Cust Paid</th>
        <th>Margin %</th>
        <th>Margin</th>
        <th>Tagihan</th>
        <th>DPP Unit Price</th>
        <th>DPP Subtotal</th>
        <th>DPP Diskon</th>
        <th>DPP</th>
        <th>PPN</th>
        <th>Keterangan</th>
        </thead>
        <tbody>
          <?php
            foreach($data as $key_ =>$data_detail_){?>
            <tr><td colspan="18"><b>Type : {{$key_}}</b></td></tr>  
          <?php    
            foreach($data_detail_ as $key =>$data_detail){
          ?>
            <tr><td colspan="18"><b>Brand : {{$key}}</b></td></tr>
            <?php 
            $total_unit_price = $total_qty = $total_sub_total = $total_sub_discount = $total_customer_paid = $total_margin = $total_tagihan = 
            $total_dpp_unit_price = $total_dpp_subtotal =  $total_dpp_discount = $total_dpp = $total_ppn = 0;
            
            foreach($data_detail as $key2 => $data_detail_){
                $t_order_date = \Carbon\Carbon::parse($data_detail_['order_date'])->setTimezone($datetime['timezone'])->format($datetime['format']);
                $total_unit_price += $data_detail_['unit_price'];
                $total_qty += $data_detail_['quantity'];
                $total_sub_total += $data_detail_['sub_total'];
                $total_sub_discount += $data_detail_['total_discount'];
                $total_customer_paid += $data_detail_['customer_paid'];
                $total_margin += $data_detail_['margin'];
                $total_tagihan += $data_detail_['tagihan'];
                $total_dpp_unit_price += $data_detail_['dpp_unit_price'];
                $total_dpp_subtotal += $data_detail_['dpp_subtotal'];
                $total_dpp_discount += $data_detail_['dpp_discount'];
                $total_dpp += $data_detail_['dpp'];
                $total_ppn += $data_detail_['ppn'];
                ?>
              <tr>
                  <td style='text-align:center;'>{{$data_detail_['invoice_number']}}</td>
                  <td style='text-align:center;'>{{$t_order_date}}</td>
                  <td style='text-align:center;'>{{$data_detail_['item_code']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['product_name']}}</td>
                  <td style='text-align:center;'>{{$data_detail_['color_name']}}</td>
                  <td style='text-align:center;'>{{number_format($data_detail_['quantity'])}}</td>
                  <td style='text-align:center;'>{{number_format($data_detail_['unit_price'])}}</td>
                  <td style='text-align:center;'>{{number_format($data_detail_['sub_total'])}}</td>
                  <td style='text-align:center;'>{{number_format($data_detail_['total_discount'])}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['customer_paid'])}}</td>
                  <td style='text-align:right;'>{{$data_detail_['margin_percentage']}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['margin'])}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['tagihan'])}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['dpp_unit_price'])}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['dpp_subtotal'])}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['dpp_discount'])}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['dpp'])}}</td>
                  <td style='text-align:right;'>{{number_format($data_detail_['ppn'])}}</td>
                  <td style='text-align:right;'>{{$data_detail_['notes']}}</td>
              </tr>
              <?php }?>
              <tr>
                  <td colspan='5' style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>Total</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:center;'>{{$total_qty}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_unit_price)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_sub_total)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_sub_discount)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_customer_paid)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'></td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_margin)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_tagihan)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_dpp_unit_price)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_dpp_subtotal)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_dpp_discount)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_dpp)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'>{{number_format($total_ppn)}}</td>
                  <td style='border-top:1px solid #000;border-bottom:1px solid #000;padding:0px;text-align:right;'></td>
              </tr>
          <?php }
            }
          ?>      
        </tbody>
    </table>

    @if($print)
    <script>
      window.onload = function() { window.print(); }
    </script>
    @endif
</body>

</html>
