<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Company extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Category_model');
		$this->load->model('modules/Company_model');
		$this->load->model('modules/News_model');
		$this->load->model('modules/Product_model');
		$this->load->model('modules/Discount_model');
		$this->load->model('modules/Service_model');
		$this->load->model('modules/Video_model');
		$this->load->model('modules/Gallery_model');
		$this->load->model('modules/Review_model');
		$this->load->model('modules/Favorite_model');
		$this->load->model('modules/Following_model');
		$this->load->model('modules/Country_model');
		$this->load->model('modules/Region_model');
		$this->load->model('modules/District_model');
		$this->load->model('modules/Metro_model');
		$this->load->model('modules/Language_skill_model');

		$this->load->library('Qr_code');

		$this->data['countries'] = $this->Country_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();
		$this->data['parent_categories'] = $this->Category_model->filter(['status' => 1, 'parent_id' => 0])->with_translation()->order_by('name', 'ASC')->all();
		$this->data['categories'] = $this->Category_model->filter(['status' => 1, 'parent_id !=' => 0])->with_translation()->order_by('name', 'ASC')->all();
		$this->data['regions'] = $this->Region_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();
		$this->data['districts'] = $this->District_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();
		$this->data['metros'] = $this->Metro_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();
	}

	public function index()
	{
		$this->data['title'] = translate('title');
		$this->breadcrumbs->push(translate('title'), 'companies');

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

		//Sub category
		if($this->input->get('sub_category_id'))
		{
			$this->data['filter']['sub_category_id'] = (int)$this->input->get('sub_category_id');
			$this->data['search']['sub_category_id'] = (int)$this->input->get('sub_category_id');
		}
		else
		{
			$this->data['search']['sub_category_id'] = 0;
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

		if($this->input->get('latitude') && $this->input->get('longitude') && $this->input->get('distance'))
		{
			$this->data['filter']["( 6371 * acos( cos( radians('".$this->input->get('latitude')."') ) * 
			cos( radians( latitude ) ) * 
			cos( radians( longitude ) - 
			radians('".$this->input->get('longitude')."') ) + 
			sin( radians('".$this->input->get('latitude')."') ) * 
			sin( radians( latitude ) ) ) ) <".$this->input->get('distance')] = NULL;
		}

		if($this->input->get('distance'))
		{
			$this->data['search']['distance'] = $this->input->get('distance');
		}
		else
		{
			$this->data['search']['distance'] = '100';
		}
		
		$total_rows = $this->Company_model->filter($this->data['filter'])->with_translation()->count_rows();
		$companies = $this->Company_model->filter($this->data['filter'])->with_translation()->order_by($this->data['order_by']['sort'], $this->data['order_by']['order'])->limit($per_page, $page-1)->all();
		
		$this->data['companies'] = [];
		if($companies)
		{
			foreach($companies as $row)
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
				$data->id 			= $row->id;
				$data->name 		= $row->name;
				$data->country_code = $country_code;
				$data->image 		= $this->Model_tool_image->resize($row->image, 350, 350);
				$data->link 		= site_url_multi('company/'.$row->slug);
				$data->country_id 	= $row->country_id;
				$data->description 	= get_description($row->description, 450);


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

				$this->data['language_link'][$key] = site_url($lang_slug.'company/');
				
			}
		}
		// Language link

		$this->template->render('company');
	}

	public function view($slug = false)
	{
		if($slug)
		{
			$company = $this->Company_model->filter(['status' => 1, 'slug' => $slug])->with_translation()->one();
			if($company)
			{
				$images = $this->Company_model->get_images($company->id);

				if($company->parent_category_id == 3)
				{
					$this->data['personal'] = true;
				}
				else
				{
					$this->data['personal'] = false;
				}

				//Breadcrumb
				$category = $this->Category_model->filter(['status' => 1, 'id' => $company->category_id])->with_translation()->one();
				if($category)
				{
					$this->breadcrumbs->push($category->name, 'category/'.$category->slug);
				}

				$sub_category = $this->Category_model->filter(['status' => 1, 'id' => $company->sub_category_id])->with_translation()->one();
				if($sub_category)
				{
					$this->breadcrumbs->push($sub_category->name, 'category/'.$sub_category->slug);
				}
				

				$image_lists = [];
				if($images)
				{
					foreach($images as $image)
					{
						$image_data = new stdClass();
						$image_data->url = base_url('uploads/'.$image->image);
						$image_data->thumb = $this->Model_tool_image->resize($image->image, 350, 350);

						$image_lists[] = $image_data;
					}
				}

				//$this->breadcrumbs->push($company->name, 'company/'.$company->slug);

				$tags = [];
				if($company->tag)
				{
					$tag_exploded = explode(',', $company->tag);
					if($tag_exploded)
					{
						foreach($tag_exploded as $tag)
						$tags[] = [
							'name' => $tag,
							'link' => site_url_multi('tag/'.$tag)
						];
					}
				}

				$landmarks = [];
				if($company->orientation)
				{
					$landmark_exploded = explode(',', $company->orientation);
					if($landmark_exploded)
					{
						foreach($landmark_exploded as $landmark)
						$landmarks[] = [
							'name' => $landmark,
							'link' => site_url_multi('landmark/'.$landmark)
						];
					}
				}

				$language_skill = [];
				if($company->language_skill)
				{
					$language_skill_exploded = explode(',', $company->language_skill);
					foreach($language_skill_exploded as $l_s_e)
					{
						$language_skill[] = $this->Language_skill_model->filter(['status' => 1, 'id' => $l_s_e])->with_translation()->one()->name;
					}

				}


				

				$this->data['id'] 					= $company->id;
				$this->data['title'] 				= $company->name;
				$this->data['qrcode'] 				= $this->qr_code->generate(site_url_multi($company->slug), 'L', 2);
				$this->data['qrcode_full'] 			= $this->qr_code->generate(site_url_multi($company->slug), 'H', 10);
				$this->data['user_id'] 				= $company->user_id;
				$this->data['slug'] 				= $company->slug;
				$this->data['image'] 				= $this->Model_tool_image->resize($company->image, 350, 350);
				$this->data['meta_image'] 			= $this->Model_tool_image->resize($company->image, 250, 250);
				$this->data['image_full'] 			= base_url('uploads/'.$company->image);
				$this->data['images'] 				= $image_lists;
				$this->data['description'] 			= $company->description;
				$this->data['meta_description'] 	= get_description($company->description, 150);

				if(($company->deadline == 0) || ($company->deadline == 1 && strtotime($company->end_date) > time()))
				{
					$this->data['website'] 				= $company->website;
					$this->data['email'] 				= $company->email;
					$this->data['facebook'] 			= $company->facebook;
					$this->data['twitter'] 				= $company->twitter;
					$this->data['instagram'] 			= $company->instagram;
					$this->data['linkedin'] 			= $company->linkedin;
					$this->data['vk'] 					= $company->vk;
					$this->data['ok'] 					= $company->ok;
					$this->data['instagram'] 			= $company->instagram;
					$this->data['phone'] 				= $company->phone;
					$this->data['fax'] 					= $company->fax;
					$this->data['mobile'] 				= $company->mobile;
				}
				else
				{
					$this->data['website'] 				= false;
					$this->data['email'] 				= false;
					$this->data['facebook'] 			= false;
					$this->data['twitter'] 				= false;
					$this->data['instagram'] 			= false;
					$this->data['linkedin'] 			= false;
					$this->data['vk'] 					= false;
					$this->data['ok'] 					= false;
					$this->data['instagram'] 			= false;
					$this->data['phone'] 				= false;
					$this->data['fax'] 					= false;
					$this->data['mobile'] 				= false;
				}
				
				$this->data['language_skills'] 		= implode(', ', $language_skill);
				
				$this->data['tags'] 				= $tags;
				$this->data['landmarks'] 			= $landmarks;

				$country = $this->Country_model->filter(['status' => 1, 'id' => $company->country_id])->with_translation()->one();
				
				$this->data['country_code'] = ($country) ? $this->Model_tool_image->resize($country->image, 32, 16) : false;
				
				$this->data['country_name'] = ($country) ? $country->name : false;
				
			

				$region = $this->Region_model->filter(['id' => $company->region_id])->with_translation()->one();
				$this->data['region'] 				= ($region) ? $region->name : false;

				$district = $this->District_model->filter(['id' => $company->district_id])->with_translation()->one();

				$this->data['district'] 			= ($district) ? $district->name: false;

				$metro = $this->Metro_model->filter(['id' => $company->metro_id])->with_translation()->one();
				$this->data['metro'] 				= ($metro) ? $metro->name : false;
				$this->data['address'] 				= $company->address;
				$this->data['experience'] 			= $company->experience;
				$this->data['working_time'] 		= working_time($company->working_time);
				$this->data['online'] 				= is_online($company->working_time);
				$this->data['latitude'] 			= $company->latitude;
				$this->data['longitude'] 			= $company->longitude;
				$this->data['follower'] 			= $this->Following_model->filter(['company_id' => $company->id])->count_rows();
				$this->data['view'] 				= $company->view;
				$this->data['type'] 				= 'company';
				$this->data['comment_count']		= $this->Review_model->filter(['status' => 1, 'data_id' => $company->id, 'type' => 'company'])->count_rows();
				
				$this->data['is_favorite'] 			= false;
				$this->data['is_follow'] 			= false;
				
				// Favorite buttun
				if($this->auth->is_loggedin()) {
					$favorite_where = [
						'company_id'	=> $company->id,
						'user_id'		=> $this->auth->get_user()->id
					];
					$this->data['is_favorite'] = $this->Favorite_model->filter($favorite_where)->one();	
				}

				// Follow buttun
				if($this->auth->is_loggedin()) {
					$follow_where = [
						'company_id'	=> $company->id,
						'user_id'		=> $this->auth->get_user()->id
					];
					$this->data['is_follow'] = $this->Following_model->filter($follow_where)->one();	
				}
				

				//View
				$new_view = $company->view+1;
				$this->Company_model->update(['view' => $new_view], $company->id);

				//News tab
				$news_list = $this->News_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->order_by('created_at', 'DESC')->limit(6, 0)->all();
				$this->data['news_list'] = [];
				if($news_list)
				{
					foreach($news_list as $row)
					{
						$data = new stdClass();
						$data->id = $row->id;
						$data->name = $row->name;
						$data->view = $row->view;
						$data->link = site_url_multi('news/'.$row->slug);
						$data->description = get_description($row->description);
						$data->date = format_date($row->created_at, 'd F Y');
						$data->image = $this->Model_tool_image->resize($row->image, 200, 200);

						$this->data['news_list'][] = $data;
					}
				}
				

				//Gallery Tab
				$galleries = $this->Gallery_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->order_by('created_at', 'DESC')->limit(6, 0)->all();
				$this->data['galleries'] = [];
				if($galleries)
				{
					foreach($galleries as $row)
					{
						$data = new stdClass();
						$data->id = $row->id;
						$data->name = $row->name;
						$data->view = $row->view;
						$data->link = site_url_multi('gallery/'.$row->slug);
						$data->description = get_description($row->description);
						$data->date = format_date($row->created_at, 'd F Y');
						$data->image = $this->Model_tool_image->resize($row->image, 200, 200);

						$this->data['galleries'][] = $data;
					}
				}
				
				//Video Tab
				$videos = $this->Video_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->order_by('created_at', 'DESC')->limit(6, 0)->all();
				$this->data['videos'] = [];
				if($videos)
				{
					foreach($videos as $row)
					{
						$data = new stdClass();
						$data->id = $row->id;
						$data->name = $row->name;
						$data->view = $row->view;
						$data->video = $row->video;
						$data->link = site_url_multi('video/'.$row->slug);
						$data->description = get_description($row->description);
						$data->date = format_date($row->created_at, 'd F Y');

						$this->data['videos'][] = $data;
					}
				}
				
				//Discount Tab
				$discounts = $this->Discount_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->order_by('created_at', 'DESC')->limit(6, 0)->all();
				$this->data['discounts'] = [];
				if($discounts)
				{
					foreach($discounts as $row)
					{
						$data = new stdClass();
						$data->id = $row->id;
						$data->name = $row->name;
						$data->view = $row->view;
						$data->link = site_url_multi('discount/'.$row->slug);
						$data->description = get_description($row->description);
						$data->date = format_date($row->created_at, 'd F Y');
						$data->image = $this->Model_tool_image->resize($row->image, 200, 200);

						$this->data['discounts'][] = $data;
					}
				}
				

				//Product Tab
				$products = $this->Product_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->order_by('created_at', 'DESC')->limit(6, 0)->all();
				$this->data['products'] = [];
				if($products)
				{
					foreach($products as $row)
					{
						$data = new stdClass();
						$data->id = $row->id;
						$data->name = $row->name;
						$data->view = $row->view;
						$data->price = number_format($row->price);
						$data->link = site_url_multi('product/'.$row->slug);
						$data->description = get_description($row->description);
						$data->date = format_date($row->created_at, 'd F Y');
						$data->image = $this->Model_tool_image->resize($row->image, 200, 200);

						$this->data['products'][] = $data;
					}
				}

				//Service Tab
				$services = $this->Service_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->order_by('created_at', 'DESC')->limit(6, 0)->all();
				$this->data['services'] = [];
				if($services)
				{
					foreach($services as $row)
					{
						$data = new stdClass();
						$data->id = $row->id;
						$data->name = $row->name;
						$data->view = $row->view;
						$data->price = number_format($row->price);
						$data->link = site_url_multi('service/'.$row->slug);
						$data->description = get_description($row->description);
						$data->date = format_date($row->created_at, 'd F Y');
						$data->image = $this->Model_tool_image->resize($row->image, 200, 200);

						$this->data['services'][] = $data;
					}
				}

				//Comments
				$star = 0;
				$this->data['review_star'] = 0;
				$comments = $this->Review_model->filter(['status' => 1, 'data_id' => $company->id, 'type' => 'company'])->order_by('created_at', 'DESC')->all();
				
				$this->data['comments'] = [];
				if($comments)
				{
					foreach($comments as $comment)
					{
						$review = new stdClass();
						$review->text = $comment->comment;
						$review->star = 6-$comment->star;
						$star += $comment->star;
						if($comment->user_id)
						{
							$review->author = get_user($comment->user_id);
							$review->author_username = site_url_multi('user/index/'.$this->auth->get_user($comment->user_id)->id);
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
							$review->author_username = '#';
							$review->author_image = $this->Model_tool_image->resize('catalog/user/user_default.png', 128, 128);
							$review->user_type = translate('guest', true);
						}

						$this->data['comments'][] = $review;

					}
				}
				if($this->data['comment_count'])
				{
					$this->data['review_star']			= round(($star/$this->data['comment_count']), 1);
				}

				//Language Links
				if($this->data['languages'])
				{
					foreach($this->data['languages'] as $key => $langauge)
					{
						$link = $this->Company_model->filter(['status' => 1, 'id' => $company->id])->with_translation($langauge['id'])->one();
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
							$this->data['language_link'][$key] = site_url($lang_slug.'company/'.$link->slug);
						}
						else
						{
							$this->data['language_link'][$key]  = site_url($lang_slug);
						}
					}
				}
				// Language link

				$this->template->render('company_single');
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

	public function add()
	{
		if(!$this->auth->is_loggedin())
		{
			show_404();	
		}

		$this->data['title'] = translate('add_title');
		$this->breadcrumbs->push(translate('add_title'), 'company/add');
		
		$this->data['parent_categories'] = $this->Category_model->filter(['parent_id' => 0])->with_translation()->order_by('name', 'ASC')->all();

		$this->form_validation->set_rules('parent_category_id', translate('parent_category_id'), 'required|trim');
		$this->form_validation->set_rules('category_id', translate('category_id'), 'required|trim');
		$this->form_validation->set_rules('region_id', translate('region_id'), 'required|trim');
		$this->form_validation->set_rules('mobile', translate('mobile'), 'required|trim');
		$this->form_validation->set_rules('email', translate('email'), 'required|trim');


		if($this->input->method() == 'post')
		{

			if($this->form_validation->run())
			{
				$company_data = [
					'parent_category_id'	=> (int)$this->input->post('parent_category_id'),
					'category_id'	=> (int)$this->input->post('category_id'),
					'sub_category_id'	=> (int)$this->input->post('sub_category_id'),
					'user_id'		=> $this->auth->get_user()->id,
					'country_id'	=> $this->input->post('country_id'),
					'region_id'		=> (int)$this->input->post('region_id'),
					'district_id'		=> (int)$this->input->post('district_id'),
					'metro_id'		=> (int)$this->input->post('metro_id'),
					'view'			=> 0,
					'phone'			=> $this->input->post('phone'),
					'website'		=> $this->input->post('website'),
					'mobile'		=> $this->input->post('mobile'),
					'fax'			=> $this->input->post('fax'),
					'email'			=> $this->input->post('email'),
					'facebook'		=> $this->input->post('facebook'),
					'instagram'		=> $this->input->post('instagram'),
					'twitter'		=> $this->input->post('twitter'),
					'latitude'		=> '',
					'longitude'		=> '',
					'status'		=> 2,
					'image'			=> $this->input->post('image'),
					'working_time'	=> NULL
				];

				$company_id = $this->Company_model->insert($company_data);

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

					foreach($this->data['languages'] as $language)
					{
						if($translation[$language['id']]['name'])
						{
							$company_language_data = [
								'company_id'	=> $company_id,
								'language_id'	=> $language['id'],
								'name'			=> $translation[$language['id']]['name'],
								'slug'			=> slug($translation[$language['id']]['name'], '-', true),
								'description'	=> $translation[$language['id']]['description']
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

							$this->Company_model->insert_translation($company_language_data);
						}
					}
					$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$company_id.'</strong> ID-li <strong>"'.$name.'"</strong> adlı şirkət əlavə etdi']);

					redirect(site_url_multi('company/edit/'.$company_id));
					
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
				$this->data['language_link'][$key] = site_url($lang_slug.'company/add/');
			}
		}
		// Language link

		$this->template->render('form/create/company');
	}

	public function edit($id = false)
	{
		if($this->auth->is_loggedin())
		{
			if($id)
			{
				$this->data['company'] = $this->Company_model->filter(['id' => $id, 'user_id' => $this->auth->get_user()->id])->one();
				$this->data['workday'] = json_decode($this->data['company']->working_time, true);

				if($this->data['company'])
				{
					$this->data['company']->image_preview = $this->Model_tool_image->resize($this->data['company']->image, 250, 250);
					
					$this->data['title'] = translate('edit_title');
					$this->breadcrumbs->push(translate('edit_title'), current_url());
					
					$this->data['parent_categories'] = $this->Category_model->filter(['parent_id' => 0])->with_translation()->order_by('name', 'ASC')->all();

					$images = $this->Company_model->get_images($id);
					$this->data['images'] = [];
					if($images)
					{
						foreach($images as $image)
						{
							$single_image = new stdClass();
							$single_image->path = $image->image;
							$single_image->preview = $this->Model_tool_image->resize($image->image, 250, 250);

							$this->data['images'][] = $single_image;
						} 
					}

					if($this->data['languages'])
					{
						foreach($this->data['languages'] as $key => $language)
						{
							$trans =  $this->Company_model->filter(['id' => $id])->with_translation($language['id'])->one();
							if($trans)
							{
								$this->data['translation'][$language['id']] = $trans;
							}
							else
							{
								$this->data['translation'][$language['id']] = new stdClass();
								$this->data['translation'][$language['id']]->name = '';
								$this->data['translation'][$language['id']]->description = '';
								$this->data['translation'][$language['id']]->address = '';
							}
							
						}
					}

					if($this->input->method() == 'post')
					{
						$translation = $this->input->post('translation');
						foreach($this->data['languages'] as $language)
						{
							if($translation[$language['id']]['name'])
							{
								$this->form_validation->set_rules('translation['.$language['id'].'][name]', translate('name'), 'required|trim');
							}
						}

						$this->data['company']->image 		= $this->input->post('image');
						

						if($this->form_validation->run())
						{

							if($this->input->post('workday'))
							{
								foreach($this->input->post('workday') as $day => $workday)
								{
									if(array_key_exists('status', $workday))
									{
										$workdays[$day]['status'] = true;
										$workdays[$day]['start_time'] = $workday['start_time'];
										$workdays[$day]['end_time'] = $workday['end_time'];
									}
									else
									{
										$workdays[$day]['status'] = false;
										$workdays[$day]['start_time'] = $workday['start_time'];
										$workdays[$day]['end_time'] = $workday['end_time'];
									}
								}

								$workday = json_encode($workdays);
							}

							$company_data = [
								'parent_category_id'	=> (int)$this->input->post('parent_category_id'),
								'category_id'	=> (int)$this->input->post('category_id'),
								'sub_category_id'	=> (int)$this->input->post('sub_category_id'),
								'user_id'		=> $this->auth->get_user()->id,
								'country_id'	=> $this->input->post('country_id'),
								'region_id'		=> (int)$this->input->post('region_id'),
								'district_id'	=> (int)$this->input->post('district_id'),
								'metro_id'		=> (int)$this->input->post('metro_id'),
								'view'			=> 0,
								'phone'			=> $this->input->post('phone'),
								'website'		=> $this->input->post('website'),
								'mobile'		=> $this->input->post('mobile'),
								'fax'			=> $this->input->post('fax'),
								'email'			=> $this->input->post('email'),
								'facebook'		=> $this->input->post('facebook'),
								'instagram'		=> $this->input->post('instagram'),
								'twitter'		=> $this->input->post('twitter'),
								'latitude'		=> $this->input->post('latitude'),
								'longitude'		=> $this->input->post('longitude'),
								'status'		=> 2,
								'image'			=> $this->input->post('image'),
								'working_time'	=> $workday
							];

							$this->Company_model->update($company_data, ['id' => $id]);
							$this->Company_model->delete_translation($id);

							foreach($this->data['languages'] as $language)
							{
								if($translation[$language['id']]['name'])
								{
									$company_translation_date = [
										'company_id'	=> $id,
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

									$this->Company_model->insert_translation($company_translation_date);
								}
							}

							if($this->input->post('images'))
							{
								$this->Company_model->delete_images($id);
								$this->Company_model->insert_images($this->input->post('images'), $id);
							}

							$this->data['response'] = [
								'success' => true,
								'message' => translate('company_successfully_edited')
							];

							$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$id.'</strong> ID-li <strong>"'.$name.'"</strong> adlı şirkəti redaktə etdi']);
							
							redirect(site_url_multi('user/company'));
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
							$this->data['language_link'][$key] = site_url($lang_slug.'company/edit/'.$id);
						}
					}
					// Language link

					$this->template->render('form/edit/company');
					
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
		else
		{
			show_404();
		}
		
	}

	public function delete($id = false)
	{
		if($id)
		{
			if(is_loggedin())
			{
				$company = $this->Company_model->filter(['id' => $id])->one();
				if($company)
				{
					if($company->user_id == $this->auth->get_user()->id)
					{
						$this->Company_model->delete($id);
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