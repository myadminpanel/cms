<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Faq_model extends Core_Model
{

	public $table = 'faq';
	public $primary_key = 'id';
	public $protected = [];
	public $table_translation = 'faq_translation';
	public $table_translation_key = 'faq_id';
	public $table_language_key = 'language_id';

	public $timestamps = true;

	public function __construct()
	{
		parent::__construct();
	}
}
