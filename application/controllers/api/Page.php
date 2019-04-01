<?php defined('BASEPATH') or exit('No direct script access allowed');

class Page extends Api_Controller {
	
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Page_model');
	}

	public function detail($id = false)
	{
		if($id)
		{
			$row = $this->Page_model->filter(['status' => 1, 'id' => $id])->with_translation()->one();
			if($row)
			{
				$page					= new stdClass();
				$page->id				= $row->id;
				$page->name				= $row->name;
				$page->description		= strip_tags($row->description);
			}
			else
			{
				$page = false;
			}
		}
		else
		{
			$page = false;
		}

		$this->template->json($page);
	}
}