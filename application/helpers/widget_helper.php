<?php

if (!function_exists('widget')) {
    function widget($key = false)
    {
        $CI =& get_instance();
        if ($key) {
            return $CI->template->view('templates/default/widget/' . $key . '.tpl', $CI->data);
        }
        return false;
    }
}
