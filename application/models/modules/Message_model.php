<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Message_model extends Core_Model
{

	public $table = 'message';
	public $primary_key = 'id';
	public $protected = [];

	public $timestamps = true;

	public function __construct()
	{
		parent::__construct();
	}
}