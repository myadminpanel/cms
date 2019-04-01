<?php
class Core_Exceptions extends CI_Exceptions {

	public function __construct()
	{
		parent::__construct();
	}

	public function show_404($page = '', $log_error = TRUE)
	{
		if (is_cli())
		{
			// For CLI
			$heading = 'Not Found';
			$message = 'The controller/method pair you requested was not found.';
			echo $this->show_error($heading, $message, 'error_404', 404);
		}
		else
		{
			$CI = &get_instance();
			$CI->data['title'] = translate('404_title', true);
			$CI->data['description'] =  translate('404_description', true);
			$CI->template->render('404');
			echo $CI->output->get_output();
		}
		
		exit(4);
	}

}