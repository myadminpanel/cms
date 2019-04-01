<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Discount extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Discount_model');
		$this->load->model('modules/Company_model');
		$this->load->model('modules/Review_model');

		$popular_discounts = $this->Discount_model->filter(['status' => 1])->with_translation()->order_by('view', 'DESC')->limit(10, 0)->all();
		$this->data['popular_discounts'] = [];

		if($popular_discounts)
		{
			foreach($popular_discounts as $row)
			{
				$data = new stdClass();
				$data->name 			= $row->name;
				$data->link 			= site_url_multi('discount/'.$row->slug);
				$data->date 			= format_date($row->created_at, 'd F Y');

				$this->data['popular_discounts'][] = $data;
			 }
		}
	}

	public function index()
	{
		$this->data['title'] = translate('title');
		$this->breadcrumbs->push(translate('title'), 'discount');

		$per_page = 10;
		$segment_array = $this->uri->segment_array();
		$page = (ctype_digit(end($segment_array))) ? end($segment_array) : 1;
		
		$total_rows = $this->Discount_model->filter(['status' => 1])->with_translation()->count_rows();
		$rows = $this->Discount_model->filter(['status' => 1])->with_translation()->order_by('created_at', 'DESC')->limit($per_page, $page-1)->all();

		$this->data['rows'] = [];
		if($rows)
		{
			foreach($rows as $row)
			{
				$data = new stdClass();
				$data->name 			= $row->name;
				$data->description		= get_description($row->description);
				$data->link 			= site_url_multi('discount/'.$row->slug);
				$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
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
		$config['base_url'] = site_url_multi('discount/index');
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

				$this->data['language_link'][$key] = site_url($lang_slug.'discount/');
				
			}
		}
		// Language link

		$this->template->render('discount');
	}
	
	public function view($slug = false)
	{
		if($slug)
		{
			$discount = $this->Discount_model->filter(['status' => 1, 'slug' => $slug])->with_translation()->one();
			if($discount)
			{
				$company = $this->Company_model->filter(['status' => 1, 'id' => $discount->company_id])->with_translation()->one();

				if($company)
				{
					$this->data['company'] = new stdClass();
					$this->data['company']->name = $company->name;
					$this->data['company']->image = $this->Model_tool_image->resize($company->image, 244, 244);
					$this->data['company']->description = get_description($company->description);
					$this->data['company']->url = site_url_multi('company/'.$company->slug);
				}

				
				$this->breadcrumbs->push(translate('title'), 'discount');
				$this->breadcrumbs->push($discount->name, 'discount/'.$discount->slug);

				$this->data['id'] 				= $discount->id;
				$this->data['type'] 			= 'discount';
				$this->data['title'] 			= $discount->name;
				$this->data['description'] 		= $discount->description;
				$this->data['image'] 			= $this->Model_tool_image->resize($discount->image, 800, 600);
				$this->data['date'] 			= format_date($discount->created_at, 'd F Y');
				$this->data['view'] 			= $discount->view;				
				$this->data['comment_count'] 	= $this->Review_model->filter(['status' => 1, 'data_id' => $discount->id, 'type' => 'discount'])->count_rows();


				//View
				$new_view = $discount->view+1;
				$this->Discount_model->update(['view' => $new_view], $discount->id);

				//Related Discount
				$related_discounts = $this->Discount_model->filter(['status' => 1, 'id !=' => $discount->id, 'company_id' => $discount->company_id])->with_translation()->order_by('created_at', 'DESC')->limit(5, 0)->all();
				
				$this->data['relateds'] = [];
				if($related_discounts)
				{
					foreach($related_discounts as $row)
					{
						$data = new stdClass();
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('discount/'.$row->slug);
						$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
						$data->date 			= format_date($row->created_at, 'd F Y');
						$data->view 			= $row->view;

						$this->data['relateds'][] = $data;
					}

				}


				//Other Discount
				$other_discounts = $this->Discount_model->filter(['status' => 1, 'id !=' => $discount->id, 'company_id' => $discount->company_id])->with_translation()->order_by('created_at', 'DESC')->limit(5, 0)->all();
				
				$this->data['others'] = [];
				if($other_discounts)
				{
					foreach($other_discounts as $row)
					{
						$data = new stdClass();
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('discount/'.$row->slug);
						$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
						$data->date 			= format_date($row->created_at, 'd F Y');
						$data->view 			= $row->view;

						$this->data['others'][] = $data;
					}

				}

				//Comments
				$comments = $this->Review_model->filter(['status' => 1, 'data_id' => $discount->id, 'type' => 'discount'])->order_by('created_at', 'DESC')->all();
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

						$this->data['comments'][] = $review;

					}
				}

				//Language Links
				if($this->data['languages'])
				{
					foreach($this->data['languages'] as $key => $langauge)
					{
						$link = $this->Discount_model->filter(['status' => 1, 'id' => $discount->id])->with_translation($langauge['id'])->one();
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
							$this->data['language_link'][$key] = site_url($lang_slug.'discount/'.$link->slug);
						}
						else
						{
							$this->data['language_link'][$key]  = site_url($lang_slug);
						}
					}
				}
				// Language link

				$this->template->render('discount_single');
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

				$this->breadcrumbs->push(translate('title'), 'discount');
				$this->breadcrumbs->push($company->name, 'discount/company/'.$company->slug);

				$per_page = 10;
				$segment_array = $this->uri->segment_array();
				$page = (ctype_digit(end($segment_array))) ? end($segment_array) : 1;
				
				$total_rows = $this->Discount_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->count_rows();
				$rows = $this->Discount_model->filter(['status' => 1, 'company_id' => $company->id])->with_translation()->order_by('created_at', 'DESC')->limit($per_page, $page-1)->all();

				$this->data['rows'] = [];
				if($rows)
				{
					foreach($rows as $row)
					{
						$data = new stdClass();
						$data->name 			= $row->name;
						$data->description		= get_description($row->description);
						$data->link 			= site_url_multi('discount/'.$row->slug);
						$data->image 			= $this->Model_tool_image->resize($row->image, 191, 135);
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
				$config['base_url'] = site_url_multi('discount/company/'.$slug);
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
							$this->data['language_link'][$key] = site_url($lang_slug.'discount/company/'.$link->slug);
						}
						else
						{
							$this->data['language_link'][$key]  = site_url($lang_slug);
						}
					}
				}
				// Language link

				$this->template->render('discount');
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

				$this->data['company_id'] = set_value('company_id');
			}
			else
			{
				$this->data['company_id'] = 0;
			}

			$this->data['title'] = translate('add_title');
			
			//Breadcrumb
			$this->breadcrumbs->push(translate('title'), 'discount');
			$this->breadcrumbs->push(translate('add_title'), 'discount/add');

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
						$discount = [
							'company_id'	=> $this->input->post('company_id'),
							'date'			=> $this->input->post('date'),
							'image'			=> $this->input->post('image'),
							'status'		=> 2,
						];

						$discount_id = $this->Discount_model->insert($discount);

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

								$this->Discount_model->insert_translation($discount_translation_data);
							}
						}

						$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$discount_id.'</strong> ID-li <strong>"'.$name.'"</strong> adlı endirim əlavə etdi']);

						$this->data['response'] = [
							'success' => true,
							'message' => translate('discount_submited')
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
						$this->data['language_link'][$key] = site_url($lang_slug.'discount/add/'.$id);
					}
					else
					{
						$this->data['language_link'][$key] = site_url($lang_slug.'discount/add/');
					}
					
				}
			}
			// Language link

			$this->template->render('form/create/discount');

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
				$this->data['discount'] = $this->Discount_model->filter(['id' => $id])->one();
				if($this->data['discount'])
				{
					$this->data['discount']->image_preview = $this->Model_tool_image->resize($this->data['discount']->image, 250, 250);
					$company = $this->Company_model->filter(['id' => $this->data['discount']->company_id, 'user_id' => $this->auth->get_user()->id])->one();
					if($company)
					{
						$this->data['title'] = translate('edit_discount');
						
						//Breadcrumb
						$this->breadcrumbs->push(translate('title'), 'discount');
						$this->breadcrumbs->push(translate('edit_discount'), 'discount/edit/'.$id);

						$this->data['companies'] = $this->Company_model->filter(['user_id' => $this->auth->get_user()->id, 'status' => 1])->with_translation()->order_by('created_at', 'ASC')->all();

						if($this->data['languages'])
						{
							foreach($this->data['languages'] as $key => $language)
							{
								$trans =  $this->Discount_model->filter(['id' => $id])->with_translation($language['id'])->one();
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
									$this->form_validation->set_rules('translation['.$language['id'].'][name]', translate('name'), 'required|trim');
								}
							}

							$this->data['discount']->company_id = (int) $this->input->post('company_id');
							$this->data['discount']->image 		= $this->input->post('image');
							

							if($this->form_validation->run())
							{
								$discount_data = [
									'company_id'	=> (int)$this->input->post('company_id'),
									'image'			=> $this->input->post('image'),
									'date'			=> $this->input->post('date'),
									'status'		=> 2
								];

								$this->Discount_model->update($discount_data, ['id' => $id]);
								$this->Discount_model->delete_translation($id);

								foreach($this->data['languages'] as $language)
								{
									if($translation[$language['id']]['name'])
									{
										$discount_translation_data = [
											'discount_id'		=> $id,
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

										$this->Discount_model->insert_translation($discount_translation_data);
									}
								}

								$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$id.'</strong> ID-li <strong>"'.$name.'"</strong> adlı endirim redaktə etdi']);

								$this->data['response'] = [
									'success' => true,
									'message' => translate('discount_successfully_edited')
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

								$this->data['language_link'][$key] = site_url($lang_slug.'discount/edit/'.$id);
								
								
							}
						}
						// Language link

						$this->template->render('form/edit/discount');
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
				$discount = $this->Discount_model->filter(['id' => $id])->one();

				if($discount)
				{
					$company = $this->Company_model->filter(['id' => $discount->company_id])->one();
					if($company)
					{
						if($company->user_id == $this->auth->get_user()->id)
						{
							$this->Discount_model->delete($id);
							$this->Notify_admin_model->insert(['text' => '<strong>'.get_user().'</strong> adlı istifadəçi <strong>'.$id.'</strong> ID-li endirimi sildi']);
							redirect(site_url_multi('user/discount'));
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