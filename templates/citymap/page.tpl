{extends file=$layout}
{block name=content}
<section class="default-section full-company blog-section">
	<div class="container">
		<div class="section-header">
			<div class="row">
				<h3 class="big-title"> {$title} </h3>
				{include file="templates/citymap/_partial/breadcrumb.tpl"}
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 p-l-r">
				<div class="blog-single">
					{if $image}
					<div class="blog-single-image">
						<img src="{base_url('uploads/')}{$image}" alt="{$title}">
					</div>
					{/if}
					<div class="blog-single-text">
						<div class="blog-single-header">
							<h3>{$title}</h3>
						</div>
						<div class="blog-single-content">
							{html_entity_decode($description)}
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
{/block}