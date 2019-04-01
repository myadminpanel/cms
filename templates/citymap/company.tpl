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
					{* {if isset($categories) && !empty($categories)}
							<div class="blog-single" style="margin-top:20px">
								<div class="blog-single-text">
										<div class="row">
											{foreach from=$categories item=category}
												<div class="col-md-6"><a href="{$category->link}" class="in-line-element"><img src="{$category->image}" alt="{$category->name}" />{$category->name} ({$category->count})</a></div>
											{/foreach}
										</div>
								</div>
							</div>
					{/if} *}
					<div class="control-items">
						<div class="order-block">
							<span> Sırala: </span>
							<select class="form-control" name="sort">
								<option value="1" {if $order_by.order == 'ASC'}selected="selected"{/if} data-href="{current_url()}?sort=name&order=ASC">  A-Z </option>
								<option value="2" {if $order_by.order == 'DESC'}selected="selected"{/if} data-href="{current_url()}?sort=name&order=DESC"> Z-A </option>
							</select>
						</div>
						<div class="listed-style-block">
							<button type="button" data-product-filter="list" class=" waves-effect btn-style-2 white-border active"> <i class="fas fa-th-large"></i> </button>
							<button type="button" data-product-filter="large" class=" waves-effect btn-style-2 white-border"> <i class="fas fa-list"></i> </button>
						</div>
					</div>
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
	<script type="text/javascript">
		$('select[name="sort"]').on('change', function(){
			let href = $('select[name="sort"] option:selected').data('href');
			window.location.href = href;
		});
	</script>
	{/literal}
{/block}