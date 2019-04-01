{extends file=$layout}
{block name=content}
	<section class="default-section full-company">
		<div class="container">
			<div class="section-header">
				<div class="row">
					<h3 class="big-title">{$title}</h3>
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 p-l-r">
					<div class="blog-single">
						<div class="blog-single-text">
							{if isset($categories) && !empty($categories)}
								<div class="row">
								{foreach from=$categories item=category}
									<div class="col-md-4"><a href="{$category->link}" class="in-line-element"><img src="{$category->image}" alt="{$category->name}" />{$category->name} ({$category->count})</a></div>
								{/foreach}
								</div>
							{/if}
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
{/block}