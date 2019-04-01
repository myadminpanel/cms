{extends file=$layout}
{block name=content}
	<section class="default-section full-company blog-section">
		<div class="container">
			<div class="section-header">
				<div class="row">
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<div class="row">
				<div class="col-md-9 p-l">
					<div class="blog-single">
						<div class="blog-single-image">
							<img src="{$image}" alt="{$title}" />
						</div>
						<div class="blog-single-text">
							<div class="blog-single-header">
								<h3>{$title}</h3>
							</div>
							<div class="blog-single-content">
								{$description}
							</div>
						</div>
						<div class="blog-single-time">
							<span class="regular-header-14"><i class="far fa-calendar-alt"></i> {$date}</span>
							<span class="regular-header-14"><i class="far fa-eye"></i> {$view}</span>
							<span class="regular-header-14"><i class="far fa-comment"></i> {$comment_count}</span>
						</div>
					</div>
					{include file="templates/citymap/_partial/comment.tpl"}
				</div>
				 <div class="col-md-3 p-r">
					{include file="templates/citymap/_partial/sidebar/discount_single.tpl"}
				</div>
			</div>
		</div>
	</section>
	{include file="templates/citymap/_partial/related/related_discount.tpl"}
	{include file="templates/citymap/_partial/other/other_discount.tpl"}
{/block}
