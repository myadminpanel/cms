<?php defined('BASEPATH') or exit('No direct script access allowed');

class Site_Controller extends Core_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Category_model');
		$this->load->model('modules/News_category_model');
		$this->load->model('Notify_admin_model');

		$this->data['css'] = '';
		$this->data['js'] = '';
		$this->data['site_title'] = get_setting('site_title', $this->data['current_lang']);
		$this->data['title'] = '';
		$this->data['description'] = '';
		$this->data['meta_title'] = '';
		$this->data['meta_description'] = '';
		$this->data['meta_image'] = '';
		$this->data['meta_keywords'] = '';

		

		$this->data['category'] = [
			'government_agencies'	=> $this->Category_model->filter(['status' => 1, 'parent_id' => 1])->with_translation()->order_by('name', 'ASC')->all(),
			'companies'				=> $this->Category_model->filter(['status' => 1, 'parent_id' => 2])->with_translation()->order_by('name', 'ASC')->all(),
			'persons'				=> $this->Category_model->filter(['status' => 1, 'parent_id' => 3])->with_translation()->order_by('name', 'ASC')->all(),
			'news'					=> $this->News_category_model->filter(['status' => 1, 'parent_id' => 0])->with_translation()->order_by('name', 'ASC')->all(),
		];

		$this->data['category_1_url'] = $this->Category_model->filter(['status' => 1, 'id' => 1])->with_translation()->one();
		$this->data['category_2_url'] = $this->Category_model->filter(['status' => 1, 'id' => 2])->with_translation()->one();
		$this->data['category_3_url'] = $this->Category_model->filter(['status' => 1, 'id' => 3])->with_translation()->one();
		
		$ip =  get_user_ip();
		$country =  geoip_country_code_by_name($ip);
		$this->config->load('country_list');
		$country_list = $this->config->item('country_list');
		$this->data['country'] = (isset($country_list[$country])) ? $country_list[$country] : false;
		

		$this->theme = get_setting('site_theme');
	}
}
