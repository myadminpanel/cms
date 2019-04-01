<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Attachment extends Site_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->load->model('Attachment_model');
	}

	public function upload()
	{

		$directory = $this->input->get('directory');
		if (isset($directory)) {
			$directory = rtrim(DIR_IMAGE . 'catalog/' . $directory, '/');
			$upload_dir = 'catalog/'.$directory.'/';
		} else {
			$directory = DIR_IMAGE . 'catalog';
			$upload_dir = 'catalog/';
		}

		$config = [];
		$config['upload_path'] = $directory;
		$config['allowed_types'] = 'gif|jpg|png|jpeg';
		$config['overwrite']     = false;

		$this->load->library('upload');

		$this->upload->initialize($config);
		$data = $this->upload->do_upload('file');
		if (! $data) {
			$this->data['response'] = [
				'success' => false,
				'message' => $this->upload->display_errors()
			];
		}


		if (empty($json['error']))
		{

			$upload_data = $this->upload->data();

			$this->data['response'] = [
				'success' 	=> true,
				'image' 	=> $upload_dir.$upload_data['file_name'],
 				'message'	=> translate('successfully_upload', true)
			];
		}
		
		$this->template->json($this->data['response']);
	}

	public function multiupload()
	{
		$dir = $this->input->get('directory');
		if (isset($dir))
		{
			$directory = rtrim(DIR_IMAGE.'catalog/'.$dir.'/');
		}
		else
		{
			$directory = DIR_IMAGE.'catalog';
		}


		$config = [];
		$config['upload_path'] = $directory;
		$config['allowed_types'] = 'gif|jpg|png';
		$config['overwrite']     = false;

		$this->load->library('upload');

		$files = $_FILES;
		$total = count($files['file']['name']);
		unset($_FILES);

		for ($i=0; $i< $total; $i++)
		{
			$_FILES['file']['name'] 		= $files['file']['name'][$i];
			$_FILES['file']['type'] 		= $files['file']['type'][$i];
			$_FILES['file']['tmp_name'] 	= $files['file']['tmp_name'][$i];
			$_FILES['file']['error'] 		= $files['file']['error'][$i];
			$_FILES['file']['size'] 		= $files['file']['size'][$i];

			$this->upload->initialize($config);

			if (!$this->upload->do_upload('file'))
			{
				$this->data['response'] = [
					'success' => false,
					'message' => $this->upload->display_errors()
				];
			}
			else
			{
				$upload_data = $this->upload->data();
				$this->data['response'] = [
					'success' 	=> true,
					'data'		=> $upload_data,
					'image'		=> $this->Model_tool_image->resize('catalog/'.$dir.$upload_data['file_name'], 250, 250),
					'save'		=> 'catalog/'.$dir.$upload_data['file_name'],
					'message' 	=> translate('successfully_uploaded')
				];
			}
		}
		
		$this->template->json($this->data['response']);
	}

}
