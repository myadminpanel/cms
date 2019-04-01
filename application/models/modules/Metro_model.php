<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Metro_model extends Core_Model
{
	public $table = 'metro';
	public $primary_key = 'id';
	public $protected = [];
	public $table_translation = 'metro_translation';
	public $table_translation_key = 'metro_id';
	public $table_language_key = 'language_id';

	public $timestamps = true;

	public function __construct()
	{
		parent::__construct();
	}
}