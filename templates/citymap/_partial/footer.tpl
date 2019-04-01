	<!-- ==== ==== ==== ==== FOOTER  start ==== ==== ==== ==== -->
	<footer>
		<div class="container-fluid mx-1190">
			<div class="row">
				<div class="col-md-2 col-sm-12">
					<div class="logo">
						<a href="{site_url_multi('/')}"> <img src="{base_url('templates/citymap/assets/css/icons/logo/logo.png')}" alt="citymap"  /> </a>
					</div>
					<div class="mobile-app">
						<ul class="mobile-app-ul" >
							<li class="header"> <span class="bold-header-14"> {translate('application', true)} </span> </li>
							<li> <a href="{get_setting('playmarket')}" class="store-icon google-store">  </a> </li>
							<li> <a href="{get_setting('appstore')}"" class="store-icon apple-store">  </a> </li>
						</ul>
					</div>
				</div>
				<div class="col-md-10 col-sm-12 d-flex center space-between">
					<div class="row">
						<div class="col-md-4 col-sm-6">
							{get_menu_by_name('footer1')}
						</div>
						<div class="col-md-4 col-sm-6">
							{get_menu_by_name('footer2')}
						</div>
						<div class="col-md-4 col-sm-12  p-l-r">
							<ul class="footer-form-ul">
								<li class="header">  <span class="bold-header-14"> {translate('join_our_mail_list', true)} </span>  </li>
								<li>
									<form action="https://citymap.us20.list-manage.com/subscribe/post?u=1035191f03c37fdc1e3412f04&amp;id=111b2a44e5" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
										<div id="mc_embed_signup_scroll">
											<div id="mce-responses" class="clear">
												<div class="alert alert-warning" id="mce-error-response" style="display:none"></div>
												<div class="alert alert-success" id="mce-success-response" style="display:none"></div>
											</div>
											<div class="form-group  f-group-with-bt d-flex " jsAnimate="shake" >
												<input type="email" value="" name="EMAIL" placeholder="{translate('enter_your_email', true)}" class="form-control required email" id="mce-EMAIL">
												<button type="submit" value="Subscribe" name="subscribe" id="mc-embedded-subscribe" class="waves-effect btn-style-1 green button">{translate('subscribe_button', true)}</button>
											</div>
											<div style="position: absolute; left: -5000px;" aria-hidden="true"><input type="text" name="b_1035191f03c37fdc1e3412f04_111b2a44e5" tabindex="-1" value=""></div>
										</div>
									</form>
								</li>
								<li>
									<ul class="social-ul">
										<li class="header" > <span class="bold-header-14" > {translate('follow_us', true)} </span> </li>
										<li><a target="_blank" href="{get_setting('facebook')}" class="fb"> <i class="fab fa-facebook-f"></i> </a> </li>
										<li><a target="_blank" href="{get_setting('linkedin')}" class="tw"> <i class="fab fa-linkedin"></i> </a> </li>
										<li><a target="_blank" href="{get_setting('instagram')}" class="in"> <i class="fab fa-instagram" ></i> </a> </li>
									</ul>
								</li>
								<li class="copyright"> <span> {translate('copyright', true)} </span> </li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</footer>
<script type='text/javascript' src='//s3.amazonaws.com/downloads.mailchimp.com/js/mc-validate.js'></script>
{literal}
<script type='text/javascript'>(function($) {window.fnames = new Array(); window.ftypes = new Array();fnames[0]='EMAIL';ftypes[0]='email';}(jQuery));var $mcj = jQuery.noConflict(true);</script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-89959309-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-89959309-1');
</script>
{/literal}
<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-5CW234J"
height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->
</body>
</html>