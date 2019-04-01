<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Logger{

	public $CI;
	
	public function __construct()
	{
		$this->CI = &get_instance();
	}

	public function write($message = false)
	{
		$this->CI->load->model('modules/Log_model');

		$date = date('Y-m-d H:i:s');

		$ip = $this->CI->input->ip_address();

		if(!$message)
		{
			$message = '';
		}


		if(is_loggedin())
		{
			$user_id = $this->CI->auth->get_user()->id;
		}
		else
		{
			$user_id = '0';
		}

		


		$this->CI->load->library('User_agent');

		if ($this->CI->agent->is_browser())
		{
				$agent = $this->CI->agent->browser().' '.$this->CI->agent->version();
		}
		elseif ($this->CI->agent->is_robot())
		{
				$agent = $this->CI->agent->robot();
		}
		elseif ($this->CI->agent->is_mobile())
		{
				$agent = $this->CI->agent->mobile();
		}
		else
		{
				$agent = 'Unidentified User Agent';
		}

		if ( $this->CI->agent->referrer())
		{
			$referrer = $this->CI->agent->referrer();
		}
		else
		{
			$referrer = '';
		}

		$platform = $this->CI->agent->platform();

		($this->CI->input->post() == null) ? $post = '' : $post = json_encode($this->CI->input->post());
		($this->CI->input->server('QUERY_STRING') == null) ? $url = current_url() : $url = current_url()."?".$this->CI->input->server('QUERY_STRING');
 
		$log_data = array(
			'user_id'		=> $user_id,
			'ip'			=> $ip,
			'user_agent'	=> $agent,
			'referrer'		=> $referrer,
			'date'			=> $date,
			'platform'		=> $platform,
			'message'		=> $message,
			'url'			=> $url,
			'post'			=> $post
		);
		$this->CI->load->model('modules/Log_model');
		$this->CI->Log_model->insert($log_data);

	}
}