<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Company_model extends Core_Model
{

	public $table = 'company';
	public $primary_key = 'id';
	public $protected = [];
	public $table_translation = 'company_translation';
	public $table_translation_key = 'company_id';
	public $table_language_key = 'language_id';

	public $timestamps = true;

	public function __construct()
	{
		parent::__construct();
	}

	public function get_images($company_id)
	{
		$this->db->where('company_id', $company_id);
		$query = $this->db->get('company_images');
		if($query->num_rows())
		{
			return $query->result();
		}
		return false;
	}

	public function insert_images($images = [], $company_id)
	{
		if(!empty($images))
		{
			foreach($images as $image)
			{
				$this->db->insert('company_images', ['company_id' => $company_id, 'image' => $image]);
			}
		}		
	}

	public function delete_images($company_id)
	{
		$this->db->delete('company_images', ['company_id' => $company_id]);
	}
}