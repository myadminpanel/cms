<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Category_model extends Core_Model
{

    public $table = 'category';
    public $primary_key = 'id';
    public $protected = [];
    public $table_translation = 'category_translation';
    public $table_translation_key = 'category_id';
    public $table_language_key = 'language_id';

    public $timestamps = true;

    public function __construct()
    {
        parent::__construct();
    }
}