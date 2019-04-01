<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Contact extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Contact_model');
	}

	public function index()
	{
		$this->data['title'] = translate('title');

		$this->load->library('Recaptcha');
		$this->data['recaptcha'] = [
			'widget' => $this->recaptcha->getWidget(),
			'script' => $this->recaptcha->getScriptTag(),
		];

		
		$this->data['request'] = $this->input->method();

		if($this->input->method() == 'post')
		{
			$this->form_validation->set_rules('name', translate('fullname'), 'required|trim');
			$this->form_validation->set_rules('email', translate('email'), 'required|trim|valid_email');
			$this->form_validation->set_rules('subject', translate('subject'), 'required|trim');
			$this->form_validation->set_rules('message', translate('message'), 'required|trim');
			$this->form_validation->set_rules('recaptcha_response', translate('recaptcha_response'), 'required');

			$recaptcha_url = 'https://www.google.com/recaptcha/api/siteverify';
			$recaptcha_secret = '6LeIhZIUAAAAABg6yiSpiRWDcbJbVcKP0ZY3EmnH';
			$recaptcha_response = $this->input->post('recaptcha_response');
		
			// Make and decode POST request:
			$recaptcha = file_get_contents($recaptcha_url . '?secret=' . $recaptcha_secret . '&response=' . $recaptcha_response);
			$recaptcha = json_decode($recaptcha);


			
			if($this->form_validation->run())
			{
				if($recaptcha->success && $recaptcha->score > 0.5)
				{
					$message = [
						'name'			=> strip_tags($this->input->post('name', true)),
						'email'			=> strip_tags($this->input->post('email', true)),
						'subject'		=> strip_tags($this->input->post('subject', true)),
						'message'		=> strip_tags($this->input->post('message', true)),
						'status' 		=> 0
					];
	
					$this->Contact_model->insert($message);
	
					$this->data['response'] = [
						'success' 	=> true,
						'message'	=> translate('successfully_send_mail', true)
					];
				}
				else
				{
					$this->data['response'] = [
						'success' 	=> false,
						'message'	=> translate('verification_error', true)
					];
				}
				
			}
			else
			{
				$this->data['response'] = [
					'success' 	=> false,
					'message'	=> validation_errors()
				];
			}

		}

		//Language Links
		if($this->data['languages'])
		{
			foreach($this->data['languages'] as $key => $langauge)
			{
				if($key == $this->data['default_language'])
				{
					$lang_slug = '';
				}
				else
				{
					$lang_slug = $key.'/';
				}

				$this->data['language_link'][$key] = site_url($lang_slug.'contact/');
				
			}
		}
		// Language link

		$this->template->render('contact');
	}
}