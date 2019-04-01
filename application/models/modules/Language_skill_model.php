<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Language_skill_model extends Core_Model
{

    public $table = 'language_skill';
    public $primary_key = 'id';
    public $protected = [];
    public $table_translation = 'language_skill_translation';
    public $table_translation_key = 'language_skill_id';
    public $table_language_key = 'language_id';

    public $timestamps = true;

    public function __construct()
    {
        parent::__construct();
    }
}