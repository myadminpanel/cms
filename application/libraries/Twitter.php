<?php 

class Twitter {

	protected $CI;

	public function __construct()
	{
		$this->CI =& get_instance();
	}

	public function login_url()
	{
		return  false;//$this->client->createAuthUrl();
	}
}