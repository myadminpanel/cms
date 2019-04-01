<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Following extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Following_model');
		$this->load->model('modules/Company_model');
	}

	public function index()
	{
		if(!$this->auth->is_loggedin())
		{
			redirect(site_url_multi('/'), 'refresh');
		}
		
		$this->data['title'] = translate('title');
		$this->breadcrumbs->push(translate('title'), 'following');

		$user_id = $this->auth->get_user()->id;

		$followings = $this->Following_model->filter(['user_id' => $user_id])->all();
		
		$this->data['companies'] = [];
		
		if($followings)
		{
			foreach($followings as $following)
			{
				$following_ids[] = $following->company_id;
			}
			
			$companies = $this->Company_model->filter(['id IN ('.implode(',', $following_ids).')' => NULL ])->with_translation()->order_by('created_at', 'DESC')->limit(10, 0)->all();
			if($companies)
			{
				foreach($companies as $company)
				{
					$data = new stdClass();
					$data->id = $company->id;
					$data->name = $company->name;
					$data->link = site_url_multi('company/'.$company->slug);
					$data->image = $this->Model_tool_image->resize($company->image, 200, 200);
					$data->description = get_description($company->description);

					$this->data['companies'][] = $data; 
				}
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

				$this->data['language_link'][$key] = site_url($lang_slug.'following/');
				
			}
		}
		// Language link

		$this->template->render('following');
	}
	
	public function add()
	{
		$response = ['success' => false, 'type'	=> 'other', "message" => ""];

		if($this->input->method() == 'post') 
		{
			$this->form_validation->set_rules('company_id', 'company_id', 'is_natural_no_zero');
			if($this->form_validation->run())
			{
				$id = $this->input->post('company_id');
				if($this->auth->is_loggedin())
				{
					$follow = [
						'company_id'	=> $id,
						'user_id'		=> $this->auth->get_user()->id
					];

					$row = $this->Following_model->filter($follow)->with_trashed()->one();
					if($row) {
						$this->Following_model->force_delete($follow);
						$response = [
							'success' 	=> true,
							'type'		=> 'deleted',
							'message'	=> translate('successfully_removed_from_follow')
						];
					} else {
						$this->Following_model->insert($follow);
						$response = [
							'success' 	=> true,
							'type'		=> 'inserted',
							'message'	=> translate('successfully_added_to_follow')
						];
					}
				}
				else
				{
					$response = [
						'success' 	=> false,
						'type' 		=> 'login',
						'message'	=> translate('please_login')
					];
				}
			}
			else
			{
				$response = [
					'success' 	=> false,
					'type'		=> 'other',
					'message'	=> translate('company_id_not_found')
				];
			}

		}

		$this->template->json($response);
	}


	public function remove()
	{
		if($this->input->method() == 'post')
		{
			$this->form_validation->set_rules('company_id', 'company_id', 'required|trim');
			
			if($this->form_validation->run())
			{
				$company_id = (int)$this->input->post('company_id');
				$user_id = $this->auth->get_user()->id;
				$delete = $this->Following_model->delete(['company_id' => $company_id, 'user_id' => $user_id]);

				$this->data['response'] = [
					'success' => true,
					'message' => translate('following_successfully_deleted')
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

	public function remove_all()
	{
		if($this->input->method() == 'post')
		{
			$user_id = $this->auth->get_user()->id;
			$delete = $this->Following_model->delete(['user_id' => $user_id]);
			if($delete)
			{
				$this->data['response'] = [
					'success' => true,
					'message' => translate('followings_successfully_deleted')
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