<div class="row extra-row">
						<aside class=" aside-block ">
							<h4 class="bold-header-16" aria-closed="false" > {translate('filters', true)} </h4>  
							<form action="{site_url_multi('company')}" method="GET">
							
							<div class="form-group">
								<label>{translate('keyword')}</label>
								<input type="text" name="keyword" class="form-control"  value="{$search.keyword}" placeholder="{translate('keyword')}" />
							</div>

							<div class="form-group">
								<label>{translate('parent_category')}</label>
								<select name="parent_category_id" class="form-control">
									<option value="0">{translate('select_parent_category')}</option>
									{if isset($parent_categories) && !empty($parent_categories)}
										{foreach from=$parent_categories item=parent_category}
											<option {if $search.parent_category_id eq $parent_category->id}selected="selected"{/if} value="{$parent_category->id}">{$parent_category->name}</option>
										{/foreach}
									{/if}
								</select>
							</div>

							<div class="form-group">
								<label>{translate('category')}</label>
								<select name="category_id" class="form-control" data-selected="{$search.category_id}"></select>
							</div>

							<div class="form-group" style="display:none">
								<label>{translate('sub_category')}</label>
								<select name="sub_category_id" class="form-control" data-selected="{$search.sub_category_id}"></select>
							</div>

							<div class="form-group">
								<label>{translate('country')}</label>
								<select name="country_id" class="form-control">
									<option value="0">{translate('select_country')}</option>
									{if isset($countries) && !empty($countries)}
										{foreach from=$countries item=country}
											<option {if $search.country_id eq $country->id}selected="selected"{/if}  value="{$country->id}">{$country->name}</option>
										{/foreach}
									{/if}
								</select>
							</div>

							<div class="form-group">
								<label>{translate('region')}</label>
								<select name="region_id" class="form-control" data-selected="{$search.region_id}"></select>
							</div>

							<div class="form-group">
								<label>{translate('district')}</label>
								<select name="district_id" class="form-control" data-selected="{$search.district_id}"></select>
							</div>

							<div class="form-group">
								<label>{translate('metro')}</label>
								<select name="metro_id" class="form-control" data-selected="{$search.metro_id}"></select>
							</div>

							<div class="form-group">
								<label>{translate('distance')}</label>
								<input type="range" name="distance" min="0" max="500" step="5" value="{$search.distance}" data-rangeSlider>
								<input type="hidden" name="latitude" value="" />
								<input type="hidden" name="longitude" value="" />
								<output></output>
							</div>

							<div class="form-group">
								<button type="submit" class=" waves-effect btn-style-1 large green" style="width:100%">{translate('search_button', true)}</button>
							</div>
							{form_close()}
						</aside>
					</div>

{literal}
	<script type="text/javascript">
		(function () {
		var selector = '[data-rangeSlider]',
			elements = document.querySelectorAll(selector);

		function valueOutput(element) {
			var value = element.value,
			output = element.parentNode.getElementsByTagName('output')[0];
			output.innerHTML = value+' km';
		}

		for (var i = elements.length - 1; i >= 0; i--) {
			valueOutput(elements[i]);
		}

		Array.prototype.slice.call(document.querySelectorAll('input[type="range"]')).forEach(function (el) {
			el.addEventListener('input', function (e) {
			valueOutput(e.target);
			}, false);
		});


		 
		// Basic rangeSlider initialization
		rangeSlider.create(elements, {
			// Callback function
			onInit: function () {
			},

			// Callback function
			onSlideStart: function (value, percent, position) {
			console.info('onSlideStart', 'value: ' + value, 'percent: ' + percent, 'position: ' + position);
			},

			// Callback function
			onSlide: function (value, percent, position) {
			console.log('onSlide', 'value: ' + value, 'percent: ' + percent, 'position: ' + position);
			},

			// Callback function
			onSlideEnd: function (value, percent, position) {
			console.warn('onSlideEnd', 'value: ' + value, 'percent: ' + percent, 'position: ' + position);
			}
		});

		 

		})();
	</script>
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
	<script>
	$(document).ready(function(){
		navigator.geolocation.watchPosition(function(position)
		{
			if (navigator.geolocation)
			{
				navigator.geolocation.getCurrentPosition(function(position) {
					if(position.coords.latitude)
					{
						$('input[name="latitude"]').val(position.coords.latitude);
						$('input[name="longitude"]').val(position.coords.longitude);
					}
					else
					{
						$('input[name="distance"]').parent().hide();
					}
				});
			}
		},
		function (error) { 
			if (error.code == error.PERMISSION_DENIED)
				$('input[name="distance"]').parent().hide();
		});
	});
	</script>
	{/literal}