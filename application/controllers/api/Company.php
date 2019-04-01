<?php defined('BASEPATH') or exit('No direct script access allowed');

class Company extends Api_Controller {
	
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Company_model');
		$this->load->model('modules/Country_model');
		$this->load->model('modules/Region_model');
		$this->load->model('modules/District_model');
		$this->load->model('modules/Metro_model');
		$this->load->model('modules/Language_skill_model');
		$this->load->model('modules/Following_model');
		$this->load->model('modules/Review_model');

		$this->load->model('modules/News_model');
		$this->load->model('modules/Discount_model');
		$this->load->model('modules/Product_model');
		$this->load->model('modules/Service_model');
		$this->load->model('modules/Video_model');
		$this->load->model('modules/Gallery_model');

		$this->load->library('Qr_code');
	}

	public function index()
	{
		$per_page = 12;

		if($this->input->get('sort'))
		{
			$order_by['sort'] = $this->input->get('sort');
		}
		else
		{
			$order_by['sort'] = 'name';
		}

		if($this->input->get('order') && in_array($this->input->get('order'), ['ASC', 'DESC']))
		{
			$order_by['order'] = $this->input->get('order');
		}
		else
		{
			$order_by['order'] = 'ASC';
		}


		$filter['status'] = 1;

		if($this->input->get('parent_category_id'))
		{
			$filter['parent_category_id'] = (int)$this->input->get('parent_category_id');
		}

		if($this->input->get('user_id'))
		{
			$filter['user_id'] = (int)$this->input->get('user_id');
		}

		if($this->input->get('category_id'))
		{
			$filter['category_id'] = (int)$this->input->get('category_id');
		}

		if($this->input->get('sub_category_id'))
		{
			$filter['sub_category_id'] = (int)$this->input->get('sub_category_id');
		}

		if($this->input->get('country_id'))
		{
			$filter['country_id'] = (int)$this->input->get('country_id');
		}

		if($this->input->get('region_id'))
		{
			$filter['region_id'] = (int)$this->input->get('region_id');
		}

		if($this->input->get('district_id'))
		{
			$filter['district_id'] = (int)$this->input->get('district_id');
		}

		if($this->input->get('metro_id'))
		{
			$filter['metro_id'] = (int)$this->input->get('metro_id');
		}

		if($this->input->get('keyword'))
		{
			$filter['(name LIKE "%'.$this->input->get('keyword').'%" OR tag LIKE "%'.$this->input->get('keyword').'%")'] = NULL;
		}

		if($this->input->get('latitude') && $this->input->get('longitude') && $this->input->get('distance'))
		{
			$filter["( 6371 * acos( cos( radians('".$this->input->get('latitude')."') ) * 
			cos( radians( latitude ) ) * 
			cos( radians( longitude ) - 
			radians('".$this->input->get('longitude')."') ) + 
			sin( radians('".$this->input->get('latitude')."') ) * 
			sin( radians( latitude ) ) ) ) <".$this->input->get('distance')] = NULL;
		}

		if($this->input->get('page'))
		{
			$page = (int)$this->input->get('page')-1;
		}
		else
		{
			$page = 0;
		}

		$rows = $this->Company_model->filter($filter)->with_translation()->order_by($order_by['sort'], $order_by['order'])->limit($per_page, $page)->all();
		if($rows)
		{
			$result = false;
		
			foreach($rows as $row)
			{
				$country = $this->Country_model->filter(['status' => 1, 'id' => $row->country_id])->with_translation()->one();
				if($country)
				{
					$country_code = $this->Model_tool_image->resize($country->image, 32, 16);
				}
				else
				{
					$country_code = false;
				}

				$data 						= new stdClass();
				$data->id 					= $row->id;
				$data->name 				= $row->name;
				$data->country_id 			= $row->country_id;
				$data->country_code 		= $country_code;
				$data->image 				= $this->Model_tool_image->resize($row->image, 400, 400);

				$result['result'][] = $data;
			}
			
		
			$this->template->json($result);
		}
		else
		{
			$this->template->json(['result' => [], 'error' => true]);
		}
		
	}


	public function detail($id = false)
	{
		if($id)
		{
			$row = $this->Company_model->filter(['status' => 1, 'id' => $id])->with_translation()->one();
			if($row)
			{
				$company = new stdClass();				
				$company->id 					= $row->id;
				$company->title 				= $row->name;
				$company->description 			= strip_tags($row->description);
				$company->qr_code 				= $this->qr_code->generate(site_url_multi($row->slug), 'L', 2);
				$company->qr_code_full 			= $this->qr_code->generate(site_url_multi($row->slug), 'H', 10);
				$company->user_id				= $row->user_id;

				//Image
				$company->image 				= $this->Model_tool_image->resize($row->image, 400, 300);
				$company->image_full 			= base_url('uploads/'.$row->image);
				//Contact
				$company->phone 				= $row->phone;
				$company->mobile 				= $row->mobile;
				$company->fax 					= $row->fax;
				$company->email 				= $row->email;
				$company->website 				= $row->website;
				$company->facebook 				= $row->facebook;
				$company->instagram 			= $row->instagram;
				$company->twitter 				= $row->twitter;
				$company->linkedin 				= $row->linkedin;
				$company->ok 					= $row->ok;
				$company->vk 					= $row->vk;
				//Location
				$company->latitude	 				= $row->latitude;
				$company->longitude					= $row->longitude;

				
				
				$language_skill = [];
				if($row->language_skill)
				{
					$language_skill_exploded = explode(',', $row->language_skill);
					foreach($language_skill_exploded as $l_s_e)
					{
						$language_skill[] = $this->Language_skill_model->filter(['status' => 1, 'id' => $l_s_e])->with_translation()->one()->name;
					}

				}

				$company->language_skill 			= implode(', ', $language_skill);

				$country = $this->Country_model->filter(['status' => 1, 'id' => $row->country_id])->with_translation()->one();
				$company->country_code 	= ($country) ? $this->Model_tool_image->resize($country->image, 32, 16) : false;
				$company->country_name = ($country) ? $country->name : false;
				
			

				$region = $this->Region_model->filter(['id' => $row->region_id])->with_translation()->one();
				$company->region			= ($region) ? $region->name : false;

				$district = $this->District_model->filter(['id' => $row->district_id])->with_translation()->one();
				$company->district 			= ($district) ? $district->name: false;

				$metro = $this->Metro_model->filter(['id' => $row->metro_id])->with_translation()->one();
				$company->metro				= ($metro) ? $metro->name : false;

				$company->address 					= $row->address;
				$company->experience				= $row->experience;
				$company->working_time 				= str_replace('<br/>', ',', working_time($row->working_time));
				$company->online 					= is_online($row->working_time);

				$company->follower 					= $this->Following_model->filter(['company_id' => $row->id])->count_rows();
				$company->view 						= $row->view;
				$company->comment_count				= $this->Review_model->filter(['status' => 1, 'data_id' => $row->id, 'type' => 'company'])->count_rows();

				$company->news 						= $this->News_model->filter(['status' => 1, 'company_id' => $row->id])->with_translation()->count_rows();
				$company->video 					= $this->Video_model->filter(['status' => 1, 'company_id' => $row->id])->with_translation()->count_rows();
				$company->gallery 					= $this->Gallery_model->filter(['status' => 1, 'company_id' => $row->id])->with_translation()->count_rows();
				$company->product 					= $this->Product_model->filter(['status' => 1, 'company_id' => $row->id])->with_translation()->count_rows();
				$company->discount 					= $this->Discount_model->filter(['status' => 1, 'company_id' => $row->id])->with_translation()->count_rows();
				$company->service 					= $this->Service_model->filter(['status' => 1, 'company_id' => $row->id])->with_translation()->count_rows();

				
				//$this->data['images'] 				= $image_lists;

			}
			else
			{
				$company = false;
			}
		}
		else
		{
			$company = false;
		}

		$this->template->json($company);
	}
}