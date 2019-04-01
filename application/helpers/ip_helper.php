<?php

if (!function_exists('get_user_ip')) {
	function get_user_ip()
	{
		foreach (array('HTTP_X_FORWARDED_FOR', 'HTTP_CLIENT_IP', 'HTTP_X_CLIENT_IP', 'HTTP_X_CLUSTER_CLIENT_IP', 'REMOTE_ADDR') as $header)
		{
			if (!isset($_SERVER[$header]) || ($spoof = $_SERVER[$header]) === null) {
				continue;
			}
			sscanf($spoof, '%[^,]', $spoof);
			if (!filter_var($spoof, FILTER_VALIDATE_IP, FILTER_FLAG_IPV4)) {
				$spoof = null;
			} else {
				return $spoof;
			}
		}
		return '0.0.0.0';
	}
}