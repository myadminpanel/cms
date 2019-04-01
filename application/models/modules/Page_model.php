<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Page_model extends Core_Model
{

    public $table = 'page';
    public $primary_key = 'id';
    public $protected = [];
    public $table_translation = 'page_translation';
    public $table_translation_key = 'page_id';
    public $table_language_key = 'language_id';

    public $timestamps = true;

    public function __construct()
    {
        parent::__construct();
    }
}