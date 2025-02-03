<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
      @page {size:auto;margin:0px;padding:0px;}  
      body{font-size:10px;margin:0px;padding:0px;padding-top:5px;}  
    </style>    
    
</head>


<body>
<center>
    <?php
      $barcode = '2313123142342';
    ?>
    <table width="100%">
      <tr>
        <td align="center" width='50%' style="padding:10px;padding-left:6px">
          @if(isset($barcode1))  
          <table>
              <tr>
                  <td align='center' colspan="2"><img src='{{$barcode1['image']}}' width='80%' height="40px"></td>
              </tr>
              <tr>
                  <td align='center' colspan="2">{{$barcode1['item_code']}}</td>
              </tr>   
              <tr>
                  <td align='left' width='100%' colspan="2" style='padding-left:10px'>{{substr($barcode1['name'],0,30)}}</td>
              </tr>    
              <tr>
                  <td align='left' width='100%' colspan="2" style='padding-left:10px'>{{substr($barcode1['color']->name,0,30)}}</td>
              </tr>
              <tr>
                  <td align='left' width='20%' style='padding-left:10px'>{{$code!=''?$code:''}}</td>
                  <td align='right' width='80%' style='padding-right:10px'>{{'Rp '.number_format($barcode1['unit_price'])}}</td>
              </tr>
          </table>
          @endif
        </td>
        <td width='50%' style="padding:10px;padding-left:6px">
          @if(isset($barcode2))  
          <table>
              <tr>
                  <td align='center' colspan='2'><img src='{{$barcode2['image']}}' width='80%' height="40px"></td>
              </tr>
              <tr>
                  <td align='center' colspan='2'>{{$barcode2['item_code']}}</td>
              </tr>   
              <tr>
                  <td align='left' width='100%' colspan="2" style='padding-left:10px'>{{substr($barcode2['name'],0,30)}}</td>
              </tr>
              <tr>
                  <td align='left' width='100%' colspan="2" style='padding-left:10px'>{{substr($barcode2['color']->name,0,30)}}</td>
              </tr>   
              <tr>
                  <td align='left' width='20%' style='padding-left:10px'>{{$code!=''?$code:''}}</td>
                  <td align='right' width='80%' style='padding-right:10px'>{{'Rp '.number_format($barcode2['unit_price'])}}</td>
              </tr>
          </table>
          @endif
        </td>
      </tr>
    </table>    
</body>
</center>
</html>
