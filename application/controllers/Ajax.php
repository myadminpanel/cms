<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Ajax extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Category_model');
		$this->load->model('modules/Region_model');
		$this->load->model('modules/District_model');
		$this->load->model('modules/Metro_model');
	}
	
	public function region()
	{
		
		
		$this->data['rows'][0] = [
			'id' => 0,
			'name' => translate('select_region')
		];
			
		
		if($this->input->get('country_id')) {

			$country_id = (int)$this->input->get('country_id');

			$rows = $this->Region_model->filter(['status' => 1, 'country_id' => $country_id])->with_translation()->order_by('name', 'ASC')->all();
			
			if($rows)
			{
				foreach($rows as $row)
				{
					$data = new stdClass();
					$data->id = $row->id;
					$data->name = $row->name;

					$this->data['rows'][] = $data;
				}
			}

		}
		$this->template->json($this->data['rows']);
	}

	public function district()
	{
		
		
		$this->data['rows'][0] = [
			'id' => 0,
			'name' => translate('select_district')
		];
		
		if($this->input->get('region_id'))
		{
			$region_id = (int)$this->input->get('region_id');

			$rows = $this->District_model->filter(['status' => 1, 'region_id' => $region_id])->with_translation()->order_by('name', 'ASC')->all();
			
			if($rows)
			{
				foreach($rows as $row)
				{
					$data = new stdClass();
					$data->id = $row->id;
					$data->name = $row->name;

					$this->data['rows'][] = $data;
				}
			}

		}
		$this->template->json($this->data['rows']);
	}

	public function metro()
	{
		
		$this->data['rows'][0] = [
			'id' => 0,
			'name' => translate('select_metro')
		];
		
		if($this->input->get('region_id'))
		{
			$region_id = (int)$this->input->get('region_id');

			$rows = $this->Metro_model->filter(['status' => 1, 'region_id' => $region_id])->with_translation()->order_by('name', 'ASC')->all();
			
			if($rows)
			{
				foreach($rows as $row)
				{
					$data = new stdClass();
					$data->id = $row->id;
					$data->name = $row->name;

					$this->data['rows'][] = $data;
				}
			}

		}
		$this->template->json($this->data['rows']);
	}

	public function category()
	{
		$this->data['rows'][0] = [
			'id' => 0,
			'name' => translate('select_category')
		];
		
		
		if($this->input->get('parent_id'))
		{
			$parent_id = (int)$this->input->get('parent_id');

			$rows = $this->Category_model->filter(['status' => 1, 'parent_id' => $parent_id])->with_translation()->order_by('name', 'ASC')->all();
			
			if($rows)
			{
				foreach($rows as $row)
				{
					$data = new stdClass();
					$data->id = $row->id;
					$data->name = $row->name;

					$this->data['rows'][] = $data;
				}
			}

		}
		$this->template->json($this->data['rows']);
	}
}