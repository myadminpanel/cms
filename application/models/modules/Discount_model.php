<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Discount_model extends Core_Model
{

    public $table = 'discount';
    public $primary_key = 'id';
    public $protected = [];
    public $table_translation = 'discount_translation';
    public $table_translation_key = 'discount_id';
    public $table_language_key = 'language_id';

    public $timestamps = true;

    public function __construct()
    {
        parent::__construct();
    }
}