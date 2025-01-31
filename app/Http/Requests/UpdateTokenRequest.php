<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class UpdateTokenRequest extends FormRequest
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
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            'token_name' => 'required|string|max:50',
            'token_symbol' => 'required|string|max:50',
            'contract_address' => 'required|string|unique:contracts,contract_address,' . $this->token->id,
            'recipient_address' => 'required|string',
            'status' => 'required|in:Active,Inactive',
        ];
    }
}
