<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class District_model extends Core_Model
{
	public $table = 'district';
	public $primary_key = 'id';
	public $protected = [];
	public $table_translation = 'district_translation';
	public $table_translation_key = 'district_id';
	public $table_language_key = 'language_id';

	public $timestamps = true;

	public function __construct()
	{
		parent::__construct();
	}
}