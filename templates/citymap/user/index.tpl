{extends file=$layout}
{block name=content}
<section class="default-section full-company">
	<div class="container">
		<div class="section-header">
			<div class="row">
				<div class="section-header">
					<h3 class="medium-title">{$title}</h3>
				</div>
				{include file="templates/citymap/_partial/breadcrumb.tpl"}
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 company-profile-block">
				<div class="c-profile-slider">
					<div class="c-profile-active-slide border-radius-50" >
						<a href="{$image_full}" data-fancybox="group1">  <img class="border-radius-50" src="{$image}" alt="{$title}" />  </a>
					</div>
				</div>
				<div class="c-profile-info">
					<ul class="c-profile-controls">
					</ul>
				</div>
				<div class="c-profile-info">
					<div class="c-profile-info-rating"><span class="rating-block">{$review_count}</span></div>
					<ul class="c-profile-info-ul">
						{if $firstname}
							<li> <i class="fas fa-id-card-alt"></i>
								<div class="c-concept">
									<span>{translate('firstname')}</span> {$firstname}
								</div>
							</li>
						{/if}
						<br/>
						{if $lastname}
							<li> <i class="fas fa-id-card-alt"></i>
								<div class="c-concept">
									<span>{translate('lastname')}</span> {$lastname}
								</div>
							</li>
						{/if}
						{if $email}
							<li> <i class="fas fa-envelope"></i>
								<div class="c-concept">
									<span>{translate('email')}</span> <a href="mailto:{$email}">{$email}</a> 
								</div>
							</li>
						{/if}
						<br/>
						{if $mobile}
							<li> <i class="fas fa-mobile"></i>
								<div class="c-concept">
									<span>{translate('mobile')}</span> <a href="tel:{$mobile}">{$mobile}</a>
								</div>
							</li>
						{/if}
						
					</ul>
				</div>
			</div>
		</div>
	</div>
</section>
{/block}