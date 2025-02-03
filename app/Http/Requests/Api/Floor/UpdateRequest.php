<?php

namespace App\Http\Requests\Api\Floor;

use Illuminate\Validation\Rule;
use Illuminate\Foundation\Http\FormRequest;
use Vinkla\Hashids\Facades\Hashids;

class UpdateRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */

    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $company = company();
        $convertedId = Hashids::decode($this->route('floor'));
        //file_put_contents(storage_path('logs') . '/test.log', "[" . date('Y-m-d H:i:s') . "]route : \n" . print_r($this->route('floor'),1) . "\n\n", FILE_APPEND);
        $id = $convertedId[0];

        $rules = [
            'value'    => 'required',
        ];

        return $rules;
    }
}
