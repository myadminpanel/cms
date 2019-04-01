<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Setting extends Administrator_Controller
{
	public $time_zones;
	public $date_format;
	public $time_format;

	public function __construct()
	{
		parent::__construct();
		$this->time_zones = $this->config->item("time_zones");
		$this->date_format = $this->config->item("date_format");
		$this->time_format = $this->config->item("time_format");
	}

	/**
	 * public function index() - Here, index function plays role as edit
	 * Gets all setting records from database and fills proper fields. Sets form fields for data update (and buttons, breadcrumb links). Also cathces submitted form, validates and performs update operation.
	 */
	public function index()
	{
		$this->data['title'] = translate('index_title');
		$this->data['subtitle'] = translate('index_description');

		$this->data['buttons'][] = [
			'type' => 'button',
			'text' => translate('form_button_save', 1),
			'class' => 'btn btn-primary btn-labeled heading-btn',
			'id' => 'save',
			'icon' => 'icon-floppy-disk',
			'additional' => [
				'onclick' => "confirm('Are you sure?') ? $('#form-save').submit() : false;",
				'form' => 'form-save',
				'formaction' => current_url()
			]
		];

		$this->data['tabs'] = [
			'general' => [
				'icon' => 'icon-menu7',
				'label' => translate('tab_general'),
				'active' => true,
				'fields' => [
					'time_zone' => [
						'property' => 'dropdown',
						'name' => 'time_zone',
						'id' => 'time_zone',
						'label' => translate('time_zone'),
						'class' => 'bootstrap-select',
						'data-style' => 'btn-default btn-xs',
						'data-width' => '100%',
						'options' => [
							"0" => translate('time_zone_select'),
							$this->time_zones
						],
						'selected' => (set_value('time_zone')) ? set_value('time_zone') : get_setting('time_zone'),
						'validation' => ['rules' => '']
					],
					'date_format' => [
						'property' => 'dropdown',
						'name' => 'date_format',
						'id' => 'date_format',
						'label' => translate('date_format'),
						'class' => 'bootstrap-select',
						'data-style' => 'btn-default btn-xs',
						'data-width' => '100%',
						'options' => [
							"0" => translate('date_format_select'),
							$this->date_format
						],
						'selected' => (set_value('date_format')) ? set_value('date_format') : get_setting('date_format'),
						'validation' => ['rules' => '']
					],
					'time_format' => [
						'property' => 'dropdown',
						'name' => 'time_format',
						'id' => 'time_format',
						'label' => translate('time_format'),
						'class' => 'bootstrap-select',
						'data-style' => 'btn-default btn-xs',
						'data-width' => '100%',
						'options' => [
							"0" => translate('time_format_select'),
							$this->time_format
						],
						'selected' => (set_value('time_format')) ? set_value('time_format') : get_setting('time_format'),
						'validation' => ['rules' => '']
					],
					'gmp_api_key' => [
						'property' => 'text',
						'name' => 'gmp_api_key',
						'class' => 'form-control',
						'value' => (set_value('gmp_api_key')) ? set_value('gmp_api_key') : get_setting('gmp_api_key'),
						'label' => translate('gmp_api_key'),
						'placeholder' => translate('gmp_api_key_placeholder'),
						'validation' => ['rules' => ''],
						'icon' => 'icon-pin'
					],
					'cpt_pub_key' => [
						'property' => 'text',
						'name' => 'cpt_pub_key',
						'class' => 'form-control',
						'value' => (set_value('cpt_pub_key')) ? set_value('cpt_pub_key') : get_setting('cpt_pub_key'),
						'label' => translate('cpt_pub_key'),
						'placeholder' => translate('cpt_pub_key_placeholder'),
						'validation' => ['rules' => ''],
						'icon' => 'icon-pin'
					],
					'cpt_sec_key' => [
						'property' => 'text',
						'name' => 'cpt_sec_key',
						'class' => 'form-control',
						'value' => (set_value('cpt_sec_key')) ? set_value('cpt_sec_key') : get_setting('cpt_sec_key'),
						'label' => translate('cpt_sec_key'),
						'placeholder' => translate('cpt_sec_key_placeholder'),
						'validation' => ['rules' => ''],
						'icon' => 'icon-pin'
					],
					'gl_analytic_code' => [
						'property' => 'textarea',
						'name' => 'gl_analytic_code',
						'class' => 'form-control',
						'value' => (set_value('gl_analytic_code')) ? set_value('gl_analytic_code') : get_setting('gl_analytic_code'),
						'label' => translate('gl_analytic_code'),
						'placeholder' => translate('gl_analytic_code_placeholder'),
						'validation' => ['rules' => ''],
						'icon' => 'icon-pin',
						'xss_filtering' => false
					],
					'custom_js' => [
						'property' => 'textarea',
						'name' => 'custom_js',
						'class' => 'form-control',
						'value' => (set_value('custom_js')) ? set_value('custom_js') : get_setting('custom_js'),
						'label' => translate('custom_js'),
						'placeholder' => translate('custom_js_placeholder'),
						'validation' => ['rules' => ''],
						'icon' => 'icon-pin',
						'xss_filtering' => false
					],
					'site_title' => [
						'property' => 'text',
						'name' => 'site_title',
						'class' => 'form-control',
						'value' => (set_value('site_title')) ? set_value('site_title') : get_setting('site_title'),
						'label' => translate('site_title'),
						'placeholder' => translate('site_title_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					],
					'site_description' => [
						'property' => 'text',
						'name' => 'site_description',
						'class' => 'form-control',
						'value' => (set_value('site_description')) ? set_value('site_description') : get_setting('site_description'),
						'label' => translate('site_description'),
						'placeholder' => translate('site_description_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					],
					'meta_title' => [
						'property' => 'text',
						'name' => 'meta_title',
						'class' => 'form-control',
						'value' => (set_value('meta_title')) ? set_value('meta_title') : get_setting('meta_title'),
						'label' => translate('meta_title'),
						'placeholder' => translate('meta_title_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					],
					'meta_description' => [
						'property' => 'text',
						'name' => 'meta_description',
						'class' => 'form-control',
						'value' => (set_value('meta_description')) ? set_value('meta_description') : get_setting('meta_description'),
						'label' => translate('meta_description'),
						'placeholder' => translate('meta_description_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					],
					'meta_keywords' => [
						'property' => 'text',
						'name' => 'meta_keywords',
						'class' => 'form-control',
						'value' => (set_value('meta_keywords')) ? set_value('meta_keywords') : get_setting('meta_keywords'),
						'label' => translate('meta_keywords'),
						'placeholder' => translate('meta_keywords_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					],
				]
			],
			'comment' => [
				'icon' => 'icon-comment-discussion',
				'label' => translate('tab_comment'),
				'fields' => [
					'comment_enable' => [
						'property' => 'dropdown',
						'name' => 'comment_enable',
						'id' => 'comment_enable',
						'label' => translate('comment_enable'),
						'class' => 'bootstrap-select',
						'data-style' => 'btn-default btn-xs',
						'data-width' => '100%',
						'options' => [
							"0" => translate('enable', true),
							"1" => translate('disable', true)
						],
						'selected' => (set_value('comment_enable')) ? set_value('comment_enable') : get_setting('comment_enable'),
						'validation' => ['rules' => '']
					]
				]
			],
			'filemanager' => [
				'icon' => 'icon-box',
				'label' => translate('tab_filemanager'),
				'fields' => [
					'permitted_file' => [
						'property' => 'text',
						'name' => 'permitted_file',
						'class' => 'form-control',
						'value' => (set_value('permitted_file')) ? set_value('permitted_file') : get_setting('permitted_file'),
						'label' => translate('filemanager_permitted_file'),                        
						'placeholder' => translate('filemanager_permitted_file_placeholder'),
						'validation' => ['rules' => '']
					]
				]
			],
			'logo' => [
				'icon' => 'icon-images2',
				'label' => translate('tab_logo'),
				'fields' => [
					'admin_logo' => [
						'property' => 'upload',
						'name' => 'file[]',
						'class' => 'file-input-ajax',
						'multiple' => "multiple",
						'value' => (set_value('admin_logo')) ? set_value('admin_logo') : get_setting('admin_logo'),
						'label' => translate('logo_admin_logo'),
						'placeholder' => translate('logo_admin_logo_placeholder'),
						'validation' => ['rules' => '']
					]
				]
			],
			'social' => [
				'icon' => 'icon-facebook2',
				'label' => translate('tab_social'),
				'fields' => [
					'playmarket' => [
						'property' => 'text',
						'name' => 'playmarket',
						'icon' => 'icon-android',
						'class' => 'form-control',
						'value' => (set_value('playmarket')) ? set_value('playmarket') : get_setting('playmarket'),
						'label' => translate('playmarket'),
						'placeholder' => translate('playmarket_placeholder'),
						'validation' => ['rules' => '']
					],
					'appstore' => [
						'property' => 'text',
						'name' => 'appstore',
						'icon' => 'icon-apple2',
						'class' => 'form-control',
						'value' => (set_value('appstore')) ? set_value('appstore') : get_setting('appstore'),
						'label' => translate('appstore'),
						'placeholder' => translate('appstore_placeholder'),
						'validation' => ['rules' => '']
					],
					'facebook' => [
						'property' => 'text',
						'name' => 'facebook',
						'icon' => 'icon-facebook',
						'class' => 'form-control',
						'value' => (set_value('facebook')) ? set_value('facebook') : get_setting('facebook'),
						'label' => translate('facebook'),
						'placeholder' => translate('facebook_placeholder'),
						'validation' => ['rules' => '']
					],
					'twitter' => [
						'property' => 'text',
						'name' => 'twitter',
						'icon' => 'icon-twitter',
						'class' => 'form-control',
						'value' => (set_value('twitter')) ? set_value('twitter') : get_setting('twitter'),
						'label' => translate('twitter'),
						'placeholder' => translate('twitter_placeholder'),
						'validation' => ['rules' => '']
					],
					'instagram' => [
						'property' => 'text',
						'name' => 'instagram',
						'icon' => 'icon-instagram',
						'class' => 'form-control',
						'value' => (set_value('instagram')) ? set_value('instagram') : get_setting('instagram'),
						'label' => translate('instagram'),
						'placeholder' => translate('instagram_placeholder'),
						'validation' => ['rules' => '']
					],
					'linkedin' => [
						'property' => 'text',
						'name' => 'linkedin',
						'icon' => 'icon-linkedin',
						'class' => 'form-control',
						'value' => (set_value('linkedin')) ? set_value('linkedin') : get_setting('linkedin'),
						'label' => translate('linkedin'),
						'placeholder' => translate('linkedin_placeholder'),
						'validation' => ['rules' => '']
					],
					'googleplus' => [
						'property' => 'text',
						'name' => 'googleplus',
						'icon' => 'icon-google-plus',
						'class' => 'form-control',
						'value' => (set_value('googleplus')) ? set_value('googleplus') : get_setting('googleplus'),
						'label' => translate('googleplus'),
						'placeholder' => translate('googleplus_placeholder'),
						'validation' => ['rules' => '']
					],
					'youtube' => [
						'property' => 'text',
						'name' => 'youtube',
						'icon' => 'icon-youtube',
						'class' => 'form-control',
						'value' => (set_value('youtube')) ? set_value('youtube') : get_setting('youtube'),
						'label' => translate('youtube'),
						'placeholder' => translate('youtube_placeholder'),
						'validation' => ['rules' => '']
					],
					'github' => [
						'property' => 'text',
						'name' => 'github',
						'icon' => 'icon-github',
						'class' => 'form-control',
						'value' => (set_value('github')) ? set_value('github') : get_setting('github'),
						'label' => translate('github'),
						'placeholder' => translate('github_placeholder'),
						'validation' => ['rules' => '']
					],
					'vimeo' => [
						'property' => 'text',
						'name' => 'vimeo',
						'icon' => 'icon-vimeo',
						'class' => 'form-control',
						'value' => (set_value('vimeo')) ? set_value('vimeo') : get_setting('vimeo'),
						'label' => translate('vimeo'),
						'placeholder' => translate('vimeo_placeholder'),
						'validation' => ['rules' => '']
					],
					'flickr' => [
						'property' => 'text',
						'name' => 'flickr',
						'icon' => 'icon-flickr',
						'class' => 'form-control',
						'value' => (set_value('flickr')) ? set_value('flickr') : get_setting('flickr'),
						'label' => translate('flickr'),
						'placeholder' => translate('flickr_placeholder'),
						'validation' => ['rules' => '']
					],
					'rss' => [
						'property' => 'text',
						'name' => 'rss',
						'icon' => 'icon-feed2',
						'class' => 'form-control',
						'value' => (set_value('rss')) ? set_value('rss') : get_setting('rss'),
						'label' => translate('rss'),
						'placeholder' => translate('rss_placeholder'),
						'validation' => ['rules' => '']
					],
					'wordpress' => [
						'property' => 'text',
						'name' => 'wordpress',
						'icon' => 'icon-wordpress',
						'class' => 'form-control',
						'value' => (set_value('wordpress')) ? set_value('wordpress') : get_setting('wordpress'),
						'label' => translate('wordpress'),
						'placeholder' => translate('wordpress_placeholder'),
						'validation' => ['rules' => '']
					],
					'dribbble' => [
						'property' => 'text',
						'name' => 'dribbble',
						'icon' => 'icon-dribbble',
						'class' => 'form-control',
						'value' => (set_value('dribbble')) ? set_value('dribbble') : get_setting('dribbble'),
						'label' => translate('dribbble'),
						'placeholder' => translate('dribbble_placeholder'),
						'validation' => ['rules' => '']
					],
					'blogger' => [
						'property' => 'text',
						'name' => 'blogger',
						'icon' => 'icon-blogger',
						'class' => 'form-control',
						'value' => (set_value('blogger')) ? set_value('blogger') : get_setting('blogger'),
						'label' => translate('blogger'),
						'placeholder' => translate('blogger_placeholder'),
						'validation' => ['rules' => '']
					],
					'tumblr' => [
						'property' => 'text',
						'name' => 'tumblr',
						'icon' => 'icon-tumblr',
						'class' => 'form-control',
						'value' => (set_value('tumblr')) ? set_value('tumblr') : get_setting('tumblr'),
						'label' => translate('tumblr'),
						'placeholder' => translate('tumblr_placeholder'),
						'validation' => ['rules' => '']
					],
					'skype' => [
						'property' => 'text',
						'name' => 'skype',
						'icon' => 'icon-skype',
						'class' => 'form-control',
						'value' => (set_value('skype')) ? set_value('skype') : get_setting('skype'),
						'label' => translate('skype'),
						'placeholder' => translate('skype_placeholder'),
						'validation' => ['rules' => '']
					]
				]
			],
			'contact' => [
				'icon' => 'icon-phone',
				'label' => translate('tab_contact'),
				'fields' => [
					'contact_email' => [
						'property' => 'text',
						'name' => 'email',
						'class' => 'form-control',
						'value' => (set_value('email')) ? set_value('email') : get_setting('email'),
						'label' => translate('contact_email'),
						'placeholder' => translate('contact_email_placeholder'),
						'validation' => ['rules' => ''],
						'icon' => 'icon-envelop'
					],
					'contact_latitude' => [
						'property' => 'text',
						'name' => 'latitude',
						'class' => 'form-control',
						'value' => (set_value('latitude')) ? set_value('latitude') : get_setting('latitude'),
						'label' => translate('contact_latitude'),
						'placeholder' => translate('contact_latitude_placeholder'),
						'validation' => ['rules' => ''],
						'icon' => 'icon-pin'
					],
					'contact_longitude' => [
						'property' => 'text',
						'name' => 'longitude',
						'class' => 'form-control',
						'value' => (set_value('longitude')) ? set_value('longitude') : get_setting('longitude'),
						'label' => translate('contact_longitude'),
						'placeholder' => translate('contact_longitude_placeholder'),
						'validation' => ['rules' => ''],
						'icon' => 'icon-pin'
					],
					'contact_address' => [
						'property' => 'text',
						'name' => 'contact_address',
						'class' => 'form-control',
						'value' => (set_value('contact_address')) ? set_value('contact_address') : get_setting('contact_address'),
						'label' => translate('contact_address'),
						'placeholder' => translate('contact_address_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					],
					'contact_region' => [
						'property' => 'text',
						'name' => 'contact_region',
						'class' => 'form-control',
						'value' => (set_value('contact_region')) ? set_value('contact_region') : get_setting('contact_region'),
						'label' => translate('contact_region'),
						'placeholder' => translate('contact_region_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					],
					'contact_place' => [
						'property' => 'text',
						'name' => 'contact_place',
						'class' => 'form-control',
						'value' => (set_value('contact_place')) ? set_value('contact_place') : get_setting('contact_place'),
						'label' => translate('contact_place'),
						'placeholder' => translate('contact_place_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					],
					'contact_postal' => [
						'property' => 'text',
						'name' => 'contact_postal',
						'class' => 'form-control',
						'value' => (set_value('contact_postal')) ? set_value('contact_postal') : get_setting('contact_postal'),
						'label' => translate('contact_postal'),
						'placeholder' => translate('contact_postal_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					],
					'contact_phone' => [
						'property' => 'text',
						'name' => 'contact_phone',
						'class' => 'form-control',
						'value' => (set_value('contact_phone')) ? set_value('contact_phone') : get_setting('contact_phone'),
						'label' => translate('contact_phone'),
						'placeholder' => translate('contact_phone_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					],
					'contact_mobile' => [
						'property' => 'text',
						'name' => 'contact_mobile',
						'class' => 'form-control',
						'value' => (set_value('contact_mobile')) ? set_value('contact_mobile') : get_setting('contact_mobile'),
						'label' => translate('contact_mobile'),
						'placeholder' => translate('contact_mobile_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					],
					'contact_fax' => [
						'property' => 'text',
						'name' => 'contact_fax',
						'class' => 'form-control',
						'value' => (set_value('contact_fax')) ? set_value('contact_fax') : get_setting('contact_fax'),
						'label' => translate('contact_fax'),
						'placeholder' => translate('contact_fax_placeholder'),
						'validation' => ['rules' => ''],
						'translate' => true
					]
				]
			],
			'mail' => [
				'icon' => 'icon-envelop',
				'label' => translate('tab_mail'),
				'fields' => [
					'mail_server' => [
						'property' => 'dropdown',
						'name' => 'mail_server',
						'id' => 'mail_server',
						'label' => translate('mail_server'),
						'class' => 'bootstrap-select',
						'data-style' => 'btn-default btn-xs',
						'data-width' => '100%',
						'options' => [
							'phpmailer' => translate('mail_server_phpmailer'),
							'smtp' => translate('mail_server_smtp')
						],
						'selected' => (set_value('mail_server')) ? set_value('mail_server') : get_setting('mail_server'),
						'validation' => ['rules' => '']
					],
					'mail_hostname' => [
						'property' => 'text',
						'name' => 'mail_hostname',
						'class' => 'form-control',
						'value' => (set_value('mail_hostname')) ? set_value('mail_hostname') : get_setting('mail_hostname'),
						'label' => translate('mail_hostname'),
						'placeholder' => translate('mail_hostname_placeholder'),
						'validation' => ['rules' => '']
					],
					'mail_username' => [
						'property' => 'text',
						'name' => 'mail_username',
						'class' => 'form-control',
						'value' => (set_value('mail_username')) ? set_value('mail_username') : get_setting('mail_username'),
						'label' => translate('mail_username'),
						'placeholder' => translate('mail_username_placeholder'),
						'validation' => ['rules' => '']
					],
					'mail_password' => [
						'property' => 'text',
						'name' => 'mail_password',
						'class' => 'form-control',
						'value' => (set_value('mail_password')) ? set_value('mail_password') : get_setting('mail_password'),
						'label' => translate('mail_password'),
						'placeholder' => translate('mail_password_placeholder'),
						'validation' => ['rules' => '']
					],
					'mail_port' => [
						'property' => 'text',
						'name' => 'mail_port',
						'class' => 'form-control',
						'value' => (set_value('mail_port')) ? set_value('mail_port') : get_setting('mail_port'),
						'label' => translate('mail_port'),
						'placeholder' => translate('mail_port_placeholder'),
						'validation' => ['rules' => '']
					],
					'mail_timeout' => [
						'property' => 'text',
						'name' => 'mail_timeout',
						'class' => 'form-control',
						'value' => (set_value('mail_timeout')) ? set_value('mail_timeout') : get_setting('mail_timeout'),
						'label' => translate('mail_timeout'),
						'placeholder' => translate('mail_timeout_placeholder'),
						'validation' => ['rules' => '']
					]
				]
			]
		];


		if ($this->input->method() == 'post') {
			$setting_data = [];
			foreach ($this->data['tabs'] as $key => $value) {
				foreach ($value['fields'] as $field_key => $field) {
					if (isset($field['xss_filtering'])) {
						if (is_array($this->input->post($field['name']))) {
							$setting_data[$field['name']] = json_encode($this->input->post($field['name'], false));
						} else {
							$setting_data[$field['name']] = $this->input->post($field['name'], false);
						}
					} else {
						if (is_array($this->input->post($field['name']))) {
							$setting_data[$field['name']] = json_encode($this->input->post($field['name'], true));
						} else {
							$setting_data[$field['name']] = $this->input->post($field['name'], true);
						}
					}
				}
			}

			$this->{$this->model}->update_setting($setting_data);
			redirect(site_url_multi($this->directory . $this->controller));
		}

		$this->template->render();
	}
}
