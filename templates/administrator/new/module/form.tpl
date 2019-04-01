{extends file=$layout}
{block name=content}
	<div class="panel panel-white">
		<div class="panel-heading">
			<h5 class="panel-title text-semibold">{$title} <a class="heading-elements-toggle"><i class="icon-more"></i></a></h5>
			<div class="heading-elements"></div>
		</div>

		{if isset($message)}
			<div class="row">
				<div class="col-md-12">
					<div class="alert alert-danger no-border">
						<button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span></button>
						{$message}
					</div>
				</div>
			</div>
		{/if}

		{form_open(current_full_url(), 'class="form-horizontal has-feedback", id="form-save"')}
		<ul class="nav nav-lg nav-tabs nav-tabs-bottom nav-tabs-toolbar no-margin">
			{if isset($form_field.general)}<li class="active"><a href="#general" data-toggle="tab"><i class="icon-earth position-left"></i> General</a></li>{/if}
			{if isset($form_field['translation'])}<li><a href="#translation" data-toggle="tab"><i class="icon-menu7 position-left"></i> Translation</a></li>{/if}
			{if $module_name eq 'company'}<li><a href="#map" data-toggle="tab"><i class="icon-menu7 position-left"></i> Map</a></li>{/if}
			{if $module_name eq 'company'}<li><a href="#working_time" data-toggle="tab"><i class="icon-menu7 position-left"></i> Working Time</a></li>{/if}
			{if $module_name eq 'company' || $module_name eq 'gallery'}<li><a href="#images" data-toggle="tab"><i class="icon-images3 position-left"></i> Images</a></li>{/if}
		</ul> 
		<div class="tab-content">	
			{if isset($form_field['translation'])} 
			<div class="tab-pane" id="translation">
				<div class="panel-body">
					{if !$module_setting->multilingual_required}
					<div class="row">
						<div class="col-md-10">
							<select class="form-control language_list">
								<option value="0">{translate('select', true)}</option>
								{if isset($languages)}
									{foreach $languages as $language}
										{if !in_array($language.id,$selected_languages)}
										<option value="{$language.slug}" data-lang_id="{$language.id}">{$language.name}</option>
										{/if}
									{/foreach}
								{/if}
							</select>
						</div>
						<div class="col-md-2">
							<button type="button" id="add_language" class="btn btn-block btn-primary"><i class="icon-plus2"></i></button>
						</div>
					</div>
					{/if}
				</div>
				<div class="panel-body">					
					<div class="tabbable tab-content-bordered">
						<ul class="nav nav-tabs nav-tabs-highlight nav-justified" id="language">
							{if isset($languages)}
								{foreach $languages as $language}
									<li {if !in_array($language.id,$selected_languages)} 	{if !$module_setting->multilingual_required}style="display:none;"{/if} {/if}>
										<a href="#{$language.slug}" data-toggle="tab">
											{$language.name}
											<img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" alt="{$language.name}" class="pull-left">
											{if !$module_setting->multilingual_required}
												{if $language.id != $default_language_id}
													<span id="remove-{$language.slug}" data-lang="{$language.slug}" data-lang_id="{$language.id}" class="remove_language pull-right"><i class="icon-cross2"></i></span>
												{/if}
											{/if}
										</a>
									</li>
								{/foreach}
							{/if}
						</ul> 
						<div class="tab-content">
							{if isset($languages)}
								{foreach $languages as $language}
									<div class="tab-pane active" id="{$language.slug}">									
										<div class="panel-body">
											<fieldset class="content-group">
												{foreach from=$form_field['translation'][{$language.id}] key=field_key item=field_value}
													<div class="form-group {if form_error($field_value.name)}has-error{/if}">
														{form_label($field_value.label, $field_key, ['class' => 'control-label col-md-2'])}
														<div class="col-md-10">
															{form_element($field_value)}
															{form_error($field_value.name)}
														</div>
													</div>
												{/foreach}																		
											</fieldset>
										</div>					
									</div>
								{/foreach}
							{/if}
						</div>								
					</div>
				</div>
			</div>
			{/if} 
			{if isset($form_field.general)} 
			<div class="tab-pane active" id="general">
				<div class="panel-body">
					{foreach from=$form_field.general key=field_key item=field_value}
						<div class="form-group {if form_error($field_value.name)}has-error{/if}">
							{form_label($field_value.label, $field_key, ['class' => 'control-label col-md-2'])}
							<div class="col-md-10">
								{form_element($field_value)}
								{form_error($field_value.name)}
							</div>
						</div>
					{/foreach}
				</div>
			</div>
			{/if} 
			{if $module_name eq 'company'}
			<div class="tab-pane" id="map">
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12"><div id="mapset" data-lat='{if $latitude}{$latitude}{else}40.409264{/if}' data-lng='{if $longitude}{$longitude}{else}49.867092{/if}' style="height:500px;margin-bottom:30px;"></div></div>
					</div>
					
					<div class="form-group row">
						<label class="control-label col-md-1">Axtar</label>
						<div class="col-md-5">
							<select class="selectpicker  with-ajax" data-live-search="true" data-width="100%">
							</select>
						</div>
						<div class="col-md-3">
							<select name="address" class="form-control col-md-6">
								<option></option>
							</select>
						</div>
					</div>

					<div class="row">
						<div class="col-md-12">
							<input id="pac-input" class="form-control" type="text" placeholder="Search Box">
							<div id="map2" data-lat='{if $latitude}{$latitude}{else}40.409264{/if}' data-lng='{if $latitude}{$latitude}{else}49.867092{/if}' style="height:500px;margin-bottom:30px;"></div>
						</div>
					</div>

					<div class="form-group">
						<label>Latitude</label>
						<input type="text" name="latitude" value="{$latitude}" id="latitude" class="form-control" placeholder="Latitude" />
					</div>
					<div class="form-group">
						<label>Longitude</label>
						<input type="text" name="longitude" value="{$longitude}" id="longitude" class="form-control" placeholder="Longitude" />
					</div>
				</div>
			</div>
			{literal}
			<script src='https://cdnjs.cloudflare.com/ajax/libs/ajax-bootstrap-select/1.3.8/js/ajax-bootstrap-select.min.js'></script>
			<script type="text/javascript">
				var options = {
					values: "a, b, c",
					ajax: {
						url: "administrator/street/ajaxSearch",
						type: "GET",
						dataType: "json"
					},
					locale: {
						emptyTitle: "Küçənin adını daxil edin"
					},
					log: 3,
					preprocessData: function(data) {
						var i,
						l = data.length,
						array = [];
						if (l) {
							for (i = 0; i < l; i++) {
								array.push(
									$.extend(true, data[i], {
										text: data[i].name,
										value: data[i].id
									})
								);
							}
						}
						return array;
					}
				};

				$(".selectpicker")
				.selectpicker()
				.filter(".with-ajax")
				.ajaxSelectPicker(options);
				$("select").trigger("change");

				function chooseSelectpicker(index, selectpicker) {
					$(selectpicker).val(index);
					$(selectpicker).selectpicker('refresh');
					street(index);
					console.log(index);
				}

				$('.selectpicker').on('change', function(){
					let street_id = this.value;
					var html = '';
					$.ajax({
						type: "GET",
						url: '/administrator/address/ajaxAddress',
						data: {'street_id': street_id},
						dataType: 'json',
						success: function (response) {
							if(response)
							{
								html += '<option data-lat="" data-lng="" value="">Seçin</option>';
								for(var i=0; i < response.length; i++)
								{
									html += '<option data-lat="'+response[i].latitude+'" data-lng="'+response[i].longitude+'" value="'+response[i].id+'">'+response[i].name+'</option>';
								}

								$('select[name="address"]').html(html);
								$('select[name="address"]').select2();
							}
						},
						error: function(jqXHR, textStatus, errorThrown) {
							console.log(textStatus, errorThrown);
						}
					});
				});

				$('select[name="address').on('change', function(){
					let bu = $(this).children("option:selected");
					let lat =bu.data('lat');
					let lng =bu.data('lng');

					document.getElementById('latitude').value = lat;
					document.getElementById('longitude').value = lng;
					$('#latitude').trigger('change');
				});
			</script>
			{/literal}
			{/if}

			{if $module_name eq 'company' || $module_name eq 'gallery'}
			<div class="tab-pane" id="images">
				<div class="panel-body">
					<div class="row text-center">
						<button type="button" class="btn btn-success select_images"><i class="con-images2"></i> Select images</button>
						<input type="file" name="file[]" id="multi_images" multiple style="display:none">
					</div>
					<div id="image_area" class="row">
						{if isset($images) && !empty($images)}
							{foreach from=$images item=image}
								<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12">
									<div class="thumbnail">
										<div class="thumb">
											<img src="{$image->preview}" alt="{$image->name}">
											<div class="caption-overflow">
												<span>
													<a href="#" class="remove_image btn border-white text-white btn-flat btn-icon btn-rounded"><i class="icon-cross2"></i></a>
												</span>
											</div>
										</div>
										<div class="caption">
											<input type="hidden" name="images[]" value="{$image->path}">
											<span class="text-regular">{$image->name}</span>
										</div>
									</div>
								</div>
							{/foreach}
						{/if}
					</div>
				</div>
			</div>
			{/if}
			{if $module_name eq 'company'}
			<div class="tab-pane" id="working_time">
				<div class="panel-body">
					<div class="row">
						<div class="col-md-6">
							<div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="checkbox-inline">
											<input type="checkbox" name="workday[1][status]" {if $workdays && (isset($workdays[1]['status']) && $workdays[1]['status'])}checked="checked"{/if}" class="styled" checked="checked">
											<strong>{translate('monday')}</strong>
										</label>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-group">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('start_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[1][start_time]" value="{if $workdays}{$workdays[1]['start_time']}{else}09:00{/if}" class="form-control form-control for-datepicker-l" placeholder="09:00" />
													</div>
												</div>
											</div>

											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('end_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[1][end_time]" value="{if $workdays}{$workdays[1]['end_time']}{else}18:00{/if}" class="form-control form-control for-datepicker-l" placeholder="18:00" />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="checkbox-inline">
											<input type="checkbox" name="workday[2][status]" {if $workdays && (isset($workdays[2]['status']) && $workdays[2]['status'])}checked="checked"{/if}" class="styled" checked="checked">
											<strong>{translate('tuesday')}</strong>
										</label>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-group">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('start_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[2][start_time]" value="{if $workdays}{$workdays[2]['start_time']}{else}09:00{/if}" class="form-control form-control for-datepicker-l" placeholder="09:00" />
													</div>
												</div>
											</div>

											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('end_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[2][end_time]" value="{if $workdays}{$workdays[2]['end_time']}{else}18:00{/if}" class="form-control form-control for-datepicker-l" placeholder="18:00" />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="checkbox-inline">
											<input type="checkbox" name="workday[3][status]" {if $workdays && (isset($workdays[3]['status']) && $workdays[3]['status'])}checked="checked"{/if}" class="styled" checked="checked">
											<strong>{translate('wednesday')}</strong>
										</label>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-group">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('start_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[3][start_time]" value="{if $workdays}{$workdays[3]['start_time']}{else}09:00{/if}" class="form-control form-control for-datepicker-l" placeholder="09:00" />
													</div>
												</div>
											</div>

											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('end_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[3][end_time]" value="{if $workdays}{$workdays[3]['end_time']}{else}18:00{/if}" class="form-control form-control for-datepicker-l" placeholder="18:00" />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="checkbox-inline">
											<input type="checkbox" name="workday[4][status]" {if $workdays && (isset($workdays[4]['status']) && $workdays[4]['status'])}checked="checked"{/if}" class="styled" checked="checked">
											<strong>{translate('thursday')}</strong>
										</label>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-group">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('start_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[4][start_time]" value="{if $workdays}{$workdays[4]['start_time']}{else}09:00{/if}" class="form-control form-control for-datepicker-l" placeholder="09:00" />
													</div>
												</div>
											</div>

											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('end_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[4][end_time]" value="{if $workdays}{$workdays[4]['end_time']}{else}18:00{/if}" class="form-control form-control for-datepicker-l" placeholder="18:00" />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="checkbox-inline">
											<input type="checkbox" name="workday[5][status]" {if $workdays && (isset($workdays[5]['status']) && $workdays[5]['status'])}checked="checked"{/if}" class="styled" checked="checked">
											<strong>{translate('friday')}</strong>
										</label>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-group">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('start_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[5][start_time]" value="{if $workdays}{$workdays[5]['start_time']}{else}09:00{/if}" class="form-control form-control for-datepicker-l" placeholder="09:00" />
													</div>
												</div>
											</div>

											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('end_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[5][end_time]" value="{if $workdays}{$workdays[5]['end_time']}{else}18:00{/if}" class="form-control form-control for-datepicker-l" placeholder="18:00" />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="checkbox-inline">
											<input type="checkbox" name="workday[6][status]" {if $workdays && (isset($workdays[6]['status']) && $workdays[6]['status'])}checked="checked"{/if}" class="styled">
											<strong>{translate('saturday')}</strong>
										</label>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-group">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('start_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[6][start_time]" value="{if $workdays}{$workdays[6]['start_time']}{else}09:00{/if}" class="form-control form-control for-datepicker-l" placeholder="09:00" />
													</div>
												</div>
											</div>

											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('end_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[6][end_time]" value="{if $workdays}{$workdays[6]['end_time']}{else}14:00{/if}" class="form-control form-control for-datepicker-l" placeholder="18:00" />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="checkbox-inline">
											<input type="checkbox" name="workday[0][status]" {if $workdays && (isset($workdays[0]['status']) && $workdays[0]['status'])}checked="checked"{/if}" class="styled">
											<strong>{translate('sunday')}</strong>
										</label>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-group">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('start_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[0][start_time]" value="{if $workdays}{$workdays[0]['start_time']}{/if}" class="form-control form-control for-datepicker-l" placeholder="09:00" />
													</div>
												</div>
											</div>

											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('end_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[0][end_time]" value="{if $workdays}{$workdays[0]['end_time']}{/if}" class="form-control form-control for-datepicker-l" placeholder="18:00" />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<label class="checkbox-inline">
											<input type="checkbox" name="workday[dinner][status]" {if $workdays && (isset($workdays['dinner']['status']) && $workdays['dinner']['status'])}checked="checked"{/if}" class="styled">
											<strong>{translate('dinner')}</strong>
										</label>
									</div>
								</div>
								<div class="col-md-9">
									<div class="form-group">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('start_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[dinner][start_time]" value="{if $workdays}{$workdays['dinner']['start_time']}{else}13:00{/if}" class="form-control form-control for-datepicker-l" placeholder="09:00" />
													</div>
												</div>
											</div>

											<div class="col-md-6">
												<div class="form-group">
													<label class="col-lg-6 control-label"><strong>{translate('end_time')}</strong></label>
													<div class="col-lg-6">
														<input type="text" name="workday[dinner][end_time]" value="{if $workdays}{$workdays['dinner']['end_time']}{else}14:00{/if}" class="form-control form-control for-datepicker-l" placeholder="18:00" />
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			{/if}
		</div> 
		{if !$module_setting->multilingual_required}<input type="hidden" name="selected_languages" value="{if $selected_languages}{','|implode:$selected_languages}{/if}">{/if}
		{if $module_setting->multilingual_required}<input type="hidden" name="selected_languages" value="1,2,3,4">{/if}
		{form_close()}
	</div>
	<script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
	<script>
		var slugGeneratorUrl = "{site_url_multi($admin_url)}/{$module_name}/slugGenerator";
		var moduleUrl = "{site_url_multi($admin_url)}/{$module_name}";
		var item_id = "{$item_id}";
		{literal}
		// Slug generator
		$(document).ready(function(){
			var slug_filed = $("input.slugField");
			if(slug_filed.length > 0){
				let slug_for = $("input.slugField:first").data('for');
				let slug_type = $("input.slugField:first").data('type');

				if(slug_type == 'translation'){
					$( "input.slugField" ).each(function(index) {
						let lang_id = $(this).data('lang-id');
						$("input[name='translation["+lang_id+"]["+slug_for+"]']").on('keyup', function (e) {
							let text = $(this).val();
							if(text){
								$.ajax({
									type: 'post',
									url: slugGeneratorUrl,
									dataType: 'json',
									data : {lang_id:lang_id,text:text,item_id:item_id},
									success: function (data) {
										if(data['success']){
											$("input[name='translation["+lang_id+"][slug]']").val(data['slug']);
										}
									}
								});
							}
						}); 
					});
				}
				else if(slug_type == 'general'){
					$("input[name='"+slug_for+"']").on('keyup', function (e) {
						let text = $(this).val();
						if(text){
							$.ajax({
								type: 'post',
								url: slugGeneratorUrl,
								dataType: 'json',
								data : {text:text,item_id:item_id},
								success: function (data) {
									if(data['success']){
										$("input[name='slug']").val(data['slug']);
									}
								}
							});
						}

					}); 
				}
				
			}
		}); 

		// AJAX dropdown
		function selectItem(element) {
			let result_element = $(element).data("element");      
			let id = $(element).data("value"); 
			let text = $(element).data("text");
			$("input#"+result_element).val(id);
			$('input[data-id="'+result_element+'"]').val(text);
			$("ul#"+result_element).css("display","none");
		}

		$('.dropdownSingleAjax').autocomplete({
			source: function(request, response){
				var input = this.element;
				var result_element = $(input).data('id');
				
				// Relation data
				let type  = $(input).data('type');
				let element  = $(input).data('element');

				if(result_element){
					$.ajax({
						type: 'post',
						url: moduleUrl+"/ajaxDropdownSearch",
						dataType: 'json',
						data : {element: element, type: type, keyword: $(input).val()},
						success: function (data) {
							let html = "";
							if(data['success']){
								console.log($("ul#"+result_element));
								$("ul#"+result_element).css("display","block");
								if(data['elements'].length > 0){
									data['elements'].forEach(function(element) {
										html += '<li onclick="selectItem(this)" data-element="'+result_element+'" data-value="'+element.id+'" data-text="'+element.value+'"><a>'+element.value+'</a></li>';
									});
								}
							}
							$("ul#"+result_element).html(html);
						}
					});
					
				}
			},
			minLength: 2,
			delay: 100
		});
		// AJAX dropdown end

		// AJAX multiselect 
		function delSelectedItem(element) {
			result_element = $(element).data('element');
			id = $(element).data('id');

			let selected_items = $('input#'+result_element).val();
			//console.log(selected_items);
			if(selected_items != ""){
			  let arr_selected_items = selected_items.split(",");
			  let index = arr_selected_items.indexOf(""+id);
			  if (index > -1) {
				arr_selected_items.splice(index, 1);
			  }

			  selected_items = arr_selected_items.join();
			  
			}

			$('input#'+result_element).val(selected_items);
			$(element).parent().remove();
		}

		function selectMultiItem(element) {
			let result_element = $(element).data("element");      
			let id = $(element).data("value"); 
			let text = $(element).data("text");
			let selected_items = $('input#'+result_element).val();
			let append_elements = false;
			if(id > 0) {
				if(!selected_items){
					selected_items = id;
					append_elements = true;
				} else {
					let arr_selected_items = selected_items.split(",");
					let index = arr_selected_items.indexOf(""+id);
					if(index == '-1') {
						selected_items += ","+id;
						append_elements = true;
					} else {
						$('input[data-id="'+result_element+'"]').val(null);
						$("ul#"+result_element).css("display","none");
					}
				}
				if(append_elements) {
					$('input#'+result_element).val(selected_items);
					$('input[data-id="'+result_element+'"]').val(null);
					html = '<div id="product-category'+id+'"><i class="icon-minus-circle2" data-element="'+result_element+'" data-id="'+id+'" onclick="delSelectedItem(this);"></i> '+text+'<input type="hidden" value="'+id+'"></div>';
					$("div#"+result_element).append(html);
					$("ul#"+result_element).css("display","none");
				}
				
			}
			

		}
		
		$('.dropdownMultiAjax').autocomplete({
			source: function(request, response){
				var input = this.element;
				var result_element = $(input).data('id');

				// Relation data
				let type  = $(input).data('type');
				let element  = $(input).data('element');

				if(result_element){
					$.ajax({
						type: 'post',
						url: moduleUrl+"/ajaxDropdownSearch",
						dataType: 'json',
						data : {element: element, type: type, keyword: $(input).val()},
						success: function (data) {
							let html = "";
							if(data['success']){
								$("ul#"+result_element).css("display","block");
								if(data['elements'].length > 0){
									data['elements'].forEach(function(element) {
										html += '<li onclick="selectMultiItem(this)" data-element="'+result_element+'" data-value="'+element.id+'" data-text="'+element.value+'"><a>'+element.value+'</a></li>';
									});
								}
							}
							$("ul#"+result_element).html(html);
						}
					});
					
				}
			},
			minLength: 2,
			delay: 100
		});
		// AJAX multiselect end
	{/literal}
	</script>

	{if !$module_setting->multilingual_required}
		<script>
			var default_language = "{$default_language}";
			{literal}
				$('.remove_language').on('click', function(){
					let lang = $(this).data('lang');
					let lang_id = $(this).data('lang_id').toString();
					
					if(lang && lang != default_language && lang_id > 0) {
						$('.language_list option[value="'+lang+'"]').show();
						$('#language a[href="#'+lang+'"]').parent().hide();
						$('#language a[href="#'+default_language+'"]').parent().addClass('active');
						$('div#'+default_language).addClass('active');
						
						// Remove from selected laguages
						let selected_languages = $.trim($('input[name="selected_languages"]').val());
						if(selected_languages) {
							let arr_selected_langs = selected_languages.split(',');
							let lang_index = arr_selected_langs.indexOf(lang_id);
							if(lang_index > -1) {
								arr_selected_langs.splice(lang_index,1);
							}
							if(arr_selected_langs.length > 0) {
								selected_languages = arr_selected_langs.join();
							}
							
							$('input[name="selected_languages"]').val(selected_languages);
						} 

					}
				});

				$('#add_language').on('click', function(){
					let lang = $('.language_list').children("option:selected").val();
					let lang_id = $('.language_list').children("option:selected").data('lang_id');
					
					if(lang && lang != 0 && lang_id > 0) {
						let selected_languages = $.trim($('input[name="selected_languages"]').val());
						if(selected_languages) {
							let arr_selected_langs = selected_languages.split(',');
							if(arr_selected_langs.indexOf(lang_id) == -1) {
								selected_languages += ','+lang_id;
							} else {
								selected_languages = false;
							}
						} else {
							selected_languages = lang_id;
						}
						if(selected_languages != false) {
							$('.language_list').children("option:selected").hide();
							$('.language_list').val(0);
							$('#language a[href="#'+lang+'"]').parent().show();
							//$('div[id="'+lang+'"]').show();			
							$('#language a[href="#'+lang+'"]').tab('show');
							$('input[name="selected_languages"]').val(selected_languages);
						}
					}
				});
			{/literal}
		</script>
	{/if}
	<script type="text/javascript">
		{literal}
		$(function(){ 
			$('input[data-role="orientationinput"]').each(function(){
				$(this).tagsinput({
					typeahead: {
						source: function(query) {
						return $.get('http://someservice.com');
						}
					}
				});		
			});		
		});
		{/literal}
	</script>
	<script type="text/javascript">
		{literal}
		$(function(){
			$('input[data-role="tagsinput"]').each(function(){
				var substringMatcher = function(strs) {
					return function findMatches(q, cb) {
						var tags = [];
						strs = function(params){
							$.ajax({
								type: 'post',
								url: '/administrator/company/ajaxGetTags/',
								data: {keyword: q},
								dataType: 'json',
								async: false,
								success: function (data) {
									tags = data;
								}
							});
							return tags;
						}();


						var matches, substringRegex;
						matches = [];
						substrRegex = new RegExp(q, 'i');

						$.each(strs, function(i, str) {
							if (substrRegex.test(str)) {
								matches.push({ value: str });
							}
						});
						cb(matches);
					};
				};

				// Attach typeahead
				$(this).tagsinput('input').typeahead(
					{
						hint: true,
						highlight: true,
						minLength: 1
					},
					{
						name: 'states',
						displayKey: 'value',
						source: substringMatcher([])
					}
				).bind('typeahead:selected', $.proxy(function (obj, datum) {
					this.tagsinput('add', datum.value);
					this.tagsinput('input').typeahead('val', '');
				}, $(this)));
			});
			
		});
		{/literal}
	</script>
	
	<link rel="stylesheet" href="{$admin_theme}/assets/css/calendar.css">
	<script src="{$admin_theme}/assets/js/calendar.js"></script>
	<script>
	$(function () {
		$('.for-datepicker-l').datetimepicker({
			useCurrent: false,
			icons: {
				time: "fa fa-clock-o",
				date: "icon-calendar3",
				up: "icon-arrow-up12",
				down: "icon-arrow-down12"
			},
			format : 'HH:mm'
		});
	});
	</script>

	{* Multi Image Upload *}
	{literal}
	<script>
		let input_multi = $('#multi_images');
		$('.select_images').on('click', function() {
			$(input_multi).trigger('click');
		});

		input_multi.on('change', function () {
			for (let i = 0; i < $(this)[0].files.length; i++)
			{
				console.log('1');
				data = new FormData();
				data.append('file[]', input_multi[0].files[i]);
				$.ajax({
					url: 'administrator/filemanager/upload?directory=company/',
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
							let image_block = '<div class="col-lg-2 col-md-4 col-sm-6 col-xs-12"><div class="thumbnail"><div class="thumb"><img src="'+response.image+'" alt="'+response.data.file_name+'"><div class="caption-overflow"><span><a href="#" class="remove_image btn border-white text-white btn-flat btn-icon btn-rounded"><i class="icon-cross2"></i></a></span></div></div><div class="caption"><input type="hidden" name="images[]" value="'+response.save+'"><span class="text-regular">'+response.data.file_name+'</span></div></div></div>';
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
	{/literal}

	
	{literal}
	<script>
		let selector = $('.image_upload');
		let id = selector.data('id');
		let folder = selector.data('folder');
		let input = $('#input_single');
		let img = selector.find('img');
		let input_image = $('input[type="hidden"][data-id="'+id+'"]');
		selector.on('click', function() {			
			input.trigger('click');
		});
		input.on('change', function () {
			data = new FormData();
			data.append('file[]', $(this)[0].files[0]);
			$.ajax({
				url: 'administrator/filemanager/upload?directory='+folder,
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
						img.attr('src', response.image);
						input_image.val(response.save);
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
		});

		$('body').delegate('.remove_image', 'click', function(e){
			e.preventDefault();
			$(this).parent().parent().parent().parent().parent().remove();
		});
	</script>
	{/literal}
	{literal}
	<script type="text/javascript">
		$('select[name="country_id"]').on('change', function(){
			let country_id = $(this).children("option:selected").val();
			let selected = $('select[name="region_id"]').data('selected');
			if (country_id) { 
				$.ajax({
					url: '/administrator/region/ajax?column=country_id&country_id='+ country_id,
					dataType: 'json',
					success: function(json) {
						html = '<option value="0">Seçin</option>';
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
						$('select[name="region_id"]').select2();
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
		$('select[name="parent_category_id"]').on('change', function(){
			let parent_category_id = $(this).children("option:selected").val();
			let selected = $('select[name="category_id"]').data('selected');
			if (parent_category_id) { 
				$.ajax({
					url: '/administrator/category/ajax?column=parent_id&parent_id='+ parent_category_id,
					dataType: 'json',
					success: function(json) {
						html = '<option value="0">Seçin</option>';
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
			
						$('select[name="category_id"]').html(html);
						$('select[name="category_id"]').select2();
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
					url: '/administrator/category/ajax?column=parent_id&parent_id='+ category_id,
					dataType: 'json',
					success: function(json) {
						html = '<option value="0">Seçin</option>';
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
			
						$('select[name="sub_category_id"]').html(html);
						$('select[name="sub_category_id"]').select2();
						$('select[name="sub_category_id"]').trigger('change');
						
						
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		});
		$('select[name="category_id"]').trigger('change');
	</script>
	{/literal}
	{literal}
	<script type="text/javascript">
		$('select[name="region_id"]').on('change', function(){
			let region_id = $(this).children("option:selected").val();
			let selected = $('select[name="district_id"]').data('selected');
			if (region_id) { 
				$.ajax({
					url: '/administrator/district/ajax?column=region_id&region_id='+ region_id,
					dataType: 'json',
					success: function(json) {
						html = '<option value="0">Seçin</option>';
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
			
						$('select[name="district_id"]').html(html);
						$('select[name="district_id"]').select2();
						
						
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
			let selected = $('select[name="metro_id"]').data('selected');
			if (region_id) { 
				$.ajax({
					url: '/administrator/metro/ajax?column=region_id&region_id='+ region_id,
					dataType: 'json',
					success: function(json) {
						html = '<option value="0">Seçin</option>';
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
			
						$('select[name="metro_id"]').html(html);
						$('select[name="metro_id"]').select2();
						
						
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
		$('.datepicker').daterangepicker({ 
			singleDatePicker: true,
			locale: {
				format: 'YYYY-MM-DD'
			},
			autoUpdateInput: false
		}, function (chosen_date) {
			$(this.element[0]).val(chosen_date.format('YYYY-MM-DD'));
		});
	</script>
	{/literal}
	{if $module_name eq 'company'}
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBvG6qropBB6jtTSg8NqY97WJCzBHLMI3w&libraries=places&callback=initAutocomplete" async defer></script>
  {/if}
{/block}