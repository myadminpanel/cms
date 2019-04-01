<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Review extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Review_model');
		$this->load->model('modules/Company_model');
		$this->load->model('modules/Gallery_model');
		$this->load->model('modules/Video_model');
		$this->load->model('modules/News_model');
		$this->load->model('modules/Discount_model');
		$this->load->model('modules/Product_model');
		$this->load->model('modules/Service_model');
	}

	public function add()
	{
		if($this->input->method() == 'post')
		{
			$this->form_validation->set_rules('type', translate('type'), 'required|trim');


			if($this->input->post('type') == 'company')
			{
				
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

			
			$this->form_validation->set_rules('data_id', translate('data_id'), 'required|trim');

			if(!$this->auth->is_loggedin())
			{
				$this->form_validation->set_rules('fullname', translate('fullname'), 'required|trim');
				$this->form_validation->set_rules('email', translate('email'), 'required|trim');
				
			}

			if($this->form_validation->run())
			{

				if($this->auth->is_loggedin())
				{
					$user_id = $this->auth->get_user()->id;
					$fullname = $this->auth->get_user()->firstname.' '.$this->auth->get_user()->lastname;
					$email =  $this->auth->get_user()->email;
				}
				else
				{
					$user_id = 0;
					$fullname = $this->input->post('fullname');
					$email = $this->input->post('email');
				}

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

				if($this->input->post('parent_id'))
				{
					$parent_id = (int)$this->input->post('parent_id');
				}
				else
				{
					$parent_id = 0;
				}

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