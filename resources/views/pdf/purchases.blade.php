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
    <table width="100%">
        <tr>
            <td width="50%"><h2>{{$company->name}}</h2></td>
            <td width="50%" align="right"><h2>{{$order->invoice_number}}</h2></td>
        </tr>
    </table>
    
    <table width="100%">
        <tr>
            <td width="50%"></td>
            <td>Tanggal :</td>
            <td>{{date_format($order->order_date,'d-m-Y')}}</td>
        </tr>
        <tr>
            <td width="50%"></td>
            <td>Supplier :</td>
            <td>{{$order->user->name}}</td>
        </tr>
        <tr>
            <td width="50%"></td>
            <td>Alamat :</td>
            <td>{{$order->user->address}}</td>
        </tr>
    </table>
    <br><br>
    <table style='border:1px solid #000;padding:0px;border-width:0px;margin:0px;border-collapse: collapse;font-size:10px;' width='100%' border='1'>
        <thead>
        <th>No</th>
        <th>Rak</th>
        <th>Kode Barang</th>
        <th>No Asli</th>
        <th>Deskripsi</th>
        <th>Keterangan</th>
        <th></th>
        <th>Kem</th>
        <th>Sat</th>
        <th>Q-Fktr</th>
        <th>QRx</th>
        </thead>
        <tbody>
          @foreach($order->items as $item)
          <tr>
        <td>{{'10'}}</td>
        <td>{{$item->shelf}}</td>
        <td>{{$item->product->item_id}}</td>
        <td>{{$item->product->item_code}}</td>
        <td>{{$item->product->name}}</td>
        <td>{{$item->product->description}}</td>
        <td>{{$item->product->subgroup2}}</td>
        <td></td>
        <td>{{$item->quantity}}</td>
        <td>{{$item->unit->name}}</td>
        <td></td>
        </tr>
          @endforeach
        </tbody>
    </table>

    @if($print)
    <script>
      window.onload = function() { window.print(); }
    </script>
    @endif
</body>

</html>
