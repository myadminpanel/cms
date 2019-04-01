<?php defined('BASEPATH') or exit('No direct script access allowed');

class User extends Api_Controller {
	
	public function __construct()
	{
		parent::__construct();
		$this->load->model('User_model');
		$this->load->model('modules/Notification_model');
		$this->load->model('modules/Country_model');
		$this->load->model('modules/Favorite_model');
		$this->load->model('modules/Following_model');
		$this->load->model('modules/Following_model');
		$this->load->model('modules/Company_model');
		$this->load->model('modules/Review_model');
		
		$this->load->model('Notify_admin_model');
	}

	public function profile()
	{
		if($this->input->get('user_id'))
		{
			$user_id = (int)$this->input->get('user_id');
			$user = $this->auth->get_user($user_id);
			$this->template->json($user);
		}
	}

	public function login()
	{
		if($this->input->method() == 'post')
		{
			$json = json_decode(file_get_contents('php://input'), true);

			$_POST['email'] = $json['email'];
			$_POST['password'] = $json['password'];

			$this->form_validation->set_rules('email', translate('email'), 'required|trim|valid_email');
			$this->form_validation->set_rules('password', translate('password'), 'required|trim');

			if ($this->form_validation->run() === true)
			{

				if ($this->auth->login($this->input->post('email'), $this->input->post('password'), false))
				{
					$this->data['response'] = [
						'success' 	=> true,
						'message' 	=> translate('successfully_login'),
						'user_id' 	=> $this->auth->get_user()->id
					];
				}
				else
				{
					$this->data['response'] = [
						'success' => false,
						'message' => 'Login parol sehvdi'
					];
				}
			}
			else
			{
				$this->data['response'] = [
					'success' => false,
					'message' => 'Zibili yaz da'
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

	public function register()
	{
		if($this->input->method() == 'post')
		{

			$json = json_decode(file_get_contents('php://input'), true);

			$_POST['email'] = $json['email'];
			$_POST['mobile'] = $json['mobile'];
			$_POST['password'] = $json['password'];
			$_POST['repassword'] = $json['password_confirm'];


			$this->form_validation->set_rules('email', translate('email'), 'required|trim|valid_email');
			$this->form_validation->set_rules('mobile', translate('mobile'), 'required|trim');
			$this->form_validation->set_rules('password', translate('password'), 'required|trim');
			$this->form_validation->set_rules('repassword', translate('repassword'), 'required|trim|matches[password]');

			if ($this->form_validation->run() === true)
			{

				if ($this->auth->create_user($this->input->post('email'), $this->input->post('password'), false, '', '', false, strip_tags($this->input->post('mobile'))))
				{
					$this->auth->login($this->input->post('email'), $this->input->post('password'));

					$this->Notify_admin_model->insert(['text' => $this->input->post('email').' emaili ilə yeni istifadəçi qeydiyyatdan keçdi']);

					$this->data['response'] = [
						'success' 	=> true,
						'message' 	=> translate('successfully_register'),
						'user_id' => $this->auth->get_user()->id
					];


				}
				else
				{
					$this->data['response'] = [
						'success' => false,
						'message' => $this->auth->print_errors()
					];
				}
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

	public function change_password()
	{
		if($this->input->method() == 'post')
		{
			
			$json = json_decode(file_get_contents('php://input'), true);

			$_POST['password'] 		= $json['new_password'];
			$_POST['repassword'] 	= $json['new_password_confirm'];

			$this->form_validation->set_rules('password', translate('new_password'), 'required|trim');
			$this->form_validation->set_rules('repassword', translate('new_repassword'), 'required|trim|matches[password]');

			if($this->form_validation->run())
			{
				$this->auth->update_user($this->auth->get_user()->id, false, $this->input->post('password'));
				
				$this->data['response'] = [
					'success' => true,
					'message' => translate('password_successfully_changed')
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

	public function forget_password()
	{
		if($this->input->method() == 'post')
		{

			$json = json_decode(file_get_contents('php://input'), true);

			$_POST['email'] = $json['email'];

			$this->form_validation->set_rules('email', translate('email'), 'required|trim|valid_email');

			if ($this->form_validation->run() === true)
			{

				if ($this->auth->remind_password($this->input->post('email')))
				{
					$this->data['response'] = [
						'success' 	=> true,
						'message' 	=> translate('successfully_forget_password')
					];
				}
				else
				{
					$this->data['response'] = [
						'success' => false,
						'message' => translate('user_not_found')
					];
				}
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
	
	public function notification()
	{
		$this->data['notifications'] = [];
		$notifications = $this->Notification_model->filter(['user_id' => (int)$this->input->get('user_id')])->with_translation()->order_by('created_by', 'DESC')->all();
		if($notifications)
		{
			foreach($notifications as $notification)
			{
				$notify = new stdClass();
				$notify->id = $notification->id;
				$notify->text = $notification->text;
				$this->data['notifications'][] = $notify;
				
			}
		}
		$this->template->json($this->data['notifications']);
	}

	public function favorite()
	{
		if($this->input->get('user_id'))
		{
			$user_id = (int)$this->input->get('user_id');

			$favorites = $this->Favorite_model->filter(['user_id' => $user_id])->all();
		
			
			if($favorites)
			{
				foreach($favorites as $favorite)
				{
					$favorite_ids[] = $favorite->company_id;
				}

				$companies = $this->Company_model->filter(['id IN ('.implode(',', $favorite_ids).')' => NULL, 'status' => 1])->with_translation()->order_by('created_at', 'DESC')->all();
				if($companies)
				{
					foreach($companies as $company)
					{
						$country = $this->Country_model->filter(['status' => 1, 'id' => $company->country_id])->with_translation()->one();
						if($country)
						{
							$country_code = $this->Model_tool_image->resize($country->image, 32, 16);
						}
						else
						{
							$country_code = false;
						}

						$data = new stdClass();
						$data 						= new stdClass();
						$data->id 					= $company->id;
						$data->name 				= $company->name;
						$data->country_id 			= $company->country_id;
						$data->country_code 		= $country_code;
						$data->image 				= $this->Model_tool_image->resize($company->image, 400, 400);

						$result['result'][] = $data; 
					}
				}
				else
				{
					$result['result'] = [];
					$result['error'] = true;
				}
			}
			else
			{
				$result['result'] = [];
				$result['error'] = true;
			}

			$this->template->json($result);
		}
	}

	public function following()
	{
		if($this->input->get('user_id'))
		{
			$user_id = (int)$this->input->get('user_id');

			$followings = $this->Following_model->filter(['user_id' => $user_id])->all();
		
			
			if($followings)
			{
				foreach($followings as $following)
				{
					$following_ids[] = $following->company_id;
				}

				$companies = $this->Company_model->filter(['id IN ('.implode(',', $following_ids).')' => NULL, 'status' => 1])->with_translation()->order_by('created_at', 'DESC')->all();
				if($companies)
				{
					foreach($companies as $company)
					{
						$country = $this->Country_model->filter(['status' => 1, 'id' => $company->country_id])->with_translation()->one();
						if($country)
						{
							$country_code = $this->Model_tool_image->resize($country->image, 32, 16);
						}
						else
						{
							$country_code = false;
						}

						$data = new stdClass();
						$data 						= new stdClass();
						$data->id 					= $company->id;
						$data->name 				= $company->name;
						$data->country_id 			= $company->country_id;
						$data->country_code 		= $country_code;
						$data->image 				= $this->Model_tool_image->resize($company->image, 400, 400);

						$result['result'][] = $data; 
					}
				}
				else
				{
					$result['result'] = [];
					$result['error'] = true;
				}
			}
			else
			{
				$result['result'] = [];
				$result['error'] = true;
			}

			$this->template->json($result);
		}
	}

	public function favorite_add()
	{
		$favorite = [
			'company_id'	=> (int)$this->input->get('company_id'),
			'user_id'		=> (int)$this->input->get('user_id')
		];

		$row = $this->Favorite_model->filter($favorite)->with_trashed()->one();
		if($row) {
			$this->Favorite_model->force_delete($favorite);
			$response = [
				'success' 	=> true,
				'type'		=> 'deleted',
				'message'	=> translate('successfully_removed_from_favorite')
			];
		} else {
			$this->Favorite_model->insert($favorite);
			$response = [
				'success' 	=> true,
				'type'		=> 'inserted',
				'message'	=> translate('successfully_added_to_favorite')
			];
		}

		$this->template->json($response);
	}

	public function following_add()
	{
		$following = [
			'company_id'	=> (int)$this->input->get('company_id'),
			'user_id'		=> (int)$this->input->get('user_id')
		];

		$row = $this->Following_model->filter($following)->with_trashed()->one();
		if($row) {
			$this->Following_model->force_delete($following);
			$response = [
				'success' 	=> true,
				'type'		=> 'deleted',
				'message'	=> translate('successfully_removed_from_following')
			];
		} else {
			$this->Following_model->insert($following);
			$response = [
				'success' 	=> true,
				'type'		=> 'inserted',
				'message'	=> translate('successfully_added_to_following')
			];
		}

		$this->template->json($response);
	}

	public function comment_add()
	{
		if($this->input->method() == 'post')
		{

			$json = json_decode(file_get_contents('php://input'), true);

			$_POST['type'] = $json['type'];

			$this->form_validation->set_rules('type', translate('type'), 'required|trim');


			if($this->input->post('type') == 'company')
			{
				
				$_POST['rating'] = $json['rating'];
				$this->form_validation->set_rules('rating', translate('rating'), 'required|trim');
				if($this->input->post('rating') != 1)
				{
					$this->form_validation->set_rules('text', translate('text'), 'required|trim');
				}
			}
			else
			{
				$this->form_validation->set_rules('text', translate('text'), 'required|trim');
			}

			$_POST['data_id'] = $json['data_id'];
			$this->form_validation->set_rules('data_id', translate('data_id'), 'required|trim');
			$user_id = (int)$json['user_id'];
			
			if($this->form_validation->run())
			{

				$user_id = $this->auth->get_user($user_id)->id;
				$fullname = $this->auth->get_user($user_id)->firstname.' '.$this->auth->get_user($user_id)->lastname;
				$email =  $this->auth->get_user($user_id)->email;
				

				if($this->input->post('type') == 'company')
				{
					$stars = [
						'1' => 5,
						'2' => 4,
						'3' => 3,
						'4' => 2,
						'5' => 1
					];
					$rating = (int)$this->input->post('rating');
					$star = $stars[$rating];
				}
				else
				{
					$star = 0;
				}

				$parent_id = 0;
				

				$comment = [
					'type'				=> $this->input->post('type'),
					'data_id'			=> $this->input->post('data_id'),
					'parent_id'			=> $parent_id,
					'location'			=> $this->input->post('type').'-'.$this->input->post('data_id'),
					'user_id'			=> $user_id,
					'fullname'			=> $fullname,
					'email'				=> $email,
					'status'			=> 0,
					'star'				=> $star,
					'comment'			=> strip_tags($this->input->post('text'))
				];

				$types = [
					'company' => 'şirkətə',
					'gallery' => 'qalereyaya',
					'video'	=> 'videoya',
					'news'	=> 'xəbərə',
					'service' => 'xidmətə',
					'product' => 'məhsula',
					'discount' => 'endirimə',
				];

				$name_data = $this->{ucfirst($comment['type']).'_model'}->filter(['id' => $comment['data_id']])->with_translation()->one();

				if($name_data)
				{
					$name = $name_data->name;
				}
				else
				{
					$name = '';
				}

				$this->Review_model->insert($comment);

				$this->Notify_admin_model->insert(['text' => '<strong>'.$fullname.'</strong> adlı istifadəçi (<strong>'.$comment['email'].'</strong>) <strong>'.$comment['data_id'].'</strong> ID-li <strong>'.$name.'</strong> adlı '.$types[$comment['type']].'  şərh yazdı']);

				$this->data['response'] = [
					'success' => true,
					'message' => translate('comment_successfully')
				];
			}
			else
			{
				$this->data['response'] = [
					'success' => false,
					'message' => strip_tags(validation_errors())
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