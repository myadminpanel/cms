{extends file=$layout}
{block name=content}
	<section class="default-section full-company blog-section blg-single">
		<div class="container mx-1235">
			<div class="section-header">
				<div class="row m-l-r-0">
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<div class="row m-l-r-0">
				<div class="col-md-12 p-l">
					<div class="blog-single">
						<div class="row">
							<div class="col-lg-9 col-md-9 col-sm-12">
								<div class="blog-single-image">
									<img src="{$image}" alt="{$title}" />
								</div>
							</div>
							<div class="col-lg-3 col-md-3 col-sm-12 show-desktop">
								{include file="templates/citymap/_partial/company_block.tpl"}
							</div>
						</div>
						
						<div class="blog-single-text">
							<div class="blog-single-header">
								<h3> {$title} </h3>
							</div>
							<div class="blog-single-content">
								{$description}
							</div>
						</div>
						<div class="blog-single-time">
							<span class="regular-header-14"><i class="far fa-calendar-alt"></i> {$date}</span>
							<span class="regular-header-14"><i class="far fa-eye"></i> {$view} </span>
							<a href="{site_url_multi('user/index')}/{$author_username}"><span class="regular-header-14"><i class="fas fa-user-alt"></i> {$author}</span></a>
							<a href="{site_url_multi('news')}?author={$author_username}"><span class="regular-header-14"><i class="fas fa-newspaper"></i> {translate('author_all_news')}</span></a>
							<span class="regular-header-14"><i class="far fa-comment"></i> {$comment_count}</span>
						</div>
					</div>
					{include file="templates/citymap/_partial/comment.tpl"}
				</div>
				<div class="col-md-12 show-mobile">
					{include file="templates/citymap/_partial/company_block.tpl"}
				</div>
			</div>
		</div>
	</section>
	{include file="templates/citymap/_partial/related/related_news.tpl"}
	{include file="templates/citymap/_partial/other/other_news.tpl"}
{/block}