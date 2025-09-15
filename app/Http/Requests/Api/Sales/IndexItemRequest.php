<?php

namespace App\Http\Requests\Api\Sales;

use Illuminate\Foundation\Http\FormRequest;

class IndexItemRequest extends FormRequest
{
    public function authorize()
    {
        return true; // Adjust authorization logic as needed
    }

    public function rules()
    {
        return [
            'offset' => 'integer|min:0',
            'limit' => 'integer|min:1|max:100',
            'order' => 'string|in:id asc,id desc,invoice_number asc,invoice_number desc,order_date asc,order_date desc',
        ];
    }
}