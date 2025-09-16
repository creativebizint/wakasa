<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Qc Picking {{ $qcPicking->invoice_number }}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            font-size: 14px;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        .header {
            margin-bottom: 20px;
        }
        .header p {
            margin: 5px 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #333;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        .status-open {
            color: #d4a017;
            font-weight: bold;
        }
        .status-complete {
            color: #28a745;
            font-weight: bold;
        }
        .status-unknown {
            color: #6c757d;
            font-weight: bold;
        }
    </style>
</head>
<body>
    
    
    <h1>Invoice {{ $qcPicking->invoice_number }}</h1>
    <div class="header">
        <p><strong>Name:</strong> {{ $qcPicking->user_name ?? 'N/A' }}</p>
        <p><strong>Date:</strong> {{ $qcPicking->order_date ? \Carbon\Carbon::parse($qcPicking->order_date)->format('Y-m-d H:i:s') : 'N/A' }}</p>
        <p><strong>Status:</strong>
                <span class="status-open">{{$qcPicking->order_status}}</span>
        </p>
    </div>

    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Invoice Number</th>
                <th>Item ID</th>
                <th>Quantity</th>
                <th>Picker</th>
            </tr>
        </thead>
        <tbody>
            <?php
                $i =0;
            ?>
            @foreach ($items as $item)
                <tr>
                    <td>{{ $i++ }}</td>
                    <td>{{ $item->item_id ?? 'N/A' }}</td>
                    <td>{{ $item->quantity ?? 'N/A' }}</td>
                    <td>{{ $item->quantity_scanned ?? 'N/A' }}</td>
                    <td>{{ $item->picker_by_name ?? 'N/A' }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>
</html>