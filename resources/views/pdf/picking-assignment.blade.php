<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Picking Assignment {{ $pickingAssignment->code }}</title>
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
    
    
    <h1>Picking Assignment {{ $pickingAssignment->code }}</h1>
    <div class="header">
        <p><strong>Name:</strong> {{ $pickingAssignment->name ?? 'N/A' }}</p>
        <p><strong>Date:</strong> {{ $pickingAssignment->created_at ? \Carbon\Carbon::parse($pickingAssignment->created_at)->format('Y-m-d H:i:s') : 'N/A' }}</p>
        <p><strong>Status:</strong>
            @if ($pickingAssignment->status == '1')
                <span class="status-open">Open</span>
            @elseif ($pickingAssignment->status == '2')
                <span class="status-complete">Complete</span>
            @endif    
        </p>
    </div>

    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Invoice Number</th>
                <th>Item ID</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($pickingAssignment->items as $item)
                <tr>
                    <td>{{ $loop->iteration }}</td>
                    <td>{{ $item->invoice_number ?? 'N/A' }}</td>
                    <td>{{ $item->item_id ?? 'N/A' }}</td>
                    <td>{{ $item->qty ?? 'N/A' }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>
</html>