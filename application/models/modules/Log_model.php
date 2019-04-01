<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Log_model extends Core_Model
{

	public $table = 'log';
	public $primary_key = 'id';
	public $protected = [];
	public $timestamps = false;
	public $authors    = false;
	public $soft_deletes = false;

	public function __construct()
	{
		parent::__construct();
	}
}