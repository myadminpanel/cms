<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Notification extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		
		if(!$this->auth->is_loggedin())
		{
			redirect(site_url_multi('/'), 'refresh');
		}

		$this->load->model('modules/Notification_model');
	}

	public function index()
	{
		$this->data['title'] = translate('title');

		$this->data['notifications'] = $this->Notification_model->filter(['user_id' => $this->auth->get_user()->id])->with_translation()->order_by('created_by', 'DESC')->all();

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

				$this->data['language_link'][$key] = site_url($lang_slug.'notification/');
				
			}
		}
		// Language link
		
		$this->template->render('notification/index');
	}

	public function delete()
	{
		if($this->input->method() == 'post')
		{
			$this->form_validation->set_rules('notification_id', 'notification_id', 'required|trim');
			
			if($this->form_validation->run())
			{
				$notification_id = (int)$this->input->post('notification_id');
				$user_id = $this->auth->get_user()->id;
				$delete = $this->Notification_model->delete(['id' => $notification_id, 'user_id' => $user_id]);

				$this->data['response'] = [
					'success' => true,
					'message' => translate('notification_successfully_deleted')
				];
			}
			else
			{
				$this->data['response'] = [
					'success' => false,
					'message' => validation_errors()
				];
			}
		}
		else
		{
			$this->data['response'] = [
				'success' => false,
				'message' => translate('only_post_request', true)
			];
		}

		$this->template->json($this->data['response']);
	}

	public function delete_all()
	{
		if($this->input->method() == 'post')
		{
			$user_id = $this->auth->get_user()->id;
			$delete = $this->Notification_model->delete(['user_id' => $user_id]);
			if($delete)
			{
				$this->data['response'] = [
					'success' => true,
					'message' => translate('notifications_successfully_deleted')
				];
			}
			else
			{
				$this->data['response'] = [
					'success' => false,
					'message' => translate('unknown_error')
				];
			}
			
		}
		else
		{
			$this->data['response'] = [
				'success' => false,
				'message' => translate('only_post_request', true)
			];
		}

		$this->template->json($this->data['response']);
	}
}