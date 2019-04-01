<?php

if (!function_exists('get_banner')) {
	function get_banner($name = false)
	{
		$CI =& get_instance();
		$CI->load->model('modules/Banner_model');
		$banner = $CI->Banner_model->filter(['name' => $name, 'status' => 1])->one();
		if($banner)
		{
			return $banner;
		}
		return false;
	}
}