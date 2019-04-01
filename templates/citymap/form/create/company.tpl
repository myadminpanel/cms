{extends file=$layout}
{block name=content}
<!-- ==== ==== ==== ==== User Profile start ==== ==== ==== ==== -->
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
				<div class="col-lg-3 col-md-12 sm-padding-r p-l">
					<div class="aside-menu-block">
						<ul class="user-profile-menu nav nav-tabs"  role="tablist">
							<li><a class="active" data-toggle="tab" href="#sector1" >{translate('information')}</a></li>
							<li><a data-toggle="tab" class="disabled" href="#sector7">{translate('map')}</a></li>
							<li><a data-toggle="tab" class="disabled"href="#sector3">{translate('worktime')}</a></li>
							<li><a data-toggle="tab" class="disabled" href="#sector4">{translate('image')}</a></li>
						</ul>
					</div>
				</div>
				<div class="col-lg-9 col-md-12 sm-padding-l p-r user-p-exist">
					{form_open(current_url())}
					<div class="combo-jumbotron tab-content">
						<div id="sector1" class=" tab-pane active comment-block">
							<form>
								<div class="comment-form">
									<div class="comment-form-header">
										<h3>{translate('company_information')}</h3>
									</div>
									{if isset($response)}
									<div class="alert {if $response.success}alert-success{else}alert-danger{/if}">{$response.message}</div>
									{/if}
									<ul class="page-tabs nav nav-tabs" role="tablist">
										{foreach from=$languages item=language}
											<li><a {if $default_language eq $language.code}class="active"{/if} data-toggle="tab" href="#{$language.code}">{$language.name}</a></li>
										{/foreach}
									</ul>
									<div class="tab-content c-profile-tab-content">
										{foreach from=$languages item=language}
											<div id="{$language.code}" class="tab-pane{if $default_language eq $language.code} active{/if}">
												<br/>
												<div class="form-group">
													<label>{translate('name')}</label>
													<input type="text" name="translation[{$language.id}][name]" value="{set_value('translation['|cat:$language.id|cat:'][name]')}" class="form-control" placeholder="{translate('name')}" />
												</div>
												
												<div class="form-group">
													<label>{translate('address')}</label>
													<input type="text" name="translation[{$language.id}][address]" value="{set_value('translation['|cat:$language.id|cat:'][address]')}" class="form-control" placeholder="{translate('address')}" />
												</div>
												
												<div class="form-group">
													<label>{translate('description')}</label>
													<textarea class="form-control" name="translation[{$language.id}][description]" placeholder="{translate('description')}" class="form-control">{set_value('translation['|cat:$language.id|cat:'][description]')}</textarea>
												</div>
											</div>
										{/foreach}
										<div class="form-group">
											<label>{translate('main_image')}</label>
											<div class="image_container">
												<img id="preview_image" src="{if set_value('image')}{base_url('uploads')}/{set_value('image')}{else}{base_url('templates/citymap/assets/image/nophoto.png')}{/if}" class="image" style="" title="{translate('click_and_change_image')}">
												<input type="file" name="file" accept="image/*" style="display:none">
												<input type="hidden" name="image" value="{set_value('image')}">
												<div class="image_middle">
													<div class="image_text">{translate('upload')}</div>
												</div>
											</div>
										</div>
										<div class="form-group">
											<label>{translate('parent_category')}</label>
											<select name="parent_category_id" class="form-control">
												<option value="0">{translate('select')}</option>
												{if isset($parent_categories) && !empty($parent_categories)}
													{foreach from=$parent_categories item=category}
														<option {if set_value('parent_category') eq $category->id}selected="selected"{/if} value="{$category->id}">{$category->name}</option>
													{/foreach}
												{/if}
											</select>
										</div>
										<div class="form-group">
											<label>{translate('category')}</label>
											<select name="category_id" class="form-control"></select>
										</div>
										<div class="form-group">
											<label>{translate('sub_category')}</label>
											<select name="sub_category_id" class="form-control"></select>
										</div>
										<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('country')}</label>
											<select name="country_id" class="form-control">
												<option value="0">{translate('select_country')}</option>
												{if isset($countries) && !empty($countries)}
													{foreach from=$countries item=country}
														<option {if set_value('country_id') eq $country->id}selected="selected"{elseif $country->id eq 1}selected="selected"{/if}  value="{$country->id}">{$country->name}</option>
													{/foreach}
												{/if}
											</select>
										</div>
										<div class="form-group">
											<label>{translate('region')}</label>
											<select name="region_id" class="form-control" data-selected="{set_value('region_id')}"></select>
										</div>
										
										
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('district')}</label>
											<select name="district_id" class="form-control"  data-selected="{set_value('district_id')}"></select>
										</div>
										<div class="form-group">
											<label>{translate('metro')}</label>
											<select name="metro_id" class="form-control" data-selected="{set_value('metro_id')}"></select>
										</div>
										
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('phone')}</label>
											<input type="text" name="phone" value="{set_value('phone')}" class="form-control" placeholder="{translate('phone')}" />
										</div>
										<div class="form-group">
											<label>{translate('mobile')}</label>
											<input type="text" name="mobile" class="form-control" value="{set_value('mobile')}" placeholder="{translate('mobile')}" />
										</div>
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('fax')}</label>
											<input type="text" name="fax" class="form-control" value="{set_value('fax')}"  placeholder="{translate('fax')}" />
										</div>
										<div class="form-group">
											<label>{translate('email')}</label>
											<input type="text" name="email" class="form-control" value="{set_value('email')}" placeholder="{translate('email')}" />
										</div>
										
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('website')}</label>
											<input type="text" name="website" class="form-control" value="{set_value('website')}" placeholder="{translate('website')}" />
										</div>
										<div class="form-group">
											<label>{translate('facebook')}</label>
											<input type="text" name="facebook" class="form-control" value="{set_value('facebook')}" placeholder="{translate('facebook')}" />
										</div>
										
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('instagram')}</label>
											<input type="text" name="instagram" class="form-control" value="{set_value('instagram')}" placeholder="{translate('instagram')}" />
										</div>
										<div class="form-group">
											<label>{translate('twitter')}</label>
											<input type="text" name="twitter" class="form-control"  value="{set_value('twitter')}" placeholder="{translate('twitter')}" />
										</div>
										
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('linkedin')}</label>
											<input type="text" name="linkedin" class="form-control"  value="{set_value('linkedin')}" placeholder="{translate('linkedin')}" />
										</div>
										<div class="form-group">
											<label>{translate('vk')}</label>
											<input type="text" name="vk" class="form-control"  value="{set_value('vk')}" placeholder="{translate('vk')}" />
										</div>
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('ok')}</label>
											<input type="text" name="ok" class="form-control"  value="{set_value('ok')}" placeholder="{translate('ok')}" />
										</div>
									</div>
									</div>
									<div class="form-group">
										<button type="submit" class="continue waves-effect btn-style-1 large green">{translate('continue')}</button>
									</div>
								</div>
							</form>
						</div>
					</div>
					{form_close()}
				</div>
			</div>
		</div>
	</section>
	{literal}
	<script>
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
		witdh:250px;
		height:250px;
		cursor:pointer;
		padding:5px;
		border: 1px solid #dfdfdf;
	}
	.image_container {
		position: relative;
		width: 250px;
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
	<script>
		var input = $('#multi_images');
		$('.select_images').on('click', function() {
			$(input).trigger('click');
		});

		input.on('change', function () {
			for (var i = 0; i < $(this)[0].files.length; i++)
			{
				data = new FormData();
				data.append('file[]', input[0].files[i]);
				$.ajax({
					url: '/attachment/multiupload?directory=company/',
					type: 'post',
					dataType: 'json',
					enctype: 'multipart/form-data',
					data: data,
					cache: false,
					contentType: false,
					processData: false,
					success: function(response) {
						if(response.success)
						{
							var image_block = '<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12"><div class="thumbnail"><div class="thumb"><img src="'+response.image+'" alt="'+response.data.file_name+'"><div class="caption-overflow"><span><a href="#" class="remove_image btn border-white text-white btn-flat btn-icon btn-rounded"><i class="icon-cross2"></i></a></span></div></div><div class="caption"><input type="hidden" name="images[]" value="'+response.save+'"><span class="text-regular">'+response.data.file_name+'</span></div></div></div>';
							$('#image_area').append(image_block);
						}
						else
						{
							console.log(response.message);
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
				}
		});

		$('body').delegate('.remove_image', 'click', function(e){
			e.preventDefault();
			$(this).parent().parent().parent().parent().parent().remove();
		});
	</script>
	<style>
	.image_uploader {
		width: 100%;
		height: 200px;
		background-color: #f2f2f2;
		text-align: center;
		padding-top: 80px;
		margin-bottom: 50px;
	}
	</style>
	{/literal}
	{literal}
	<script type="text/javascript">
		$('select[name="country_id"]').on('change', function(){
			let country_id = $(this).children("option:selected").val();
			let selected = $('select[name="region_id"]').data('selected');
			if (country_id) { 
				$.ajax({
					url: '/ajax/region?country_id='+ country_id,
					dataType: 'json',
					success: function(json) {
						html = '';
						if (json && json != '')
						{
							for (i = 0; i < json.length; i++)
							{
								html += '<option value="' + json[i]['id'] + '"';
								if (json[i]['id'] == selected)
								{
									html += ' selected="selected"';
								}
			
								html += '>' + json[i]['name'] + '</option>';
							}
						}
			
						$('select[name="region_id"]').html(html);
						$('select[name="region_id"]').trigger('change');
						
						
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		});
		$('select[name="country_id"]').trigger('change');
	</script>
	{/literal}
	{literal}
	<script type="text/javascript">
		$('select[name="region_id"]').on('change', function(){
			let region_id = $(this).children("option:selected").val();
			let selected = $('select[name="metro_id"]').data('selected');
			if (region_id) { 
				$.ajax({
					url: '/ajax/metro?region_id='+ region_id,
					dataType: 'json',
					success: function(json) {
						let html = '';
						if (json && json != '')
						{
							if(json.length > 1)
							{
								$('select[name="metro_id"]').parent().show();
								for (i = 0; i < json.length; i++)
								{
									html += '<option value="' + json[i]['id'] + '"';
									if (json[i]['id'] == selected)
									{
										html += ' selected="selected"';
									}
				
									html += '>' + json[i]['name'] + '</option>';
								}
							}
							else {
								$('select[name="metro_id"]').parent().hide();
							}
						}
			
						$('select[name="metro_id"]').html(html);
						
						
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		});
	</script>
	{/literal}
	{literal}
	<script type="text/javascript">
		$('select[name="region_id"]').on('change', function(){
			let region_id = $(this).children("option:selected").val();
			let selected = $('select[name="district_id"]').data('selected');
			if (region_id) { 
				$.ajax({
					url: '/ajax/district?region_id='+ region_id,
					dataType: 'json',
					success: function(json) {
						let html = '';
						if (json && json != '')
						{
							if(json.length > 1)
							{
								$('select[name="district_id"]').parent().show();
								for (i = 0; i < json.length; i++)
								{
									html += '<option value="' + json[i]['id'] + '"';
									if (json[i]['id'] == selected)
									{
										html += ' selected="selected"';
									}
				
									html += '>' + json[i]['name'] + '</option>';
								}
							}
							else
							{
									$('select[name="district_id"]').parent().hide();
							}
						}
			
						$('select[name="district_id"]').html(html);
						
						
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		});
	</script>
	{/literal}
	{literal}
	<script type="text/javascript">
		$('select[name="parent_category_id"]').on('change', function(){
			let parent_category_id = $(this).children("option:selected").val();
			let selected = $('select[name="category_id"]').data('selected');
			if (parent_category_id) { 
				$.ajax({
					url: '/ajax/category?parent_id='+ parent_category_id,
					dataType: 'json',
					success: function(json) {
						let html = '';
						if (json && json != '')
						{
							if(json.length > 1)
							{
								$('select[name="category_id"]').parent().show();
								for (i = 0; i < json.length; i++)
								{
									html += '<option value="' + json[i]['id'] + '"';
									if (json[i]['id'] == selected)
									{
										html += ' selected="selected"';
									}
				
									html += '>' + json[i]['name'] + '</option>';
								}
							}
							else
							{
									$('select[name="category_id"]').parent().hide();
							}
						}
			
						$('select[name="category_id"]').html(html);
						
						
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		});

		$('select[name="parent_category_id"]').trigger('change');
	</script>
	{/literal}
	{literal}
	<script type="text/javascript">
		$('select[name="category_id"]').on('change', function(){
			let category_id = $(this).children("option:selected").val();
			let selected = $('select[name="sub_category_id"]').data('selected');
			if (category_id) { 
				$.ajax({
					url: '/ajax/category?parent_id='+ category_id,
					dataType: 'json',
					success: function(json) {
						let html = '';
						if (json && json != '')
						{
							if(json.length > 1)
							{
								$('select[name="sub_category_id"]').parent().show();
								for (i = 0; i < json.length; i++)
								{
									html += '<option value="' + json[i]['id'] + '"';
									if (json[i]['id'] == selected)
									{
										html += ' selected="selected"';
									}
				
									html += '>' + json[i]['name'] + '</option>';
								}
							}
							else
							{
									$('select[name="sub_category_id"]').parent().hide();
							}
						}
			
						$('select[name="sub_category_id"]').html(html);
						
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		});

	</script>
	{/literal}
{/block}