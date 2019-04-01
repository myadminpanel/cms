<?php 

class Linkedin {

	protected $CI;

	public function __construct()
	{
		$this->CI =& get_instance();
		$this->CI->config->load('linkedin');
	}

	public function login_url()
	{
		return  base_url().$this->CI->config->item('linkedin_redirect_url').'?oauth_init=1';
	}
}