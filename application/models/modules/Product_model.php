<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Product_model extends Core_Model
{

    public $table = 'product';
    public $primary_key = 'id';
    public $protected = [];
    public $table_translation = 'product_translation';
    public $table_translation_key = 'product_id';
    public $table_language_key = 'language_id';

    public $timestamps = true;

    public function __construct()
    {
        parent::__construct();
    }
}