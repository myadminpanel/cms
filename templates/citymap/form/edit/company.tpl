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
				<div class="col-lg-3 col-md-12 sm-padding-r p-l">
					<div class="aside-menu-block">
						<ul class="user-profile-menu nav nav-tabs"  role="tablist">
							<li><a class="active"  data-toggle="tab" href="#sector1" >{translate('information')}</a> </li>
							<li><a data-toggle="tab" href="#sector7">{translate('map')}</a></li>
							<li><a data-toggle="tab" href="#sector3">{translate('worktime')}</a></li>
							<li><a data-toggle="tab" href="#sector4">{translate('image')}</a></li>
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
													<input type="text" name="translation[{$language.id}][name]" value="{(set_value('translation['|cat:$language.id|cat:'][name]')) ? set_value('translation['|cat:$language.id|cat:'][name]') : $translation[$language.id]->name }" class="form-control" placeholder="{translate('name')}" />
												</div>
												
												<div class="form-group">
													<label>{translate('address')}</label>
													<input type="text" name="translation[{$language.id}][address]" value="{(set_value('translation['|cat:$language.id|cat:'][address]')) ? set_value('translation['|cat:$language.id|cat:'][address]') : $translation[$language.id]->address }" class="form-control" placeholder="{translate('address')}" />
												</div>
												
												<div class="form-group">
													<label>{translate('description')}</label>
													<textarea class="form-control" name="translation[{$language.id}][description]" placeholder="{translate('description')}" class="form-control">{(set_value('translation['|cat:$language.id|cat:'][description]')) ? set_value('translation['|cat:$language.id|cat:'][description]') : $translation[$language.id]->description }</textarea>
												</div>
											</div>
										{/foreach}
										<div class="form-group">
											<label>{translate('main_image')}</label>
											<div class="image_container">
												<img id="preview_image" src="{if set_value('image')}{base_url('uploads')}/{set_value('image')}{elseif $company->image_preview}{$company->image_preview}{else}{base_url('templates/citymap/assets/image/nophoto.png')}{/if}" class="image" style="" title="{translate('click_and_change_image')}">
												<input type="file" name="file" accept="image/*" style="display:none">
												<input type="hidden" name="image" value="{(set_value('image')) ? set_value('image') : $company->image}">
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
														<option {if set_value('parent_category') && set_value('parent_category') eq $category->id}selected="selected"{elseif $company->parent_category_id eq $category->id}selected="selected"{/if} value="{$category->id}">{$category->name}</option>
													{/foreach}
												{/if}
											</select>
										</div>
										<div class="form-group">
											<label>{translate('category')}</label>
											<select name="category_id" class="form-control" data-selected="{(set_value('category_id')) ? set_value('category_id') : $company->category_id}"></select>
										</div>
										<div class="form-group">
											<label>{translate('sub_category')}</label>
											<select name="sub_category_id" class="form-control" data-selected="{(set_value('sub_category_id')) ? set_value('sub_category_id') : $company->sub_category_id}"></select>
										</div>
										<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('country')}</label>
											<select name="country_id" class="form-control">
												<option value="0">{translate('select_country')}</option>
												{if isset($countries) && !empty($countries)}
													{foreach from=$countries item=country}
														<option {if set_value('country_id') && set_value('country_id') eq $country->id}selected="selected"{elseif $country->id eq $company->country_id}selected="selected"{/if}  value="{$country->id}">{$country->name}</option>
													{/foreach}
												{/if}
											</select>
										</div>
										<div class="form-group">
											<label>{translate('region')}</label>
											<select name="region_id" class="form-control" data-selected="{(set_value('region_id')) ? set_value('region_id') : $company->region_id}"></select>
										</div>
										
										
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('district')}</label>
											<select name="district_id" class="form-control"  data-selected="{(set_value('district_id')) ? set_value('district_id') : $company->district_id}"></select>
										</div>
										<div class="form-group">
											<label>{translate('metro')}</label>
											<select name="metro_id" class="form-control" data-selected="{(set_value('metro_id')) ? set_value('metro_id') : $company->metro_id}"></select>
										</div>
										
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('phone')}</label>
											<input type="text" name="phone" value="{(set_value('phone')) ? set_value('phone') : $company->phone}" class="form-control" placeholder="{translate('phone')}" />
										</div>
										<div class="form-group">
											<label>{translate('mobile')}</label>
											<input type="text" name="mobile" class="form-control" value="{(set_value('mobile')) ? set_value('mobile') : $company->mobile}" placeholder="{translate('mobile')}" />
										</div>
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('fax')}</label>
											<input type="text" name="fax" class="form-control" value="{(set_value('fax')) ? set_value('fax') : $company->fax}"  placeholder="{translate('fax')}" />
										</div>
										<div class="form-group">
											<label>{translate('email')}</label>
											<input type="text" name="email" class="form-control" value="{(set_value('email')) ? set_value('email') : $company->email}" placeholder="{translate('email')}" />
										</div>
										
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('website')}</label>
											<input type="text" name="website" class="form-control" value="{(set_value('website')) ? set_value('website') : $company->website}" placeholder="{translate('website')}" />
										</div>
										<div class="form-group">
											<label>{translate('facebook')}</label>
											<input type="text" name="facebook" class="form-control" value="{(set_value('facebook')) ? set_value('facebook') : $company->facebook}" placeholder="{translate('facebook')}" />
										</div>
										
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('instagram')}</label>
											<input type="text" name="instagram" class="form-control" value="{(set_value('instagram')) ? set_value('instagram') : $company->instagram}" placeholder="{translate('instagram')}" />
										</div>
										<div class="form-group">
											<label>{translate('twitter')}</label>
											<input type="text" name="twitter" class="form-control"  value="{(set_value('twitter')) ? set_value('twitter') : $company->twitter}" placeholder="{translate('twitter')}" />
										</div>
										
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('linkedin')}</label>
											<input type="text" name="linkedin" class="form-control"  value="{(set_value('linkedin')) ? set_value('linkedin') : $company->linkedin}" placeholder="{translate('linkedin')}" />
										</div>
										<div class="form-group">
											<label>{translate('vk')}</label>
											<input type="text" name="vk" class="form-control"  value="{(set_value('vk')) ? set_value('vk') : $company->vk}" placeholder="{translate('vk')}" />
										</div>
									</div>

									<div class="d-flex flex-48 space-between">
										<div class="form-group">
											<label>{translate('ok')}</label>
											<input type="text" name="ok" class="form-control"  value="{(set_value('ok')) ? set_value('ok') : $company->ok}" placeholder="{translate('ok')}" />
										</div>
									</div>
									</div>
									<div class="form-group">
										<button type="button" data-id="sector7" data-current-id="sector1" class="continue waves-effect btn-style-1 large green">{translate('continue')}</button>
									</div>
								</div>
							</form>
						</div>
						<div id="sector7" class=" tab-pane fade comment-block">
							<div id="mapset" data-lat='{(set_value('latitude')) ? set_value('latitude') : ($company->latitude) ? $company->latitude : '40.409264'}' data-lng='{(set_value('longitude')) ? set_value('longitude') : ($company->longitude) ? $company->longitude : '49.867092'}' style="height:500px;margin-bottom:30px;"></div>
							<div class="form-group">
								<label>{translate('latitude')}</label>
								<input type="text" name="latitude"  value="{(set_value('latitude')) ? set_value('latitude') : $company->latitude}" id="latitude" class="form-control" placeholder="{translate('latitude')}" />
							</div>
							<div class="form-group">
								<label>{translate('longitude')}</label>
								<input type="text" name="longitude" value="{(set_value('longitude')) ? set_value('longitude') : $company->longitude}" id="longitude" class="form-control" placeholder="{translate('longitude')}" />
							</div>
							<div class="form-group">
								<button type="button" data-id="sector3" data-current-id="sector7" class="continue waves-effect btn-style-1 large green">{translate('continue')}</button>
							</div>
						</div>
						<div id="sector3" class=" tab-pane fade comment-block">
							<div class="form-group">
								<label {if ($workday[1]['status'] eq 1) || set_value('workday[1][status]') eq 'on'}class="checked checkbox-style selected"{/if}><input type="checkbox" name="workday[1][status]" {if ($workday[1]['status'] eq 1) || set_value('workday[1][status]') eq 'on'}checked="checked"{/if}> {translate('monday')}</label>
							</div>
							<div class="form-group row">
								<div class="col-md-6">
									<label>{translate('start_time')}</label>
									<input type="text" name="workday[1][start_time]" class="form-control" value="{(set_value('workday[1][start_time]')) ? set_value('workday[1][start_time]') : (isset($workday[1]['start_time'])) ? $workday[1]['start_time'] : '09:00'}">
								</div>
								<div class="col-md-6">
									<label>{translate('end_time')}</label>
									<input type="text" name="workday[1][end_time]" class="form-control" value="{(set_value('workday[1][end_time]')) ? set_value('workday[1][end_time]') : (isset($workday[1]['end_time'])) ? $workday[1]['end_time'] : '18:00'}">
								</div>
							</div>
							<div class="form-group">
								<label {if ($workday[2]['status'] eq 1) || set_value('workday[2][status]') eq 'on'}class="checked checkbox-style selected"{/if}><input type="checkbox" name="workday[2][status]" {if ($workday[2]['status'] eq 1) || set_value('workday[2][status]') eq 'on'}checked="checked"{/if}> {translate('tuesday')}</label>
							</div>
							<div class="form-group row">
								<div class="col-md-6">
									<label>{translate('start_time')}</label>
									<input type="text" name="workday[2][start_time]" class="form-control" value="{(set_value('workday[2][start_time]')) ? set_value('workday[2][start_time]') : (isset($workday[2]['start_time'])) ? $workday[2]['start_time'] : '09:00'}">
								</div>
								<div class="col-md-6">
									<label>{translate('end_time')}</label>
									<input type="text" name="workday[2][end_time]" class="form-control" value="{(set_value('workday[2][end_time]')) ? set_value('workday[2][end_time]') : (isset($workday[2]['end_time'])) ? $workday[2]['end_time'] : '18:00'}">
								</div>
							</div>
							<div class="form-group">
								<label {if ($workday[3]['status'] eq 1) || set_value('workday[3][status]') eq 'on'}class="checked checkbox-style selected"{/if}><input type="checkbox" name="workday[3][status]" {if ($workday[3]['status'] eq 1) || set_value('workday[3][status]') eq 'on'}checked="checked"{/if}> {translate('wednesday')}</label>
							</div>
							<div class="form-group row">
								<div class="col-md-6">
									<label>{translate('start_time')}</label>
									<input type="text" name="workday[3][start_time]" class="form-control" value="{(set_value('workday[3][start_time]')) ? set_value('workday[3][start_time]') : (isset($workday[3]['start_time'])) ? $workday[3]['start_time'] : '09:00'}">
								</div>
								<div class="col-md-6">
									<label>{translate('end_time')}</label>
									<input type="text" name="workday[3][end_time]" class="form-control" value="{(set_value('workday[3][end_time]')) ? set_value('workday[3][end_time]') : (isset($workday[3]['end_time'])) ? $workday[3]['end_time'] : '18:00'}">
								</div>
							</div>
							<div class="form-group">
								<label {if ($workday[4]['status'] eq 1) || set_value('workday[4][status]') eq 'on'}class="checked checkbox-style selected"{/if}><input type="checkbox" name="workday[4][status]" {if ($workday[4]['status'] eq 1) || set_value('workday[4][status]') eq 'on'}checked="checked"{/if}> {translate('thursday')}</label>
							</div>
							<div class="form-group row">
								<div class="col-md-6">
									<label>{translate('start_time')}</label>
									<input type="text" name="workday[4][start_time]" class="form-control" value="{(set_value('workday[4][start_time]')) ? set_value('workday[4][start_time]') : (isset($workday[4]['start_time'])) ? $workday[4]['start_time'] : '09:00'}">
								</div>
								<div class="col-md-6">
									<label>{translate('end_time')}</label>
									<input type="text" name="workday[4][end_time]" class="form-control" value="{(set_value('workday[4][end_time]')) ? set_value('workday[4][end_time]') : (isset($workday[4]['end_time'])) ? $workday[4]['end_time'] : '18:00'}">
								</div>
							</div>
							<div class="form-group">
								<label {if ($workday[5]['status'] eq 1) || set_value('workday[5][status]') eq 'on'}class="checked checkbox-style selected"{/if}><input type="checkbox" name="workday[5][status]" {if ($workday[5]['status'] eq 1) || set_value('workday[5][status]') eq 'on'}checked="checked"{/if}> {translate('friday')}</label>
							</div>
							<div class="form-group row">
								<div class="col-md-6">
									<label>{translate('start_time')}</label>
									<input type="text" name="workday[5][start_time]" class="form-control" value="{(set_value('workday[5][start_time]')) ? set_value('workday[5][start_time]') : (isset($workday[5]['start_time'])) ? $workday[5]['start_time'] : '09:00'}">
								</div>
								<div class="col-md-6">
									<label>{translate('end_time')}</label>
									<input type="text" name="workday[5][end_time]" class="form-control" value="{(set_value('workday[5][end_time]')) ? set_value('workday[5][end_time]') : (isset($workday[5]['end_time'])) ? $workday[5]['end_time'] : '18:00'}">
								</div>
							</div>
							<div class="form-group">
								<label {if ($workday[6]['status'] eq 1) || set_value('workday[6][status]') eq 'on'}class="checked checkbox-style selected"{/if}><input type="checkbox" name="workday[6][status]" {if ($workday[6]['status'] eq 1) || set_value('workday[6][status]') eq 'on'}checked="checked"{/if}> {translate('saturday')}</label>
							</div>
							<div class="form-group row">
								<div class="col-md-6">
									<label>{translate('start_time')}</label>
									<input type="text" name="workday[6][start_time]" class="form-control" value="{(set_value('workday[6][start_time]')) ? set_value('workday[6][start_time]') : (isset($workday[6]['start_time'])) ? $workday[6]['start_time'] : ''}">
								</div>
								<div class="col-md-6">
									<label>{translate('end_time')}</label>
									<input type="text" name="workday[6][end_time]" class="form-control" value="{(set_value('workday[6][end_time]')) ? set_value('workday[6][end_time]') : (isset($workday[6]['end_time'])) ? $workday[6]['end_time'] : ''}">
								</div>
							</div>
							<div class="form-group">
								<label {if ($workday[0]['status'] eq 1) || set_value('workday[0][status]') eq 'on'}class="checked checkbox-style selected"{/if}><input type="checkbox" name="workday[0][status]" {if ($workday[0]['status'] eq 1) || set_value('workday[0][status]') eq 'on'}checked="checked"{/if}> {translate('sunday')}</label>
							</div>
							<div class="form-group row">
								<div class="col-md-6">
									<label>{translate('start_time')}</label>
									<input type="text" name="workday[0][start_time]" class="form-control" value="{(set_value('workday[0][start_time]')) ? set_value('workday[0][start_time]') : (isset($workday[0]['start_time'])) ? $workday[0]['start_time'] : ''}">
								</div>
								<div class="col-md-6">
									<label>{translate('end_time')}</label>
									<input type="text" name="workday[0][end_time]" class="form-control" value="{(set_value('workday[0][end_time]')) ? set_value('workday[0][end_time]') : (isset($workday[0]['end_time'])) ? $workday[0]['end_time'] : ''}">
								</div>
							</div>
							<div class="form-group">
								<label {if ($workday['dinner']['status'] eq 1) || set_value('workday[dinner][status]') eq 'on'}class="checked checkbox-style selected"{/if}><input type="checkbox" name="workday[dinner][status]" {if ($workday['dinner']['status'] eq 1) || set_value('workday[dinner][status]') eq 'on'}checked="checked"{/if}> {translate('dinner')}</label>
							</div>
							<div class="form-group row">
								<div class="col-md-6">
									<label>{translate('start_time')}</label>
									<input type="text" name="workday[dinner][start_time]" class="form-control" value="{(set_value('workday[dinner][start_time]')) ? set_value('workday[dinner][start_time]') : (isset($workday['dinner']['start_time'])) ? $workday['dinner']['start_time'] : ''}">
								</div>
								<div class="col-md-6">
									<label>{translate('end_time')}</label>
									<input type="text" name="workday[dinner][end_time]" class="form-control" value="{(set_value('workday[dinner][end_time]')) ? set_value('workday[dinner][end_time]') : (isset($workday['dinner']['end_time'])) ? $workday['dinner']['end_time'] : ''}">
								</div>
							</div>
							<div class="form-group">
								<button type="button" data-id="sector4" data-current-id="sector3"  class="continue waves-effect btn-style-1 large green">{translate('continue')}</button>
							</div>
						</div>
						<div id="sector4" class=" tab-pane fade comment-block">
							<div class="image_uploader">
								<button type="button" class="waves-effect btn-style-1 large green select_images"><i class="con-images2"></i> Şəkil seçin</button>
								<input type="file" name="file[]" id="multi_images" multiple style="display:none">
							</div>
							<div id="image_area" class="row">
							{if isset($images) && !empty($images)}
								{foreach from=$images item=image}
									<div class="col-md-4">
										<img class="img-thumbnail thumb" src="{$image->preview}">
										<input type="hidden" name="images[]" value="{$image->path}">
										<button type="button" class="remove_images btn btn-danger btn-block"><i class="fas fa-trash-alt"></i></button>
									</div>
								{/foreach}
							{/if}
							</div>
							<div class="form-group">
								<br/>
								<button type="submit"  class="continue waves-effect btn-style-1 large green">{translate('update')}</button>
							</div>
						</div>
					</div>
					{form_close()}
				</div>
			</div>
		</div>
	</section>
	{literal}
	<script>
		$('.continue').on('click', function(){
			let id = $(this).data('id');
			let current_id = $(this).data('current-id');
			$('.nav-tabs a[href="#' + id + '"]').tab('show');
		});
	</script>
	{/literal}
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
	.thumb {
		padding: 10px;
		border: 1px solid #dfdfdf;
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
							var image_block = '<div class="col-md-4"><img class="img-thumbnail thumb" src="'+response.image+'" alt="'+response.data.file_name+'"><input type="hidden" name="images[]" value="'+response.save+'"><button class="btn btn-danger btn-block" type="button" class="remove_image"><i class="fas fa-trash-alt"></i></button</div>';
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
	<script type="text/javascript">
		$('select[name=\'parent_category_id\']').on('change', function() {
			var element = this;
			
			if (element.value) { 
				$.ajax({
					url: '/az/category/ajax?category_id='+ element.value,
					dataType: 'json',
					success: function(json) {
						html = '<option value="0">Seçin</option>';
						if (json['categories'] && json['categories'] != '') {	
							for (i = 0; i < json['categories'].length; i++) {
								html += '<option value="' + json['categories'][i]['category_id'] + '"';
								if (json['categories'][i]['category_id'] == $(element).data('category-id')) {
									html += ' selected="selected"';
								}
			
								html += '>' + json['categories'][i]['name'] + '</option>';
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
						$('select[name="category_id"]').trigger('change');
						
						
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
	{literal}
	<script>
		var mapid = 'mapset';
			var lat = parseFloat($("#" + mapid).attr("data-lat"));
			var lng = parseFloat($("#" + mapid).attr("data-lng"));

			var map = L.map(mapid, {
				center  : [lat,lng],
				center: [lat, lng],
				zoom: 12,
				fullscreenControl: true
			})
			var myIcon = L.icon({
				iconUrl: '/templates/citymap/assets/css/icons/google/marker.png',
				iconSize: [65, 80],
				iconAnchor: [22, 94],
				popupAnchor: [-3, -76]
			});
			var marker = L.marker([lat,lng], {icon: myIcon, draggable: true}).addTo(map);
		
			var Esri_WorldGrayCanvas = L.tileLayer('https://map.citymap.az/osm_tiles/{z}/{x}/{y}.png', {
				attribution: 'CityMap',
				maxZoom: 18
			});
			map.addLayer(Esri_WorldGrayCanvas); 

			marker.addTo(map); // Adding marker to the map

			marker.on('dragend', function (e) {
				document.getElementById('latitude').value = marker.getLatLng().lat;
				document.getElementById('longitude').value = marker.getLatLng().lng;
			});

			map.panTo(new L.LatLng(lat, lng));


			$('.continue').on('click', function(){
				let id = $(this).data('id');
				map.panTo(new L.LatLng(lat, lng));
				map.setView(new L.LatLng(lat, lng), 12, { animation: true });

				map.invalidateSize(true);
				map.locate({setView: true}, 12);
				let current_id = $(this).data('current-id');
				$('.nav-tabs a[href="#' + id + '"]').tab('show');
			});

		

			

		$('.remove_images').on('click', function(){
			$(this).parent().remove();
		});
	</script>
	{/literal}
{/block}