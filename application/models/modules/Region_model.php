<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Region_model extends Core_Model
{

    public $table = 'region';
    public $primary_key = 'id';
    public $protected = [];
    public $table_translation = 'region_translation';
    public $table_translation_key = 'region_id';
    public $table_language_key = 'language_id';

    public $timestamps = true;

    public function __construct()
    {
        parent::__construct();
    }
}