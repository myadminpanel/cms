<?php

if (!function_exists('form_status')) {
    function form_status($name)
    {
        $options[0] = translate('deactive');
        $options[1] = translate('deactive');
        return form_dropdown($name, $options, 'default');
    }
}

if (!function_exists('form_slug')) {
    function form_slug($data = '', $value = '', $extra = '')
    {
        is_array($data) OR $data = array('name' => $data);
        $data['type'] = 'text';
        $data['readonly'] = 'readonly';
		$data['autocomplete'] = 'slug';
		return form_input($data, $value, $extra);
    }
}