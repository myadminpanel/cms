<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once(APPPATH . 'third_party/phpqrcode/qrlib.php');

class Qr_code
{
	public function generate($data = false, $errorCorrectionLevel = 'L', $matrixPointSize = 4)
	{
		if($data)
		{
			$filename =  dirname(__FILE__).'/../../uploads/catalog/qrcode/'.md5($data.'|'.$errorCorrectionLevel.'|'.$matrixPointSize).'.png';
			QRcode::png($data, $filename, $errorCorrectionLevel, $matrixPointSize, 2);
			return base_url('uploads/catalog/qrcode/'.basename($filename));
		}
		return false;
	}
}
