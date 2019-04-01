<?php

if (!function_exists('module_setting')) {
	function module_setting($module_name)
	{
		$CI =& get_instance();
		
		$CI->db->where('slug', $module_name);
		$query = $CI->db->get('modules');

		if ($query->num_rows() === 1) {
			return $query->row();
		} else {
			return false;
		}
	}
}

if (!function_exists('get_module')) {
	function get_module($module_name = false, $params = [])
	{
		if ($module_name) {
			$module_setting = module_setting($module_name);
			if ($module_setting) {
				if ($module_setting->status == 1) {
					$CI =& get_instance();

					$CI->load->model($module_name.'_model');

					$default = [
						'page' 					=> 1,
						'per_page'				=> 10,
						'fields'				=> '*',
						'filter'				=> [],
						'sort_column'			=> 'created_at',
						'sort_order'			=> 'DESC',
					];

					foreach ($default as $key => $value) {
						$params[$key] = (isset($params[$key])) ? $params['$key'] : $default[$key];
					}
					
					if ($module_setting->multilingual == 1) {
						$row = $CI->{$module_name.'_model'}->fields($params['fields'])->with_translation()->filter($params['filter'])->order_by($params['sort_column'], $params['sort_order'])->limit($params['per_page'], $params['page']-1)->all();
					} else {
						$row = $CI->{$module_name.'_model'}->fields($params['fields'])->filter($params['filter'])->order_by($params['sort_column'], $params['sort_order'])->limit($params['per_page'], $params['page']-1)->all();
					}

					if ($row) {
						return $row;
					} else {
						return false;
					}
				} else {
					return 'Module disable';
				}
			} else {
				return 'Module not exists';
			}
		}

		return 'Error';
	}
}

if (!function_exists('get_date')) {
	function get_date($format = 'Y-m-d H:i:s', $date = false)
	{
		if ($date) {
			return date($format, strtotime($date));
		}
		return false;
	}
}

if (!function_exists('get_short_description')) {
	function get_short_description($description = false, $length = '270', $end = '...')
	{
		if ($description) {
			return mb_substr(trim(strip_tags($description)), 0, $length).$end;
		}
		return false;
	}
}


if (!function_exists('get_info')) {
	function get_info($id = false)
	{
		if ($id) {

			$CI =& get_instance();
			$model = $CI->model;
			$CI->load->model($model);
			$data = $CI->{$model}->filter(['id' => $id])->with_trashed()->one();

			if($CI->method == 'index')
			{
				$info = '<strong>Created at:</strong> '.$data->created_at;
				
				if($data->created_by)
				{
					$info .= '<br/> <strong>Created by:</strong> '.$CI->auth->get_user($data->created_by)->firstname.' '.$CI->auth->get_user($data->created_by)->lastname;
				}
				
				if($data->updated_at != NULL)
				{
					$info .= '<br/><strong>Updated at:</strong> '.$data->updated_at;
					
					if($data->updated_by)
					{
						$info .= '<br/><strong>Updated by:</strong> '.$CI->auth->get_user($data->updated_by)->firstname.' '.$CI->auth->get_user($data->updated_by)->lastname;
					}
					
				}
			}
			else
			{
				$info = '<strong>Deleted at:</strong> '.$data->deleted_at.'<br/><strong>Deleted by:</strong> '.$CI->auth->get_user($data->deleted_by)->firstname.' '.$CI->auth->get_user($data->deleted_by)->lastname;
			}

			return $info;
		}
		return false;
	}
}

if (!function_exists('get_languages')) {
	function get_languages($id = false)
	{
		if ($id) {

			$CI =& get_instance();
			$model = $CI->model;
			$CI->load->model($model);

			$language_string = '<div class="btn-group">';
			if(isset($CI->data['languages']))
			{
				foreach($CI->data['languages'] as $language_slug => $language)
				{
					$data = $CI->{$model}->filter(['id' => $id])->with_translation($language['id'])->with_trashed()->one();
					if($data)
					{
						$language_string .= '<a class="btn btn-default"><img src="/templates/administrator/new/global_assets/images/flags/'.$language['code'].'.png" alt="'.$language['name'].'"></a>';
					}	
					else
					{
						$language_string .= '<a class="btn btn-default" href="'.site_url_multi('administrator/'.$CI->module_name.'/edit/'.$id).'"><i class="icon-plus3"></i></a>';
					}
				}
			}

			$language_string .= '</div>';

			return $language_string;
		}
		return 'alma';
	}
}


