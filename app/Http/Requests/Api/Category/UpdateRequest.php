<?php

namespace App\Http\Requests\Api\Category;

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
        file_put_contents(storage_path('logs') . '/test.log', "[" . date('Y-m-d H:i:s') . "]test 1 : \n" . $this->route('category') . "\n\n", FILE_APPEND);
        $convertedId = Hashids::decode($this->route('category'));
        $id = $convertedId[0];

        $rules = [
            'name'    => 'required',
            'slug'    => [
                'required',
                Rule::unique('categories', 'slug')->where(function ($query) use ($company, $id) {
                    return $query->where('company_id', $company->id)
                        ->where('id', '!=', $id);
                })
            ],
        ];

        return $rules;
    }
}
