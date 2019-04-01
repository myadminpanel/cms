<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Car_plate_code_model extends Core_Model
{

    public $table = 'car_plate_code';
    public $primary_key = 'id';
    public $protected = [];
    public $table_translation = 'car_plate_code_translation';
    public $table_translation_key = 'car_plate_code_id';
    public $table_language_key = 'language_id';

    public $timestamps = true;

    public function __construct()
    {
        parent::__construct();
    }
}