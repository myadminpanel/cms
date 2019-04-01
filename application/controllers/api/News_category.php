<?php defined('BASEPATH') or exit('No direct script access allowed');

class News_category extends Api_Controller {
	
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/News_category_model');
	}

	public function index()
	{
		if($this->input->method() == 'get')
		{
			if($this->input->get('parent_id') != NULL)
			{
				$parent_id = (int)$this->input->get('parent_id');
			}
			else
			{
				$parent_id = 0;
			}

			$rows = $this->News_category_model->filter(['status' => 1, 'parent_id' => $parent_id])->with_translation()->order_by('name', 'ASC')->all();

			if($rows)
			{
				foreach($rows as $row)
				{
					$news_category 			= new stdClass();
					$news_category->id 		= $row->id;
					$news_category->name 	= $row->name;

					$news_categories[] = $news_category;
				}
					
			}
			else
			{
				$news_categories = [];
			}
		}
		else{
			$news_categories = [];
		}

		$this->template->json($news_categories);
	}
}