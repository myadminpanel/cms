
{extends file=$layout}
{block name=content}
	<!-- ==== ==== ==== ====  Map start ==== ==== ==== ==== -->
	<section class="default-section map-section">
		<div class="map-block" data-lat="40.385289345299746"  data-lng="49.887223500000005" data-detect="true" id="map"></div>
		<div class="map-place-block">
			<div class="container-fluid mx-1235">
				<div class="row">
					<div class="col-xl-4 col-lg-5 col-sm-12 col-12">
						<div class="map-current-place" style="display:none">
							<fieldset>
								<div class="d-flex center space-between find-me">
									<article>
										<span>{translate('current_position', true)}</span> 
										<p class="your_address"> Xırdalan şəhəri, Heydər Əliyev pr.... </p>
									</article>
									<span class="mp-current-icon"> <i class="far fa-eye"> </i> </span>
								</div>
							</fieldset>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="map-info">
			<div class="container-fluid mx-1235 ">
				<form action="{site_url_multi('company')}" method="GET">
					<div class="row">
						<div class="col-lg-9 col-md-12 mx-837">
							<div class="search-area d-flex">
								<div class="form-group">
									<label> <i class="fas fa-map-marker-alt"></i> </label>
									<input type="text" name="keyword" class="form-control" placeholder="{translate('search_keyword', true)}" />
								</div>
								<div class="form-group">
									<label> <i class="fas fa-map-marker-alt"></i> </label>
									<input type="text" jsKeyup="search" class="form-control" placeholder="{translate('search_region', true)}" />
									<ul jsGet="search" class="list-group green">
										{foreach from=$regions item=region}
											<li data-index="{$region->id}" data-text="{$region->name}" class="list-group-item active">{$region->name}</li>
										{/foreach}
									</ul>
								</div>
								<div class="form-group">
									<input type="hidden" name="country_id" value="1" />
									<input type="hidden" name="region_id" value="" />
									<button type="submit" class="waves-effect btn-style-1" ><i class="fas fa-search"></i> {translate('search_button', true)}</button>
								</div>
							</div>
						</div>
						{if isset($most_categories) && !empty($most_categories)}
						<div class="col-lg-3 col-md-12 mx-345">
							<div class="search-area white">
								<ul class="search-menu">
									{foreach from=$most_categories item=category}
									<li data-id="{$category->id}">
										<a data-toggle="tooltip" data-placement="top" title="{$category->fullname}" data-original-title=" {$category->fullname}" href="{$category->link}"><img src="{$category->image}"/> {$category->name}</a>
									</li>
									{/foreach}
								</ul>
							</div>
						</div>
						{/if}
					</div>
				</form>
			</div>
		</div>
	</section>


	<section class="default-section random-section">
		<div class="container">
			<div class="row space-between">
				<aside class=" category-aside mx-190 ">
					<div class="category-block">
						<ul class="category-block-ul">
							<li class="header" > <span class="bold-header-16"> {translate('category', true)} </span> </li>
							<li> <a href="{site_url_multi('category')}/{$category_1_url->slug}"> <i class="fas fa-university" ></i> {translate('institutions', true)} </a> </li>
							<li> <a href="{site_url_multi('category')}/{$category_2_url->slug}"> <i class="fas fa-briefcase"></i> {translate('companies', true)} </a> </li>
							<li> <a href="{site_url_multi('category')}/{$category_3_url->slug}"> <i class="fas fa-user"></i>{translate('businessman', true)} </a> </li>
						</ul>
						<ul class="category-block-ul">
							<li class="header"> <span class="bold-header-16"> {translate('useful', true)} </span> </li>
							{get_menu_by_name('useful')}
						</ul>
					</div>
				</aside>
				{if isset($random_companies) && !empty($random_companies)}
				<div class="mx-825">
					<div class="section-header">
						<div class="row m-l-r">
							<h3>{translate('random_companies', true)}</h3>
							<div class="more">
								<a href="{site_url_multi('company')}"> {translate('show_all', true)} </a>
							</div>
						</div>
					</div>
					<div>
						<ul class="last-added-ul" >
							{foreach from=$random_companies item=row}
								<li>
									<div class="last-added-image">
										<a href="{$row->link}">
											{if isset($row->country_code) && $row->country_code}
												<div class="m-mini-icon">
													<img src="{$row->country_code}"/>
												</div>
											{/if}
											<img src="{$row->image}" alt="{$row->name}" />
										</a>
									</div>
									<div class="last-added-content">
										<h3> <a href="{$row->link}" class="bold-header-14">{$row->name}</a></h3>
									</div>
								</li>
							{/foreach}
						</ul>
					</div>
				</div>
				{/if}
			</div>
		</div>
	</section>

	{if get_banner('banner_home_main')}
	{assign var=banner_home_main value=get_banner('banner_home_main')}
	<section class="default-section">
		<div class="container">
			<div class="row">
				<div class="full-banner">
					<a target="_blank" href="{$banner_home_main->url}"> <img src="/uploads/{$banner_home_main->image}" /> </a>
				</div>
			</div>
		</div>
	</section>
	{/if}

	{if (isset($products) && !empty($products)) || (isset($services) && !empty($services))}
		<section class="default-section last-added-section" >
			<div class="container">
				<div class="section-header">
					<div class="row">
						<h3> {translate('product_service', true)} </h3>
						<div class="slider-buttons">
							<button type="button" jsClick="nextSlide" class="slider-prev"> <i class="fas fa-chevron-left"></i> </button>
							<button type="button" jsClick="prevSlide" class="slider-next"> <i class="fas fa-chevron-right"></i> </button>
						</div>
					</div>
				</div>
			</div>
			<div class="services-slider-block">
				<ul jsGet="carousel" class="last-added-ul owl-carousel" >
					{if isset($products) && !empty($products)}
						{foreach from=$products item=row}
							<li>
								<div class="last-added-image">
									<a href="{$row->link}">
										<img src="{$row->image}" alt="{$row->name}" />
										<span class="price">{$row->price} AZN</span>
									</a>
								</div>
								<div class="last-added-content">
									<h3> <a href="{$row->link}" class="bold-header-14">{$row->name}</a></h3>
								</div>
							</li>
						{/foreach}
					{/if}
					{if isset($services) && !empty($services)}
						{foreach from=$services item=row}
							<li>
								<div class="last-added-image">
									<a href="{$row->link}">
										<img src="{$row->image}" alt="{$row->name}" />
										<span class="price">{$row->price} AZN</span>
									</a>
								</div>
								<div class="last-added-content">
									<h3> <a href="{$row->link}" class="bold-header-14">{$row->name}</a></h3>
								</div>
							</li>
						{/foreach}
					{/if}
				</ul>
			</div>
		</section>
	{/if}

	{if isset($news_list) && !empty($news_list)}
		<section class="default-section" >
			<div class="container">
				<div class="section-header">
					<div class="row">
						<h3> {translate('news', true)} </h3>
						<div class="more">
							<a href="{site_url_multi('news')}"> {translate('show_all', true)} </a>
						</div>
					</div>
				</div>
				<div class="row blog-block">
					{foreach from=$news_list item=row}
						<div class="col-md-4 col-sm-6 col-12">
							<div class="blog-image">
								<a href="{$row->link}"><img src="{$row->image}" alt="{$row->name}" /></a>
							</div>
							<div class="blog-content">
								<h3> <a href="{$row->link}" class="bold-header-14"> {$row->name}</a></h3>
								<div class="f-flex-inline every">
									<span class="light-header-12"> <i class="far fa-calendar-alt"></i>  {$row->date} </span>
									<span class="light-header-12"> <i class="fas fa-user-alt"></i>  {$row->author} </span>
								</div>
							</div>
						</div>
					{/foreach}
				</div>
			</div>
		</section>
	{/if}

	{if isset($latest_companies) && !empty($latest_companies)}
		<section class="default-section last-added-section " >
			<div class="container">
				<div class="row">
					<div class="col-md-10">
						<div class="section-header">
							<div class="row">
								<h3>{translate('latest_company', true)}</h3>
								<div class="more">
									<a href="{site_url_multi('company')}"> {translate('show_all', true)} </a>
								</div>
							</div>
						</div>
						<div class="last-added-block with-banner">
							<ul class="last-added-ul" >
								{foreach from=$latest_companies item=$row}
									<li>
										<div class="last-added-image">
											<a href="{$row->link}">
												{if isset($row->country_code) && $row->country_code}
													<div class="m-mini-icon">
														<img src="{$row->country_code}"/>
													</div>
												{/if}
												<img src="{$row->image}" alt="{$row->name}" />
											</a>
										</div>
										<div class="last-added-content">
											<h3> <a href="{$row->link}" class="bold-header-14">{$row->name}</a></h3>
										</div>
									</li>
								{/foreach}
							</ul>
						</div>
					</div>
					<div class="col-md-2 p-l-r">
						{if get_banner('banner_home_right_1')}
						{assign var=banner_home_right_1 value=get_banner('banner_home_right_1')}
						<div class="banner">
							<a target="_blank" href="{$banner_home_right_1->url}"> <img src="/uploads/{$banner_home_right_1->image}"/> </a>
						</div>
						{/if}
						{if get_banner('banner_home_right_2')}
						{assign var=banner_home_right_2 value=get_banner('banner_home_right_2')}
						<div class="banner">
							<a target="_blank" href="{$banner_home_right_2->url}"> <img src="/uploads/{$banner_home_right_2->image}"/> </a>
						</div>
						{/if}
					</div>
				</div>
			</div>
		</section>
	{/if}

	{if isset($discounts) && !empty($discounts)}
		<section class="default-section">
			<div class="container">
				<div class="section-header">
					<div class="row">
						<h3> {translate('discount', true)} </h3>
						<div class="more">
							<a href="{site_url_multi('discount')}"> {translate('show_all', true)} </a>
						</div>
					</div>
				</div>
				<div class="company-block">
					<ul class="company-ul" >
						{foreach from=$discounts item=row}
						<li>
							<div class="company-image">
								<a href="{$row->link}"> <img src="{$row->image}" alt="{$row->name}" /></a>
							</div>
							<div class="company-content">
								<h3> <a href="{$row->link}" class="bold-header-14">{$row->name}</a></h3>
								<span class="light-header-12"> <i class="far fa-calendar-alt"></i>  {$row->date} </span>
							</div>
						</li>
						{/foreach}
					</ul>
				</div>
			</div>
		</section>
	{/if}
	{literal}
	<script type="text/javascript">
	$('.list-group li').on('click', function(){
		var region_id = $(this).data('index');
		$('input[name="region_id"]').val(region_id);
	});
	</script>
	{/literal}
{/block}