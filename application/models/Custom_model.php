<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Custom_model extends CI_Model
{

	public function __construct()
	{
		parent::__construct();
	}

	public function callback_get_image($data, $params, $id= false)
	{
		if (!empty($data)) {
			return "<img src='" . $this->Model_tool_image->resize($data, $params['width'],
					$params['height']) . "' width='" . $params['width'] . "' height='" . $params['height'] . "'>";
		}
		return;
	}

	public function callback_get_status($data, $params = false, $id = false)
	{
		if($data == 2)
		{
			return "<span class='label label-warning'>"  . translate('waiting', true) . "</span>";
		}
		else
		{
			return '<div class="checkbox checkbox-switch">
				<label>
					<input type="checkbox" class="switch changeStatus" data-on-text="On" data-off-text="Off" data-on-color="success" data-size="mini" data-off-color="danger" data-id="'.$id.'" data-url="'.current_url().'" '.(($data) ? "checked=checked" : "").'>
				</label>
			</div>';
		}
		
									
		// $rows = [
		//     '0' => "<span class='label label-danger  changeStatus' >"  . translate('disable', true) . "</span>",
		//     '1' => "<span class='label label-success changeStatus' data-url='".current_url()."'>" . translate('enable', true) . "</span>"
		// ];

		// return $rows[$data];
	}

	public function callback_get_name($data, $params = false, $id = false)
	{
		if (!empty($data)) {
			return (isset(json_decode($data)->index->title->{$this->data['current_lang']})) ? json_decode($data)->index->title->{$this->data['current_lang']} : json_decode($data)->index->title->{$this->data['default_language']};
		}
		return;
	}

	public function callback_get_icon($data, $params = false, $id = false)
	{
		if (!empty($data)) {
			return "<i class='" . $data . "'></i>";
		}
		return;
	}

	public function callback_get_status_label($data)
	{
		if($data) {
			return "<span class='label label-success'>" . translate('enable', true) . "</span>";
		} else {
			return "<span class='label label-danger'>" . translate('disable', true) . "</span>";
		}
	}

	public function callback_get_file_label($data)
	{
		if(!empty($data)) {
			return base_url('uploads/'.$data);
		}
		return;
	}

	public function callback_get_image_label($data, $params = ['width' => 200, 'height' => 200]) 
	{
		if($data) {
			$image = $this->Model_tool_image->resize($data, $params['width'], $params['height']);
			if($image) {
				return '<img src="'.$image.'" width="'.$params["width"].'" height="'.$params["height"].'">';
			} else {
				return '<img src="'.$this->Model_tool_image->resize('no-photo.png', $params['width'], $params['height']).'" width="'.$params["width"].'" height="'.$params["height"].'">';
			}
		}

	}

	public function callback_get_option($data, $params = [])
	{
		if($params['module'])
		{
			if($params['module']['dynamic'])
			{
				$this->load->model('modules/'.$params['module']['name'].'_model');
			}
			else
			{
				$this->load->model($params['module']['name'].'_model');
			}

			$where[$params['module']['key']] = $data;
			if($params['module']['where'])
			{
				foreach($params['module']['where'] as $row)
				{
					$where[$row['key']] = $row['value'];
				}
			}

			if($params['module']['translation'])
			{
				$row = $this->{$params['module']['name'].'_model'}->filter($where)->with_translation()->one();
			}
			else
			{
				$row = $this->{$params['module']['name'].'_model'}->filter($where)->one();
			}

			$columns = explode(',', $params['module']['columns']);

			if($row)
			{
				$result = '';
				foreach($columns as $column)
				{
					$result .= $row->{$column}.' ';
				}

				return trim($result);
			}

			return false;

		}
	}

	public function callback_get_multiselect_label($data, $params = [])
	{
		$rows = [];
		if($data)
		{
			$explode = explode(',', $data);
			$this->db->where_in($params['key'], $explode);
			$query = $this->db->get($params['table']);			
			if($query->num_rows() > 0)
			{
				foreach($query->result() as $row)
				{
					$rows[] = $row->{$params['value']};
				}
			}
		}

		return implode(',', $rows);
	}

	public function callback_get_rating($rating, $params = [])
	{
		$stars = '';
		if($rating > 0) {
			for ($i=0; $i < $rating; $i++) { 
				$stars .= '<i class="icon-star-full2" style="color:#ebc733;"></i>';
			}
		}	
		return $stars;
	}

	public function callback_get_type($type)
	{
		if($type == 'company')
		{
			$name = 'Şirkət';
		}
		elseif($type == 'news')
		{
			$name = 'Xəbər';
		}
		elseif($type == 'discount')
		{
			$name = 'Endirim';
		}
		elseif($type == 'gallery')
		{
			$name = 'Qalereya';
		}
		elseif($type == 'video')
		{
			$name = 'Video';
		}
		elseif($type == 'product')
		{
			$name = 'Məhsul';
		}
		elseif($type == 'service')
		{
			$name = 'Xidmət';
		}

		return $name;
	}

	public function callback_get_content($data)
	{
		$data = explode('-', $data);
		$this->db->select(['name', 'slug']);
		$this->db->from($data[0]);
		$this->db->join($data[0].'_translation', $data[0].'.id='.$data[0].'_translation.'.$data[0].'_id');
		$this->db->where('id', $data[1]);
		$this->db->where('language_id', $this->data['current_lang_id']);
		$query = $this->db->get();
		if($query->num_rows() == 1)
		{
			return '<a target="_blank" href="'.site_url_multi($data[0].'/'.$query->row()->slug).'">'.$query->row()->name.'</a>';
		}
		else
		{
			return false;
		}
	}

}