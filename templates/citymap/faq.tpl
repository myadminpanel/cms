{extends file=$layout}
{block name=content}
	<section class="default-section full-company blog-section">
		<div class="container">
			<div class="section-header">
				<div class="row">
					<h3 class="big-title" > {$title} </h3>
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 p-l">
					<div class="row blog-block">
						{if isset($faqs) && !empty($faqs)}
						<div id="accordion" class="accordion-block">
							{foreach from=$faqs item=row}
								<div class=" accordion-list">
									<div class="accordion-header" id="headingOne">
										<h5 class="mb-0">
											<button class="btn btn-link" data-toggle="collapse" data-target="#collapseOne-{$row->id}" aria-expanded="false" aria-controls="collapseOne">
												{$row->name}
											</button>
										</h5>
									</div>
									<div id="collapseOne-{$row->id}" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
										<div class="accordion-content">
											{$row->description}
										</div>
									</div>
								</div>
							{/foreach}
						</div>
						{/if}
					</div>
				</div>
			</div>
		</div>
	</section>
{/block}