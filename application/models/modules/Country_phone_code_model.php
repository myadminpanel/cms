<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Country_phone_code_model extends Core_Model
{

    public $table = 'country_phone_code';
    public $primary_key = 'id';
    public $protected = [];
    public $table_translation = 'country_phone_code_translation';
    public $table_translation_key = 'country_phone_code_id';
    public $table_language_key = 'language_id';

    public $timestamps = true;

    public function __construct()
    {
        parent::__construct();
    }
}