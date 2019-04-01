<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Video extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Video_model');
		$this->load->model('modules/Company_model');
		$this->load->model('modules/Review_model');

		$popular_videos = $this->Video_model->filter(['status' => 1])->with_translation()->order_by('view', 'DESC')->limit(10, 0)->all();
		$this->data['popular_videos'] = [];

		if($popular_videos)
		{
			foreach($popular_videos as $row)
			{
				$data = new stdClass();
				$data->name 			= $row->name;
				$data->link 			= site_url_multi('video/'.$row->slug);
				$data->date 			= format_date($row->created_at, 'd F Y');

				$this->data['popular_videos'][] = $data;
			 }
		}
	}

	public function index()
	{
		$this->data['title'] = translate('title');
		$this->breadcrumbs->push(translate('title'), 'video');

		$per_page = 10;
		$segment_array = $this->uri->segment_array();
		$page = (ctype_digit(end($segment_array))) ? end($segment_array) : 1;
		
		$total_rows = $this->Video_model->filter(['status' => 1])->with_translation()->count_rows();
		$rows = $this->Video_model->filter(['status' => 1])->with_translation()->order_by('created_at', 'DESC')->limit($per_page, $page-1)->all();

		$this->data['rows'] = [];
		if($rows)
		{
			foreach($rows as $row)
			{
				$data = new stdClass();
				$data->name 			= $row->name;
				$data->description		= get_description($row->description);
				$data->link 			= site_url_multi('video/'.$row->slug);
				$data->image 			= youtube_image($row->video);
				$data->date 			= format_date($row->created_at, 'd F Y');
				$data->view 			= $row->view;

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
		$config['base_url'] = site_url_multi('video/index');
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

				$this->data['language_link'][$key] = site_url($lang_slug.'video/');
				
			}
		}
		// Language link

		$this->template->render('video');
	}

	public function view($slug = false)
	{
		if($slug)
		{
			$video = $this->Video_model->filter(['status' => 1, 'slug' => $slug])->with_translation()->one();
			if($video)
			{
				$company = $this->Company_model->filter(['status' => 1, 'id' => $video->company_id])->with_translation()->one();

				if($company)
				{
					$this->data['company'] = new stdClass();
					$this->data['company']->name = $company->name;
					$this->data['company']->image = $this->Model_tool_image->resize($company->image, 244, 244);
					$this->data['company']->description = get_description($company->description);
					$this->data['company']->url = site_url_multi('company/'.$company->slug);
				}

				
				$this->data['id'] 				= $video->id;
				$this->data['type'] 			= 'video';
				$this->data['title'] 			= $video->name;
				$this->data['description'] 		= $video->description;
				$this->data['image'] 			= youtube_image($video->video);
				$this->data['video'] 			= youtube_id($video->video);
				$this->data['date'] 			= format_date($video->created_at, 'd F Y');
				$this->data['view'] 			= $video->view;
				$this->data['comment_count'] 	= $this->Review_model->filter(['status' => 1, 'data_id' => $video->id, 'type' => 'video'])->count_rows();

				//Breadcrumb
				$this->breadcrumbs->push(translate('title'), 'video');
				$this->breadcrumbs->push($video->name, 'video/'.$video->slug);

				//View
				$new_view = $video->view+1;
				$this->Video_model->update(['view' => $new_view], $video->id);

				//Related Video
				$related_videos = $this->Video_model->filter(['status' => 1, 'id !=' => $video->id, 'company_id' => $video->company_id])->with_translation()->order_by('created_at', 'DESC')->limit(5, 0)->all();
				$this->data['relateds'] = [];
				if($related_videos)
				{
					foreach($related_videos as $row)
					{
						$data = new stdClass();
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('video/'.$row->slug);
						$data->image 			= youtube_image($video->video);
						$data->date 			= format_date($row->created_at, 'd F Y');
						$data->view 			= $row->view;
					}

					$this->data['relateds'][] = $data;
				}

				//Other Video
				$other_videos = $this->Video_model->filter(['status' => 1, 'id !=' => $video->id, 'company_id' => $video->company_id])->with_translation()->order_by('created_at', 'DESC')->limit(5, 0)->all();
				$this->data['others'] = [];
				if($other_videos)
				{
					foreach($other_videos as $row)
					{
						$data = new stdClass();
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('video/'.$row->slug);
						$data->image 			= youtube_image($video->video);
						$data->date 			= format_date($row->created_at, 'd F Y');
						$data->view 			= $row->view;
					}

					$this->data['others'][] = $data;
				}


				//Comments
				$comments = $this->Review_model->filter(['status' => 1, 'data_id' => $video->id, 'type' => 'video'])->order_by('created_at', 'DESC')->all();
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
						$link = $this->Video_model->filter(['status' => 1, 'id' => $video->id])->with_translation($langauge['id'])->one();
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
							$this->data['language_link'][$key] = site_url($lang_slug.'video/'.$link->slug);
						}
						else
						{
							$this->data['language_link'][$key]  = site_url($lang_slug);
						}
					}
				}
				// Language link

				$this->template->render('video_single');
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
			$company = $this->Company_model->filter(['slug' => $slug, 'status' => 1])->with_translation()->one();
			if($company)
			{
				$this->data['title'] = translate('title');

				//Breadcrumb
				$this->breadcrumbs->push(translate('title'), 'video');
				$this->breadcrumbs->push($company->name, 'video/company/'.$company->slug);

				$per_page = 10;
				$segment_array = $this->uri->segment_array();
				$page = (ctype_digit(end($segment_array))) ? end($segment_array) : 1;
				
				$total_rows = $this->Video_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->count_rows();
				$rows = $this->Video_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->order_by('created_at', 'DESC')->limit($per_page, $page-1)->all();

				$this->data['rows'] = [];
				if($rows)
				{
					foreach($rows as $row)
					{
						$data = new stdClass();
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('video/'.$row->slug);
						$data->image 			= youtube_image($row->video);
						$data->date 			= format_date($row->created_at, 'd F Y');
						$data->view 			= $row->view;

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
				$config['base_url'] = site_url_multi('video/company/'.$slug);
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
							$this->data['language_link'][$key] = site_url($lang_slug.'video/company/'.$link->slug);
						}
						else
						{
							$this->data['language_link'][$key]  = site_url($lang_slug);
						}
					}
				}
				// Language link

				$this->template->render('video');
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
				$company = $this->Company_model->filter(['id' => $id])->one();
				if($company)
				{
					if($company->user_id == $this->auth->get_user()->id)
					{
						$this->data['company_id'] = $id;
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
			elseif(set_value('company_id'))
			{
				$company = $this->Company_model->filter(['id' => set_value('company_id')])->one();
				if($company)
				{
					if($company->user_id == $this->auth->get_user()->id)
					{
						$this->data['company_id'] = set_value('company_id');
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
				$this->data['company_id'] = 0;
			}

			$this->data['title'] = translate('add_title');

			//Breadcrumb
			$this->breadcrumbs->push(translate('title'), 'video');
			$this->breadcrumbs->push(translate('add_title'), 'video/add');

			$this->data['companies'] = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id, 'status' => 1])->with_translation()->order_by('created_at', 'ASC')->all();

			if($this->input->method() == 'post')
			{
				$this->form_validation->set_rules('video', translate('video'), 'required|trim');
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
						$video = [
							'company_id'	=> $this->input->post('company_id'),
							'video'			=> $this->input->post('video'),
							'status'		=> 2,
						];

						$video_id = $this->Video_model->insert($video);

						foreach($this->data['languages'] as $language)
						{
							if($translation[$language['id']]['name'])
							{
								$video_translation_data = [
									'video_id'		=> $video_id,
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

								$this->Video_model->insert_translation($video_translation_data);
							}
						}

						
						$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$video_id.'</strong> ID-li <strong>"'.$name.'"</strong> adlı videonu əlavə etdi']);


						$this->data['response'] = [
							'success' => true,
							'message' => translate('video_submited')
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
						$this->data['language_link'][$key] = site_url($lang_slug.'video/add/'.$id);
					}
					else
					{
						$this->data['language_link'][$key] = site_url($lang_slug.'video/add/');
					}
					
				}
			}
			// Language link

			$this->template->render('form/create/video');
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
				$this->data['video'] = $this->Video_model->filter(['id' => $id])->one();
				if($this->data['video'])
				{
					$company = $this->Company_model->filter(['id' => $this->data['video']->company_id, 'user_id' => $this->auth->get_user()->id])->one();
					if($company)
					{
						$this->data['title'] = translate('edit_video');

						//Breadcrumb
						$this->breadcrumbs->push(translate('title'), 'video');
						$this->breadcrumbs->push(translate('edit_video'), 'video/edit/'.$id);

						$this->data['companies'] = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id, 'status' => 1])->with_translation()->order_by('created_at', 'ASC')->all();

						if($this->data['languages'])
						{
							foreach($this->data['languages'] as $key => $language)
							{
								$trans =  $this->Video_model->filter(['id' => $id])->with_translation($language['id'])->one();
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
						$this->form_validation->set_rules('video', translate('video'), 'required|trim');

						if($this->input->method() == 'post')
						{
							$translation = $this->input->post('translation');
							foreach($this->data['languages'] as $language)
							{
								if($translation[$language['id']]['name'] )
								{
									$this->form_validation->set_rules('translation['.$language['id'].'][name]', translate('name'), 'required|trim');
								}
							}

							$this->data['video']->company_id = (int) $this->input->post('company_id');
							$this->data['video']->video 		= $this->input->post('video');
							

							if($this->form_validation->run())
							{
								$video_data = [
									'company_id'	=> (int)$this->input->post('company_id'),
									'video'			=> $this->input->post('video'),
									'status'		=> 2
								];

								$this->Video_model->update($video_data, ['id' => $id]);
								$this->Video_model->delete_translation($id);

								foreach($this->data['languages'] as $language)
								{
									if($translation[$language['id']]['name'])
									{
										$video_translation_data = [
											'video_id'		=> $id,
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

										$this->Video_model->insert_translation($video_translation_data);
									}
								}

								$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$id.'</strong> ID-li <strong>"'.$name.'"</strong> adlı videonu redaktə etdi']);

								$this->data['response'] = [
									'success' => true,
									'message' => translate('video_successfully_edited')
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

								$this->data['language_link'][$key] = site_url($lang_slug.'video/edit/'.$id);
								
								
							}
						}
						// Language link

						$this->template->render('form/edit/video');
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
				$video = $this->Video_model->filter(['id' => $id])->one();

				if($video)
				{
					$company = $this->Company_model->filter(['id' => $video->company_id])->one();
					if($company)
					{
						if($company->user_id == $this->auth->get_user()->id)
						{
							$this->Video_model->delete($id);
							$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$id.'</strong> ID-li videonu sildi']);
							redirect(site_url_multi('user/video'));
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