{extends file=$layout}
{block name=content}
<!-- ==== ==== ==== ==== Blog single start ==== ==== ==== ==== -->
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
					<div class="blog-single-text">
						<div class="blog-single-header">
							<h3>{$title}</h3>
						</div>
						<div class="blog-single-content">
							{if isset($codes) && !empty($codes)}
							<div class="row">
								{foreach from=$codes item=code}
									<div class="col-md-4 mb-3"><strong>{$code->name}</strong> <span class="badge badge-success float-right">{$code->code}</span></div>
								{/foreach}
							</div>
							{/if}
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- ==== ==== ==== ==== Blog single end ==== ==== ==== ==== -->
{/block}