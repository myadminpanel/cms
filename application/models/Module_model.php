<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Module_model extends Core_Model
{

	public $table = 'modules';
	public $primary_key = 'id';
	public $protected = ['id'];
	public $rules = [];


	public function __construct()
	{
		parent::__construct();
	}

	public function generate_option($table, $key, $value, $multi = false)
	{
		$this->db->select([$key, $value]);
		$query = $this->db->get($table);		
		$options = [];
		if($query->num_rows() > 0)
		{
			if(!$multi)
			{
				$options[0] = translate('select', true);
			}
			$rows = $query->result();
			foreach($rows as $row)
			{
				$options[$row->{$key}] = $row->{$value};
			}
		}
		return $options;
	}

}