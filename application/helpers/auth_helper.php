<?php

if (!function_exists('is_loggedin')) {
	function is_loggedin()
	{
		$CI =& get_instance();
		return $CI->auth->is_loggedin();
	}
}

if (!function_exists('get_user')) {
	function get_user($user_id = false)
	{
		$CI =& get_instance();
		return $CI->auth->get_user($user_id)->firstname.' '.$CI->auth->get_user($user_id)->lastname;
	}
}

if (!function_exists('get_user_id')) {
	function get_user_id()
	{
		if(is_loggedin())
		{
			$CI =& get_instance();
			return $CI->auth->get_user()->id;
		}
		return false;
		
	}
}

