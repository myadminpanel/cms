<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Page extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Page_model');
		$this->load->model('modules/Country_phone_code_model');
		$this->load->model('modules/City_phone_code_model');
		$this->load->model('modules/Short_phone_code_model');
		$this->load->model('modules/Postal_code_model');
		$this->load->model('modules/Car_plate_code_model');
		$this->load->model('modules/Faq_model');
	}

	public function index($slug = false)
	{
		if($slug)
		{
			$page = $this->Page_model->filter(['status' => 1, 'slug' => $slug])->with_translation()->one();

			if($page)
			{
				$this->data['title'] 		= $page->name;
				$this->data['image'] 		= $page->image;
				$this->data['description'] 	= $page->description;

				
				$this->breadcrumbs->push($page->name, $page->slug);

				//Language Links
				if($this->data['languages'])
				{
					foreach($this->data['languages'] as $key => $langauge)
					{
						$link = $this->Page_model->filter(['status' => 1, 'id' => $page->id])->with_translation($langauge['id'])->one();
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
							$this->data['language_link'][$key] = site_url($lang_slug.$link->slug);
						}
						else
						{
							$this->data['language_link'][$key]  = site_url($lang_slug);
						}
					}
				}
				// Language link

				$this->template->render('page');
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

	public function not_found()
	{
		$this->data['title'] = '404';
		$this->data['description'] = 'Page not found';
		$this->output->set_status_header('404'); 
		$this->template->render('page');
	}

	public function country_phone_code()
	{
		$this->data['title'] = translate('country_phone_code_title');
		$this->breadcrumbs->push(translate('country_phone_code_title'), 'country_phone_code');

		$this->data['codes'] = $this->Country_phone_code_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();

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

				$this->data['language_link'][$key] = site_url($lang_slug.'page/country_phone_code');
				
			}
		}
		// Language link

		$this->template->render('country_phone_code');
	}

	public function city_phone_code()
	{
		$this->data['title'] = translate('city_phone_code_title');
		$this->breadcrumbs->push(translate('city_phone_code_title'), 'city_phone_code');

		$this->data['codes'] = $this->City_phone_code_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();

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

				$this->data['language_link'][$key] = site_url($lang_slug.'page/city_phone_code');
				
			}
		}
		// Language link

		$this->template->render('city_phone_code');
	}

	public function postal_code()
	{
		$this->data['title'] = translate('postal_code_title');
		$this->breadcrumbs->push(translate('postal_code_title'), 'postal_code');

		$this->data['codes'] = $this->Postal_code_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();

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

				$this->data['language_link'][$key] = site_url($lang_slug.'page/postal_code');
				
			}
		}
		// Language link

		$this->template->render('postal_code');
	}

	public function short_phone_code()
	{
		$this->data['title'] = translate('short_phone_code_title');
		$this->breadcrumbs->push(translate('short_phone_code_title'), 'short_phone_code');

		$this->data['codes'] = $this->Short_phone_code_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();

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

				$this->data['language_link'][$key] = site_url($lang_slug.'page/short_phone_code');
				
			}
		}
		// Language link

		$this->template->render('short_phone_code');
	}

	public function car_plate_code()
	{
		$this->data['title'] = translate('car_plate_code_title');
		$this->breadcrumbs->push(translate('car_plate_code_title'), 'car_plate_code');

		$this->data['codes'] = $this->Car_plate_code_model->filter(['status' => 1])->with_translation()->order_by('name', 'ASC')->all();

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

				$this->data['language_link'][$key] = site_url($lang_slug.'page/car_plate_code');
				
			}
		}
		// Language link

		$this->template->render('car_plate_code');
	}

	public function faq()
	{
		$this->data['title'] = translate('faq_title');
		$this->breadcrumbs->push(translate('faq_title'), 'faq');

		$this->data['faqs'] = $this->Faq_model->filter(['status' => 1])->with_translation()->order_by('sort', 'ASC')->all();

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

				$this->data['language_link'][$key] = site_url($lang_slug.'faq');
				
			}
		}
		// Language link

		$this->template->render('faq');
	}
}