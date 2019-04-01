<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Contact_model extends Core_Model
{

    public $table = 'contact';
    public $primary_key = 'id';
    public $protected = [];
    public $authors = false;

    public $timestamps = true;

    public function __construct()
    {
        parent::__construct();
    }
}