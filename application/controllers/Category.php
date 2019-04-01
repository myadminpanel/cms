<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Category extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Category_model');
		$this->load->model('modules/Company_model');
		
		$this->load->model('modules/Country_model');
		$this->load->model('modules/Region_model');
		$this->load->model('modules/District_model');
		$this->load->model('modules/Metro_model');

		$this->data['countries'] = $this->Country_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();
		$this->data['parent_categories'] = $this->Category_model->filter(['status' =>1, 'parent_id' => 0])->with_translation()->order_by('name', 'ASC')->all();
		$this->data['regions'] = $this->Region_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();
		$this->data['districts'] = $this->District_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();
		$this->data['metros'] = $this->Metro_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();
	}

	public function index($slug = false)
	{
		if($slug)
		{
			$category = $this->Category_model->filter(['status' => 1, 'slug' => $slug])->with_translation()->one();
			if($category)
			{
				$this->data['title'] = $category->name;
				
				if($category->parent_id == '0')
				{
					$categories = $this->Category_model->filter(['status' => 1, 'parent_id' => $category->id])->with_translation()->order_by('name', 'ASC')->all();
					
					$this->breadcrumbs->push($category->name, site_url_multi('category/'.$category->slug));
					
					if($this->data['languages'])
					{
						foreach($this->data['languages'] as $key => $langauge)
						{
							$link = $this->Category_model->filter(['status' => 1, 'id' => $category->id])->with_translation($langauge['id'])->one();
							if($link)
							{
								if($key == $this->data['default_language'])
								{
									$lang_slug = '';
								}
								else
								{
									$lang_slug = $key.'/';
								}
								$this->data['language_link'][$key] = site_url($lang_slug.'category/'.$link->slug);
							}
							else
							{
								$this->data['language_link'][$key]  = site_url($lang_slug);
							}
						}
					}
					
					$this->data['categories'] = [];
					if($categories)
					{
						foreach($categories as $category)
						{
							$data = new stdClass();
							$data->name = $category->name;
							$data->link = site_url_multi('category/'.$category->slug);
							$data->image = $this->Model_tool_image->resize($category->image, 24, 24);
							$data->count = $this->Company_model->filter(['category_id' => $category->id])->count_rows();
							$this->data['categories'][] = $data;
						}
					}

					

					$this->template->render('category_list');
				}
				else
				{
					

					$rows = $this->Category_model->filter(['status' => 1, 'parent_id' => $category->id])->with_translation()->order_by('name', 'ASC')->all();
					
					$this->data['categories'] = [];
					if($rows)
					{
						foreach($rows as $row)
						{
							$data = new stdClass();
							$data->name = $row->name;
							$data->link = site_url_multi('category/'.$row->slug);
							$data->image = $this->Model_tool_image->resize($row->image, 24, 24);
							$data->count = $this->Company_model->filter(['(category_id='.$row->id.' OR sub_category_id='.$row->id.')' => NULL, 'status' => 1])->count_rows();
							$this->data['categories'][] = $data;
						}
					}

					$parent = $this->Category_model->filter(['status' => 1, 'id' => $category->parent_id])->with_translation()->one();
					if($parent)
					{
						if($parent->parent_id)
						{
							$parent_1 = $this->Category_model->filter(['status' => 1, 'id' => $parent->parent_id])->with_translation()->one();
							$this->breadcrumbs->push($parent_1->name, 'category/'.$parent_1->slug);
						}
						$this->breadcrumbs->push($parent->name, 'category/'.$parent->slug);
					}

					$this->breadcrumbs->push($category->name, 'category/'.$category->slug);

					$per_page = 12;
					$segment_array = $this->uri->segment_array();
					$page = (ctype_digit(end($segment_array))) ? end($segment_array) : 1;

					$this->data['filter']['status'] = 1;

					//Parent Category
					if($this->input->get('parent_category_id'))
					{
						$this->data['filter']['parent_category_id'] = (int)$this->input->get('parent_category_id');
						$this->data['search']['parent_category_id'] = (int)$this->input->get('parent_category_id');
					}
					else
					{
						$this->data['search']['parent_category_id'] = 1;
					}

					//Country
					if($this->input->get('country_id'))
					{
						$this->data['filter']['country_id'] = (int)$this->input->get('country_id');
						$this->data['search']['country_id'] = (int)$this->input->get('country_id');
					}
					else
					{
						$this->data['search']['country_id'] = 1;
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

					

					$total_rows = $this->Company_model->filter(['(category_id='.$category->id.' OR sub_category_id='.$category->id.')' => NULL, 'status' => 1])->with_translation()->count_rows();
					$companies = $this->Company_model->filter(['(category_id='.$category->id.' OR sub_category_id='.$category->id.')' => NULL, 'status' => 1])->with_translation()->order_by('name', 'ASC')->limit($per_page, $page-1)->all();
					
					//echo $this->db->last_query();

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
							$data->description 	= get_description($row->description, 450);


							$this->data['companies'][] = $data;
						}
					}

					$this->config->load('pagination-site', TRUE);
					$config = $this->config->item('pagination-site');
					$config['base_url'] = site_url_multi('category/index/'.$slug);
					$config['total_rows'] = $total_rows;
					$config['per_page'] = $per_page;
					$config['reuse_query_string'] = true;
					$config['use_page_numbers'] = true;

					$this->pagination->initialize($config);
					$this->data['pagination'] = $this->pagination->create_links();

					if($this->data['languages'])
					{
						foreach($this->data['languages'] as $key => $langauge)
						{
							$link = $this->Category_model->filter(['status' => 1, 'id' => $category->id])->with_translation($langauge['id'])->one();
							if($link)
							{
								if($key == $this->data['default_language'])
								{
									$lang_slug = '';
								}
								else
								{
									$lang_slug = $key.'/';
								}
								$this->data['language_link'][$key] = site_url($lang_slug.'category/'.$link->slug);
							}
							else
							{
								$this->data['language_link'][$key]  = site_url($lang_slug);
							}
						}
					}

					$this->template->render('category');
				}
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

	public function ajax()
	{
		if($this->input->get('category_id'))
		{
			$category_id = (int) $this->input->get('category_id');
			$categories = $this->Category_model->filter(['status' => 1, 'parent_id' => $category_id])->with_translation()->order_by('name', 'ASC')->all();
			
			$data['categories'] = [];
			if($categories)
			{
				foreach($categories as $category)
				{
					$data['categories'][] = [
						'category_id' => $category->id,
						'name' => $category->name
					];
				}
			}

			$this->template->json($data);
		}
	}
}