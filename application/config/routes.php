<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$admin_url = 'administrator';
$api_url = 'api';

$route['default_controller']	= 'home';
$route['404_override']			= 'page/not_found';
$route['translate_uri_dashes']	= FALSE;

/* Custom Routes */

//API URL
$route[$api_url.'/news'] 												= $api_url.'/news';
$route['^(\w{2})/'.$api_url.'/news']									= $api_url.'/news';
$route[$api_url.'/news/detail/(:num)'] 									= $api_url.'/news/detail/$1';
$route['^(\w{2})/'.$api_url.'/news/detail/(:num)']						= $api_url.'/news/detail/$2';

$route[$api_url.'/discount'] 											= $api_url.'/discount';
$route['^(\w{2})/'.$api_url.'/discount']								= $api_url.'/discount';
$route[$api_url.'/discount/detail/(:num)'] 								= $api_url.'/discount/detail/$1';
$route['^(\w{2})/'.$api_url.'/discount/detail/(:num)']					= $api_url.'/discount/detail/$2';

$route[$api_url.'/service'] 											= $api_url.'/service';
$route['^(\w{2})/'.$api_url.'/service']									= $api_url.'/service';
$route[$api_url.'/service/detail/(:num)'] 								= $api_url.'/service/detail/$1';
$route['^(\w{2})/'.$api_url.'/service/detail/(:num)']					= $api_url.'/service/detail/$2';

$route[$api_url.'/gallery'] 											= $api_url.'/gallery';
$route['^(\w{2})/'.$api_url.'/gallery']									= $api_url.'/gallery';
$route[$api_url.'/gallery/detail/(:num)'] 								= $api_url.'/gallery/detail/$1';
$route['^(\w{2})/'.$api_url.'/gallery/detail/(:num)']					= $api_url.'/gallery/detail/$2';


$route[$api_url.'/video'] 												= $api_url.'/video';
$route['^(\w{2})/'.$api_url.'/video']									= $api_url.'/video';
$route[$api_url.'/video/detail/(:num)'] 								= $api_url.'/video/detail/$1';
$route['^(\w{2})/'.$api_url.'/video/detail/(:num)']						= $api_url.'/video/detail/$2';

$route[$api_url.'/product'] 											= $api_url.'/product';
$route['^(\w{2})/'.$api_url.'/product']									= $api_url.'/product';
$route[$api_url.'/product/detail/(:num)'] 								= $api_url.'/product/detail/$1';
$route['^(\w{2})/'.$api_url.'/product/detail/(:num)']					= $api_url.'/product/detail/$2';

$route[$api_url.'/company'] 											= $api_url.'/company';
$route['^(\w{2})/'.$api_url.'/company']									= $api_url.'/company';
$route[$api_url.'/company/detail/(:num)'] 								= $api_url.'/company/detail/$1';
$route['^(\w{2})/'.$api_url.'/company/detail/(:num)']					= $api_url.'/company/detail/$2';

$route[$api_url.'/category'] 											= $api_url.'/category';
$route['^(\w{2})/'.$api_url.'/category']								= $api_url.'/category';

$route[$api_url.'/news_category'] 										= $api_url.'/news_category';
$route['^(\w{2})/'.$api_url.'/news_category']							= $api_url.'/news_category';

$route[$api_url.'/information/(:any)'] 									= $api_url.'/information/$1';
$route['^(\w{2})/'.$api_url.'/information/(:any)']						= $api_url.'/information/$2';

$route[$api_url.'/page/detail/(:num)'] 									= $api_url.'/page/detail/$1';
$route['^(\w{2})/'.$api_url.'/page/detail/(:num)']						= $api_url.'/page/detail/$2';

$route[$api_url.'/user/login'] 										    = $api_url.'/user/login';
$route['^(\w{2})/'.$api_url.'/user/login']							    = $api_url.'/user/login';


$route[$api_url.'/user/profile'] 										    = $api_url.'/user/profile';
$route['^(\w{2})/'.$api_url.'/user/profile']							    = $api_url.'/user/profile';


$route[$api_url.'/user/forget_password'] 										    = $api_url.'/user/forget_password';
$route['^(\w{2})/'.$api_url.'/user/forget_password']							    = $api_url.'/user/forget_password';


$route[$api_url.'/user/change_password'] 										    = $api_url.'/user/change_password';
$route['^(\w{2})/'.$api_url.'/user/change_password']							    = $api_url.'/user/change_password';

$route[$api_url.'/user/register'] 										    = $api_url.'/user/register';
$route['^(\w{2})/'.$api_url.'/user/register']							    = $api_url.'/user/register';


$route[$api_url.'/user/notification'] 								    = $api_url.'/user/notification';
$route['^(\w{2})/'.$api_url.'/user/notification']					    = $api_url.'/user/notification';


$route[$api_url.'/user/favorite'] 								    = $api_url.'/user/favorite';
$route['^(\w{2})/'.$api_url.'/user/favorite']					    = $api_url.'/user/favorite';

$route[$api_url.'/user/favorite_add'] 								    = $api_url.'/user/favorite_add';
$route['^(\w{2})/'.$api_url.'/user/favorite_add']					    = $api_url.'/user/favorite_add';

$route[$api_url.'/user/following'] 								    = $api_url.'/user/following';
$route['^(\w{2})/'.$api_url.'/user/following']					    = $api_url.'/user/following';

$route[$api_url.'/user/following_add'] 								    = $api_url.'/user/following_add';
$route['^(\w{2})/'.$api_url.'/user/following_add']					    = $api_url.'/user/following_add';




//Dashboard
$route[$admin_url] 														= $admin_url.'/dashboard';
$route['^(\w{2})/'.$admin_url]											= $admin_url.'/dashboard';
$route[$admin_url.'/dashboard'] 										= $admin_url.'/dashboard';
$route['^(\w{2})/'.$admin_url.'/dashboard']								= $admin_url.'/dashboard';

//Setting
$route[$admin_url.'/setting'] 											= $admin_url.'/setting';
$route['^(\w{2})/'.$admin_url.'/setting']								= $admin_url.'/setting';

//Filemanager
$route[$admin_url.'/filemanager'] 										= $admin_url.'/filemanager';
$route['^(\w{2})/'.$admin_url.'/filemanager']							= $admin_url.'/filemanager';
$route[$admin_url.'/filemanager/(:any)'] 								= $admin_url.'/filemanager/$1';
$route['^(\w{2})/'.$admin_url.'/filemanager/(:any)']					= $admin_url.'/filemanager/$2';
$route[$admin_url.'/filemanager/(:any)/(:any)']							= $admin_url.'/filemanager/$1/$2';
$route['^(\w{2})/'.$admin_url.'/filemanager/(:any)/(:any)']				= $admin_url.'/filemanager/$2/$3';

//Language
$route[$admin_url.'/language'] 											= $admin_url.'/language';
$route['^(\w{2})/'.$admin_url.'/language']								= $admin_url.'/language';
$route[$admin_url.'/language/(:any)'] 									= $admin_url.'/language/$1';
$route['^(\w{2})/'.$admin_url.'/language/(:any)']						= $admin_url.'/language/$2';
$route[$admin_url.'/language/(:any)/(:num)'] 							= $admin_url.'/language/$1/$2';
$route['^(\w{2})/'.$admin_url.'/language/(:any)/(:num)']				= $admin_url.'/language/$2/$3';

//Language
$route[$admin_url.'/translation/save'] 						            = $admin_url.'/translation/save';
$route[$admin_url.'/translation/directory/(.*)'] 						= $admin_url.'/translation/directory/$1';
$route['^(\w{2})/'.$admin_url.'/translation/directory/(.*)']			= $admin_url.'/translation/directory/$2';

//Group
$route[$admin_url.'/group']												= $admin_url.'/group';
$route['^(\w{2})/'.$admin_url.'/group']									= $admin_url.'/group';

$route[$admin_url.'/group/(:any)']										= $admin_url.'/group/$1';
$route['^(\w{2})/'.$admin_url.'/group/(:any)']							= $admin_url.'/group/$2';

$route[$admin_url.'/group/(:any)/(:num)']								= $admin_url.'/group/$1/$2';
$route['^(\w{2})/'.$admin_url.'/group/(:any)/(:num)']					= $admin_url.'/group/$2/$3';

//User
$route[$admin_url.'/user'] 												= $admin_url.'/user';
$route['^(\w{2})/'.$admin_url.'/user']									= $admin_url.'/user';

$route[$admin_url.'/user/(:any)'] 										= $admin_url.'/user/$1';
$route['^(\w{2})/'.$admin_url.'/user/(:any)']							= $admin_url.'/user/$2';

$route[$admin_url.'/user/(:any)/(:num)'] 								= $admin_url.'/user/$1/$2';
$route['^(\w{2})/'.$admin_url.'/user/(:any)/(:num)']					= $admin_url.'/user/$2/$3';

//User field
$route[$admin_url.'/user_field'] 										= $admin_url.'/user_field';
$route['^(\w{2})/'.$admin_url.'/user_field']							= $admin_url.'/user_field';

$route[$admin_url.'/user_field/(:any)'] 								= $admin_url.'/user_field/$1';
$route['^(\w{2})/'.$admin_url.'/user_field/(:any)']						= $admin_url.'/user_field/$2';

$route[$admin_url.'/user_field/(:any)/(:num)'] 							= $admin_url.'/user_field/$1/$2';
$route['^(\w{2})/'.$admin_url.'/user_field/(:any)/(:num)']				= $admin_url.'/user_field/$2/$3';

//Permissions
$route[$admin_url.'/permission'] 										= $admin_url.'/permission';
$route['^(\w{2})/'.$admin_url.'/permission']							= $admin_url.'/permission';

$route[$admin_url.'/permission/(:any)']									= $admin_url.'/permission/$1';
$route['^(\w{2})/'.$admin_url.'/permission/(:any)']						= $admin_url.'/permission/$2';

$route[$admin_url.'/permission/(:any)/(:num)']							= $admin_url.'/permission/$1/$2';
$route['^(\w{2})/'.$admin_url.'/permission/(:any)/(:num)']				= $admin_url.'/permission/$2/$3';

//Setting
$route[$admin_url.'/extension'] 										= $admin_url.'/extension';
$route['^(\w{2})/'.$admin_url.'/extension']								= $admin_url.'/extension';

$route[$admin_url.'/extension/(:any)']									= $admin_url.'/extension/$1';
$route['^(\w{2})/'.$admin_url.'/extension/(:any)']						= $admin_url.'/extension/$2';

$route[$admin_url.'/extension/(:any)/(:num)']							= $admin_url.'/extension/$1/$2';
$route['^(\w{2})/'.$admin_url.'/extension/(:any)/(:num)']				= $admin_url.'/extension/$2/$3';

//Authentication
$route[$admin_url.'/authentication/(:any)']								= $admin_url.'/authentication/$1';
$route['^(\w{2})/'.$admin_url.'/authentication/(:any)']					= $admin_url.'/authentication/$2';
/* End custom Routes */

/* Modules */
$route[$admin_url.'/(:any)']											= $admin_url.'/module/index';
$route['^(\w{2})/'.$admin_url.'/(:any)']								= $admin_url.'/module/index';

$route[$admin_url.'/(:any)/(:any)']										= $admin_url.'/module/$2';
$route['^(\w{2})/'.$admin_url.'/(:any)/(:any)']							= $admin_url.'/module/$3';

$route[$admin_url.'/(:any)/(:any)/(:num)']								= $admin_url.'/module/$2/$3';
$route['^(\w{2})/'.$admin_url.'/(:any)/(:any)/(:num)']					= $admin_url.'/module/$3/$4';

/* End Modules */


$route['tag/(:any)']													= 'tag/index/$1';
$route['^(\w{2})/tag/(:any)']		    								= 'tag/index/$2';


$route['landmark/(:any)']												= 'landmark/index/$1';
$route['^(\w{2})/landmark/(:any)']		    							= 'landmark/index/$2';

$route['news']															= 'news/index';
$route['^(\w{2})/news']													= 'news/index';
$route['news/index/(:num)']												= 'news/index/$1';
$route['^(\w{2})/news/index/(:num)']									= 'news/index/$2';
$route['news/add']														= 'news/add';
$route['^(\w{2})/news/add']												= 'news/add';
$route['news/add/(:num)']												= 'news/add/$1';
$route['^(\w{2})/news/add/(:num)']										= 'news/add/$2';
$route['news/category/(:any)']											= 'news/category/$1';
$route['^(\w{2})/news/category/(:any)']									= 'news/category/$2';
$route['news/edit/(:num)']												= 'news/edit/$1';
$route['^(\w{2})/news/edit/(:num)']										= 'news/edit/$2';
$route['news/delete/(:num)']											= 'news/delete/$1';
$route['^(\w{2})/news/delete/(:num)']									= 'news/delete/$2';
$route['news/company/(:any)']											= 'news/company/$1';
$route['^(\w{2})/news/company/(:any)']									= 'news/company/$2';
$route['news/(:any)']													= 'news/view/$1';
$route['^(\w{2})/news/(:any)']											= 'news/view/$2';


$route['gallery']														= 'gallery/index';
$route['^(\w{2})/gallery']												= 'gallery/index';
$route['gallery/index/(:num)']											= 'gallery/index/$1';
$route['^(\w{2})/gallery/index/(:num)']									= 'gallery/index/$2';
$route['gallery/add']													= 'gallery/add';
$route['^(\w{2})/gallery/add']											= 'gallery/add';
$route['gallery/add/(:num)']											= 'gallery/add/$1';
$route['^(\w{2})/gallery/add/(:num)']									= 'gallery/add/$2';
$route['gallery/edit/(:num)']											= 'gallery/edit/$1';
$route['^(\w{2})/gallery/edit/(:num)']									= 'gallery/edit/$2';
$route['gallery/delete/(:num)']											= 'gallery/delete/$1';
$route['^(\w{2})/gallery/delete/(:num)']								= 'gallery/delete/$2';
$route['gallery/company/(:any)']										= 'gallery/company/$1';
$route['^(\w{2})/gallery/company/(:any)']								= 'gallery/company/$2';
$route['gallery/(:any)']												= 'gallery/view/$1';
$route['^(\w{2})/gallery/(:any)']										= 'gallery/view/$2';


$route['video']															= 'video/index';
$route['^(\w{2})/video']												= 'video/index';
$route['video/index/(:num)']											= 'video/index/$1';
$route['^(\w{2})/video/index/(:num)']									= 'video/index/$2';
$route['video/add/(:num)']												= 'video/add/$1';
$route['^(\w{2})/video/add/(:num)']										= 'video/add/$2';
$route['video/add']														= 'video/add';
$route['^(\w{2})/video/add']											= 'video/add';
$route['video/edit/(:num)']												= 'video/edit/$1';
$route['^(\w{2})/video/edit/(:num)']									= 'video/edit/$2';
$route['video/delete/(:num)']											= 'video/delete/$1';
$route['^(\w{2})/video/delete/(:num)']									= 'video/delete/$2';
$route['video/company/(:any)']											= 'video/company/$1';
$route['^(\w{2})/video/company/(:any)']									= 'video/company/$2';
$route['video/(:any)']													= 'video/view/$1';
$route['^(\w{2})/video/(:any)']											= 'video/view/$2';

$route['service']														= 'service/index';
$route['^(\w{2})/service']												= 'service/index';
$route['service/index/(:num)']											= 'service/index/$1';
$route['^(\w{2})/service/index/(:num)']									= 'service/index/$2';
$route['service/add']													= 'service/add';
$route['^(\w{2})/service/add']											= 'service/add';
$route['service/add/(:num)']											= 'service/add/$1';
$route['^(\w{2})/service/add/(:num)']									= 'service/add/$2';
$route['service/edit/(:num)']											= 'service/edit/$1';
$route['^(\w{2})/service/edit/(:num)']									= 'service/edit/$2';
$route['service/delete/(:num)']											= 'service/delete/$1';
$route['^(\w{2})/service/delete/(:num)']								= 'service/delete/$2';
$route['service/company/(:any)']										= 'service/company/$1';
$route['^(\w{2})/service/company/(:any)']								= 'service/company/$2';
$route['service/(:any)']												= 'service/view/$1';
$route['^(\w{2})/service/(:any)']										= 'service/view/$2';

$route['discount']														= 'discount/index';
$route['^(\w{2})/discount']												= 'discount/index';
$route['discount/index/(:num)']											= 'discount/index/$1';
$route['^(\w{2})/discount/index/(:num)']								= 'discount/index/$2';
$route['discount/add']													= 'discount/add';
$route['^(\w{2})/discount/add']											= 'discount/add';
$route['discount/add/(:num)']											= 'discount/add/$1';
$route['^(\w{2})/discount/add/(:num)']									= 'discount/add/$2';
$route['discount/edit/(:num)']											= 'discount/edit/$1';
$route['^(\w{2})/discount/edit/(:num)']									= 'discount/edit/$2';
$route['discount/delete/(:num)']										= 'discount/delete/$1';
$route['^(\w{2})/discount/delete/(:num)']								= 'discount/delete/$2';
$route['discount/company/(:any)']										= 'discount/company/$1';
$route['^(\w{2})/discount/company/(:any)']								= 'discount/company/$2';
$route['discount/(:any)']												= 'discount/view/$1';
$route['^(\w{2})/discount/(:any)']										= 'discount/view/$2';

$route['product']														= 'product/index';
$route['^(\w{2})/product']												= 'product/index';
$route['product/index/(:num)']											= 'product/index/$1';
$route['^(\w{2})/product/index/(:num)']								    = 'product/index/$2';
$route['product/add']													= 'product/add';
$route['^(\w{2})/product/add']											= 'product/add';
$route['product/add/(:num)']											= 'product/add/$1';
$route['^(\w{2})/product/add/(:num)']									= 'product/add/$2';
$route['product/edit/(:num)']											= 'product/edit/$1';
$route['^(\w{2})/product/edit/(:num)']									= 'product/edit/$2';
$route['product/delete/(:num)']											= 'product/delete/$1';
$route['^(\w{2})/product/delete/(:num)']								= 'product/delete/$2';
$route['product/company/(:any)']										= 'product/company/$1';
$route['^(\w{2})/product/company/(:any)']								= 'product/company/$2';
$route['product/(:any)']												= 'product/view/$1';
$route['^(\w{2})/product/(:any)']										= 'product/view/$2';

$route['category/ajax']												    = 'category/ajax';
$route['^(\w{2})/category/ajax']										= 'category/ajax';
$route['category/(:any)']												= 'category/index/$1';
$route['^(\w{2})/category/(:any)']										= 'category/index/$2';

$route['company']														= 'company/index';
$route['^(\w{2})/company']											    = 'company/index';

$route['company/index']													= 'company/index';
$route['^(\w{2})/company/index']									    = 'company/index';

$route['company/add']													= 'company/add';
$route['^(\w{2})/company/add']											= 'company/add';

$route['company/ajaxGetTags']										    = 'company/ajaxGetTags';
$route['^(\w{2})/company/ajaxGetTags']								    = 'company/ajaxGetTags';

$route['company/(:any)']												= 'company/view/$1';
$route['^(\w{2})/company/(:any)']										= 'company/view/$2';


$route['notification']													= 'notification/index';
$route['^(\w{2})/notification']											= 'notification/index';

$route['message']														= 'message/index';
$route['^(\w{2})/message']												= 'message/index';

$route['favorite']														= 'favorite/index';
$route['^(\w{2})/favorite']												= 'favorite/index';

$route['following']														= 'following/index';
$route['^(\w{2})/following']											= 'following/index';

$route['contact']														= 'contact/index';
$route['^(\w{2})/contact']												= 'contact/index';

$route['sitemap']														= 'sitemap/index';
$route['^(\w{2})/sitemap']												= 'sitemap/index';

$route['sitemap/xml']													= 'sitemap/xml';
$route['^(\w{2})/sitemap/xml']											= 'sitemap/xml';


$route['user/(:any)']													= 'user/$1';
$route['user/(:any)/(:num)']											= 'user/$1/$2';
$route['^(\w{2})/user/(:any)']											= 'user/$2';
$route['^(\w{2})/user/(:any)/(:num)']									= 'user/$2/$3';

$route['page/country_phone_code']										= 'page/country_phone_code';
$route['^(\w{2})/page/country_phone_code']								= 'page/country_phone_code';
$route['page/city_phone_code']											= 'page/city_phone_code';
$route['^(\w{2})/page/city_phone_code']									= 'page/city_phone_code';
$route['page/postal_code']												= 'page/postal_code';
$route['^(\w{2})/page/postal_code']										= 'page/postal_code';
$route['page/short_phone_code']											= 'page/short_phone_code';
$route['^(\w{2})/page/short_phone_code']								= 'page/short_phone_code';
$route['page/car_plate_code']											= 'page/car_plate_code';
$route['^(\w{2})/page/car_plate_code']									= 'page/car_plate_code';

//FAQ routing
$route['faq']															= 'page/faq';
$route['^(\w{2})/faq']													= 'page/faq';

$route['^(\w{2})/(:any)']												= 'page/index/$2';
$route['^(\w{2})$']														= $route['default_controller']; 
$route['(:any)']														= 'page/index/$1';


 
