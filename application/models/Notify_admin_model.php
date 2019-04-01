<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Notify_admin_model extends Core_Model
{

	public $table = 'notify_admin';
	public $primary_key = 'id';
	public $authors = false;

	public function __construct()
	{
		parent::__construct();
	}
}