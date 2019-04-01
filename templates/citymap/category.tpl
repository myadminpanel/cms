{extends file=$layout}
{block name=content}
	<section class="default-section full-company">
		<div class="container">
			<div class="section-header">
				<div class="row">
					<h3 class="big-title" > {$title} </h3>
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<div class="row">
				<div class="col-md-3 p-l-r">
					{include file="templates/citymap/_partial/filter.tpl"}
				</div>
				<div class="col-md-9 p-l-r">
					<div class="control-items">
						<div class="order-block">
							<span> Sırala: </span>
							<select class="form-control">
								<option value="0">  Seçilməyib </option>
								<option value="1">  A-Z </option>
								<option value="2"> Z-A </option>
							</select>
						</div>
						<div class="listed-style-block">
							<button type="button" data-product-filter="list" class=" waves-effect btn-style-2 white-border active"> <i class="fas fa-th-large"></i> </button>
							<button type="button" data-product-filter="large" class=" waves-effect btn-style-2 white-border"> <i class="fas fa-list"></i> </button>
						</div>
					</div>
					{if isset($categories) && !empty($categories)}
							<div class="blog-single" style="margin-top:20px">
								<div class="blog-single-text">
										<div class="row">
											{foreach from=$categories item=category}
												<div class="col-md-6"><a href="{$category->link}" class="in-line-element"><img src="{$category->image}" alt="{$category->name}" />{$category->name} ({$category->count})</a></div>
											{/foreach}
										</div>
								</div>
							</div>
					{/if}
					<div class="company-block product">
						<ul class="company-ul">
							{if isset($companies) && !empty($companies)}
								{foreach from=$companies item=row}
									{include file="templates/citymap/_partial/company.tpl"}
								{/foreach}
							{/if}
						</ul>
						{$pagination}
					</div>
				</div>
			</div>
		</div>
	</section>
{/block}