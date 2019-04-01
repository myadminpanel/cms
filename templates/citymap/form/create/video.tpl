{extends file=$layout}
{block name=content}
	<section class="default-section full-company">
		<div class="container">
			<div class="section-header">
				<div class="row">
					<div class="section-header">
						<h3 class="medium-title">{$title}</h3>
					</div>
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12 col-md-12 sm-padding-l p-r user-p-exist">
					<div class="combo-jumbotron tab-content">
						<div id="sector1" class=" tab-pane active comment-block">
							<form method="POST" action="{current_url()}">
								<div class="comment-form">
									<div class="comment-form-header">
										<h3>{$title}</h3>
									</div>
									{if isset($response) && !empty($response)}
									<div class="alert {if $response.success}alert-success{else}alert-danger{/if}">{$response.message}</div>
									{/if}
									<ul class="page-tabs nav nav-tabs" id="myTab" role="tablist">
										{foreach from=$languages item=language}
										<li>
											<a class="{if $language.code eq $default_language}active{/if}" id="{$language.code}-tab" data-toggle="tab" href="#{$language.code}" role="tab" aria-controls="{$language.code}" aria-selected="true">{$language.name}</a>
										</li>
										{/foreach}
									</ul>
									<div class="tab-content">
										{foreach from=$languages item=language}										
										<div class="tab-pane  {if $language.code eq $default_language}active{/if}" id="{$language.code}" role="tabpanel" aria-labelledby="{$language.code}-tab">
											<br/>
											<div class="form-group">
												<label>{translate('name')}</label>
												<input type="text" name="translation[{$language.id}][name]" value="{set_value('translation['|cat:$language.id|cat:'][name]')}" class="form-control" placeholder="{translate('name')}" />
											</div>
											<div class="form-group">
												<label>{translate('description')}</label>
												<textarea class="form-control" name="translation[{$language.id}][description]" value="{set_value('translation[1][name]')}" placeholder="{translate('description')}" class="form-control">{set_value('translation['|cat:$language.id|cat:'][description]')}</textarea>
											</div>
										</div>
										{/foreach}
									</div>
									<div class="form-group">
										<label>{translate('company')}</label>
										<select name="company_id" class="form-control">
											<option value="0">{translate('select')}</option>
											{if $companies}
												{foreach from=$companies item=company}
													<option {if $company_id eq $company->id}selected="selected"{/if} value="{$company->id}">{$company->name}</option>
												{/foreach}
											{/if}
										</select>
									</div>
									<div class="form-group">
										<label>{translate('youtube_url')}</label>
										<input type="text" name="video" class="form-control" value="{set_value('video')}" placeholder="{translate('youtube_url')}" />
									</div>
									<div class="form-group">
										<button type="submit" class=" waves-effect btn-style-1 large green">{translate('add_button')}</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
{/block}