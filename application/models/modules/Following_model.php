<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Following_model extends Core_Model
{

    public $table = 'following';
    public $primary_key = 'id';
    public $protected = [];
    public $timestamps = true;
    public $authors    = false;

    public function __construct()
    {
        parent::__construct();
    }
}