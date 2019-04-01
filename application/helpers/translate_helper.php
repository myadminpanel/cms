<?php

if (!function_exists('translate')) {
    function translate($key = false, $common = false)
    {
        $CI =& get_instance();
        if ($key) {
            $controller = $CI->controller;

            if ($common) {
                return $CI->lang->translate('main_' . $key);
            }
            return $CI->lang->translate($controller . '_' . $key);
        }

        return 'undefined';
    }
}

if (!function_exists('trans')) {
    function trans($key = false)
    {
        if ($key) {
            $CI =& get_instance();
            return $CI->lang->translate($CI->module_name . '_' . $key);
        }
        return false;
    }
}
