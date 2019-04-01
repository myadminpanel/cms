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
												<input type="text" name="translation[{$language.id}][name]" value="{(set_value('translation['|cat:$language.id|cat:'][name]')) ? set_value('translation[1][name]') : $translation[$language.id]->name }" class="form-control" placeholder="{translate('name')}" />
											</div>
											<div class="form-group">
												<label>{translate('description')}</label>
												<textarea class="form-control" name="translation[{$language.id}][description]" value="{set_value('translation[1][name]')}" placeholder="{translate('description')}" class="form-control">{(set_value('translation['|cat:$language.id|cat:'][description]')) ? set_value('translation[1][description]') : $translation[$language.id]->description }</textarea>
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
													<option {if $discount->company_id eq $company->id}selected="selected"{/if} value="{$company->id}">{$company->name}</option>
												{/foreach}
											{/if}
										</select>
									</div>
									<div class="form-group">
										<label>{translate('image')}</label>

										<div class="image_container">
											<img id="preview_image" src="{$discount->image_preview}" class="image" style="" title="Click and change">
											<input type="file" name="file" accept="image/*" style="display:none">
											<input type="hidden" name="image" value="{$discount->image}">
											<div class="image_middle">
												<div class="image_text">{translate('upload')}</div>
											</div>
										</div>
									</div>
									<div class="form-group">
										<label>{translate('date')}</label>
											<input type="text" class="form-control datepicker" name="date" placeholder="{translate('date')}" value="{(set_value('date')) ? set_value('date') : $discount->date}">
										</div>
									</div>
									<div class="form-group">
										<button type="submit" class=" waves-effect btn-style-1 large green">{translate('edit_button')}</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	{literal}
	<script>
		$('.datepicker').daterangepicker({ 
			singleDatePicker: true,
			locale: {
				format: 'YYYY-MM-DD'
			},
			autoUpdateInput: false
		}, function (chosen_date) {
			$(this.element[0]).val(chosen_date.format('YYYY-MM-DD'));
		});
		$('.image_text').on('click', function() {

		$('input[name=\'file\']').trigger('click');

		if (typeof timer != 'undefined') {
			clearInterval(timer);
		}

		timer = setInterval(function() {
			if ($('input[name=\'file\']').val() != '') {
				clearInterval(timer);
				data = new FormData();
				 data.append('file', $('input[name=\'file\']')[0].files[0]);
				$.ajax({
					url: '/attachment/upload',
					type: 'post',
					dataType: 'json',
	 				enctype: 'multipart/form-data',
					data: data,
					cache: false,
					contentType: false,
					processData: false,
					success: function(response) {
						if (response.success) {
							$('input[name="image"]').val(response.image);
							$('#preview_image').attr('src', '/uploads/'+response.image);
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		}, 500);
	});
	</script>
	<style>
	#preview_image {
		witdh:300px;
		height:300px;
		cursor:pointer;
		padding:5px;
		border: 1px solid #dfdfdf;
	}
	.image_container {
		position: relative;
		width: 300px;
	}
	.image {
		opacity: 1;
		display: block;
		width: 100%;
		height: auto;
		transition: .5s ease;
		backface-visibility: hidden;
	}
	.image_middle {
		transition: .5s ease;
		opacity: 0;
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		-ms-transform: translate(-50%, -50%);
		text-align: center;
	}
	.image_container:hover .image {
		opacity: 0.3;
	}
	.image_container:hover .image_middle {
		opacity: 1;
	}

	.image_text {
		background-color: #0b7a50;
		color: white;
		font-size: 16px;
		padding: 16px 16px;
		cursor:pointer;
	}
	</style>
	{/literal}
{/block}