{extends file=$layout}
{block name=content}
	<section class="default-section full-company blog-section">
		<div class="container">
			<div class="section-header">
				<div class="row">
					<h3 class="big-title" >{$title}</h3>
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<div class="row">
				<div class="col-md-9 p-l">
					{if isset($categories) && !empty($categories)}
						<div class="blog-single" style="margin-top:20px">
							<div class="blog-single-text">
								<div class="row">
									{foreach from=$categories item=category}
										<div class="col-md-6"><a href="{site_url_multi('news/category/')}{$category->slug}" class="in-line-element">{$category->name}</a></div>
									{/foreach}
								</div>
							</div>
						</div>
					{/if}
					<div class="control-items">
						<div class="order-block">
							<!-- <span> Sırala: </span>
							<select class="form-control">
								<option value="0">  Seçilməyib </option>
								<option value="1">  A-Z </option>
								<option value="2"> Z-A </option>
							</select> -->
						</div>
						<div class="listed-style-block">
							<button type="button" data-blog-filter="list" class=" waves-effect btn-style-2 white-border active"> <i class="fas fa-th-large"></i> </button>
							<button type="button" data-blog-filter="large" class=" waves-effect btn-style-2 white-border"> <i class="fas fa-list"></i> </button>
						</div>
					</div>
					<div class="row blog-block">
						{if isset($rows) && !empty($rows)}
							{foreach from=$rows item=row}
								{include file="templates/citymap/_partial/news.tpl"}
							{/foreach}
						{/if}
					</div>
					{$pagination}
				</div>
				<div class="col-md-3 p-r">
					{include file="templates/citymap/_partial/sidebar/news.tpl"}
				</div>
			</div>
		</div>
	</section>
{/block}