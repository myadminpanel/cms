<?php
defined('BASEPATH') or exit('No direct script access allowed');

class News extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/News_model');
		$this->load->model('modules/News_category_model');
		$this->load->model('modules/Company_model');
		$this->load->model('modules/Review_model');

		$popular_news = $this->News_model->filter(['status' => 1])->with_translation()->order_by('view', 'DESC')->limit(10, 0)->all();
		$this->data['popular_news'] = [];

		if($popular_news)
		{
			foreach($popular_news as $row)
			{
				$data = new stdClass();
				$data->name 			= $row->name;
				$data->link 			= site_url_multi('news/'.$row->slug);
				$data->date 			= format_date($row->created_at, 'd F Y');

				$this->data['popular_news'][] = $data;
			 }
		}
	}

	public function index()
	{
		$this->data['title'] = translate('title');
		$this->breadcrumbs->push(translate('title'), 'news');

		$per_page = 12;
		$segment_array = $this->uri->segment_array();
		$page = (ctype_digit(end($segment_array))) ? end($segment_array) : 1;

		$filter['status'] = 1;

		if($this->input->get('author'))
		{
			$filter['created_by'] = $this->input->get('author');
		}
		
		$total_rows = $this->News_model->filter($filter)->with_translation()->count_rows();
		$rows = $this->News_model->filter($filter)->with_translation()->order_by('created_at', 'DESC')->limit($per_page, $page-1)->all();

		$this->data['categories'] = $this->News_category_model->filter(['status' => 1, 'parent_id' => 0])->with_translation()->order_by('name', 'ASC')->all();

		$this->data['rows'] = [];
		if($rows)
		{
			foreach($rows as $row)
			{
				$data = new stdClass();
				$data->name 			= $row->name;
				$data->description		= get_description($row->description);
				$data->link 			= site_url_multi('news/'.$row->slug);
				$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
				$data->date 			= format_date($row->created_at, 'd F Y');
				$data->view 			= $row->view;
				$data->author 			= get_user($row->created_by);

				$this->data['rows'][] = $data;
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
		$config['base_url'] = site_url_multi('news/index');
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

				$this->data['language_link'][$key] = site_url($lang_slug.'news/');
				
			}
		}
		// Language link

		$this->template->render('news');
	}

	public function category($slug = false)
	{
		if($slug)
		{
			$category = $this->News_category_model->filter(['status' => 1, 'slug' => $slug])->with_translation()->one();

			if($category)
			{
				$this->data['title'] = $category->name;

				$this->data['categories'] = $this->News_category_model->filter(['status' => 1, 'parent_id' => $category->id])->with_translation()->order_by('name', 'ASC')->all();
				//Breadcrumb
				$this->breadcrumbs->push(translate('title'), 'news');

				$parent_category = $this->News_category_model->filter(['status' => 1, 'id' => $category->parent_id])->with_translation()->one();
				
				if($parent_category)
				{
					$this->breadcrumbs->push($parent_category->name, 'news/category/'.$parent_category->slug);
				}

				$sub_categories = $this->News_category_model->filter(['status' => 1, 'parent_id' => $category->id])->with_translation()->all();

				$filter['status'] = 1;
				
				$sub_category_ids[0] = $category->id;
				if($sub_categories)
				{
					foreach($sub_categories as $sub_category)
					{
						$sub_category_ids[] = $sub_category->id;
					}
				}

				$filter['category_id IN ('.implode(',', $sub_category_ids).')'] = NULL;
				
				$this->breadcrumbs->push($category->name, 'news/category/'.$slug);

				$per_page = 12;
				$segment_array = $this->uri->segment_array();
				$page = (ctype_digit(end($segment_array))) ? end($segment_array) : 1;
				
				$total_rows = $this->News_model->filter($filter)->with_translation()->count_rows();
				$rows = $this->News_model->filter($filter)->with_translation()->order_by('created_at', 'DESC')->limit($per_page, $page-1)->all();

				$this->data['rows'] = [];
				if($rows)
				{
					foreach($rows as $row)
					{
						$data = new stdClass();
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('news/'.$row->slug);
						$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
						$data->date 			= format_date($row->created_at, 'd F Y');
						$data->view 			= $row->view;
						$data->author 			= get_user($row->created_by);

						$this->data['rows'][] = $data;
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
				$config['base_url'] = site_url_multi('news/index');
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
						$link = $this->News_category_model->filter(['status' => 1, 'id' => $category->id])->with_translation($langauge['id'])->one();
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
							$this->data['language_link'][$key] = site_url($lang_slug.'news/category/'.$link->slug);
						}
						else
						{
							$this->data['language_link'][$key]  = site_url($lang_slug);
						}
					}
				}
				// Language link

				$this->template->render('news');
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
	
	public function view($slug = false)
	{
		if($slug)
		{
			$news = $this->News_model->filter(['status' => 1, 'slug' => $slug])->with_translation()->one();
			if($news)
			{
				$company = $this->Company_model->filter(['status' => 1, 'id' => $news->company_id])->with_translation()->one();

				if($company)
				{
					$this->data['company'] = new stdClass();
					$this->data['company']->name = $company->name;
					$this->data['company']->image = $this->Model_tool_image->resize($company->image, 244, 244);
					$this->data['company']->description = get_description($company->description);
					$this->data['company']->url = site_url_multi('company/'.$company->slug);
				}

				//Breadcrumb
				$this->breadcrumbs->push(translate('title'), 'news');

				if($news->category_id)
				{
					$category = $this->News_category_model->filter(['status' => 1, 'id' => $news->category_id])->with_translation()->one();
					if($category)
					{
						if($category->parent_id)
						{
							$parent_category = $this->News_category_model->filter(['status' => 1, 'id' => $category->parent_id])->with_translation()->one();
							if($parent_category)
							{
								$this->breadcrumbs->push($parent_category->name, 'news/category/'.$parent_category->slug);
							}
						}
						$this->breadcrumbs->push($category->name, 'news/category/'.$category->slug);
					}
				}

				$this->breadcrumbs->push($news->name, 'news/'.$news->slug);

				


				$this->data['id'] 				= $news->id;
				$this->data['type'] 			= 'news';
				$this->data['title'] 			= $news->name;
				$this->data['description'] 		= $news->description;
				$this->data['image'] 			= $this->Model_tool_image->resize($news->image, 800, 600);
				$this->data['date'] 			= format_date($news->created_at, 'd F Y');
				$this->data['view'] 			= $news->view;
				$this->data['author'] 			= get_user($news->created_by);
				$this->data['author_username']	= $this->auth->get_user($news->created_by)->id;
				$this->data['comment_count'] 	= $this->Review_model->filter(['status' => 1, 'data_id' => $news->id, 'type' => 'news'])->count_rows();

				
				$this->breadcrumbs->push(translate('title'), 'news');
				$this->breadcrumbs->push($news->name, 'news/'.$news->slug);

				//View
				$new_view = $news->view+1;
				$this->News_model->update(['view' => $new_view], $news->id);

				//Related News
				$related_news = $this->News_model->filter(['status' => 1, 'id !=' => $news->id])->with_translation()->order_by('created_at', 'RANDOM')->limit(5, 0)->all();
				$this->data['relateds'] = [];
				if($related_news)
				{
					foreach($related_news as $row)
					{
						$data = new stdClass();
						$data->id 			= $row->id;
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('news/'.$row->slug);
						$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
						$data->date 			= format_date($row->created_at, 'd F Y');
						$data->view 			= $row->view;

						$this->data['relateds'][] = $data;
					}

				}

				//Other News
				$other_news = $this->News_model->filter(['status' => 1, 'id !=' => $news->id, 'company_id' => $news->company_id])->with_translation()->order_by('created_at', 'DESC')->limit(5, 0)->all();
				$this->data['others'] = [];
				if($other_news)
				{
					foreach($other_news as $row)
					{
						$data = new stdClass();
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('news/'.$row->slug);
						$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
						$data->date 			= format_date($row->created_at, 'd F Y');
						$data->view 			= $row->view;

						$this->data['others'][] = $data;
					}

				}


				//Comments
				$comments = $this->Review_model->filter(['status' => 1, 'data_id' => $news->id, 'type' => 'news'])->order_by('created_at', 'DESC')->all();
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
							$review->user_type = translate('guest', true);
						}

						$this->data['comments'][] = $review;

					}
				}

				//Language Links
				if($this->data['languages'])
				{
					foreach($this->data['languages'] as $key => $langauge)
					{
						$link = $this->News_model->filter(['status' => 1, 'id' => $news->id])->with_translation($langauge['id'])->one();
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
							$this->data['language_link'][$key] = site_url($lang_slug.'news/'.$link->slug);
						}
						else
						{
							$this->data['language_link'][$key]  = site_url($lang_slug);
						}
					}
				}
				// Language link

				$this->template->render('news_single');
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

	public function company($slug = false)
	{
		if($slug)
		{
			$company = $this->Company_model->filter(['status' => 1, 'slug' => $slug])->with_translation()->one();
			if($company)
			{
				$this->data['title'] = translate('title');

				$this->breadcrumbs->push(translate('title'), 'news');
				$this->breadcrumbs->push($company->name, 'news/company/'.$company->slug);
				

				$per_page = 12;
				$segment_array = $this->uri->segment_array();
				$page = (ctype_digit(end($segment_array))) ? end($segment_array) : 1;
				
				$total_rows = $this->News_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->count_rows();
				$rows = $this->News_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->order_by('created_at', 'DESC')->limit($per_page, $page-1)->all();

				$this->data['rows'] = [];
				if($rows)
				{
					foreach($rows as $row)
					{
						$data = new stdClass();
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('news/'.$row->slug);
						$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
						$data->date 			= format_date($row->created_at, 'd F Y');
						$data->view 			= $row->view;
						$data->author 			= get_user($row->created_by);


						$this->data['rows'][] = $data;
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
				$config['base_url'] = site_url_multi('news/index');
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
							$this->data['language_link'][$key] = site_url($lang_slug.'news/company/'.$link->slug);
						}
						else
						{
							$this->data['language_link'][$key]  = site_url($lang_slug);
						}
					}
				}
				// Language link


				$this->template->render('news');
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

	public function add($id = false)
	{
		if(is_loggedin())
		{
			if($id)
			{
				$this->data['company_id'] = $id;
			}
			elseif(set_value('company_id'))
			{
				$this->data['company_id'] = set_value('company_id');
			}
			else
			{
				$this->data['company_id'] = 0;
			}

			$this->data['title'] = translate('add_title');

			//Breadcrumb
			$this->breadcrumbs->push(translate('title'), 'news');
			$this->breadcrumbs->push(translate('add_title'), 'news/add');


			$this->data['companies'] = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id, 'status' => 1])->with_translation()->order_by('created_at', 'ASC')->all();

			if($this->input->method() == 'post')
			{
				$this->form_validation->set_rules('image', translate('image'), 'required|trim');
				$this->form_validation->set_rules('company_id', translate('company'), 'required|trim');

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
						$news = [
							'company_id'	=> $this->input->post('company_id'),
							'image'			=> $this->input->post('image'),
							'status'		=> 2,
						];

						$news_id = $this->News_model->insert($news);

						foreach($this->data['languages'] as $language)
						{
							if($translation[$language['id']]['name'])
							{
								$news_translation_data = [
									'news_id'		=> $news_id,
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

								$this->News_model->insert_translation($news_translation_data);
							}
						}

						$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$news_id.'</strong> ID-li <strong>"'.$name.'"</strong> adlı xəbər əlavə etdi']);

						$this->data['response'] = [
							'success' => true,
							'message' => translate('news_submited')
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
					if($id)
					{
						$this->data['language_link'][$key] = site_url($lang_slug.'news/add/'.$id);
					}
					else
					{
						$this->data['language_link'][$key] = site_url($lang_slug.'news/add/');
					}
					
				}
			}
			// Language link

			$this->template->render('form/create/news');
				
		}
		else
		{
			show_404();
		}
		
	}

	public function edit($id = false)
	{
		if($this->auth->is_loggedin())
		{
			if($id)
			{
				$this->data['news'] = $this->News_model->filter(['id' => $id])->one();
				if($this->data['news'])
				{
					$this->data['news']->image_preview = $this->Model_tool_image->resize($this->data['news']->image, 250, 250);
					$company = $this->Company_model->filter(['id' => $this->data['news']->company_id, 'user_id' => $this->auth->get_user()->id])->one();
					if($company)
					{
						$this->data['title'] = translate('edit_news');

						//Breadcrumb
						$this->breadcrumbs->push(translate('title'), 'news');
						$this->breadcrumbs->push(translate('edit_news'), 'news/edit/'.$id);


						$this->data['companies'] = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id, 'status' => 1])->with_translation()->order_by('created_at', 'ASC')->all();

						if($this->data['languages'])
						{
							foreach($this->data['languages'] as $key => $language)
							{
								$trans =  $this->News_model->filter(['id' => $id])->with_translation($language['id'])->one();
								if($trans)
								{
									$this->data['translation'][$language['id']] = $trans;
								}
								else
								{
									$this->data['translation'][$language['id']] = new stdClass();
									$this->data['translation'][$language['id']]->name = '';
									$this->data['translation'][$language['id']]->description = '';
								}
								
							}
						}

						$this->form_validation->set_rules('company_id', translate('company_id'), 'required|trim');
						$this->form_validation->set_rules('image', translate('image'), 'required|trim');

						if($this->input->method() == 'post')
						{
							$translation = $this->input->post('translation');
							foreach($this->data['languages'] as $language)
							{
								if($translation[$language['id']]['name'])
								{
									$this->form_validation->set_rules('translation['.$language['id'].'][name]', 'Name', 'required|trim');
								}
							}

							$this->data['news']->company_id = (int) $this->input->post('company_id');
							$this->data['news']->image 		= $this->input->post('image');
							

							if($this->form_validation->run())
							{
								$news_data = [
									'company_id'	=> (int)$this->input->post('company_id'),
									'image'			=> $this->input->post('image'),
									'status'		=> 2
								];

								$this->News_model->update($news_data, ['id' => $id]);
								$this->News_model->delete_translation($id);

								foreach($this->data['languages'] as $language)
								{
									if($translation[$language['id']]['name'])
									{
										$news_translation_data = [
											'news_id'		=> $id,
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

										$this->News_model->insert_translation($news_translation_data);
									}
								}

								
								$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$id.'</strong> ID-li <strong>"'.$name.'"</strong> adlı xəbəri redaktə etdi']);

								$this->data['response'] = [
									'success' => true,
									'message' => translate('news_successfully_edited')
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

								$this->data['language_link'][$key] = site_url($lang_slug.'news/edit/'.$id);
								
								
							}
						}
						// Language link

						$this->template->render('form/edit/news');
					}
					else
					{
						show_404();
					}
				}
				else
				{
					show_4o4();
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
				$news = $this->News_model->filter(['id' => $id])->one();

				if($news)
				{
					$company = $this->Company_model->filter(['id' => $news->company_id])->one();
					if($company)
					{
						if($company->user_id == $this->auth->get_user()->id)
						{
							$this->News_model->delete($id);
							$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$id.'</strong> ID-li xəbəri sildi']);
							redirect(site_url_multi('user/news'));
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
		else
		{
			show_404();	
		}
	}
}