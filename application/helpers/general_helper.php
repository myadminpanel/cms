<?php defined('BASEPATH') or exit('No direct script access allowed');

if (!function_exists('get_description')) {
	function get_description($description = false, $text_limit = 100)
	{
		if($description)
		{
			$short_description = mb_substr(strip_tags($description), 0, $text_limit).'...';
			return $short_description;

		}
		return false;
	}
}

if (!function_exists('format_date')) {
	function format_date($date = false, $format = 'd n Y')
	{
		$months = [
			'empty',
			'January',
			'February',
			'March',
			'April',
			'May',
			'June',
			'July',
			'August',
			'September',
			'October',
			'November',
			'December'
		];



		if($date)
		{
			$month_en = date('F', strtotime($date));
			$month = translate(strtolower($months[date('n', strtotime($date))]), true);
			$date = date($format, strtotime($date));
			$date = str_replace($month_en, $month, $date);
			return $date;
		}
		return false;
	}
}

if (!function_exists('youtube_id')) {
	function youtube_id($youtube_url = false)
	{
		if($youtube_url)
		{
			parse_str(parse_url($youtube_url, PHP_URL_QUERY ), $my_array_of_vars);
			return $my_array_of_vars['v'];
		}
		return false;
	}
}

if (!function_exists('youtube_image')) {
	function youtube_image($youtube_url = false)
	{
		if($youtube_url)
		{
			parse_str(parse_url($youtube_url, PHP_URL_QUERY ), $my_array_of_vars);
			return 'https://img.youtube.com/vi/'.$my_array_of_vars['v'].'/0.jpg';
		}
		return false;
	}
}

if (!function_exists('working_time'))
{
	function working_time($working_time = false)
	{
		if($working_time)
		{
			$data = json_decode($working_time, TRUE);
			$work_day = '';
			
			if(
				($data[1]['status'] && $data[2]['status'] &&  $data[3]['status'] && $data[4]['status'] && $data[5]['status']) &&
				(($data[1]['start_time'] == $data[2]['start_time']) && ($data[2]['start_time'] == $data[3]['start_time']) && ($data[3]['start_time'] == $data[4]['start_time']) && ($data[4]['start_time'] == $data[5]['start_time'])) &&
				(($data[1]['end_time'] == $data[2]['end_time']) && ($data[2]['end_time'] == $data[3]['end_time']) && ($data[3]['end_time'] == $data[4]['end_time']) && ($data[4]['end_time'] == $data[5]['end_time']))
			)
			{
				$work_day .= translate('every_workday').' '.$data[1]['start_time'].'-'.$data[1]['end_time'].'<br/>';
			}

			if($data[6]['status'])
			{
				$work_day .= translate('saturday', true).' '.$data[6]['start_time'].'-'.$data[6]['end_time'].'<br/>';
			}
			

			if(
				($data[1]['status'] && $data[2]['status'] &&  $data[3]['status'] && $data[4]['status'] && $data[5]['status'] && $data[6]['status'] && $data[0]['status']) &&
				(
					($data[0]['start_time'] == $data[0]['end_time']) &&
					($data[1]['start_time'] == $data[1]['end_time']) &&
					($data[2]['start_time'] == $data[2]['end_time']) &&
					($data[3]['start_time'] == $data[3]['end_time']) &&
					($data[4]['start_time'] == $data[4]['end_time']) &&
					($data[5]['start_time'] == $data[5]['end_time']) &&
					($data[6]['start_time'] == $data[6]['end_time'])
				)
			)
			{
				$work_day = translate('every_day');
			}

			if($data['dinner']['status'])
			{
				$work_day.= translate('dinner').' '.$data['dinner']['start_time'].'-'.$data['dinner']['end_time'].'<br/>';
			}
			
		}
		return $work_day;
	}
}

if (!function_exists('is_online')) {
	function is_online($working_time = false)
	{
		if($working_time)
		{
			$data = json_decode($working_time, TRUE);
			if(array_key_exists(date('w'), $data)){
				if($data[date('w')]['status']) {
					if(date('H:i') > $data[date('w')]['start_time'] && date('H:i') < $data[date('w')]['end_time']) {
						return true;
					} else {
						return false;
					}
				}
			}
		}
		return false;
	}
}
