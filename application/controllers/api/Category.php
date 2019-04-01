<?php defined('BASEPATH') or exit('No direct script access allowed');

class Category extends Api_Controller {
	
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Category_model');
		$this->load->model('modules/Company_model');
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

			$rows = $this->Category_model->filter(['status' => 1, 'parent_id' => $parent_id])->with_translation()->order_by('name', 'ASC')->all();

			if($rows)
			{
				foreach($rows as $row)
				{
					$sub_category = $this->Category_model->filter(['status' => 1, 'parent_id' => $row->id])->all();
					if($sub_category)
					{
						$sub = true;
					}
					else
					{
						$sub = false;
					}

					if($parent_id == 0)
					{
						$level = 1;
					}
					else
					{
						if($sub)
						{
							$level = 2;
						}
						else{
							$level = 3;
						}
					}

					$filters = [];
					$filters['status'] = 1;

					if($level == 1)
					{
						$filters['parent_category_id'] = $row->id;
					}
					elseif($level == 2)
					{
						$filters['category_id'] = $row->id;
					}
					elseif($level == 3)
					{
						$filters['sub_category_id'] = $row->id;
					}

					$company_count = $this->Company_model->filter($filters)->count_rows();

					$category 			= new stdClass();
					$category->id 		= $row->id;
					$category->name 	= $row->name;
					$category->sub 		= $sub;
					$category->level 	= $level;
					$category->count 	= $company_count;
					$category->icon 	= ($row->image) ? $this->Model_tool_image->resize($row->image, 48, 48) : false;

					$categories[] = $category;
				}
					
			}
			else
			{
				$categories = [];
			}
		}
		else{
			$categories = [];
		}

		$this->template->json($categories);
	}
}