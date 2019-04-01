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
				<div class="col-md-4">
					{include file="templates/citymap/_partial/sidebar/product.tpl"}
				</div>
				<div class="col-md-8 p-l-r">
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
							<button type="button" data-service-filter="list" class=" waves-effect btn-style-2 white-border active"> <i class="fas fa-th-large"></i> </button>
							<button type="button" data-service-filter="large" class=" waves-effect btn-style-2 white-border"> <i class="fas fa-list"></i> </button>
						</div>
					</div>
					<div class="company-block service">
						<ul class="company-ul">
							{if isset($rows) && !empty($rows)}
								{foreach from=$rows item=row}
									{include file="templates/citymap/_partial/product.tpl"}
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