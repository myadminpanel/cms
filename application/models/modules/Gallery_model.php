<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Gallery_model extends Core_Model
{

	public $table = 'gallery';
	public $primary_key = 'id';
	public $protected = [];
	public $table_translation = 'gallery_translation';
	public $table_translation_key = 'gallery_id';
	public $table_language_key = 'language_id';

	public $timestamps = true;

	public function __construct()
	{
		parent::__construct();
	}

	public function get_images($gallery_id)
	{
		$this->db->where('gallery_id', $gallery_id);
		$query = $this->db->get('gallery_images');
		if($query->num_rows())
		{
			return $query->result();
		}
		return false;
	}

	public function insert_images($images = [], $gallery_id)
	{
		if(!empty($images))
		{
			foreach($images as $image)
			{
				$this->db->insert('gallery_images', ['gallery_id' => $gallery_id, 'image' => $image]);
			}
		}		
	}

	public function delete_images($gallery_id)
	{
		$this->db->delete('gallery_images', ['gallery_id' => $gallery_id]);
	}
}