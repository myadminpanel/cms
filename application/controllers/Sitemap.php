<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Sitemap extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
	}

	public function index()
	{
		$this->data['title'] = translate('title');
		$this->breadcrumbs->push(translate('title'), 'sitemap');

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

				$this->data['language_link'][$key] = site_url($lang_slug.'sitemap/');
				
			}
		}
		// Language link

		$this->template->render('sitemap');
	}

	public function xml()
	{
		$this->template->json();
	}
}