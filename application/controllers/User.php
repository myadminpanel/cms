<?php
defined('BASEPATH') or exit('No direct script access allowed');

class User extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Company_model');
		$this->load->model('modules/Gallery_model');
		$this->load->model('modules/Video_model');
		$this->load->model('modules/News_model');
		$this->load->model('modules/Discount_model');
		$this->load->model('modules/Product_model');
		$this->load->model('modules/Service_model');
		$this->load->model('modules/Review_model');
		$this->load->model('User_model');
	}

	public function index($id = false)
	{
		if($id)
		{
			$user = $this->User_model->filter(['id' => $id])->one();
			if($user)
			{
				$this->data['title'] = $user->firstname.' '.$user->lastname;
				$this->data['firstname'] = $user->firstname;
				$this->data['lastname'] = $user->lastname;
				$this->data['mobile'] = $user->mobile;
				$this->data['email'] = $user->email;
				$this->data['review_count'] = $this->Review_model->filter(['user_id' => $user->id])->count_rows();
				if($user->image)
				{
					$this->data['image'] = $this->Model_tool_image->resize($user->image, 250, 250);
					$this->data['image_full'] = base_url('uploads/'.$user->image);
				}
				else
				{
					$this->data['image'] = $this->Model_tool_image->resize('catalog/user/user_default.png', 250, 250);
					$this->data['image_full'] = base_url('uploads/catalog/user/user_default.png');
				}


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
		
						$this->data['language_link'][$key] = site_url($lang_slug.'user/index/'.$id);
						
					}
				}

				$this->template->render('user/index');
			}
			else
			{
				show_404();
			}
		}
		else
		{
			show_404();
		}
	}

	public function login()
	{
		if($this->input->method() == 'post')
		{
			$this->form_validation->set_rules('email', translate('email'), 'required|trim|valid_email');
			$this->form_validation->set_rules('password', translate('password'), 'required|trim');

			if ($this->form_validation->run() === true)
			{
				$remember = (bool)$this->input->post('remember');

				if ($this->auth->login($this->input->post('email'), $this->input->post('password'), $remember))
				{
					$this->data['response'] = [
						'success' 	=> true,
						'message' 	=> translate('successfully_login'),
						'redirect' 	=> site_url_multi('user/profile')
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

	public function register()
	{
		if($this->input->method() == 'post')
		{
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
						'redirect' 	=> site_url_multi('user/profile')
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

	public function activation()
	{
		$this->data['title'] = translate('user_activation');

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

				$this->data['language_link'][$key] = site_url($lang_slug.'user/activation');
				
			}
		}
		// Language link

		$this->template->render('user/activation');
	}

	public function logout()
	{
		$this->auth->logout();
		redirect(site_url_multi('/'), 'refresh');
	}

	public function forget_password()
	{
		if($this->input->method() == 'post')
		{
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

	public function reset_password($key = false)
	{
		$this->data['title'] = translate('reset_password');

		//Breadcrumb
		$this->breadcrumbs->push(translate('reset_password'), 'user/reset_password');

		if($this->auth->reset_password($key))
		{
			$this->data['response'] = [
				'success' => true,
				'message' => translate('password_successfully_send')
			];
		}
		else
		{
			$this->data['response'] = [
				'success' => false,
				'message' => translate('your_verification_key_error')
			];
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

				$this->data['language_link'][$key] = site_url($lang_slug.'user/reset_password');
				
			}
		}
		// Language link

		$this->template->render('user/reset_password');
	}

	// Facebook
	public function facebook_login()
	{
		$this->load->library('facebook');
		$data['user'] = array();

		// Check if user is logged in
		if ($this->facebook->is_authenticated() && !is_loggedin())
		{
			// User logged in, get user details
			$user = $this->facebook->request('get', '/me?fields=id,name,email,picture.type(large).width(250).height(250)');
			if (!isset($user['error']))
			{
				// Success login
				$user_id = $user['id'];
				$fullname = $user['name'];
				$email = $user['email'];


				

				$content = file_get_contents("http://graph.facebook.com/".$user_id."/picture?width=250&height=250&redirect=false");
				$data = json_decode($content, true);
				$filename = 'catalog/user/'.md5($user_id).'.jpg';
				$content = file_get_contents($data["data"]["url"]);
				file_put_contents(DIR_IMAGE.$filename, $content);
				
				$data = $user;
				// Check user exist 
				if(!$this->auth->login($email, $user_id)) {
					$firstname = '';
					$lastname = '';
					if($fullname) {
						$fullname = explode(' ', $fullname);
						if(array_key_exists(0,$fullname)){
							$firstname = $fullname[0];
							$lastname = $fullname[1];
						}
					}
					$response = $this->auth->ceate_user_by_social($user_id, $firstname, $lastname, $email, 'facebook', $filename);
					
					
					if($response) {
						$this->auth->login($email, $user_id);
						$this->Notify_admin_model->insert(['text' => $email.' emaili ilə facebook vasitəsi ilə yeni istifadəçi qeydiyyatdan keçdi']);
					}
				} else {
					redirect(base_url().'user/profile');
				}
				
			}
		} 

		redirect(base_url());
	}

	public function linkedin_login()
	{
		include_once APPPATH."libraries/linkedin-oauth-client/http.php";
		include_once APPPATH."libraries/linkedin-oauth-client/oauth_client.php";
		$this->config->load('linkedin');
		
		//Get status and user info from session
		$oauthStatus = $this->session->userdata('oauth_status');
		$sessUserData = $this->session->userdata('userData');
		
		if(($this->input->get("oauth_init") && $this->input->get("oauth_init") == 1) || ($this->input->get('oauth_token') && $this->input->get('oauth_verifier')))
		{
			$client = new oauth_client_class;
			$client->client_id = $this->config->item('linkedin_api_key');
			$client->client_secret = $this->config->item('linkedin_api_secret');
			$client->redirect_uri = base_url().$this->config->item('linkedin_redirect_url');
			$client->scope = $this->config->item('linkedin_scope');
			$client->debug = false;
			$client->debug_http = true;
			$application_line = __LINE__;
			
			//If authentication returns success
			if($success = $client->Initialize())
			{
				if(($success = $client->Process()))
				{
					
					if(strlen($client->authorization_error))
					{
						$client->error = $client->authorization_error;
						$success = false;
					}
					elseif(strlen($client->access_token))
					{
						$success = $client->CallAPI('http://api.linkedin.com/v1/people/~:(id,email-address,first-name,last-name,location,picture-url,public-profile-url,formatted-name)', 
						'GET',
						['format'=>'json'],
						['FailOnAccessError'=>true], $userInfo);
					}
				}
				$success = $client->Finalize($success);
				
			}

			if($client->exit) exit;
	
			if($success)
			{
				//Preparing data for database insertion
				$firstname = !empty($userInfo->firstName)?$userInfo->firstName:'';
				$lastname = !empty($userInfo->lastName)?$userInfo->lastName:'';
				
				$userData = array(
					'oauth_provider'=> 'linkedin',
					'oauth_uid' 	=> $userInfo->id,
					'firstname' 	=> $firstname,
					'lastname' 		=> $lastname,
					'email' 		=> $userInfo->emailAddress,
					'locale' 		=> $userInfo->location->name,
					'profile_url' 	=> $userInfo->publicProfileUrl,
					'picture_url' 	=> $userInfo->pictureUrl
				);
				
				//Insert or update user data
				$response = $this->auth->ceate_user_by_social($userInfo->id, $firstname, $lastname, $userInfo->emailAddress, 'linkedin');
				
				if($response)
				{
					$this->auth->login($userInfo->emailAddress, $userInfo->id);
					$this->Notify_admin_model->insert(['text' => $userInfo->emailAddress.' emaili ilə linkedin vasitəsi ilə yeni istifadəçi qeydiyyatdan keçdi']);
				}
				else
				{
					$user_id = $this->auth->user_exist_by_email($userInfo->emailAddress);
					$this->auth->login_fast($user_id);
				}
				//Redirect the user back to the same page
				redirect('user/profile');

			}
			else
			{
				 $this->data['error_msg'] = 'Some problem occurred, please try again later!';
			}
		}
		elseif(isset($_REQUEST["oauth_problem"]) && $_REQUEST["oauth_problem"] <> "")
		{
			
			$this->data['error_msg'] = $_GET["oauth_problem"];
		}
		else
		{
			redirect(base_url().$this->config->item('linkedin_redirect_url').'?oauth_init=1');
		}
	}

	// Google
	public function google_login()
	{
		$this->load->library('google');
		$google_data=$this->google->validate();

		$data = array(
			'id' => $google_data['id'],
			'fullname'=>$google_data['name'],
			'email'=>$google_data['email'],
		);

		if($data && !is_loggedin())
		{
			// Check user exist 
			if(!$this->auth->login($data['email'], $data['id'])) {
				$firstname = '';
				$lastname = '';
				
				if($data['fullname']) {
					$fullname = explode(' ', $data['fullname']);
					if(array_key_exists(0,$fullname)){
						$firstname = $fullname[0];
					} 
					if(array_key_exists(1,$fullname)){
						$lastname = $fullname[1];
					}
				}

				$response = $this->auth->ceate_user_by_social($data['id'], $firstname, $lastname, $data['email'], 'google');
				
				if($response) {
					$this->auth->login($data['email'], $data['id']);
					$this->Notify_admin_model->insert(['text' => $data['email'].' emaili ilə google vasitəsi ilə yeni istifadəçi qeydiyyatdan keçdi']);
				}
				else
				{
					$user_id = $this->auth->user_exist_by_email($data['email']);
					$this->auth->login_fast($user_id);
				}
			} else {
				redirect(base_url().'user/profile');
			}
		}
		redirect(base_url());
	}

	public function profile()
	{
		if(!$this->auth->is_loggedin())
		{
			redirect(site_url_multi('/'), 'refresh');
		}
		$this->data['title'] = translate('user_profile', true);
		
		//Breadcrumb
		$this->breadcrumbs->push(translate('user_profile', true), 'user/profile');

		$this->data['user'] = [
			'firstname'	=> $this->auth->get_user()->firstname,
			'lastname'	=> $this->auth->get_user()->lastname,
			'email'	=> $this->auth->get_user()->email,
			'mobile'	=> $this->auth->get_user()->mobile,
			'image'	=> $this->auth->get_user()->image,
		];

		$this->form_validation->set_rules('firstname', translate('firstname'), 'required|trim');
		$this->form_validation->set_rules('lastname', translate('lastname'), 'required|trim');
		$this->form_validation->set_rules('email', translate('email'), 'required|trim|valid_email');
		$this->form_validation->set_rules('mobile', translate('mobile'), 'required|trim');

		if($this->input->method() == 'post')
		{

			$this->data['user'] = [
				'firstname'	=> strip_tags($this->input->post('firstname')),
				'lastname'	=> strip_tags($this->input->post('lastname')),
				'email'		=> strip_tags($this->input->post('email')),
				'mobile'	=> strip_tags($this->input->post('mobile')),
				'image'		=> strip_tags($this->input->post('image')),
			];

			if($this->form_validation->run())
			{
				$this->auth->update_user($this->auth->get_user()->id, $this->input->post('email'), false, false, $this->input->post('firstname'), $this->input->post('lastname'), false, $this->input->post('mobile'), $this->input->post('image'));

				$this->data['response'] = [
					'success' => true,
					'message' => translate('profile_successfully_updated')
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

				$this->data['language_link'][$key] = site_url($lang_slug.'user/profile');
				
			}
		}
		// Language link

		$this->template->render('user/profile');
	}

	public function change_password()
	{
		if(!$this->auth->is_loggedin())
		{
			redirect(site_url_multi('/'), 'refresh');
		}
		$this->data['title'] = translate('change_password');

		//Breadcrumb
		$this->breadcrumbs->push(translate('change_password'), 'user/change_password');
		

		$this->form_validation->set_rules('password', translate('new_password'), 'required|trim');
		$this->form_validation->set_rules('repassword', translate('new_repassword'), 'required|trim|matches[password]');
		//$this->form_validation->set_error_delimiters('', '');

		if($this->input->method() == 'post')
		{
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

				$this->data['language_link'][$key] = site_url($lang_slug.'user/change_password');
				
			}
		}
		// Language link
		

		$this->template->render('user/change_password');
	}

	public function company()
	{
		if(!$this->auth->is_loggedin())
		{
			redirect(site_url_multi('/'), 'refresh');
		}

		$this->data['title'] = translate('company_title');
		
		//Breadcrumb
		$this->breadcrumbs->push(translate('company_title'), 'user/company');

		$companies = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id])->with_translation()->order_by('created_at', 'DESC')->all();

		$this->data['rows'] = [];
		if($companies)
		{
			foreach($companies as $company)
			{

				if($company->status == 1)
				{
					$status = '<span class="badge badge-success" style="color:#fff;">'.translate('active',true).'</span>';
				}
				elseif($company->status == 2)
				{
					$status = '<span class="badge badge-warning" style="color:#fff;">'.translate('waiting',true).'</span>';
				}
				elseif($company->status == 0)
				{
					$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
				}
				else
				{
					$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
				}

				$row = new stdClass();
				$row->id = $company->id;
				$row->name = $company->name;
				$row->status = $status;
				$row->date = format_date($company->created_at, 'd F Y');
				$row->link = ($company->status == 1) ? site_url_multi('company/'.$company->slug) : false;
				$row->edit_link = site_url_multi('company/edit/'.$company->id);
				$row->delete_link = site_url_multi('company/delete/'.$company->id);

				$this->data['rows'][] = $row;
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

				$this->data['language_link'][$key] = site_url($lang_slug.'user/company');
				
			}
		}
		// Language link
		

		$this->template->render('user/company');
	}

	public function gallery()
	{
		if(!$this->auth->is_loggedin())
		{
			redirect(site_url_multi('/'), 'refresh');
		}

		$this->data['title'] = translate('gallery_title');

		
		//Breadcrumb
		$this->breadcrumbs->push(translate('gallery_title'), 'user/gallery');
		
		$companies = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id])->with_translation()->order_by('created_at', 'DESC')->all();
		$company_ids = [];
		if($companies)
		{
			foreach($companies as $company)
			{
				$company_ids[] = $company->id;
			}
			$company_ids = implode(',',$company_ids);
		}

		$this->data['rows'] = [];

		if($company_ids) {			

			$galleries = $this->Gallery_model->filter(['company_id IN('.$company_ids.')' => null])->with_translation()->order_by('created_at', 'DESC')->all();

			if($galleries)
			{
				foreach($galleries as $gallery)
				{

					if($gallery->status == 1)
					{
						$status = '<span class="badge badge-success" style="color:#fff;">'.translate('active',true).'</span>';
					}
					elseif($gallery->status == 2)
					{
						$status = '<span class="badge badge-warning" style="color:#fff;">'.translate('waiting',true).'</span>';
					}
					elseif($gallery->status == 0)
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}
					else
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}

					$row = new stdClass();
					$row->id = $gallery->id;
					$row->name = $gallery->name;
					$row->company = $this->Company_model->filter(['company_id' => $gallery->company_id])->with_translation()->one()->name;
					$row->status = $status;
					$row->date = format_date($gallery->created_at, 'd F Y');
					$row->link =  ($gallery->status == 1) ? site_url_multi('gallery/'.$gallery->slug) : false;
					$row->edit_link = site_url_multi('gallery/edit/'.$gallery->id);
					$row->delete_link = site_url_multi('gallery/delete/'.$gallery->id);

					$this->data['rows'][] = $row;
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

				$this->data['language_link'][$key] = site_url($lang_slug.'user/gallery');
				
			}
		}
		// Language link

		
		$this->template->render('user/gallery');
	}

	public function video()
	{
		if(!$this->auth->is_loggedin())
		{
			redirect(site_url_multi('/'), 'refresh');
		}

		$this->data['title'] = translate('video_title');
		
		//Breadcrumb
		$this->breadcrumbs->push(translate('video_title'), 'user/video');

		$companies = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id])->with_translation()->order_by('created_at', 'DESC')->all();
		$company_ids = [];
		if($companies)
		{
			foreach($companies as $company)
			{
				$company_ids[] = $company->id;
			}

			$company_ids = implode(',',$company_ids);
		}
		
		$this->data['rows'] = [];

		if($company_ids) {

			$videos = $this->Video_model->filter(['company_id IN('.$company_ids.')' => null])->with_translation()->order_by('created_at', 'DESC')->all();

			if($videos)
			{
				foreach($videos as $video)
				{

					if($video->status == 1)
					{
						$status = '<span class="badge badge-success" style="color:#fff;">'.translate('active',true).'</span>';
					}
					elseif($video->status == 2)
					{
						$status = '<span class="badge badge-warning" style="color:#fff;">'.translate('waiting',true).'</span>';
					}
					elseif($video->status == 0)
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}
					else
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}

					$row = new stdClass();
					$row->id = $video->id;
					$row->name = $video->name;
					$row->company = $this->Company_model->filter(['company_id' => $video->company_id])->with_translation()->one()->name;
					$row->status = $status;
					$row->date = format_date($video->created_at, 'd F Y');
					$row->link =  ($video->status == 1) ? site_url_multi('video/'.$video->slug) : false;
					$row->edit_link = site_url_multi('video/edit/'.$video->id);
					$row->delete_link = site_url_multi('video/delete/'.$video->id);

					$this->data['rows'][] = $row;
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

				$this->data['language_link'][$key] = site_url($lang_slug.'user/video');
				
			}
		}
		// Language link

		$this->template->render('user/video');
	}

	public function news()
	{
		if(!$this->auth->is_loggedin())
		{
			redirect(site_url_multi('/'), 'refresh');
		}

		$this->data['title'] = translate('news_title');
		
		//Breadcrumb
		$this->breadcrumbs->push(translate('news_title'), 'user/news');

		$companies = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id])->with_translation()->order_by('created_at', 'DESC')->all();
		$company_ids = [];
		if($companies)
		{
			foreach($companies as $company)
			{
				$company_ids[] = $company->id;
			}
			
			$company_ids = implode(',',$company_ids);
		}

		$this->data['rows'] = [];

		if($company_ids) {

			$newss = $this->News_model->filter(['company_id IN('.$company_ids.')' => null])->with_translation()->order_by('created_at', 'DESC')->all();
			
			if($newss)
			{
				foreach($newss as $news)
				{

					if($news->status == 1)
					{
						$status = '<span class="badge badge-success" style="color:#fff;">'.translate('active',true).'</span>';
					}
					elseif($news->status == 2)
					{
						$status = '<span class="badge badge-warning" style="color:#fff;">'.translate('waiting',true).'</span>';
					}
					elseif($news->status == 0)
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}
					else
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}

					$row = new stdClass();
					$row->id = $news->id;
					$row->name = $news->name;
					$row->company = $this->Company_model->filter(['company_id' => $news->company_id])->with_translation()->one()->name;
					$row->status = $status;
					$row->date = format_date($news->created_at, 'd F Y');
					$row->link =  ($news->status == 1) ?  site_url_multi('news/'.$news->slug): false;
					$row->edit_link = site_url_multi('news/edit/'.$news->id);
					$row->delete_link = site_url_multi('news/delete/'.$news->id);

					$this->data['rows'][] = $row;
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

				$this->data['language_link'][$key] = site_url($lang_slug.'user/news');
				
			}
		}
		// Language link
		

		$this->template->render('user/news');
	}

	public function discount()
	{
		if(!$this->auth->is_loggedin())
		{
			redirect(site_url_multi('/'), 'refresh');
		}

		$this->data['title'] = translate('discount_title');

		//Breadcrumb
		$this->breadcrumbs->push(translate('discount_title'), 'user/discount');

		$companies = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id])->with_translation()->order_by('created_at', 'DESC')->all();
		$company_ids = [];
		if($companies)
		{
			foreach($companies as $company)
			{
				$company_ids[] = $company->id;
			}

			$company_ids = implode(',',$company_ids);
		}
		
		$this->data['rows'] = [];

		if($company_ids) {

			$discounts = $this->Discount_model->filter(['company_id IN('.$company_ids.')' => null])->with_translation()->order_by('created_at', 'DESC')->all();

			if($discounts)
			{
				foreach($discounts as $discount)
				{

					if($discount->status == 1)
					{
						$status = '<span class="badge badge-success" style="color:#fff;">'.translate('active',true).'</span>';
					}
					elseif($discount->status == 2)
					{
						$status = '<span class="badge badge-warning" style="color:#fff;">'.translate('waiting',true).'</span>';
					}
					elseif($discount->status == 0)
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}
					else
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}

					$row = new stdClass();
					$row->id = $discount->id;
					$row->name = $discount->name;
					$row->company = $this->Company_model->filter(['company_id' => $discount->company_id])->with_translation()->one()->name;
					$row->status = $status;
					$row->date = format_date($discount->created_at, 'd F Y');
					$row->link =  ($discount->status == 1) ?  site_url_multi('discount/'.$discount->slug) : false;
					$row->edit_link = site_url_multi('discount/edit/'.$discount->id);
					$row->delete_link = site_url_multi('discount/delete/'.$discount->id);

					$this->data['rows'][] = $row;
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

				$this->data['language_link'][$key] = site_url($lang_slug.'user/discount');
				
			}
		}
		// Language link

		$this->template->render('user/discount');
	}

	public function service()
	{
		if(!$this->auth->is_loggedin())
		{
			redirect(site_url_multi('/'), 'refresh');
		}

		$this->data['title'] = translate('service_title');

		//Breadcrumb
		$this->breadcrumbs->push(translate('service_title'), 'user/service');

		$companies = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id])->with_translation()->order_by('created_at', 'DESC')->all();
		$company_ids = [];
		if($companies)
		{
			foreach($companies as $company)
			{
				$company_ids[] = $company->id;
			}

			$company_ids = implode(',',$company_ids);
		}
		
		$this->data['rows'] = [];

		if($company_ids) {
			$services = $this->Service_model->filter(['company_id IN('.$company_ids.')' => null])->with_translation()->order_by('created_at', 'DESC')->all();

			if($services)
			{
				foreach($services as $service)
				{
					if($service->status == 1)
					{
						$status = '<span class="badge badge-success" style="color:#fff;">'.translate('active',true).'</span>';
					}
					elseif($service->status == 2)
					{
						$status = '<span class="badge badge-warning" style="color:#fff;">'.translate('waiting',true).'</span>';
					}
					elseif($service->status == 0)
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}
					else
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}

					$row = new stdClass();
					$row->id = $service->id;
					$row->name = $service->name;
					$row->company = $this->Company_model->filter(['company_id' => $service->company_id])->with_translation()->one()->name;
					$row->status = $status;
					$row->date = format_date($service->created_at, 'd F Y');
					$row->link =  ($service->status == 1) ?  site_url_multi('service/'.$service->slug) : false;
					$row->edit_link = site_url_multi('service/edit/'.$service->id);
					$row->delete_link = site_url_multi('service/delete/'.$service->id);

					$this->data['rows'][] = $row;
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

				$this->data['language_link'][$key] = site_url($lang_slug.'user/service');
				
			}
		}
		// Language link

		$this->template->render('user/service');
	}

	public function product()
	{
		if(!$this->auth->is_loggedin())
		{
			redirect(site_url_multi('/'), 'refresh');
		}

		$this->data['title'] = translate('product_title');

		//Breadcrumb
		$this->breadcrumbs->push(translate('product_title'), 'user/product');

		$companies = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id])->with_translation()->order_by('created_at', 'DESC')->all();
		$company_ids = [];
		if($companies)
		{
			foreach($companies as $company)
			{
				$company_ids[] = $company->id;
			}

			$company_ids = implode(',',$company_ids);
		}
		
		$this->data['rows'] = [];

		if($company_ids) {

			$products = $this->Product_model->filter(['company_id IN('.$company_ids.')' => null])->with_translation()->order_by('created_at', 'DESC')->all();

			if($products)
			{
				foreach($products as $product)
				{

					if($product->status == 1)
					{
						$status = '<span class="badge badge-success" style="color:#fff;">'.translate('active',true).'</span>';
					}
					elseif($product->status == 2)
					{
						$status = '<span class="badge badge-warning" style="color:#fff;">'.translate('waiting',true).'</span>';
					}
					elseif($product->status == 0)
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}
					else
					{
						$status = '<span class="badge badge-danger" style="color:#fff;">'.translate('deactive',true).'</span>';
					}

					$row = new stdClass();
					$row->id = $product->id;
					$row->name = $product->name;
					$row->company = $this->Company_model->filter(['company_id' => $product->company_id])->with_translation()->one()->name;
					$row->status = $status;
					$row->date = format_date($product->created_at, 'd F Y');
					$row->link =  ($product->status == 1) ? site_url_multi('product/'.$product->slug) : false;
					$row->edit_link = site_url_multi('product/edit/'.$product->id);
					$row->delete_link = site_url_multi('product/delete/'.$product->id);

					$this->data['rows'][] = $row;
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

				$this->data['language_link'][$key] = site_url($lang_slug.'user/product');
				
			}
		}
		// Language link

		$this->template->render('user/product');
	}

}