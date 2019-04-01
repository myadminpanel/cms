<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Landmark extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Orientation_model');
		$this->load->model('modules/Company_model');
		$this->load->model('modules/Country_model');
		$this->load->model('modules/Region_model');
		$this->load->model('modules/District_model');
		$this->load->model('modules/Metro_model');

		$this->data['parent_categories'] = $this->Category_model->filter(['status' => 1, 'parent_id' => 0])->with_translation()->order_by('name', 'ASC')->all();
	}

	public function index($slug = false)
	{
		if($slug)
		{
			$slug = urldecode($slug);
			$landmark = $this->Orientation_model->filter(['name' => $slug])->one();
			if($landmark)
			{
				
				$this->data['title'] = '#'.$landmark->name;
				$this->breadcrumbs->push('#'.$landmark->name, 'landmark/'.$landmark->name);
				
				$per_page = 12;
				$segment_array = $this->uri->segment_array();
				$page = (ctype_digit(end($segment_array))) ? end($segment_array) : 1;

				if($this->input->get('sort' != NULL))
				{
					$this->data['order_by']['sort'] = $this->input->get('sort');
				}
				else
				{
					$this->data['order_by']['sort'] = 'name';
				}

				if($this->input->get('order') != NULL && in_array($this->input->get('order'), ['ASC', 'DESC']))
				{
					$this->data['order_by']['order'] = $this->input->get('order');
				}
				else
				{
					$this->data['order_by']['order'] = 'ASC';
				}

				$this->data['filter']['status'] = 1;

				//Country
				if($this->input->get('country_id'))
				{
					$this->data['filter']['country_id'] = (int)$this->input->get('country_id');
					$this->data['search']['country_id'] = (int)$this->input->get('country_id');
				}
				else
				{
					$this->data['search']['country_id'] = 0;
				}

				//Region
				if($this->input->get('region_id'))
				{
					$this->data['filter']['region_id'] = (int)$this->input->get('region_id');
					$this->data['search']['region_id'] = (int)$this->input->get('region_id');
				}
				else
				{
					$this->data['search']['region_id'] = 0;
				}

				//District
				if($this->input->get('district_id'))
				{
					$this->data['filter']['district_id'] = (int)$this->input->get('district_id');
					$this->data['search']['district_id'] = (int)$this->input->get('district_id');
				}
				else
				{
					$this->data['search']['district_id'] = 0;
				}

				//Metro
				if($this->input->get('metro_id'))
				{
					$this->data['filter']['metro_id'] = (int)$this->input->get('metro_id');
					$this->data['search']['metro_id'] = (int)$this->input->get('metro_id');
				}
				else
				{
					$this->data['search']['metro_id'] = 0;
				}

				//Parent category
				if($this->input->get('parent_category_id'))
				{
					$this->data['search']['parent_category_id'] = (int)$this->input->get('parent_category_id');
				}
				else
				{
					$this->data['search']['parent_category_id'] = 0;
				}

				//Category
				if($this->input->get('category_id'))
				{
					$this->data['filter']['category_id'] = (int)$this->input->get('category_id');
					$this->data['search']['category_id'] = (int)$this->input->get('category_id');
				}
				else
				{
					$this->data['search']['category_id'] = 0;
				}

				if($this->input->get('keyword'))
				{
					$this->data['filter']['name LIKE "%'.$this->input->get('keyword').'%"'] = NULL;
					$this->data['search']['keyword'] = $this->input->get('keyword');
				}
				else
				{
					$this->data['search']['keyword'] = '';
				}

				if($this->input->get('distance'))
				{
					$this->data['search']['distance'] = $this->input->get('distance');
				}
				else
				{
					$this->data['search']['distance'] = '100';
				}

				$this->data['filter']['FIND_IN_SET("'.$slug.'", orientation)'] = NULL;
						
				$total_rows = $this->Company_model->filter($this->data['filter'])->with_translation()->count_rows();
				$companies = $this->Company_model->filter($this->data['filter'])->with_translation()->order_by($this->data['order_by']['sort'], $this->data['order_by']['order'])->limit($per_page, $page-1)->all();

				$this->data['companies'] = [];
				if($companies)
				{
					foreach($companies as $row)
					{
						$data = new stdClass();
						$data->id 			= $row->id;
						$data->name 		= $row->name;
						$data->image 		= $this->Model_tool_image->resize($row->image, 350, 350);
						$data->link 		= site_url_multi('company/'.$row->slug);
						$data->description 	= $row->description;


						$this->data['companies'][] = $data;
					}
				}

				$config['full_tag_open'] 			= '<div class="paginator-block"><ul class="pagination">';
				$config['full_tag_close'] 			= '</ul></div>';
				$config['first_link'] 				= '&laquo;';
				$config['first_tag_open'] 			= '<li class="page-item">';
				$config['first_tag_close']			= '</li>';
				$config['last_link'] 				= '&raquo;';
				$config['last_tag_open'] 			= '<li class="page-item">';
				$config['last_tag_close'] 			= '</li>';
				$config['next_link'] 				= '<i class="fas fa-chevron-right" style="font-size: 11px;" ></i>';
				$config['next_tag_open'] 			= '<li class="page-item">';
				$config['next_tag_close'] 			= '</li>';
				$config['prev_link'] 				= '<i class="fas fa-chevron-left" style="font-size: 11px;"></i>';
				$config['prev_tag_open'] 			= '<li class="page-item">';
				$config['prev_tag_close'] 			= '</li>';
				$config['cur_tag_open'] 			= '<li class="page-item active"><a class="page-link" href="">';
				$config['cur_tag_close'] 			= '</a></li>';
				$config['num_tag_open'] 			= '<li class="page-item">';
				$config['num_tag_close'] 			= '</li>';
				$config['anchor_class'] 			= 'page-link';
				$config['base_url'] = site_url_multi('company/index');
				$config['total_rows'] = $total_rows;
				$config['per_page'] = $per_page;
				$config['reuse_query_string'] = true;
				$config['use_page_numbers'] = true;
			
				$this->pagination->initialize($config);
				$this->data['pagination'] = $this->pagination->create_links();

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

						$this->data['language_link'][$key] = site_url($lang_slug.'landmark/'.$landmark->name);
						
					}
				}
				// Language link

				$this->template->render('company');

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
}