<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Street_model extends Core_Model
{
	public $table = 'street';
	public $primary_key = 'id';
	public $protected = [];
	public $authors = true;
	public $timestamps = true;

	public function __construct()
	{
		parent::__construct();
	}
}