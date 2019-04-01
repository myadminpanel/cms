<?php defined('BASEPATH') or exit('No direct script access allowed');

class Service extends Api_Controller {
	
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Service_model');
		$this->load->model('modules/Company_model');
		$this->load->model('modules/Review_model');
		$this->load->model('Notify_admin_model');
	}

	public function index()
	{
		$per_page = 12;

		$filter['status'] = 1;

		if($this->input->get('company_id'))
		{
			$filter['company_id'] = (int)$this->input->get('company_id');
		}

		if($this->input->get('created_by') != NULL)
		{
			$filter['created_by'] = (int)$this->input->get('created_by');
		}

		if($this->input->get('page') != NULL)
		{
			$page = (int)$this->input->get('page')-1;
		}
		else
		{
			$page = 0;
		}

		$rows = $this->Service_model->filter($filter)->with_translation()->order_by('created_at', 'DESC')->limit($per_page, $page)->all();

		$result = [];
		if($rows)
		{
			foreach($rows as $row)
			{
				$data = new stdClass();
				$data->id = $row->id;
				$data->name = $row->name;
				$data->image = $this->Model_tool_image->resize($row->image, 800, 600);
				$data->date = format_date($row->created_at, 'd F Y');
				$data->price = $row->price.' AZN';
				$data->view = $row->view;

				$result[] = $data;
			}
		}

		$this->template->json($result);
	}


	public function detail($id = false)
	{
		if($id)
		{
			$row = $this->Service_model->filter(['status' => 1, 'id' => $id])->with_translation()->one();
			if($row)
			{

				$company = $this->Company_model->filter(['status' => 1, 'id' => $row->company_id])->with_translation()->one();

				if($company)
				{
					$company_data 					= new stdClass();
					$company_data->id 				= $company->id;
					$company_data->name 			= $company->name;
					$company_data->image 			= $this->Model_tool_image->resize($company->image, 244, 244);
					$company_data->description 		= get_description($company->description);
				}
				else
				{
					$company_data = false;
				}

				$service				= new stdClass();
				$service->id			= $row->id;
				$service->name			= $row->name;
				$service->company		= $company_data;
				$service->name			= $row->name;
				$service->description	= strip_tags($row->description);
				$service->image			= $this->Model_tool_image->resize($row->image, 800, 600);
				$service->date			= format_date($row->created_at, 'd F Y');
				$service->view			= $row->view;
				$service->author		= get_user($row->created_by);
				$service->author_id		= $row->created_by;
				$service->price			= $row->price;
				$service->comment_count	= $this->Review_model->filter(['status' => 1, 'data_id' => $row->id, 'type' => 'service'])->count_rows();

				//Related Services
				$related_services = $this->Service_model->filter(['status' => 1, 'id !=' => $service->id])->with_translation()->order_by('created_at', 'RANDOM')->limit(5, 0)->all();
				$this->data['relateds'] = [];
				if($related_services)
				{
					foreach($related_services as $row)
					{
						$data = new stdClass();
						$data->id 				= $row->id;
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('service/'.$row->slug);
						$data->image 			= $this->Model_tool_image->resize($row->image, 800, 600);
						$data->date 			= format_date($row->created_at, 'd F Y');
						$data->view 			= $row->view;
						$data->price			= $row->price. 'AZN';
						$data->author			= get_user($row->created_by);

						$service->relateds[] = $data;
					}

				}

				//Other Services
				$other_services = $this->Service_model->filter(['status' => 1, 'id !=' => $service->id, 'company_id' => $row->company_id])->with_translation()->order_by('created_at', 'DESC')->limit(5, 0)->all();
				$this->data['others'] = [];
				if($other_services)
				{
					foreach($other_services as $row)
					{
						$data = new stdClass();
						$data->id 				= $row->id;
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('service/'.$row->slug);
						$data->image 			= $this->Model_tool_image->resize($row->image, 800, 600);
						$data->date 			= format_date($row->created_at, 'd F Y');
						$data->view 			= $row->view;
						$data->price			= $row->price. 'AZN';
						$data->author			= get_user($row->created_by);

						$service->others[] = $data;
					}

				}


				//Comments
				$comments = $this->Review_model->filter(['status' => 1, 'data_id' => $service->id, 'type' => 'service'])->order_by('created_at', 'DESC')->all();
				$this->data['comments'] = [];
				if($comments)
				{
					foreach($comments as $comment)
					{
						$review = new stdClass();
						$review->text = $comment->comment;
						if($comment->user_id)
						{
							$review->author = get_user($comment->user_id);
							if($this->auth->get_user($comment->user_id)->image)
							{
								$review->author_image = $this->Model_tool_image->resize($this->auth->get_user($comment->user_id)->image, 128, 128);
							}
							else
							{
								$review->author_image = $this->Model_tool_image->resize('catalog/user/user_default.png', 128, 128);
							}
							$review->user_type = translate('user', true);
						}
						else
						{
							$review->author = $comment->fullname;
							$review->user_type = translate('guest', true);
						}

						$service->comments[] = $review;

					}
				}
			}
			else
			{
				$service = false;
			}
		}
		else
		{
			$service = false;
		}

		$this->template->json($service);
	}

	public function create()
	{
		
		if($this->input->method() == 'post')
		{
			$json = json_decode(file_get_contents('php://input'), true);

			$_POST['image'] = $json['image'];
			$_POST['company'] = $json['company'];
			$_POST['price'] = $json['price'];

			//Get description
			$_POST['translation'][1]['name'] = ($json['title_en']) ? $json['title_en'] : '';
			$_POST['translation'][2]['name'] = ($json['title_ru']) ? $json['title_ru'] : '';
			$_POST['translation'][3]['name'] = ($json['title_az']) ? $json['title_az'] : '';
			$_POST['translation'][4]['name'] = ($json['title_tr']) ? $json['title_tr'] : '';

			$_POST['translation'][1]['description'] = ($json['description_en']) ? $json['description_en'] : '';
			$_POST['translation'][2]['description'] = ($json['description_ru']) ? $json['description_ru'] : '';
			$_POST['translation'][3]['description'] = ($json['description_az']) ? $json['description_az'] : '';
			$_POST['translation'][4]['description'] = ($json['description_tr']) ? $json['description_tr'] : '';


			$this->form_validation->set_rules('image', translate('image'), 'required|trim');
			$this->form_validation->set_rules('company', translate('company'), 'required|trim');

			if($this->input->post('translation'))
			{
				$translation = $this->input->post('translation');
				foreach($this->data['languages'] as $language)
				{
					if($translation[$language['id']]['name'])
					{
						$this->form_validation->set_rules('translation['.$language['id'].'][name]', translate('name'), 'required|trim');
					}
				}

				if($this->form_validation->run())
				{
					$discount = [
						'company_id'	=> $this->input->post('company_id'),
						'price'			=> $this->input->post('price'),
						'image'			=> $this->input->post('image'),
						'status'		=> 2,
					];

					$discount_id = $this->Service_model->insert($discount);

					foreach($this->data['languages'] as $language)
					{
						if($translation[$language['id']]['name'])
						{
							$discount_translation_data = [
								'discount_id'		=> $discount_id,
								'language_id'	=> $language['id'],
								'name'			=> $translation[$language['id']]['name'],
								'slug'			=> slug($translation[$language['id']]['name'], '-', true),
								'description'	=> $translation[$language['id']]['description'],
							];

							if(isset($translation[3]['name']) && !empty($translation[3]['name']))
							{
								$name = $translation[3]['name'];
							}
							elseif(isset($translation[$language['id']]['name']) && !empty($translation[$language['id']]['name']))
							{
								$name = $translation[$language['id']]['name'];
							}
							else
							{
								$name = '';
							}

							$this->Service_model->insert_translation($discount_translation_data);
						}
					}

					$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$discount_id.'</strong> ID-li <strong>"'.$name.'"</strong> adlı endirim əlavə etdi']);

					$this->data['response'] = [
						'success' => true,
						'message' => translate('product_submited')
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
					'message' => translate('minimum_language')
				];
			}
		}
		else
		{
			$this->data['response'] = [
				'success' => false,
				'message' => translate('ony_post_request')
			];
		}

		$this->template->json($this->data['response']);

	}

	public function delete()
	{
		if($this->input->get('id'))
		{
			$id = (int)$this->input->get('id');
			$this->Service_model->delete($id);

			$this->data['response'] = [
				'success' => true,
				'message' => translate('successfully_deleted')
			];
		}
		else
		{
			$this->data['response'] = [
				'success' => false,
				'message' => translate('delete_failed')
			];
		}

		$this->template->json($this->data['response']);
	}
}