{extends file=$layout}
{block name=content}
 <!-- ==== ==== ==== ==== Contact  start ==== ==== ==== ==== -->
	<section class="default-section map-section contact">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-6 col-md-12">
					<div class="contact-block">
						<div class="contact-block-content">
							<div class="contact-header">
								<h2>{$title}</h2>
							</div>
							<ul class="contact-ul">
								<li> <i class="fas fa-map-marker-alt"></i> <span>{get_setting('contact_address', $current_lang)}</span></li>
								<li class="phone"> <i class="fas fa-phone"></i>  <a href="tel:{get_setting('contact_phone', $current_lang)}"> {get_setting('contact_phone', $current_lang)}</a>  <a href="tel:{get_setting('contact_mobile', $current_lang)}"> {get_setting('contact_mobile', $current_lang)}</a></li>
								<li> <i class="fas fa-envelope"></i> <a href="mailto:{get_setting('email')}">{get_setting('email')}</a></li>
							</ul>
							<ul class="social-ul">
								<li class="header" > <span class="bold-header-14" > {translate('follow_us')} </span> </li>
								<li> <a href="{get_setting('facebook')}" class="fb"> <i class="fab fa-facebook-f"></i> </a> </li>
								<li> <a href="{get_setting('linkedin')}" class="tw"> <i class="fab fa-linkedin"></i> </a> </li>
								<li> <a href="{get_setting('instagram')}" class="in"> <i class="fab fa-instagram"></i> </a> </li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-md-12">
					<div class="contact-map-block">
						<div class="map-block" data-lat="{get_setting('latitude')}" data-lng="{get_setting('longitude')}" id="map">
						</div>
						<div class="contact-form {if $request eq 'post'}show{/if}" jsFocus="hide-form">
							<form action="{current_url()}" method="POST">
								
								<div class="contact-form-header"><h3>{translate('write_us')}</h3></div>
								{if isset($response) && !empty($response)}
									<div class="alert alert-success">{$response.message}</div>
								{/if}
								<div class="form-group">
									<input type="text" name="name" jsFocus="show-form" class="form-control-style" placeholder="{translate('fullname')}" />
								</div>
								<div class="form-group">
									<input type="email" name="email" class="form-control-style" placeholder="{translate('email')}" />
								</div>
									<div class="form-group">
									<input type="text" name="subject" class="form-control-style" placeholder="{translate('subject')}" />
								</div>
									<div class="form-group">
									<textarea name="message"  class="form-control-style" placeholder="{translate('message')}"></textarea>
								</div>
								<div class="form-group">
									 <input type="hidden" name="recaptcha_response" id="recaptchaResponse">
									<button type="submit" class=" waves-effect  btn-style-1 orange">{translate('submit')}</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	 <script src="https://www.google.com/recaptcha/api.js?render=6LeIhZIUAAAAAI1uGXBd-xZ6kLYmc8NYQ52rgQxj"></script>
	 {literal}
	 <script>
		grecaptcha.ready(function () {
			grecaptcha.execute('6LeIhZIUAAAAAI1uGXBd-xZ6kLYmc8NYQ52rgQxj', { action: 'contact' }).then(function (token) {
				var recaptchaResponse = document.getElementById('recaptchaResponse');
				recaptchaResponse.value = token;
			});
		});
	</script>
	 {/literal}
{/block}