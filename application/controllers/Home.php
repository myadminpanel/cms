<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Home extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();		
		$this->load->model('modules/Category_model');
		$this->load->model('modules/Company_model');
		$this->load->model('modules/News_model');
		$this->load->model('modules/Discount_model');
		$this->load->model('modules/Service_model');
		$this->load->model('modules/Product_model');
		$this->load->model('modules/Country_model');
		$this->load->model('modules/Region_model');
	}

	public function index()
	{
		$this->data['title'] = translate('title');

		$this->data['regions'] = $this->Region_model->filter(['status' => 1, 'country_id' => 1])->with_translation()->order_by('name', 'ASC')->all();

		//Random companies
		$random_companies = $this->Company_model->filter(['status' => 1])->with_translation()->order_by('created_at', 'RANDOM')->limit(8, 0)->all();
		$this->data['random_companies'] = [];
		if($random_companies)
		{
			foreach($random_companies as $row)
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
				
				$data = new stdClass();
				$data->name 			= $row->name;
				$data->country_code 	= $country_code;
				$data->description		= get_description($row->description);
				$data->link 			= site_url_multi('company/'.$row->slug);
				$data->image 			= $this->Model_tool_image->resize($row->image, 350, 350);

				$this->data['random_companies'][] = $data;
			 }
		}


		//Products
		$products = $this->Product_model->filter(['status' => 1])->with_translation()->order_by('created_at', 'DESC')->limit(12, 0)->all();
		$this->data['products'] = [];
		if($products)
		{
			foreach($products as $row)
			{
				$data = new stdClass();
				$data->name 			= $row->name;
				$data->description		= get_description($row->description);
				$data->link 			= site_url_multi('product/'.$row->slug);
				$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
				$data->date 			= format_date($row->created_at, 'd F Y');
				$data->view 			= $row->view;
				$data->price 			= number_format($row->price);
				$this->data['products'][] = $data;
			 }

		}

		$services = $this->Service_model->filter(['status' => 1])->with_translation()->order_by('created_at', 'DESC')->limit(12, 0)->all();
		$this->data['services'] = [];
		if($services)
		{
			foreach($services as $row)
			{
				$data = new stdClass();
				$data->name 			= $row->name;
				$data->description		= get_description($row->description);
				$data->link 			= site_url_multi('service/'.$row->slug);
				$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
				$data->date 			= format_date($row->created_at, 'd F Y');
				$data->view 			= $row->view;
				$data->price 			= number_format($row->price);
				$this->data['services'][] = $data;
			 }

		}

		//Latest news
		$news_list = $this->News_model->filter(['status' => 1])->with_translation()->order_by('created_at', 'DESC')->limit(6, 0)->all();
		$this->data['news_list'] = [];
		if($news_list)
		{
			foreach($news_list as $row)
			{
				$data = new stdClass();
				$data->name 			= $row->name;
				$data->description		= get_description($row->description);
				$data->link 			= site_url_multi('news/'.$row->slug);
				$data->image 			= $this->Model_tool_image->resize($row->image, 335, 167);
				$data->date 			= format_date($row->created_at, 'd F Y');
				$data->view 			= $row->view;
				$data->author 			= get_user($row->created_by);

				$this->data['news_list'][] = $data;
			 }
		}
		
		
		//Latest companies
		$latest_companies = $this->Company_model->filter(['status' => 1])->with_translation()->order_by('created_at', 'DESC')->limit(12, 0)->all();
		$this->data['latest_companies'] = [];
		if($latest_companies)
		{
			foreach($latest_companies as $row)
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

				$data = new stdClass();
				$data->name 			= $row->name;
				$data->country_code 	= $country_code;
				$data->description		= get_description($row->description);
				$data->link 			= site_url_multi('company/'.$row->slug);
				$data->image 			= $this->Model_tool_image->resize($row->image, 350, 350);

				$this->data['latest_companies'][] = $data;
			 }
		}


		//Latest discount
		$discounts = $this->Discount_model->filter(['status' => 1])->with_translation()->order_by('created_at', 'DESC')->limit(10, 0)->all();
		$this->data['discounts'] = [];
		if($discounts)
		{
			foreach($discounts as $row)
			{
				$data = new stdClass();
				$data->name 			= $row->name;
				$data->description		= get_description($row->description);
				$data->link 			= site_url_multi('discount/'.$row->slug);
				$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
				$data->date 			= format_date($row->created_at, 'd F Y');
				$data->view 			= $row->view;

				$this->data['discounts'][] = $data;
			 }
		}

		$this->data['most_categories'] = [];
		$most_categories = $this->Category_model->filter(['status' => 1, 'parent_id !=' => 0])->with_translation()->limit(4)->all();
		if($most_categories)
		{
			foreach($most_categories as $most_category)
			{
				$data = new stdClass();
				$data->link = site_url_multi('category/'.$most_category->slug);
				$data->name = mb_substr($most_category->name, 0, 10);
				$data->fullname = $most_category->name;
				$data->id = $most_category->id;
				$data->image = $this->Model_tool_image->resize($most_category->image, 25, 25);
				$this->data['most_categories'][] = $data;
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

				$this->data['language_link'][$key] = site_url($lang_slug);
				
			}
		}
		// Language link

		$this->template->render('home');
	}
}