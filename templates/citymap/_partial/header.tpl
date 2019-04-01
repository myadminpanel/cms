<!DOCTYPE html>
<html lang="az">
<head>
<title>{$site_title} - {$title}</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<meta property="og:title" content="{$title}" />
<meta property="og:description" content="{$meta_description}" />
<meta property="og:url" content="{current_url()}" />
<meta property="og:site_name" content="{$site_title}" />
<meta property="og:image" content="{$meta_image}" />
<meta property="og:image:width" content="250" />
<meta property="og:image:height" content="250" />
<link rel="shortcut icon" href="{base_url('templates/citymap/assets/css/icons/logo/ico.png')}">
<link rel="stylesheet" href="{base_url('templates/citymap/assets/css/plugins.min.css')}">
<link rel="stylesheet" href="{base_url('templates/citymap/assets/css/style.css')}">
<link rel="stylesheet" href="{base_url('templates/citymap/assets/css/daterangepicker.css')}">
<link rel="stylesheet" href="{base_url('templates/citymap/assets/range-slider/range-slider.css')}">
<link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css' rel='stylesheet' />

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js"></script>
<script src="{base_url('templates/citymap/assets/js/plugins.min.js')}"></script>
<script src="{base_url('templates/citymap/assets/range-slider/range-slider.js')}"></script>
<script src="{base_url('templates/citymap/assets/js/moment/moment.min.js')}"></script>
<script src="{base_url('templates/citymap/assets/js/daterangepicker.js')}"></script>
<script src='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js'></script>
<script src="{base_url('templates/citymap/assets/js/fileinput/fileinput.min.js')}"></script>
<script src="{base_url('templates/citymap/assets/js/script.js')}"></script>
{literal}
<!-- Google Tag Manager -->
<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
})(window,document,'script','dataLayer','GTM-5CW234J');</script>
<!-- End Google Tag Manager -->
{/literal}
</head>
<body class="active">
	<header jsGet="header">
		<div class="container-fluid mx-1235">
			{if $country}<div class="get-location-name"><a href="#"><i class="fas fa-map-marker-alt"> </i> {$country}</a></div>{/if}
			<div class="row">
				<div class="col-lg-2 col-md-8 col-sm-8 col-6">
					<div class="logo">
						<a href="{site_url_multi('/')}"> <img src="{base_url('templates/citymap/assets/css/icons/logo/logo.png')}" alt="citymap"/> </a>
					</div>
				</div>
				<div class="col-lg-10 col-md-4 col-sm-4 col-6 d-flex center space-between">
					<ul class="menus" >
						<li class="m-mobile-lang" >
							{if isset($language_link) && !empty(language_link)}
								<div class="lang-menu">
									<ul class="lang-menu-ul">
										{foreach from=$language_link key=language_key item=link}
											<li><a href="{$link}" class="icon-country icon-{$language_key}" ></a></li>
										{/foreach}
									</ul>
								</div>
							{/if}
						</li>
						<li class="m-mobile-place" >
							<a href="{site_url_multi('company/add')}" onclick="return addCompany()" class="waves-effect btn-style-1 green"> <i class="fas fa-map-marker-alt"></i> {translate('add_company', true)}</a>
						</li>
						<li> <a href="{site_url_multi('category')}/{$category_1_url->slug}"> {translate('institutions', true)} </a>
							<div class="main-submenu">
								<div class="container-fluid mx-1235">
									<div class="d-flex space-around">
										{if isset($category.government_agencies) && !empty($category.government_agencies)}
										<ul class="main-submenu-ul">
											{foreach from=$category.government_agencies item=category}
												<li> <a href="{site_url_multi('category')}/{$category->slug}"> {$category->name} </a> </li>
											{/foreach}
										</ul>
										{/if}
										{if get_banner('banner_navigation_govertment')}
										<div class="main-submenu-image">
											{assign var="banner_navigation_govertment" value=get_banner('banner_navigation_govertment')}
											<a target="_blank" href="{$banner_navigation_govertment->url}"> <img src="/uploads/{$banner_navigation_govertment->image}" /> </a>
										</div>
										{/if}
									</div>
								</div>
							</div>
						</li>
						<li> <a href="{site_url_multi('category')}/{$category_2_url->slug}"> {translate('companies', true)} </a>
							<div class="main-submenu">
								<div class="container-fluid mx-1235">
									<div class="d-flex space-around">
										{if isset($category.companies) && !empty($category.companies)}
										<ul class="main-submenu-ul">
											{foreach from=$category.companies item=category}
												<li> <a href="{site_url_multi('category')}/{$category->slug}"> {$category->name} </a> </li>
											{/foreach}
										</ul>
										{/if}
										{if get_banner('banner_navigation_company')}
										<div class="main-submenu-image">
											{assign var="banner_navigation_company" value=get_banner('banner_navigation_company')}
											<a target="_blank" href="{$banner_navigation_company->url}"> <img src="/uploads/{$banner_navigation_company->image}" /> </a>
										</div>
										{/if}
									</div>
								</div>
							</div>
						</li>
						<li> <a href="{site_url_multi('category')}/{$category_3_url->slug}">{translate('businessman', true)}</a>
							<div class="main-submenu">
								<div class="container-fluid mx-1235">
									<div class="d-flex space-around">
										{if isset($category.persons) && !empty($category.persons)}
										<ul class="main-submenu-ul">
											{foreach from=$category.persons item=category}
												<li> <a href="{site_url_multi('category')}/{$category->slug}"> {$category->name} </a> </li>
											{/foreach}
										</ul>
										{/if}
										{if get_banner('banner_navigation_personal')}
										<div class="main-submenu-image">
											{assign var="banner_navigation_personal" value=get_banner('banner_navigation_personal')}
											<a target="_blank" href="{$banner_navigation_personal->url}"> <img src="/uploads/{$banner_navigation_personal->image}" /> </a>
										</div>
										{/if}
									</div>
								</div>
							</div>
						</li>
						<li> <a href="{site_url_multi('news')}">{translate('press_releases', true)}</a>
							<div class="main-submenu">
								<div class="container-fluid mx-1235">
									<div class="d-flex space-around">
										{if isset($category.news) && !empty($category.news)}
										<ul class="main-submenu-ul">
											{foreach from=$category.news item=category}
												<li> <a href="{site_url_multi('news/category')}/{$category->slug}"> {$category->name} </a> </li>
											{/foreach}
										</ul>
										{/if}
										{if get_banner('banner_navigation_press_release')}
										<div class="main-submenu-image">
											{assign var="banner_navigation_press_release" value=get_banner('banner_navigation_press_release')}
											<a target="_blank" href="{$banner_navigation_press_release->url}"> <img src="/uploads/{$banner_navigation_press_release->image}" /> </a>
										</div>
										{/if}
									</div>
								</div>
							</div>
						</li>
						<li> <a href="{site_url_multi('product')}">{translate('products', true)}</a> </li>
						<li> <a href="{site_url_multi('service')}">{translate('services', true)}</a> </li>
						<li> <a href="{site_url_multi('discount')}">{translate('sales', true)}</a> </li>
					</ul>
					<div class="flex-block d-flex center">
						<div class="sign-block">
								{if is_loggedin()}
									<a class="waves-effect btn-style-1  i-blue"> <i class="fas fa-user"></i> {get_user()}</a>
									<ul class="sign-submenu">
										<li> <a href="{site_url_multi('user/profile')}"><i class="fas fa-user"></i> {translate('user_profile', true)}</a></li>
										<li> <a href="{site_url_multi('user/company')}"><i class="fas fa-building"></i> {translate('user_company', true)}</a></li>
										<li> <a href="{site_url_multi('notification')}"><i class="fas fa-bell"></i> {translate('user_notification', true)}</a></li>
										<!-- <li> <a href="{site_url_multi('message')}"><i class="fas fa-envelope"></i> {translate('user_messages', true)}</a></li> -->
										<li> <a href="{site_url_multi('favorite')}"><i class="fas fa-star"></i> {translate('user_favorite', true)}</a></li>
										<li> <a href="{site_url_multi('following')}"><i class="fas fa-eye"></i> {translate('user_following', true)}</a></li>
										<!-- <li> <a href="{site_url_multi('user/setting')}"><i class="fas fa-cog"></i> {translate('user_setting', true)}</a></li> -->
										<li> <a href="{site_url_multi('user/logout')}"><i class="fas fa-power-off"></i> {translate('user_logout', true)}</a></li>
									</ul>
								{else}
									<a class="waves-effect btn-style-1  i-blue" data-toggle="modal" data-target="#sign-form" id="btnSign"> <i class="fas fa-user"></i> {translate('login', true)}</a>
								{/if}
						</div>
						<div class="add-place">
							<a href="{site_url_multi('company/add')}" onclick="return addCompany()" class="waves-effect btn-style-1 green"> <i class="fas fa-map-marker-alt"></i> {translate('add_company', true)}</a>
						</div>
					</div>
					 <button type="button" jsClick="mob-menu-button" class="toggle-mobile-menu waves-effect btn-style-2 green active"> <i></i> <i></i> <i></i>  </button>
				</div>
			</div>
			<div class="nav-fixed">
				<div class="home-link">
					<a href="{site_url_multi('/')}" class="waves-effect"> <i class="fas fa-home"></i> </a>
				</div>
				{if isset($language_link) && !empty(language_link)}
				<div class="lang-menu">
					<ul class="lang-menu-ul">
						{foreach from=$language_link key=language_key item=link}
							<li><a href="{$link}" class="icon-country icon-{$language_key}" ></a></li>
						{/foreach}
					</ul>
				</div>
				{/if}
				<button type="button" class="page-up" ></button>
			</div>
		</div>
	</header>
	<!-- ==== ==== ==== ==== HEADER  end ==== ==== ==== ==== -->
	{if !is_loggedin()}
	<!-- SIGN MODAL start -->
	<div class="modal fade" id="sign-form">
		<div class="modal-dialog modal-dialog-big">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal"></button>
				<div class="modal-body p-l-r">
					<ul class="sign-tab-ul nav nav-tabs">
						<li> <a class="active" data-toggle="tab" href="#login"> {translate('login', true)}</a></li>
						<li> <a  data-toggle="tab" href="#register"> {translate('registration', true)}</a></li>
					</ul>
					<div class="tab-content sign-form-block">
						<div id="login" class="tab-pane  active">
							<div class="d-flex center space-between">
								<div class="sign-form-content login_form">
									<div class="login_form_response"></div>
									<div class="form-group">
										<label>{translate('email', true)}</label>
										<input type="email" id="login_email" placeholder="{translate('email_placeholder', true)}" class="form-control" />
									</div>
									<div class="form-group">
										<label>{translate('password', true)}</label>
										<input type="password" id="login_password" placeholder="{translate('password_placeholder', true)}" class="form-control" />
										<a data-toggle="modal" data-dismiss="modal" data-target="#remember-form" href="#"> {translate('forget_password', true)}</a>
									</div>
									<div class="form-group">
										<button type="submit" class="waves-effect btn-style-1 large green btn-block login_button" >{translate('login_button', true)}</button>
									</div>
								</div>
								<ul class="social-ul">
									<li class="header" > <span class="bold-header-14" > {translate('login_social', true)}</span></li>
									<li> <a href="{get_google_login_url()}" class="go"> <i class="fab fa-google-plus-g"></i> </a> </li>
									<li> <a href="{get_google_login_url()}" class="go"> <i class="fas fa-envelope"></i> </a> </li>
									<li> <a href="{get_facebook_login_url()}" class="fb"> <i class="fab fa-facebook-f"></i> </a> </li>
									<li> <a href="{get_linkedin_login_url()}" class="fb"> <i class="fab fa-linkedin"></i> </a> </li>
									{* <li> <a href="{get_twitter_login_url()}" class="fb"> <i class="fab fa-twitter"></i> </a> </li> *}
								</ul>
							</div>
						</div>
						<div id="register" class="tab-pane fade">
							<div class="sign-form-content w-100 register_form">
								<div class="register_form_response"></div>
								<div class="d-flex space-between w-100">
									<div class="form-group">
										<label>{translate('email', true)}</label>
										<input type="email" id="register_email" name="email" placeholder="{translate('email_placeholder', true)}" class="form-control" />
									</div>
									<div class="form-group">
										<label>{translate('mobile', true)}</label>
										<input type="text" id="register_mobile" name="mobile" placeholder="{translate('mobile_placeholder', true)}" class="form-control" />
									</div>
									<div class="form-group">
										<label>{translate('password', true)}</label>
										<input type="password"  id="register_password" name="password" placeholder="{translate('password_placeholder', true)}" class="form-control" />
									</div>
									<div class="form-group">
										<label>{translate('repassword', true)}</label>
										<input type="password" id="register_repassword" name="repassword" placeholder="{translate('repassword_placeholder', true)}" class="form-control" />
									</div>
								</div>
								<div class="form-group">
									<button type="submit" class="waves-effect btn-style-1 large green register_button" >{translate('registration_button', true)}</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- SIGN MODAL END -->

	<!-- Remember form start -->
	<div class="modal fade" id="remember-form">
		<div class="modal-dialog">
			<div class="modal-content">
				<button type="button" class="close" data-dismiss="modal"></button>
				<div class="modal-header"><h3>{translate('forget_password', true)}</h3></div>
				<div class="modal-body p-l-r">
					<div class="tab-content">
						<div class="sign-form-content remember forget_form">
							<div class="forget_form_response"></div>
							<div class="form-group">
								<label>{translate('email', true)}</label>
								<input type="email" name="email" id="forget_email" placeholder="{translate('email_placeholder', true)}" class="form-control" />
							</div>
							<div class="form-group">
								<button type="submit" class=" waves-effect btn-style-1 large green btn-block forget_button" >{translate('reset_password_button', true)}</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--  Remember form END -->
	<script type="text/javascript">
	var is_loggedin = "{is_loggedin()}";
	var lang = "{$current_lang}";
	{literal}
		$('.login_button').on('click', function(){
			let email = $('#login_email').val();
			let password = $('#login_password').val();
			$.ajax({
				type: 'post',
				url: '/'+lang+'/user/login',
				dataType: 'json',
				data : {email:email, password:password},
				success: function (response)
				{
					if(response['success'])
					{
						$('.login_form_response').html('<div class="alert alert-success">'+response.message+'</div>');
						window.location.href= response.redirect;
					}
					else
					{
						$('.login_form_response').html('<div class="alert alert-danger">'+response.message+'</div>');
					}
				}
			});
		});
		
		function addCompany(){
			if(is_loggedin)
			{
				return true;
			} else {
				$('#btnSign').trigger('click');
				return false;
			}
		}
	{/literal}	
	</script>
	{literal}
	<script type="text/javascript">
		$('.register_button').on('click', function(){
			let email = $('#register_email').val();
			let mobile = $('#register_mobile').val();
			let password = $('#register_password').val();
			let repassword = $('#register_repassword').val();
			$.ajax({
				type: 'post',
				url: '/'+lang+'/user/register',
				dataType: 'json',
				data : {email: email, mobile:mobile, password:password, repassword: repassword},
				success: function (response)
				{
					if(response['success'])
					{
						$('.register_form_response').html('<div class="alert alert-success">'+response.message+'</div>');
						window.location.href= response.redirect;
					}
					else
					{
						$('.register_form_response').html('<div class="alert alert-danger">'+response.message+'</div>');
					}
				}
			});
		});
	</script>
	<script type="text/javascript">
		$('.forget_button').on('click', function(){
			let element = $(this);
			let email = $('#forget_email').val();
			$.ajax({
				type: 'post',
				url: '/'+lang+'/user/forget_password',
				dataType: 'json',
				data : {email: email},
				success: function (response)
				{
					if(response['success'])
					{
						$('.forget_form_response').html('<div class="alert alert-success">'+response.message+'</div>');
					}
					else
					{
						$('.forget_form_response').html('<div class="alert alert-danger">'+response.message+'</div>');
					}
				}
			});
		});
	</script>
	{/literal}
	{/if}