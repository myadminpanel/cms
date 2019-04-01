<?php defined('BASEPATH') or exit('No direct script access allowed');

class Information extends Api_Controller {
	
	public function __construct()
	{
		parent::__construct();
		$this->load->model('modules/Country_model');
		$this->load->model('modules/Region_model');
		$this->load->model('modules/District_model');
		$this->load->model('modules/Metro_model');
		
		$this->load->model('modules/Country_phone_code_model');
		$this->load->model('modules/City_phone_code_model');
		$this->load->model('modules/Postal_code_model');
		$this->load->model('modules/Short_phone_code_model');
		$this->load->model('modules/Car_plate_code_model');
		$this->load->model('modules/Faq_model');
	}

	public function country()
	{
		$rows = $this->Country_model->filter(['status' => 1])->with_translation()->all();

		$result = [];
		if($rows)
		{
			foreach($rows as $row)
			{
				$data = new stdClass();
				$data->id = $row->id;
				$data->name = $row->name;

				$result[] = $data;
			}
		}
		$this->template->json($result);
	}

	public function region()
	{
		if($this->input->get('country_id') != NULL)
		{
			$country_id = (int)$this->input->get('country_id');

			$rows = $this->Region_model->filter(['status' => 1, 'country_id' => $country_id])->with_translation()->all();

			$result = [];
			if($rows)
			{
				foreach($rows as $row)
				{
					$data = new stdClass();
					$data->id = $row->id;
					$data->name = $row->name;

					$result[] = $data;
				}
			}
			$this->template->json($result);
		}
		
	}

	public function district()
	{
		if($this->input->get('region_id') != NULL)
		{
			$region_id = (int)$this->input->get('region_id');

			$rows = $this->District_model->filter(['status' => 1, 'region_id' => $region_id])->with_translation()->all();

			$result = [];
			if($rows)
			{
				foreach($rows as $row)
				{
					$data = new stdClass();
					$data->id = $row->id;
					$data->name = $row->name;

					$result[] = $data;
				}
			}
			$this->template->json($result);
		}
		
	}

	public function metro()
	{
		if($this->input->get('region_id') != NULL)
		{
			$region_id = (int)$this->input->get('region_id');

			$rows = $this->Metro_model->filter(['status' => 1, 'region_id' => $region_id])->with_translation()->all();

			$result = [];
			if($rows)
			{
				foreach($rows as $row)
				{
					$data = new stdClass();
					$data->id = $row->id;
					$data->name = $row->name;

					$result[] = $data;
				}
			}
			$this->template->json($result);
		}
		
	}

	public function country_phone_code()
	{
		$rows = $this->Country_phone_code_model->filter(['status' => 1])->with_translation()->all();

		$result = [];
		if($rows)
		{
			foreach($rows as $row)
			{
				$data = new stdClass();
				$data->id = $row->id;
				$data->name = $row->name;
				$data->code = $row->code;

				$result[] = $data;
			}
		}
		$this->template->json($result);
	}

	public function city_phone_code()
	{
		$rows = $this->City_phone_code_model->filter(['status' => 1])->with_translation()->all();

		$result = [];
		if($rows)
		{
			foreach($rows as $row)
			{
				$data = new stdClass();
				$data->id = $row->id;
				$data->name = $row->name;
				$data->code = $row->code;

				$result[] = $data;
			}
		}
		$this->template->json($result);
	}

	public function postal_code()
	{
		$rows = $this->Postal_code_model->filter(['status' => 1])->with_translation()->all();

		$result = [];
		if($rows)
		{
			foreach($rows as $row)
			{
				$data = new stdClass();
				$data->id = $row->id;
				$data->name = $row->name;
				$data->code = $row->code;

				$result[] = $data;
			}
		}
		$this->template->json($result);
	}

	public function short_phone_code()
	{
		$rows = $this->Short_phone_code_model->filter(['status' => 1])->with_translation()->all();

		$result = [];
		if($rows)
		{
			foreach($rows as $row)
			{
				$data = new stdClass();
				$data->id = $row->id;
				$data->name = $row->name;
				$data->code = $row->code;

				$result[] = $data;
			}
		}
		$this->template->json($result);
	}

	public function car_plate_code()
	{
		
		$rows = $this->Car_plate_code_model->filter(['status' => 1])->with_translation()->all();

		$result = [];
		if($rows)
		{
			foreach($rows as $row)
			{
				$data = new stdClass();
				$data->id = $row->id;
				$data->name = $row->name;
				$data->code = $row->code;

				$result[] = $data;
			}
		}
		$this->template->json($result);
	}

	public function faq()
	{
		
		$rows = $this->Faq_model->filter(['status' => 1])->with_translation()->all();

		$result = [];
		if($rows)
		{
			foreach($rows as $row)
			{
				$data = new stdClass();
				$data->id = $row->id;
				$data->name = $row->name;
				$data->description = strip_tags($row->description);

				$result[] = $data;
			}
		}
		$this->template->json($result);
	}
}