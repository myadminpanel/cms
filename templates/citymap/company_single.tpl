{extends file=$layout}
{block name=content}
	 <!-- The Modal   -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-body">
					<button type="button" class="close" data-video-frame="close" data-dismiss="modal"></button>
					<iframe  id="videoFrame" width="100%" height="315" src="https://www.youtube.com/embed"> </iframe>
				</div>
			</div>
		</div>
	</div>
	<!-- ==== ==== ==== ==== Company Profile  start ==== ==== ==== ==== -->
	<section class="default-section full-company">
		<div class="container">
			<div class="section-header">
				<div class="row">
					<div class="section-header">
						<h3 class="medium-title">{$title} {if $online}<sup class="header-icon">{translate('now_enable')}</sup>{else}<sup class="header-icon-off">{translate('now_disable')}</sup>{/if}</h3>
						
					</div>
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 company-profile-block">
					<div class="c-profile-slider">
						<div class="c-profile-active-slide {if $personal}border-radius-50{/if}" >
							<a href="{$image_full}"  data-fancybox="group1">  <img class="{if $personal}border-radius-50{/if}" src="{$image}" alt="{$title}" />  </a>
						</div>
						
						{if isset($images) && !empty($images)}
						<ul class="c-profile-slider-ul owl-carousel" >
							{foreach from=$images item=image}
								<li><a href="{$image->url}"  data-fancybox="group1"><img src="{$image->thumb}" /></a></li>
							{/foreach}
						</ul>
						{/if}
					</div>
					<div class="c-profile-info">
						<ul class="c-profile-controls">
							<li><button type="button" data-toggle="tooltip" data-placement="top" title="{translate('favorite_description')}" class="waves-effect c-profile-fav" id="btnFavorite"><i class="fas fa-heart"></i> {if $is_favorite} {translate('unfavorite')} {else} {translate('favorite')} {/if}</button></li>
							<li><button type="button" data-toggle="tooltip" data-placement="top" title="{translate('following_description')}" class="waves-effect c-profile-track" id="btnFollow"><i class="far fa-eye"></i> {if $is_follow} {translate('unfollow')} {else} {translate('follow')} {/if} {if $follower > 0}<b>{$follower}</b>{/if}</button></li>
							<li><span> <b>{$view}</b> {translate('viewed')}</span></li>
							<li class="qr-code"><a href="{$qrcode_full}"  data-fancybox="group2" ><img src="{$qrcode}"></a></li>

							<li class="social_share"><a target="_blank" class="fb" href="https://www.facebook.com/sharer/sharer.php?u={urlencode(current_url())}"><i class="fab fa-facebook-f"></i></a></li>
							<li class="social_share"><a target="_blank" class="tw" href="http://www.twitter.com/intent/tweet?url={urlencode(current_url())}"><i class="fab fa-twitter"></i></a></li>
							<li class="social_share"><a target="_blank" class="in" href="https://www.linkedin.com/shareArticle?mini=true&url={urlencode(current_url())}&title={$title}&summary={get_description($description)}&source=LinkedIn"><i class="fab fa-linkedin-in"></i></a></li>
							<li class="social_share"><a target="_blank" class="ok" href="https://connect.ok.ru/offer?url={urlencode(current_url())}&title={urlencode($title)}&description={urlencode(get_description($description))}"><i class="fab fa-odnoklassniki"></i></a></li>
							<li class="social_share"><a target="_blank" class="vk" href="http://vk.com/share.php?url={urlencode(current_url())}"><i class="fab fa-vk"></i></a></li>
							<li class="social_share"><a target="_blank" class="wp" href="https://api.whatsapp.com/send?text={urlencode(current_url())}" data-action="share/whatsapp/share"><i class="fab fa-whatsapp"></i></a></li>
						</ul>
						{if $review_star}
							<div class="c-profile-info-rating"><span class="rating-block">{$review_star}</span></div>
						{/if}
						<ul class="c-profile-info-ul">
							{if $phone}
							<li> <i class="fas fa-phone"></i>
								<div class="c-concept">
									<span>{translate('phone')}</span> <a href="tel:{$phone}">{$phone}</a> 
								</div>
							</li>
							{/if}
							{if $fax}
							<li> <i class="fas fa-fax"></i>
								<div class="c-concept">
									<span>{translate('fax')}</span> <a href="tel:{$fax}">{$fax}</a>
								</div>
							</li>
							{/if}
							{if $mobile}
							<li> <i class="fas fa-mobile"></i>
								<div class="c-concept">
									<span>{translate('mobile')}</span> <a href="tel:{$mobile}">{$mobile}</a>
								</div>
							</li>
							{/if}
							{if $website}
							<li> <i class="fas fa-globe-americas"></i>
								<div class="c-concept">
									<span>{translate('website')}</span> <a href="{$website}" target="_blank">{$website}</a>
								</div>
							</li>
							{/if}
							{if $email}
							<li><i class="fas fa-envelope"></i>
								<div class="c-concept">
									<span>{translate('email')}</span> <a href="mailto:{$email}">{$email} </a>
								</div>
							</li>
							{/if}
							{if $facebook || $instagram || $twitter || $linkedin || $vk || $ok}
							<li><i class="fas fa-share"></i>
								<div class="c-concept for-share-company">
									<span>{translate('social')}</span>
									{if $facebook}<a target="_blank" href="{$facebook}" class="fb"><i class="fab fa-facebook-f"></i> </a>{/if}
									{if $instagram}<a target="_blank" href="{$instagram}" class="ins"><i class="fab fa-instagram"></i></a>{/if}
									{if $twitter}<a target="_blank" href="{$twitter}" class="tw"><i class="fab fa-twitter"></i></a>{/if}
									{if $linkedin}<a target="_blank" href="{$linkedin}" class="in"><i class="fab fa-linkedin-in"></i></a>{/if}
									{if $vk}<a target="_blank" href="{$vk}" class="vk"><i class="fab fa-vk"></i></a>{/if}
									{if $ok}<a target="_blank" href="{$ok}" class="ok"><i class="fab fa-odnoklassniki"></i></a>{/if}
								</div>
							</li>
							{/if}
							{if $country_name}
							<li> <i class="fas fa-map-marker-alt"></i>
								<div class="c-concept">
									<span>{translate('country')}</span> <address><img src="{$country_code}"> {$country_name} </address>
								</div>
							</li>
							{/if}
							{if $region}
							<li> <i class="fas fa-map-marker-alt"></i>
								<div class="c-concept">
									<span>{translate('region')}</span> <address>{$region} </address>
								</div>
							</li>
							{/if}
							{if $district}
							<li> <i class="fas fa-map-marker-alt"></i>
								<div class="c-concept">
									<span>{translate('district')}</span> <address>{$district} </address>
								</div>
							</li>
							{/if}
							{if $metro}
							<li> <i class="fas fa-subway"></i>
								<div class="c-concept">
									<span>{translate('metro')}</span> <address>{$metro} </address>
								</div>
							</li>
							{/if}
							{if $address}
							<li> <i class="fas fa-map-marker-alt"></i>
								<div class="c-concept">
									<span>{translate('address')}</span> <address>{$address} </address>
								</div>
							</li>
							{/if}

							{if $landmarks}
							<li> <i class="fas fa-map-marked-alt"></i>
								<div class="c-concept">
									<span>{translate('landmark')}</span>
									{foreach from=$landmarks item=landmark}
										<a href="{$landmark.link}">#{$landmark.name}</a>
									{/foreach}
								</div>
							</li>
							{/if}

							{if $language_skills}
							<li> <i class="fas fa-globe"></i>
								<div class="c-concept">
									<span>{translate('language_skills')}</span>
									{$language_skills}
								</div>
							</li>
							{/if}

							{if $working_time}
							<li><i class="far fa-file-alt"></i>
								<div class="c-concept">
									<span>{translate('working_time')}</span> 
									<div class="c-profile-content">
										{$working_time}
									</div>
								</div>
							</li>
							{/if}
							{if $experience}
							<li><i class="far fa-file-alt"></i>
								<div class="c-concept">
									<span>{translate('experience')}</span> 
									<div class="c-profile-content">
										{$experience} {translate('year')}
									</div>
								</div>
							</li>
							{/if}
							{if $description}
								<li class="content"> <i class="far fa-file-alt"></i>
									<div class="c-concept">
										<span>{translate('description')}</span> 
										<div class="c-profile-content">
											{$description}
										</div>
									</div>
								</li>
							{/if}
						</ul>
					</div>
				</div>
			</div>
			{if $tags}
				<div class="row tag-row">
					<ul class="tags">
						{foreach from=$tags item=tag}
							<li><a href="{$tag.link}">#{$tag.name}</a></li>
						{/foreach}
					</ul>
				</div>
			{/if}
			<div class="row">
				<div class="col-lg-4 col-md-12">
					{if $latitude || $longitude}
					<div class="row flex-column">
						<h3 class="bold-header-20"> {translate('show_on_map', true)} </h3>
					   <div class="mini-google-map"> <div data-msg="{$address}" data-lat="{$latitude}" data-lng="{$longitude}" id="map" data-detect='false' ></div> </div>
					</div>
					{/if}

					{if get_banner('company_view')}
					{assign var=company_view value=get_banner('company_view')}
					<div class="mini-banner">
						<a target="_blank" href="{$company_view->url}"> <img src="/uploads/{$company_view->image}" /> </a>
					</div>
					{/if}

				</div>
				<div class="col-lg-8  col-md-12 p-l-r">
					{if (isset($galleries) && !empty($galleries)) || (isset($videos) && !empty($videos)) || (isset($news_list) && !empty($news_list)) || (isset($products) && !empty($products)) || (isset($services) && !empty($services)) || (isset($discounts) && !empty($discounts))}
					<ul class="page-tabs nav nav-tabs" role="tablist">
						{if isset($galleries) && !empty($galleries)}<li><a data-toggle="tab" href="#photo-gallery">{translate('gallery', true)}</a></li>{/if}
						{if isset($videos) && !empty($videos)}<li> <a data-toggle="tab" href="#video">{translate('videos', true)}</a></li>{/if}
						{if isset($news_list) && !empty($news_list)}<li><a  data-toggle="tab" href="#blog">{translate('news', true)}</a></li>{/if}
						{if isset($products) && !empty($products)}<li> <a  data-toggle="tab" href="#product">{translate('products', true)}</a></li>{/if}
						{if isset($services) && !empty($services)}<li> <a  data-toggle="tab" href="#service">{translate('services', true)}</a></li>{/if}
						{if isset($discounts) && !empty($discounts)}<li> <a  data-toggle="tab" href="#unde">{translate('discount', true)}</a></li>{/if}
					</ul>
					<div class="tab-content c-profile-tab-content">
						{if isset($galleries) && !empty($galleries)}
						<div id="photo-gallery" class="tab-pane active">
							<div class="company-block d-flex-box">
								<ul class="company-ul">
									{foreach from=$galleries item=row}
									<li>
										<div class="company-image">
											<a href="{$row->link}"><img src="{$row->image}" alt="{$row->name}" /> </a>
										</div>
										<div class="company-content">
											<h3> <a href="{$row->link}" class="bold-header-14"> {$row->name}</a> </h3>
											<span class="light-header-12 float-right"><i class="far fa-eye"></i> {$row->view}</span>
											<span class="light-header-12"> <i class="far fa-calendar-alt"></i> {$row->date}</span>
										</div>
										{if get_user_id() eq $user_id}
											<div class="toolbar">
												<a class="btn btn-sm btn-dark" href="{site_url_multi('gallery/edit')}/{$row->id}"><i class="fas fa-pencil-alt"></i></a>
												<a class="btn btn-sm btn-dark" href="{site_url_multi('gallery/delete')}/{$row->id}"><i class="fas fa-trash-alt"></i></a>
											</div>
										{/if}
									</li>
									{/foreach}
								</ul>
								<div class="text-center">									
									<a href="{site_url_multi('gallery')}/company/{$slug}" class="waves-effect btn-style-1 text-center large green"><i class="fas fa-images"></i> {translate('gallery_all')}</a>
									{if get_user_id() eq $user_id}<a href="{site_url_multi('gallery')}/add/{$id}" class="waves-effect btn-style-1 text-center large green"><i class="fas fa-plus"></i> {translate('gallery_add')}</a>{/if}
								</div>
							</div>
						</div>
						{/if}

						{if isset($news_list) && !empty($news_list)}
						<div id="blog" class="tab-pane fade">
							<div class="row m-l-r blog-block tab-blog">
								{foreach from=$news_list item=row}
								<div class="col-md-4 col-sm-6 col-12">
									<div class="blog-image">
										<a href="{$row->link}"><img src="{$row->image}" alt="{$row->name}" /></a>
									</div>
									<div class="blog-content">
										<h3> <a href="{$row->link}" class="bold-header-14">{$row->name}</a></h3>
										<span class="light-header-12"><i class="far fa-calendar-alt"></i> {$row->date}</span>
									</div>
									{if get_user_id() eq $user_id}
										<div class="toolbar">
											<a class="btn btn-sm btn-dark" href="{site_url_multi('news/edit')}/{$row->id}"><i class="fas fa-pencil-alt"></i></a>
											<a class="btn btn-sm btn-dark" href="{site_url_multi('news/delete')}/{$row->id}"><i class="fas fa-trash-alt"></i></a>
										</div>
									{/if}
								</div>
								{/foreach}
							</div>
							<div class="text-center">									
								<a href="{site_url_multi('news')}/company/{$slug}" class="waves-effect btn-style-1 text-center large green"><i class="fas fa-newspaper"></i> {translate('news_all')}</a>
								{if get_user_id() eq $user_id}<a href="{site_url_multi('news')}/add/{$id}" class="waves-effect btn-style-1 text-center large green"><i class="fas fa-plus"></i> {translate('news_add')}</a>{/if}
							</div>
						</div>
						{/if}

						{if isset($products) && !empty($products)}
						<div id="product" class="tab-pane fade">
							<div class="company-block product">
								<ul class="company-ul">
									{foreach from=$products item=row}
									<li>
										<div class="company-image">
											<a href="{$row->link}">
												<img src="{$row->image}" alt="{$row->name}" data-filter="false">
												<span class="price">{$row->price} AZN</span>
											</a>
										</div>
										<div class="company-content">
											<h3> <a href="{$row->link}" class="bold-header-14"> {$row->name}</a> </h3>
											<span class="light-header-12 float-right"><i class="far fa-eye"></i> {$row->view}</span>
											<span class="light-header-12"> <i class="far fa-calendar-alt"></i> {$row->date}</span>
										</div>
										{if get_user_id() eq $user_id}
											<div class="toolbar">
												<a class="btn btn-sm btn-dark" href="{site_url_multi('product/edit')}/{$row->id}"><i class="fas fa-pencil-alt"></i></a>
												<a class="btn btn-sm btn-dark" href="{site_url_multi('product/delete')}/{$row->id}"><i class="fas fa-trash-alt"></i></a>
											</div>
										{/if}
									</li>
									{/foreach}
								</ul>
								<div class="text-center">									
									<a href="{site_url_multi('product')}/company/{$slug}" class="waves-effect btn-style-1 text-center large green"><i class="fas fa-cart-plus"></i> {translate('product_all')}</a>
									{if get_user_id() eq $user_id}<a href="{site_url_multi('product')}/add/{$id}" class="waves-effect btn-style-1 text-center large green"><i class="fas fa-plus"></i> {translate('product_add')}</a>{/if}
								</div>
							</div>
						</div>
						{/if}

						{if isset($services) && !empty($services)}
						<div id="service" class="tab-pane fade">
							<div class="company-block service">
								<ul class="company-ul">
									{foreach from=$services item=row}
									<li>
										<div class="company-image">
											<a href="{$row->link}">
												<img src="{$row->image}" alt="{$row->name}" data-filter="false">
												<span class="price">{$row->price} AZN</span>
											</a>
										</div>
										<div class="company-content">
											<h3><a href="{$row->link}" class="bold-header-14">{$row->name}</a></h3>
											<span class="light-header-12 float-right"> <i class="far fa-eye"></i> {$row->view}</span>
											<span class="light-header-12"> <i class="far fa-calendar-alt"></i> {$row->date}</span>
										</div>
										{if get_user_id() eq $user_id}
											<div class="toolbar">
												<a class="btn btn-sm btn-dark" href="{site_url_multi('service/edit')}/{$row->id}"><i class="fas fa-pencil-alt"></i></a>
												<a class="btn btn-sm btn-dark" href="{site_url_multi('service/delete')}/{$row->id}"><i class="fas fa-trash-alt"></i></a>
											</div>
										{/if}
									</li>
									{/foreach}
								</ul>
								<div class="text-center">									
									<a href="{site_url_multi('service')}/company/{$slug}" class="waves-effect btn-style-1 text-center large green"><i class="fas fa-concierge-bell"></i>  {translate('service_all')}</a>
									{if get_user_id() eq $user_id}<a href="{site_url_multi('service')}/add/{$id}" class="waves-effect btn-style-1 text-center large green"><i class="fas fa-plus"></i> {translate('service_add')}</a>{/if}
								</div>
							</div>
						</div>
						{/if}

						{if isset($videos) && !empty($videos)}
						<div id="video" class="tab-pane">
							<div class="company-block product video">
								<ul class="company-ul">
									{foreach from=$videos item=row}
									<li>
										<div class="company-image">
											<a href="{$row->link}" data-video-url="{$row->video}" data-prevent="off"  data-toggle="modal" data-target="#myModal">
												<img src="{youtube_image($row->video)}" alt="{$row->name}" data-filter="false">
											</a>
										</div>
										<div class="company-content">
											<h3> <a href="{$row->link}" class="regular-header-14">{$row->name}</a> </h3>
										</div>
										{if get_user_id() eq $user_id}
											<div class="toolbar">
												<a class="btn btn-sm btn-dark" href="{site_url_multi('video/edit')}/{$row->id}"><i class="fas fa-pencil-alt"></i></a>
												<a class="btn btn-sm btn-dark" href="{site_url_multi('video/delete')}/{$row->id}"><i class="fas fa-trash-alt"></i></a>
											</div>
										{/if}
									</li>
									{/foreach}
								</ul>
								<div class="text-center">									
									<a href="{site_url_multi('video')}/company/{$slug}" class="waves-effect btn-style-1 text-center large green"><i class="fab fa-youtube"></i>  {translate('video_all')}</a>
									{if get_user_id() eq $user_id}<a href="{site_url_multi('video')}/add/{$id}" class="waves-effect btn-style-1 text-center large green"><i class="fas fa-plus"></i> {translate('video_add')}</a>{/if}
								</div>
							</div>
						</div>
						{/if}

						{if isset($discounts) && !empty($discounts)}
						<div id="unde" class="tab-pane fade">
							<div class="company-block d-flex-box">
								<ul class="company-ul">
									{foreach from=$discounts item=row}
									<li>
										<div class="company-image">
											<a href="{$row->link}"> <img src="{$row->image}" alt="{$row->name}" /></a>
										</div>
										<div class="company-content">
											<h3><a href="{$row->link}" class="regular-header-14">{$row->name}</a></h3>
										</div>
										{if get_user_id() eq $user_id}
											<div class="toolbar">
												<a class="btn btn-sm btn-dark" href="{site_url_multi('discount/edit')}/{$row->id}"><i class="fas fa-pencil-alt"></i></a>
												<a class="btn btn-sm btn-dark" href="{site_url_multi('discount/delete')}/{$row->id}"><i class="fas fa-trash-alt"></i></a>
											</div>
										{/if}
									</li>
									{/foreach}
								</ul>
								<div class="text-center">									
									<a href="{site_url_multi('discount')}/company/{$slug}" class="waves-effect btn-style-1 text-center large green"><i class="fas fa-percentage"></i>  {translate('discount_all')}</a>
									{if get_user_id() eq $user_id}<a href="{site_url_multi('discount')}/add/{$id}" class="waves-effect btn-style-1 text-center large green"><i class="fas fa-plus"></i> {translate('discount_add')}</a>{/if}
								</div>
							</div>
						</div>
						{/if}
					</div>
					{/if}
					{include file="templates/citymap/_partial/comment.tpl"}
				</div>
			</div>
		</div>
	</section>

	{if isset($relateds) && !empty($relateds)}
	<section class="default-section last-added-section use-partner-blog " >
		<div class="container">
			<div class="section-header">
				<div class="row">
					<h3> {translate('related_companies', true)} </h3>
				</div>
			</div>
			<div class="last-added-block">
				<ul class="last-added-ul" >
					{foreach from=$relateds item=row}
					<li>
						<div class="last-added-image">
							<a href="{$row->link}"> <img src="{$row->image}" alt="{$row->name}" /> </a>
						</div>
						<div class="last-added-content">
							<h3> <a href="{$row->link}" class="bold-header-14">  {$row->name} </a> </h3>
							<span class="light-header-12"> {$row->description} </span>
						</div>
					</li>
					{/foreach}
				</ul>
			</div>
		</div>
	</section>
	{/if}

	<script>
	var company_id = "{$id}";
	var form_labels = {
		favorite : "{translate('favorite')}",
		unfavorite : "{translate('unfavorite')}",
		follow : "{translate('follow')}",
		unfollow : "{translate('unfollow')}"
	};
	{literal}
	$("button#btnFavorite").on("click",function(){
		var element = $(this);
		$.ajax({
			type: "POST",
			url: '/favorite/add',
			data: {'company_id': company_id},
			dataType: 'json',
			success: function (response) {
				if(response.success)
				{
					if(response.type == 'inserted') {
						$(element).html('<i class="fas fa-heart"></i> '+form_labels.unfavorite);
					} else if(response.type == 'deleted') {
						$(element).html('<i class="fas fa-heart"></i> '+form_labels.favorite);
					} else {
						alert(response.message);
					}
					//element.parent().parent().fadeOut();
				}
				else
				{
					if(response.type == 'login') {
						$('a#btnSign').trigger("click");
					} else {
						alert(response.message);
					}

				}

			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(textStatus, errorThrown);
			}
		});
	});

	$("button#btnFollow").on("click",function(){
		var element = $(this);
		$.ajax({
			type: "POST",
			url: '/following/add',
			data: {'company_id': company_id},
			dataType: 'json',
			success: function (response) {
				if(response.success)
				{
					if(response.type == 'inserted') {
						$(element).html('<i class="far fa-eye"></i> '+form_labels.unfollow);
					} else if(response.type == 'deleted') {
						$(element).html('<i class="far fa-eye"></i> '+form_labels.follow);
					} else {
						alert(response.message);
					}
					//element.parent().parent().fadeOut();
				}
				else
				{
					if(response.type == 'login') {
						$('a#btnSign').trigger("click");
					} else {
						alert(response.message);
					}

				}

			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(textStatus, errorThrown);
			}
		});
	});
	{/literal}
	</script>
	{literal}
	<script type="text/javascript">
		$('.page-tabs a:first').tab('show');
	</script>
	{/literal}
{/block}