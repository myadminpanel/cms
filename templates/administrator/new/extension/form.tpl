{extends file=$layout}
{block name=content}
<div class="panel panel-white">
	<div class="panel-heading">
		<h5 class="panel-title text-semibold">{$title} <a class="heading-elements-toggle"><i class="icon-more"></i></a></h5>
		<div class="heading-elements"></div>
	</div> 
	{if isset($message) && !empty($message)}
		<!-- Show form error -->
		<div class="row">
			<div class="col-md-12">
				<div class="alert alert-danger no-border">
					<button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span></button>
					{$message}
				</div>
			</div>
		</div>
		<!-- End show form error -->
	{/if} 
	{form_open(current_url(), 'class="form-horizontal has-feedback", id="form-save"')}
	<!-- Tabs -->	
	<ul class="nav nav-lg nav-tabs nav-tabs-bottom nav-tabs-toolbar no-margin">
		<li class="active"><a href="#general" data-toggle="tab"><i class="icon-grid4 position-left"></i> {translate('tab_general')}</a></li>
		<li><a href="#text" data-toggle="tab"><i class="icon-paragraph-justify2 position-left"></i> {translate('tab_text')}</a></li>
		<li><a href="#fields" data-toggle="tab"><i class="icon-paragraph-justify2 position-left"></i> {translate('tab_fields')}</a></li>
		<li><a href="#permissions" data-toggle="tab"><i class="icon-list position-left"></i> {translate('tab_permissions')}</a></li>
		<li><a href="#front" data-toggle="tab"><i class="icon-design"></i> {translate('tab_front')}</a></li>
	</ul>
	<!-- End tabs -->

	<!-- Tab content -->
	<div class="tab-content">
		<!-- General tab -->
		<div class="tab-pane active" id="general">
			<div class="panel-body">
				{foreach from=$form_field.general key=$field_key item=$field_value}
					<div class="form-group {if form_error($field_key)}has-error{/if}">
						{form_label($field_value.label, $field_key, ['class' => 'control-label col-md-2'])}
						<div class="col-md-10">
							{form_element($field_value)}
							{form_error($field_value.name)}
						</div>
					</div>
				{/foreach}
			</div>
		</div>
		<!-- End general tab -->

        <!-- Front tab -->
		<div class="tab-pane active" id="front">
			<div class="panel-body">
				{foreach from=$form_field.front key=$field_key item=$field_value}
					<div class="form-group {if form_error($field_key)}has-error{/if}">
						{form_label($field_value.label, $field_key, ['class' => 'control-label col-md-2'])}
						<div class="col-md-10">
							{form_element($field_value)}
							{form_error($field_value.name)}
						</div>
					</div>
				{/foreach}
			</div>
		</div>
		<!-- End general tab -->

		<!-- Permissions tab -->
		<div class="tab-pane" id="permissions">
			<table class="table table-bordered table-striped table-responsive">
				<thead>
					<tr>
						<th>Permission</th>
						<th>Admin</th>
						<th>Public</th>
						<th>Default</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Index</td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
					</tr>
					<tr>
						<td>Trash</td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
					</tr>
					<tr>
						<td>Create</td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
					</tr>
					<tr>
						<td>Edit</td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
					</tr>
					<tr>
						<td>Delete</td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
					</tr>
					<tr>
						<td>Remove</td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
					</tr>
					<tr>
						<td>Restore</td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
					</tr>
					<tr>
						<td>Clean</td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
					</tr>
					<tr>
						<td>Show</td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
						<td><input type="checkbox" name="" class="styled"></td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- End breadcrumb tab -->

		<!-- Title tab -->
		<div class="tab-pane" id="text">
			<div class="panel-body">
				<div class="row">
					<div class="col-md-6">
						<h6>{translate('text_index')}</h6>					
						<div class="tabbable nav-tabs-vertical nav-tabs-left">
							<ul class="nav nav-tabs nav-tabs-highlight" style="width:200px !important">
								<li class="active"><a href="#index_title" data-toggle="tab" aria-expanded="true"> {translate('text_tab_title')}</a></li>
								<li><a href="#index_subtitle" data-toggle="tab" aria-expanded="true">  {translate('text_tab_subtitle')}</a></li>
							</ul>

							<div class="tab-content">
								<div class="tab-pane active" id="index_title">
									{if isset($languages)}
										{foreach from=$languages key=language_code item=language}
											{if $language.admin == 1}
												{assign var="setvalue" value='text[index][title]['|cat:$language.code|cat:']'}
												<div class="form-group">	
													<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
														<input type="text" name="text[index][title][{$language.code}]" value="{(isset($text.index.title[$language.code])) ? $text.index.title[$language.code] : set_value($setvalue) }" placeholder="{translate('text_index_title')}" class="form-control">
													</div>
												</div>
											{/if}
										{/foreach}
									{/if}
								</div>

								<div class="tab-pane" id="index_subtitle">
									{if isset($languages)}
										{foreach from=$languages key=language_code item=language}
											{if $language.admin == 1}
												{assign var="setvalue" value='text[index][subtitle]['|cat:$language.code|cat:']'}
												<div class="form-group">	
													<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
														<input type="text" name="text[index][subtitle][{$language.code}]" value="{(isset($text.index.subtitle[$language.code])) ? $text.index.subtitle[$language.code] : set_value($setvalue) }" placeholder="{translate('text_index_subtitle')}" class="form-control">
													</div>
												</div>
											{/if}
										{/foreach}
									{/if}
								</div>

							</div>
						</div>                                       
					</div>
					<div class="col-md-6">
						<h6>{translate('text_trash')}</h6>					
						<div class="tabbable nav-tabs-vertical nav-tabs-left">
							<ul class="nav nav-tabs nav-tabs-highlight" style="width:200px !important">
								<li class="active"><a href="#trash_title" data-toggle="tab" aria-expanded="true"> {translate('text_tab_title')}</a></li>
								<li><a href="#trash_subtitle" data-toggle="tab" aria-expanded="true">  {translate('text_tab_subtitle')}</a></li>
							</ul>

							<div class="tab-content">
								<div class="tab-pane active" id="trash_title">
									{if isset($languages)}
										{foreach from=$languages item=language}
											{if $language.admin == 1}
												{assign var="setvalue" value='text[trash][title]['|cat:$language.code|cat:']'}
												<div class="form-group">	
													<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
														<input type="text" name="text[trash][title][{$language.code}]" value="{(isset($text.trash.title[$language.code])) ? $text.trash.title[$language.code] : set_value($setvalue) }" placeholder="{translate('text_trash_title')}" class="form-control">
													</div>
												</div>
											{/if}
										{/foreach}
									{/if}
								</div>

								<div class="tab-pane" id="trash_subtitle">
									{if isset($languages)}
										{foreach from=$languages item=language}
											{if $language.admin == 1}
												{assign var="setvalue" value='text[trash][subtitle]['|cat:$language.code|cat:']'}	
												<div class="form-group">	
													<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
														<input type="text" name="text[trash][subtitle][{$language.code}]" value="{(isset($text.trash.subtitle[$language.code])) ? $text.trash.subtitle[$language.code] : set_value($setvalue) }" placeholder="{translate('text_trash_subtitle')}" class="form-control">
													</div>
												</div>
											{/if}
										{/foreach}
									{/if}
								</div>

							</div>
						</div>                                       
					</div>
					<div class="col-md-6">
						<h6>{translate('text_create')}</h6>					
						<div class="tabbable nav-tabs-vertical nav-tabs-left">
							<ul class="nav nav-tabs nav-tabs-highlight" style="width:200px !important">
								<li class="active"><a href="#create_title" data-toggle="tab" aria-expanded="true"> {translate('text_tab_title')}</a></li>
								<li><a href="#create_subtitle" data-toggle="tab" aria-expanded="true">  {translate('text_tab_subtitle')}</a></li>
							</ul>

							<div class="tab-content">
								<div class="tab-pane active" id="create_title">
									{if isset($languages)}
										{foreach $languages as $language}
											{if $language.admin == 1}
												{assign var="setvalue" value='text[create][title]['|cat:$language.code|cat:']'}
												<div class="form-group">
													<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
														<input type="text" name="text[create][title][{$language.code}]" value="{(isset($text.create.title[$language.code])) ? $text.create.title[$language.code] : set_value($setvalue) }" placeholder="{translate('text_index_title')}" class="form-control">
													</div>
												</div>
											{/if}
										{/foreach}
									{/if}
								</div>

								<div class="tab-pane" id="create_subtitle">
									{if isset($languages)}
										{foreach $languages as $language}
											{if $language.admin == 1}
												{assign var="setvalue" value='text[create][subtitle]['|cat:$language.code|cat:']'}
												<div class="form-group">	
													<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
														<input type="text" name="text[create][subtitle][{$language.code}]" value="{(isset($text.create.subtitle[$language.code])) ? $text.create.subtitle[$language.code] : set_value($setvalue) }" placeholder="{translate('text_create_subtitle')}" class="form-control">
													</div>
												</div>
											{/if}
										{/foreach}
									{/if}
								</div>

							</div>
						</div>                                       
					</div>
					<div class="col-md-6">
						<h6>{translate('text_edit')}</h6>					
						<div class="tabbable nav-tabs-vertical nav-tabs-left">
							<ul class="nav nav-tabs nav-tabs-highlight" style="width:200px !important">
								<li class="active"><a href="#edit_title" data-toggle="tab" aria-expanded="true"> {translate('text_tab_title')}</a></li>
								<li><a href="#edit_subtitle" data-toggle="tab" aria-expanded="true"> {translate('text_tab_subtitle')}</a></li>
							</ul>

							<div class="tab-content">
								<div class="tab-pane active" id="edit_title">
									{if isset($languages)}
										{foreach $languages as $language}
											{if $language.admin == 1}
												{assign var="setvalue" value='text[edit][title]['|cat:$language.code|cat:']'}
												<div class="form-group">	
													<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
														<input type="text" name="text[edit][title][{$language.code}]" value="{(isset($text.edit.title[$language.code])) ? $text.edit.title[$language.code] : set_value($setvalue) }" placeholder="{translate('text_edit_title')}" class="form-control">
													</div>
												</div>
											{/if}
										{/foreach}
									{/if}
								</div>

								<div class="tab-pane" id="edit_subtitle">
									{if isset($languages)}
										{foreach $languages as $language}
											{if $language.admin == 1}
												{assign var="setvalue" value='text[edit][subtitle]['|cat:$language.code|cat:']'}
												<div class="form-group">	
													<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
														<input type="text" name="text[edit][subtitle][{$language.code}]" value="{(isset($text.edit.subtitle[$language.code])) ? $text.edit.subtitle[$language.code] : set_value($setvalue) }" placeholder="{translate('text_edit_subtitle')}" class="form-control">
													</div>
												</div>
											{/if}
										{/foreach}
									{/if}
								</div>

							</div>
						</div>                                       
					</div>
				</div>
			</div>
		</div>
		<!-- End title tab -->

		<!-- Fields tab -->
		<div class="tab-pane" id="fields">
			<ul class="nav nav-lg nav-tabs nav-tabs-bottom nav-tabs-toolbar no-margin nav-justified">
				<li class="general active"><a href="#general_field" data-toggle="tab"><i class="icon-menu7 position-left"></i> {translate('tab_fields_general')}</a></li>
				<li class="translation" style="display:none"><a href="#translation_field" data-toggle="tab"><i class="icon-earth position-left"></i> {translate('tab_fields_translatable')}</a></li>
			</ul>

			<div class="tab-content">
				<div class="tab-pane active" id="general_field">
					<table class="table table-bordered table-striped table-responsive extension">
						<thead>
							<th class="text-center" width="15%">{translate('fields_general_column')}</th>                               
							<th class="text-center" width="20%">{translate('fields_general_database')}</th>
							<th class="text-center" width="15%">{translate('fields_general_show_on')}</th>
							<th class="text-center" width="15%">{translate('fields_general_form_element')}</th>
							<th class="text-center" width="25%">{translate('fields_general_text')}</th>
							<th class="text-center" width="15%">{translate('fields_general_rules')}</th>
							<th class="text-center" width="1%"><i class='icon-menu7'></i></th>
						</thead>
						<tbody class="flowers">
							{assign var=i value=0}
							{if isset($db_fields_general)}
								{foreach from=$db_fields_general item=$db_field}
									{assign var=i value=$i+1}
										<tr class="row_{$i}">
											<td><input type="text" name="general[{$i}][column]" value="{$db_field->name}" class="form-control" /></td>
											<td>
												<div class="form-group">
													<label>{translate('fields_general_data_type')}</label>
													<select class="select select-search type type_{$i}" name="general[{$i}][type]">
														{foreach from=$mysql_data_types key=optgroup item=options}
															<optgroup label="{$optgroup}">
																{foreach from=$options item=option}
																	<option {if $db_field->type eq $option|lower}selected="date"{/if} value="{$option}">{$option}</option>
																{/foreach}
															</optgroup>
														{/foreach}                                               
													</select>                                     
												</div>
												<div class="form-group">                                           
													<label>{translate('fields_general_length_values')}</label>
													<input type="text" name="general[{$i}][length]" value="{$db_field->max_length}" placeholder="Length/Values" class="form-control length length_{$i}"/>
												</div>
												<div class="form-group">
													<label>{translate('fields_general_default')}</label>
													<input type="text" name="general[{$i}][default]" value="{$db_field->default}" placeholder="Default" class="form-control default default_{$i}"/>
												</div>
												<div class="form-group pt-15">
													<div class="checkbox">
														<label>
															<input type="checkbox" value="1" name="general[{$i}][primary]" data-id="{$i}" class="styled primary primary_{$i}" {if $db_field->primary_key eq 1}checked="checked"{/if}>
															{translate('fields_general_primary')}
														</label>
													</div>
													<div class="checkbox">
														<label>
															<input type="checkbox" value="1" name="general[{$i}][auto_increment]" data-id="{$i}" class="styled increment increment{$i}">
															{translate('fields_general_auto_increment')}
														</label>
													</div> 
													<div class="checkbox">
														<label>
															<input type="checkbox" name="general[{$i}][null]" value="1" data-id="{$i}" class="styled null null_{$i}">
															{translate('fields_general_null')}
														</label>
													</div>
												</div>
											</td>
											<td>
												<div class="form-group pt-15">
													<div class="checkbox">
														<label>
															<input type="checkbox" name="general[{$i}][show_on_table]" data-id="{$i}" data-id="{$i}" class="styled show_on_table show_on_table_{$i}" {if $fields.general[$db_field->name].show_on_table eq 1}checked="checked"{/if}>
															{translate('fields_general_show_on_table')}
														</label>
													</div>
													<div class="form-group" style="margin-top:10px;margin-bottom:0px;">
														<div class="input-group">
															{if isset($fields.general[$db_field->name].table_function)}                
																{assign var="general_table_function" value=$fields.general[$db_field->name].table_function}
															{else}
																{assign var="general_table_function_value" value="general["|cat:$i|cat:"][table_function]"}
																{assign var="general_table_function" value=set_value($general_table_function_value)}
															{/if}
															{if $methods}
															<select  name="table_function[{$i}]" class="form-control table_function">
																<option value="">{translate('please_select')}</option>
																{foreach from=$methods item=method}
																	<option {if $general_table_function eq $method}selected="selected"{/if} value="{$method}">{$method}</option>
																{/foreach}
															</select>
															{/if}
														</div>
													</div>
													<div class="checkbox">
														<label>
															<input type="checkbox" name="general[{$i}][show_on_form]" data-id="{$i}" data-id="{$i}" class="styled show_on_form show_on_form_{$i}" {if $fields.general[$db_field->name].show_on_form eq 1}checked="checked"{/if}>
															{translate('fields_general_show_on_form')}
														</label>
													</div>
													<div class="form-group" style="margin-top:10px;margin-bottom:0px;">
														<div class="input-group">
															{if isset($fields.general[$db_field->name].form_function)}                
																{assign var="general_form_function" value=$fields.general[$db_field->name].form_function}
															{else}
																{assign var="general_form_function_value" value="general["|cat:$i|cat:"][form_function]"}
																{assign var="general_form_function" value=set_value($general_form_function_value)}
															{/if}
															{if $methods}
															<select  name="form_function[{$i}]" class="form-control form_function">
																<option value="">{translate('please_select')}</option>
																{foreach from=$methods item=method}
																	<option {if $general_form_function eq $method}selected="selected"{/if} value="{$method}">{$method}</option>
																{/foreach}
															</select>
															{/if}
														</div>
													</div>                  
												</div>                                  
											</td>
											<td>
												<div class="form-group">
													<label class="control-label">{translate('fields_general_form_element')}</label>
													<select class="select select-search element element_{$i}" name="general[{$i}][element]">
													{if isset($fields.general[$db_field->name].element)}                
														{assign var="general_element" value=$fields.general[$db_field->name].element}
													{else}
														{assign var="general_element_value" value="general["|cat:$i|cat:"][element]"}
														{assign var="general_element" value=set_value($general_element_value)}
													{/if}
														{foreach from=$elements key=optgroup item=element}
															<optgroup label="{$optgroup}">
																{foreach from=$element key=option_key item=option}
																	<option {if $general_element eq $option_key}selected="selected"{/if} value="{$option_key}" data-id="{$i}" data-type="general">{$option}</option>
																{/foreach}
															</optgroup>
														{/foreach}   
													</select>
												</div>
												<div class="form-group inner_element inner_element_{$i}"></div>
												<div class="field_element field_element_{$i}"></div>
												<div class="form-group" style="position: inherit;">
													<label class="control-label">{translate('fields_general_form_class')}</label>
													{assign var="general_class" value="general["|cat:$i|cat:"][class]"}
													<input type="text" name="general[{$i}][class]" value="{(isset($fields.general[$db_field->name].class)) ? $fields.general[$db_field->name].class : set_value($general_class)}" placeholder="" class="form-control class class_{$i}"/>
												</div>
											</td>
											<td>
												<ul class="nav nav-tabs bg-indigo-800 nav-tabs-component nav-justified">
													<li class="active table_{$i}"><a href="#table_{$i}" data-toggle="tab">{translate('fields_general_text_table')}</a></li>
													<li class="label_{$i}"><a href="#label_{$i}" data-toggle="tab">{translate('fields_general_text_label')}</a></li>
													<li class="placeholder_{$i}"><a href="#placeholder_{$i}" data-toggle="tab">{translate('fields_general_text_placeholder')}</a></li>
												</ul>
												<div class="tab-content">
													<div class="tab-pane active" id="table_{$i}">
														{if isset($languages)}
															{foreach from=$languages item=language}
																{if $language.admin == 1}
																	<div class="form-group">
																		<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
																			<input type="text" name="general[{$i}][table][{$language.code}]" value="{(isset($fields.general[$db_field->name].table[$language.code])) ? $fields.general[$db_field->name].table[$language.code] : '' }" placeholder="{translate('fields_general_text_table')}" class="form-control">
																		</div>
																	</div>
																{/if}
															{/foreach}
														{/if}
													</div>
													<div class="tab-pane" id="label_{$i}">
														{if isset($languages)}
															{foreach from=$languages item=language}
																{if $language.admin == 1}
																	<div class="form-group">	
																		<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
																			<input type="text" name="general[{$i}][label][{$language.code}]" value="{(isset($fields.general[$db_field->name].label[$language.code])) ? $fields.general[$db_field->name].label[$language.code] : ''}" placeholder="{translate('fields_general_text_label')}" class="form-control">
																		</div>
																	</div>
																{/if}
															{/foreach}
														{/if}
													</div>
													<div class="tab-pane" id="placeholder_{$i}">
														{if isset($languages)}
															{foreach from=$languages item=language}
																{if $language.admin == 1}
																	<div class="form-group">	
																		<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
																			<input type="text" name="general[{$i}][placeholder][{$language.code}]" value="{(isset($fields.general[$db_field->name].placeholder[$language.code])) ? $fields.general[$db_field->name].placeholder[$language.code] : ''}" placeholder="{translate('fields_general_text_placeholder')}" class="form-control">
																		</div>
																	</div>
																{/if}
															{/foreach}
														{/if}
													</div>
												</div>
											</td>
											<td>
												<div class="rulesarea rulesarea_{$i}"></div>  
												<button type="button" class="btn bg-indigo-800 btn-block add_rules add_rules_{$i}" data-id="{$i}" data-type="fields"><i class="icon icon-plus2"></i> {translate('fields_general_add_rules')}</button>
											</td>
											<td>
												<a href="#" class="btn btn-danger delete danger delete_row" data-popup="tooltip" title="" data-original-title="{translate('fields_general_delete')}"><i class="icon-minus-circle2"></i></a>
											</td>
										</tr>
								{/foreach}
							{/if} 
						<tbody>
					</table> 
					<a class="btn bg-indigo-800 col-md-offset-4 col-md-4" id="add_field_general" style="margin-top:25px;"><i class="icon-plus2"></i> {translate('fields_general_add_field')}</a> 
				</div> 
				
				<div class="tab-pane" id="translation_field">
					<table class="table table-bordered table-striped table-responsive extension">
						<thead>
							<th class="text-center" width="15%">{translate('fields_general_column')}</th>                               
							<th class="text-center" width="20%">{translate('fields_general_database')}</th>
							<th class="text-center" width="10%">{translate('fields_general_show_on')}</th>
							<th class="text-center" width="15%">{translate('fields_general_form_element')}</th>
							<th class="text-center" width="25%">{translate('fields_general_text')}</th>
							<th class="text-center" width="15%">{translate('fields_general_rules')}</th>
							<th class="text-center" width="1%"><i class='icon-menu7'></i></th>
						</thead>
						<tbody class="translation_flow">
							{if isset($db_fields_translation)}
								{foreach from=$db_fields_translation item=$db_field}
									{assign var=i value=$i+1}
										<tr class="row_{$i}">
											<td><input type="text" name="translation[{$i}][column]" value="{$db_field->name}" class="form-control" /></td>
											<td>
												<div class="form-group">
													<label>{translate('fields_general_data_type')}</label>
													<select class="select select-search type type_{$i}" name="translation[{$i}][type]">
														{foreach from=$mysql_data_types key=optgroup item=options}
															<optgroup label="{$optgroup}">
																{foreach from=$options item=option}
																	<option {if $db_field->type eq $option|lower}selected="date"{/if} value="{$option}">{$option}</option>
																{/foreach}
															</optgroup>
														{/foreach}                                               
													</select>                                     
												</div>
												<div class="form-group">                                           
													<label>{translate('fields_general_length_values')}</label>
													<input type="text" name="translation[{$i}][length]" value="{$db_field->max_length}" placeholder="Length/Values" class="form-control length length_{$i}"/>
												</div>
												<div class="form-group">
													<label>{translate('fields_general_default')}</label>
													<input type="text" name="translation[{$i}][default]" value="{$db_field->default}" placeholder="Default" class="form-control default default_{$i}"/>
												</div>
												<div class="form-group pt-15">
													<div class="checkbox">
														<label>
															<input type="checkbox" name="translation[{$i}][null]" value="1" data-id="{$i}" class="styled null null_{$i}">
															{translate('fields_general_null')}
														</label>
													</div>
												</div>
											</td>
											<td>
												<div class="form-group pt-15">
													<div class="checkbox">
														<label>
															<input type="checkbox" name="translation[{$i}][show_on_table]" data-id="{$i}" data-id="{$i}" class="styled show_on_table show_on_table_{$i}" {if $fields.translation[$db_field->name].show_on_table eq 1}checked="checked"{/if}>
															{translate('fields_general_show_on_table')}
														</label>
													</div>
													<div class="form-group" style="margin-top:10px;margin-bottom:0px;">
														<div class="input-group">
															{if isset($fields.translation[$db_field->name].table_function)}                
																{assign var="translation_table_function" value=$fields.translation[$db_field->name].table_function}
															{else}
																{assign var="translation_table_function_value" value="translation["|cat:$i|cat:"][table_function]"}
																{assign var="translation_table_function" value=set_value($translation_table_function_value)}
															{/if}
															{if $methods}
															<select  name="table_function[{$i}]" class="form-control table_function">
																<option value="">{translate('please_select')}</option>
																{foreach from=$methods item=method}
																	<option {if $translation_table_function eq $method}selected="selected"{/if} value="{$method}">{$method}</option>
																{/foreach}
															</select>
															{/if}
														</div>
													</div>
													<div class="checkbox">
														<label>
															<input type="checkbox" name="translation[{$i}][show_on_form]" data-id="{$i}" data-id="{$i}" class="styled show_on_form show_on_form_{$i}" {if $fields.translation[$db_field->name].show_on_form eq 1}checked="checked"{/if}>
															{translate('fields_general_show_on_form')}
														</label>
													</div>
													<div class="form-group" style="margin-top:10px;margin-bottom:0px;">
														<div class="input-group">
															{if isset($fields.translation[$db_field->name].form_function)}                
																{assign var="translation_form_function" value=$fields.translation[$db_field->name].form_function}
															{else}
																{assign var="translation_form_function_value" value="translation["|cat:$i|cat:"][form_function]"}
																{assign var="translation_form_function" value=set_value($translation_form_function_value)}
															{/if}
															{if $methods}
															<select  name="form_function[{$i}]" class="form-control form_function">
																<option value="">{translate('please_select')}</option>
																{foreach from=$methods item=method}
																	<option {if $translation_form_function eq $method}selected="selected"{/if} value="{$method}">{$method}</option>
																{/foreach}
															</select>
															{/if}
														</div>
													</div>
												</div>
											</td>
											<td>
												<div class="form-group">
													<label class="control-label">{translate('fields_general_form_element')}</label>
													<select class="select select-search element element_{$i}" name="translation[{$i}][element]">
													{if isset($fields.translation[$db_field->name].element)}                
														{assign var="general_element" value=$fields.translation[$db_field->name].element}
													{else}
														{assign var="general_element_value" value="translation["|cat:$i|cat:"][element]"}
														{assign var="general_element" value=set_value($general_element_value)}
													{/if}
														{foreach from=$elements key=optgroup item=element}
															<optgroup label="{$optgroup}">
																{foreach from=$element key=option_key item=option}
																	<option {if $general_element eq $option_key}selected="selected"{/if} value="{$option_key}" data-id="{$i}" data-type="translation">{$option}</option>
																{/foreach}
															</optgroup>
														{/foreach}   
													</select>
												</div>
												<div class="form-group inner_element inner_element_{$i}">
	
												</div>
												<div class="field_element field_element_{$i}">

												</div>
												<div class="form-group" style="position: inherit;">                                                
													<label class="control-label">{translate('fields_general_form_class')}</label>
													{assign var="general_class" value="translation["|cat:$i|cat:"][class]"}
													<input type="text" name="translation[{$i}][class]" value="{(isset($fields.translation[$db_field->name].class)) ? $fields.translation[$db_field->name].class : set_value($general_class)}" placeholder="" class="form-control class class_{$i}"/>
												</div>
											</td>
											<td>
												<ul class="nav nav-tabs bg-indigo-800 nav-tabs-component nav-justified">
													<li class="active table_{$i}"><a href="#table_{$i}" data-toggle="tab">{translate('fields_general_text_table')}</a></li>
													<li class="label_{$i}"><a href="#label_{$i}" data-toggle="tab">{translate('fields_general_text_label')}</a></li>
													<li class="placeholder_{$i}"><a href="#placeholder_{$i}" data-toggle="tab">{translate('fields_general_text_placeholder')}</a></li>
												</ul>
												<div class="tab-content">
													<div class="tab-pane active" id="table_{$i}">
														{if isset($languages)}
															{foreach $languages as $language}
																{if $language.admin == 1}
																	<div class="form-group">
																		<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
																			<input type="text" name="translation[{$i}][table][{$language.code}]" value="" placeholder="{translate('fields_general_text_table')}" class="form-control">
																		</div>
																	</div>
																{/if}
															{/foreach}
														{/if}
													</div>
													<div class="tab-pane" id="label_{$i}">
														{if isset($languages)}
															{foreach $languages as $language}
																{if $language.admin == 1}
																	<div class="form-group">	
																		<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
																			<input type="text" name="translation[{$i}][label][{$language.code}]" value="" placeholder="{translate('fields_general_text_label')}" class="form-control">
																		</div>
																	</div>
																{/if}
															{/foreach}
														{/if}
													</div>
													<div class="tab-pane" id="placeholder_{$i}">
														{if isset($languages)}
															{foreach $languages as $language}
																{if $language.admin == 1}
																	<div class="form-group">	
																		<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>
																			<input type="text" name="translation[{$i}][placeholder][{$language.code}]" value="" placeholder="{translate('fields_general_text_placeholder')}" class="form-control">
																		</div>
																	</div>
																{/if}
															{/foreach}
														{/if}
													</div>
												</div>
											</td>
											<td>
												<div class="rulesarea rulesarea_{$i}"></div>  
												<button type="button" class="btn bg-indigo-800 btn-block add_rules add_rules_{$i}" data-id="{$i}" data-type="fields"><i class="icon icon-plus2"></i> {translate('fields_general_add_rules')}</button>
											</td>
											<td>
												<a href="#" class="btn btn-danger delete danger delete_row" data-popup="tooltip" title="" data-original-title="{translate('fields_general_delete')}"><i class="icon-minus-circle2"></i></a>
											</td>
										</tr>
								{/foreach}
							{/if} 
						<tbody>
					</table> 
					<a class="btn bg-indigo-800 col-md-offset-4 col-md-4" id="add_field_translation" style="margin-top:25px;"><i class="icon-plus2"></i> {translate('fields_general_add_field')}</a> 
				</div>
			</div>

		</div>
		<!-- End field tab -->

	</div>
	<!-- End tab content -->
	{form_close()}
</div>
<style>
	.extension > tbody > tr > td {
		vertical-align: top !important;
	}
	.extension > tbody > tr > td:first-child {
		vertical-align: middle !important;
	}
</style>
<script> 
	function addField(count){
		var field = '';
		field +='<tr class="row_'+count+'">';
			field +='<td><input type="text" name="general['+count+'][column]" value="" class="form-control" /></td>';
			field +='<td>';
				field +='<div class="form-group">';
					field +='<label>{translate('fields_general_data_type')}</label>';
					field +='<select class="select select-search type type_'+count+'" name="general['+count+'][type]">';
						field +='{foreach from=$mysql_data_types key=optgroup item=options}';
							field +='<optgroup label="{$optgroup}">';
								field +='{foreach from=$options item=option}';
									field +='<option value="{$option}">{$option}</option>';
								field +='{/foreach}';
							field +='</optgroup>';
						field +='{/foreach}';                                               
					field +='</select>';                                     
				field +='</div>';
				field +='<div class="form-group">';                                           
					field +='<label>{translate('fields_general_length_values')}</label>';
					field +='<input type="text" name="general['+count+'][length]" value="" placeholder="Length/Values" class="form-control length length_'+count+'"/>';
				field +='</div>';
				field +='<div class="form-group">';
					field +='<label>{translate('fields_general_default')}</label>';
					field +='<input type="text" name="general['+count+'][default]" value="" placeholder="Default" class="form-control default default_'+count+'"/>';
				field +='</div>';
				field +='<div class="form-group pt-15">';
					field +='<div class="checkbox">';
						field +='<label>';
							field +='<input type="checkbox" value="1" name="general['+count+'][primary]" data-id="'+count+'" class="styled primary primary_'+count+'">';
							field +='{translate('fields_general_primary')}';
						field +='</label>';
					field +='</div>';
					field +='<div class="checkbox">';
						field +='<label>';
							field +='<input type="checkbox" value="1" name="general['+count+'][auto_increment]" data-id="'+count+'" class="styled increment increment'+count+'">';
							field +='{translate('fields_general_auto_increment')}';
						field +='</label>';
					field +='</div> ';
					field +='<div class="checkbox">';
						field +='<label>';
							field +='<input type="checkbox" name="general['+count+'][null]" value="1" data-id="'+count+'" class="styled null null_'+count+'">';
							field +='{translate('fields_general_null')}';
						field +='</label>';
					field +='</div>';
				field +='</div>';
			field +='</td>';
			field +='<td>';
				field +='<div class="form-group pt-15">';
					field +='<div class="checkbox">';
						field +='<label>';
							field +='<input type="checkbox" name="general['+count+'][show_on_table]" data-id="'+count+'" data-id="'+count+'" class="styled show_on_table show_on_table_'+count+'" checked>';
							field +='{translate('fields_general_show_on_table')}';
						field +='</label>';
					field +='</div>';
					field +='<div class="form-group" style="margin-top:10px;margin-bottom:0px;">';
						field +='<div class="input-group">';
							 field +='{if $methods}';
								field +='<select  name="general['+count+'][table_function]" class="form-control table_function table_function_'+count+'">';                                    
									field +='<option value="">{translate("please_select")}</option>';
									field +='{foreach from=$methods item=method}';
										field +='<option value="{$method}" data-param="general"  data-id="'+count+'">{$method}</option>';
									field +='{/foreach}';
								field +='</select>';
							field +='{/if}';
						field +='</div>';
					field +='</div>'; 
					field +='<div class="general_table_function_inner_'+count+'"></div>';
					field +='<div class="checkbox">';
						field +='<label>';
							field +='<input type="checkbox" name="general['+count+'][show_on_form]" data-id="'+count+'" data-id="'+count+'" class="styled show_on_form show_on_form_'+count+'" checked>';
							field +='{translate('fields_general_show_on_form')}';
						field +='</label>';
					field +='</div>';  
					field +='<div class="form-group" style="margin-top:10px;margin-bottom:0px;">';
						field +='<div class="input-group">';
							 field +='{if $methods}';
								field +='<select  name="general['+count+'][form_function]" class="form-control form_function form_function_'+count+'">';
									field +='<option value="">{translate("please_select")}</option>';
									field +='{foreach from=$methods item=method}';
										field +='<option value="{$method}" data-param="general" data-id="'+count+'">{$method}</option>';
									field +='{/foreach}';
								field +='</select>';
							field +='{/if}';
						field +='</div>'
					field +='</div>';
					field +='<div class="general_form_function_inner_'+count+'"></div>';                   
				field +='</div>';                                  
			field +='</td>';
			field +='<td>';
				field +='<div class="form-group">';
					field +='<label class="control-label">{translate('fields_general_form_element')}</label>';
					field +='<select class="select select-search element element_'+count+'" name="general['+count+'][element]">';
						field +='{foreach from=$elements key=optgroup item=element}';
							field +='<optgroup label="{$optgroup}">';
								field +='{foreach from=$element key=option_key item=option}';
									field +='<option data-id="'+count+'" data-type="general" value="{$option_key}">{$option}</option>';
								field +='{/foreach}';
							field +='</optgroup>';
						field +='{/foreach}';   
					field +='</select>';
				field +='</div>';
				
				field +='<div class="form-group inner_element inner_element_'+count+'"></div>'; 
				
				field +='<div class="form-group field_element field_element_'+count+'"></div>';
				
				field +='<div class="form-group" style="position: inherit;">';                                                
					field +='<label class="control-label">{translate('fields_general_form_class')}</label>';
					field +='<input type="text" name="general['+count+'][class]" value="form-control" class="form-control class class_'+count+'"/>';
				field +='</div>';
			field +='</td>';
			field +='<td>';
				field +='<ul class="nav nav-tabs bg-indigo-800 nav-tabs-component nav-justified">';
					field +='<li class="active table_'+count+'"><a href="#table_'+count+'" data-toggle="tab">{translate('fields_general_text_table')}</a></li>';
					field +='<li class="label_'+count+'"><a href="#label_'+count+'" data-toggle="tab">{translate('fields_general_text_label')}</a></li>';
					field +='<li class="placeholder_'+count+'"><a href="#placeholder_'+count+'" data-toggle="tab">{translate('fields_general_text_placeholder')}</a></li>';
				field +='</ul>';
				field +='<div class="tab-content">';
					field +='<div class="tab-pane active" id="table_'+count+'">';
						field +='{if isset($languages)}';
							field +='{foreach $languages as $language}';
								field +='{if $language.admin == 1}';
									field +='<div class="form-group">';
										field +='<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>';
											field +='<input type="text" name="general['+count+'][table][{$language.code}]" value="" placeholder="{translate('fields_general_text_table')}" class="form-control">';
										field +='</div>';
									field +='</div>';
								field += '{/if}';
							field +='{/foreach}';
						field +='{/if}';
					field +='</div>';
					field +='<div class="tab-pane" id="label_'+count+'">';
						field +='{if isset($languages)}';
							field +='{foreach $languages as $language}';
								field +='{if $language.admin == 1}';
									field +='<div class="form-group">';	
										field +='<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>';
											field +='<input type="text" name="general['+count+'][label][{$language.code}]" value="" placeholder="{translate('fields_general_text_label')}" class="form-control">';
										field +='</div>';
									field +='</div>';
								field += '{/if}';
							field +='{/foreach}';
						field +='{/if}';
					field +='</div>';
					field +='<div class="tab-pane" id="placeholder_'+count+'">';
						field +='{if isset($languages)}';
							field +='{foreach $languages as $language}';
								field +='{if $language.admin == 1}';
									field +='<div class="form-group">';	
										field +='<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>';
											field +='<input type="text" name="general['+count+'][placeholder][{$language.code}]" value="" placeholder="{translate('fields_general_text_placeholder')}" class="form-control">';
										field +='</div>';
									field +='</div>';
								field += '{/if}';
							field +='{/foreach}';
						field +='{/if}';
					field +='</div>';
				field +='</div>';
			field +='</td>';
			field +='<td>';
				field +='<div class="rulesarea rulesarea_'+count+'"></div>';  
				field +='<button type="button" class="btn bg-indigo-800 btn-block add_rules add_rules_'+count+'" data-id="'+count+'" data-type="general"><i class="icon icon-plus2"></i> {translate('fields_general_add_rules')}</button>';
			field +='</td>';
			field +='<td>';
				field +='<a href="#" class="btn btn-danger delete danger delete_row" data-popup="tooltip" title="" data-original-title="{translate('fields_general_delete')}"><i class="icon-minus-circle2"></i></a>';
			field +='</td>';
		field +='</tr>';
		return field;
	}
	
	function addTranslation(say){
		var field = '';
		field +='<tr class="row_'+say+'">';
			field +='<td><input type="text" name="translation['+say+'][column]" value="" class="form-control" /></td>';
			field +='<td>';
				field +='<div class="form-group">';
					field +='<label>{translate('fields_general_data_type')}</label>';
					field +='<select class="select select-search type type_'+say+'" name="translation['+say+'][type]">';
						field +='{foreach from=$mysql_data_types key=optgroup item=options}';
							field +='<optgroup label="{$optgroup}">';
								field +='{foreach from=$options item=option}';
									field +='<option value="{$option}">{$option}</option>';
								field +='{/foreach}';
							field +='</optgroup>';
						field +='{/foreach}';                                               
					field +='</select>';                                     
				field +='</div>';
				field +='<div class="form-group">';                                           
					field +='<label>{translate('fields_general_length_values')}</label>';
					field +='<input type="text" name="translation['+say+'][length]" value="" placeholder="Length/Values" class="form-control length length_'+say+'"/>';
				field +='</div>';
				field +='<div class="form-group">';
					field +='<label>{translate('fields_general_default')}</label>';
					field +='<input type="text" name="translation['+say+'][default]" value="" placeholder="Default" class="form-control default default_'+say+'"/>';
				field +='</div>';
				field +='<div class="form-group pt-15">'; 
					field +='<div class="checkbox">';
						field +='<label>';
							field +='<input type="checkbox" name="translation['+say+'][null]" value="1" data-id="'+say+'" class="styled null null_'+say+'">';
							field +='{translate('fields_general_null')}';
						field +='</label>';
					field +='</div>';
				field +='</div>';
			field +='</td>';
			field +='<td>';
				field +='<div class="form-group pt-15">';
					field +='<div class="checkbox">';
						field +='<label>';
							field +='<input type="checkbox" name="translation['+say+'][show_on_table]" data-id="'+say+'" data-id="'+say+'" class="styled show_on_table show_on_table_'+say+'" checked>';
							field +='{translate('fields_general_show_on_table')}';
						field +='</label>';
					field +='</div>';
					field +='<div class="form-group" style="margin-top:10px;margin-bottom:0px;">';
						field +='<div class="input-group">';
							 field +='{if $methods}';
								field +='<select  name="translation['+say+'][table_function]" class="form-control table_function table_function_'+say+'">';
									field +='<option value="">{translate("please_select")}</option>';
									field +='{foreach from=$methods item=method}';
										field +='<option value="{$method}" data-param="translation" data-id="'+say+'">{$method}</option>';
									field +='{/foreach}';
								field +='</select>';
							field +='{/if}';
						field +='</div>'
					field +='</div>';
					field +='<div class="translation_table_function_inner_'+say+'"></div>';
					field +='<div class="checkbox">';
						field +='<label>';
							field +='<input type="checkbox" name="translation['+say+'][show_on_form]" data-id="'+say+'" data-id="'+say+'" class="styled show_on_form show_on_form_'+say+'" checked>';
							field +='{translate('fields_general_show_on_form')}';
						field +='</label>';
					field +='</div>'; 

					field +='<div class="form-group" style="margin-top:10px;margin-bottom:0px;">';
						field +='<div class="input-group">';
							 field +='{if $methods}';
								field +='<select  name="translation['+say+'][form_function]" class="form-control form_function form_function_'+say+'">';
									field +='<option value="">{translate("please_select")}</option>';
									field +='{foreach from=$methods item=method}';
										field +='<option value="{$method}" data-param="translation" data-id="'+say+'">{$method}</option>';
									field +='{/foreach}';
								field +='</select>';
							field +='{/if}';
						field +='</div>'
					field +='</div>';
					field +='<div class="translation_form_function_inner_'+say+'"></div>';  

				field +='</div>';                                  
			field +='</td>';
			field +='<td>';
				field +='<div class="form-group">';
					field +='<label class="control-label">{translate('fields_general_form_element')}</label>';
					field +='<select class="select select-search element element_'+say+'" name="translation['+say+'][element]">';
						field +='{foreach from=$elements key=optgroup item=element}';
							field +='<optgroup label="{$optgroup}">';
								field +='{foreach from=$element key=option_key item=option}';
									field +='<option data-id="'+say+'" data-type="translation" value="{$option_key}">{$option}</option>';
								field +='{/foreach}';
							field +='</optgroup>';
						field +='{/foreach}';   
					field +='</select>';
				field +='</div>';
				
				field +='<div class="form-group inner_element inner_element_'+say+'"></div>';  
				
				field +='<div class="field_element field_element_'+say+'"></div>';
				
				field +='<div class="form-group" style="position: inherit;">';                                                
					field +='<label class="control-label">{translate('fields_general_form_class')}</label>';
					field +='<input type="text" name="translation['+say+'][class]" value="form-control" class="form-control class class_'+say+'"/>';
				field +='</div>';
			field +='</td>';
			field +='<td>';
				field +='<ul class="nav nav-tabs bg-indigo-800 nav-tabs-component nav-justified">';
					field +='<li class="active table_'+say+'"><a href="#table_'+say+'" data-toggle="tab">{translate('fields_general_text_table')}</a></li>';
					field +='<li class="label_'+say+'"><a href="#label_'+say+'" data-toggle="tab">{translate('fields_general_text_label')}</a></li>';
					field +='<li class="placeholder_'+say+'"><a href="#placeholder_'+say+'" data-toggle="tab">{translate('fields_general_text_placeholder')}</a></li>';
				field +='</ul>';
				field +='<div class="tab-content">';
					field +='<div class="tab-pane active" id="table_'+say+'">';
						field +='{if isset($languages)}';
							field +='{foreach $languages as $language}';
								field +='{if $language.admin == 1}';
									field +='<div class="form-group">';
										field +='<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>';
											field +='<input type="text" name="translation['+say+'][table][{$language.code}]" value="" placeholder="{translate('fields_general_text_table')}" class="form-control">';
										field +='</div>';
									field +='</div>';
								field += '{/if}';
							field +='{/foreach}';
						field +='{/if}';
					field +='</div>';
					field +='<div class="tab-pane" id="label_'+say+'">';
						field +='{if isset($languages)}';
							field +='{foreach $languages as $language}';
								field +='{if $language.admin == 1}';
									field +='<div class="form-group">';	
										field +='<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>';
											field +='<input type="text" name="translation['+say+'][label][{$language.code}]" value="" placeholder="{translate('fields_general_text_label')}" class="form-control">';
										field +='</div>';
									field +='</div>';
								field += '{/if}';
							field +='{/foreach}';
						field +='{/if}';
					field +='</div>';
					field +='<div class="tab-pane" id="placeholder_'+say+'">';
						field +='{if isset($languages)}';
							field +='{foreach $languages as $language}';
								field +='{if $language.admin == 1}';
									field +='<div class="form-group">';
										field +='<div class="input-group"> <span class="input-group-addon"><img src="{$admin_theme}/global_assets/images/flags/{$language.code}.png" title="{$language.name}"></span>';
											field +='<input type="text" name="translation['+say+'][placeholder][{$language.code}]" value="" placeholder="{translate('fields_general_text_placeholder')}" class="form-control">';
										field +='</div>';
									field +='</div>';
								field += '{/if}';
							field +='{/foreach}';
						field +='{/if}';
					field +='</div>';
				field +='</div>';
			field +='</td>';
			field +='<td>';
				field +='<div class="rulesarea rulesarea_'+say+'"></div>';  
				field +='<button type="button" class="btn bg-indigo-800 btn-block add_rules add_rules_'+say+'" data-id="'+say+'" data-type="translation"><i class="icon icon-plus2"></i> {translate('fields_general_add_rules')}</button>';
			field +='</td>';
			field +='<td>';
				field +='<a href="#" class="btn btn-danger delete danger delete_row" data-popup="tooltip" title="" data-original-title="{translate('fields_general_delete')}"><i class="icon-minus-circle2"></i></a>';
			field +='</td>';
		field +='</tr>';
		return field;
	}
	
	$(document).ready(function(){ 
		/*---------------------[ADD FIELDS AND TRANSLATION FIELDS]-----------------------*/ 
		var count = {$i}; 
		
		$(document).on('click','#add_field_general',function(){
			count += 1;
			var created = addField(count);
			$('.flowers').append(created);
			$('.select').select2();
			$(".styled").uniform(); 
		}); 
		 
		$(document).on('click','#add_field_translation',function(){
			count += 1;
			var created = addTranslation(count);
			$('.translation_flow').append(created);
			$('.select').select2();
			$(".styled").uniform(); 
		});
		
		$(document).on('click','.delete', function(e){
			e.preventDefault();
			$(this).parent().parent().remove();
			e.preventDefault();
			return false;
		}); 

		$(document).on('change','.null', function(){
			var data_id = $(this).attr('data-id'); 
			if($(this).is(':checked'))
			{ 
				$('.default_'+data_id).prop("disabled", true);
			}
			else{
				$('.default_'+data_id).prop("disabled", false);
			} 
		}); 

		/*---------------------[ADD FIELDS AND TRANSLATION FIELDS]-----------------------*/
 
 
		/*---------------------------[ELEMENT CHECKED EVENT]-----------------------------*/
		$(document).on('change','.element', function(){
			var selectbox = '';
			var value = $(this).val();
			var param = $(this).find('optgroup option[value="'+value+'"]').attr('data-id');  
			var type  = $(this).find('optgroup option[value="'+value+'"]').attr('data-type');  
			 
			if(value == 'dropdown')
			{
				selectbox +='<label class="control-label">{translate('fields_general_form_option')}</label>';
				selectbox +='<select class="select select-search all_tables all_tables_'+param+'" name="'+type+'['+param+'][connected]">';                    
					selectbox +='<option value="">{translate("please_select")}</option>'; 
					{foreach from=$all_table key=key item=table}  
					selectbox +='<option data-id="'+param+'" data-type="'+type+'" value="{$table.table_name}">{$table.table_name}</option>';  
					{/foreach}
				selectbox +='</select>';
				
				$('.inner_element_'+param).html(selectbox); 
				$('.select').select2();
			}
			else 
			{
							$('.inner_element_'+param).empty(); 
							$('.field_element_'+param).empty(); 
			}
		}); 
		
		/*---------------------------[ELEMENT CHECKED EVENT]-----------------------------*/
		
		
		
 
		$(document).on('change','.primary',function(){
			var data_id = $(this).attr('data-id');
			if($(this).is(':checked'))
			{
				/* ALL PRIMARY CHACKBOX DISABLED AND UNCHECKED*/
				$('.primary').prop("disabled", true);
				$('.primary').prop("checked", false);
				
				/* THIS PRIMARY CHECKBOX ENABLED AND CHECKED*/
				$(this).prop("disabled", false);
				$(this).prop("checked", true);
				
				/* ALL INCREMENT CHACKBOX DISABLED AND UNCHECKED*/
				$('.increment').prop("disabled", true);
				$('.increment').prop("checked", false);
				
				/* THIS INCREMENT CHECKBOX ENABLED AND CHECKED*/
				$('.increment'+data_id).prop("disabled", false);
				$('.increment'+data_id).prop("checked", true);
				
				/* AUTO INCREMENT */
				$('.increment'+data_id).parent().addClass('checked');
				$('.increment'+data_id).prop("checked", true);
				$('.increment'+data_id).prop("disabled", false);
				
				/* TABLE */
				$('.show_on_table_'+data_id).parent().addClass('checked');
				$('.show_on_table_'+data_id).prop("checked", true);
				$('.show_on_table_'+data_id).prop("disabled", false);
				
				/* FORM */
				$('.show_on_form_'+data_id).parent().removeClass('checked');
				$('.show_on_form_'+data_id).prop("checked", false);
				$('.show_on_form_'+data_id).prop("disabled", true);
				
				/* NULL */
				$('.null_'+data_id).parent().removeClass('checked');
				$('.null_'+data_id).prop("checked", false);
				$('.null_'+data_id).prop("disabled", true);
				
				if($('.show_on_form_'+data_id).is(':checked'))
				{
					/* ELEMENT */
					$('.element_'+data_id).prop("disabled", false);

					/* CLASS */
					$('.class_'+data_id).prop("disabled", false);
					
					/* RULES */
					$('.rules_'+data_id).prop("disabled", false);

					/* ADD RULES */
					$('.add_rules_'+data_id).prop("disabled", false);
					
					/* RULES PARAMETR */
					$('.rules_parametr_'+data_id).prop("disabled", false); 
				}
				else 
				{
					/* ELEMENT */
					$('.element_'+data_id).prop("disabled", true);

					/* CLASS */
					$('.class_'+data_id).prop("disabled", true);
					
					/* RULES */
					$('.rules_'+data_id).prop("disabled", true);

					/* ADD RULES */
					$('.add_rules_'+data_id).prop("disabled", true);
					
					/* RULES PARAMETR */
					$('.rules_parametr_'+data_id).prop("disabled", true); 
				}
				
				/* DEFAULT */
				$('.default_'+data_id).prop("disabled", true);
				
				/* LABEL */
				$('.label_'+data_id).hide(); 
				
				/* PLACEHOLDER */
				$('.placeholder_'+data_id).hide(); 
				
				/* TABLE */
				$('.table_'+data_id+' a').trigger('click'); 
				
				/* DATA TYPE */
				$('.type_'+data_id).val('INT').trigger('change'); 
				$('.type_'+data_id).prop("disabled", true);
				
				/* LENGTH */
				$('.length_'+data_id).val('11'); 
			}
			else
			{ 
				/* AUTO INCREMENT */
				$('.increment'+data_id).prop("disabled", false);
				$('.increment'+data_id).prop("checked", false);
				$('.increment'+data_id).parent().removeClass('checked');
				
				/* TABLE */
				$('.show_on_table_'+data_id).prop("disabled", false);
				
				/* FORM */
				$('.show_on_form_'+data_id).prop("disabled", false);
				
				/* NULL */
				$('.null_'+data_id).prop("disabled", false);
				 
				if($('.show_on_form_'+data_id).is(':checked'))
				{
					/* ELEMENT */
					$('.element_'+data_id).prop("disabled", false);

					/* CLASS */
					$('.class_'+data_id).prop("disabled", false);
					
					/* RULES */
					$('.rules_'+data_id).prop("disabled", false);

					/* ADD RULES */
					$('.add_rules_'+data_id).prop("disabled", false);
				}
				else 
				{
					/* ELEMENT */
					$('.element_'+data_id).prop("disabled", true);

					/* CLASS */
					$('.class_'+data_id).prop("disabled", true);
					
					/* RULES */
					$('.rules_'+data_id).prop("disabled", true);

					/* ADD RULES */
					$('.add_rules_'+data_id).prop("disabled", true);
					
					/* RULES PARAMETR */
					$('.rules_parametr_'+data_id).prop("disabled", true); 
					
					/* RULES PARAMETR */
					$('.rules_parametr_'+data_id).prop("disabled", true); 
				} 
				
				/* DEFAULT */
				$('.default_'+data_id).prop("disabled", false);
				
				/* LABEL */
				$('.label_'+data_id).show(); 
				
				/* PLACEHOLDER */
				$('.placeholder_'+data_id).show(); 
				
				/* TABLE */
				$('.table_'+data_id+' a').trigger('click');
				
				/* DATA TYPE */
				$('.type_'+data_id).prop("disabled", false);
				
				/* LENGTH */
			}  
		});
		
		$('.primary').trigger('change');
		
		/*-------------------[SHOW FORM CHECKED / UNCHECKED]------------------*/
		
		$(document).on('change','.show_on_form', function(){
			var data_id = $(this).attr('data-id'); 
			if($(this).is(':checked'))
			{ 
				$('.label_'+data_id).show();  
				$('.placeholder_'+data_id).show(); 
				$('.label_'+data_id+' a').trigger('click');
				$('#label_'+data_id).addClass('active');
				 /* ELEMENT */
				$('.element_'+data_id).prop("disabled", false);
				
				/* CLASS */
				$('.class_'+data_id).prop("disabled", false);
				
				/* RULES */
				$('.rules_'+data_id).prop("disabled", false);
				
				/* ADD RULES */
				$('.add_rules_'+data_id).prop("disabled", false);
				
				/* RULES PARAMETR */
				$('.rules_parametr_'+data_id).prop("disabled", false); 
			}
			else 
			{ 
				$('.label_'+data_id).hide();  
				$('.placeholder_'+data_id).hide(); 
				$('#label_'+data_id).removeClass('active');
				  
				/* ELEMENT */
				$('.element_'+data_id).prop("disabled", true);
				
				/* CLASS */
				$('.class_'+data_id).prop("disabled", true);
				
				if($('.show_on_table_'+data_id).is(':checked'))
				{
					$('.table_'+data_id+' a').trigger('click');
				} 
				
				/* RULES */
				$('.rules_'+data_id).prop("disabled", true);
				 
				/* ADD RULES */
				$('.add_rules_'+data_id).prop("disabled", true);
				
				/* RULES PARAMETR */
				$('.rules_parametr_'+data_id).prop("disabled", true); 
			}
		}); 

		$('.show_on_form').trigger('change');
		
		/*-------------------[SHOW FORM CHECKED / UNCHECKED]------------------*/
		
		 
		
		
		/*-------------------[SHOW TABLE CHECKED / UNCHECKED]-----------------*/
		
		$(document).on('change','.show_on_table', function(){
			var data_id = $(this).attr('data-id'); 
			if($(this).is(':checked'))
			{ 
				$('.table_'+data_id).show(); 
				$('#table_'+data_id).addClass('active');
				$('.table_'+data_id+' a').trigger('click');
				$('.table_function_'+data_id).prop("disabled", false);
				
				
			}
			else 
			{ 
				$('.table_'+data_id).hide();  
				$('#table_'+data_id).removeClass('active');
				$('.table_function_'+data_id).prop("disabled", true);
				
				if($('.show_on_form_'+data_id).is(':checked'))
				{
					$('.label_'+data_id+' a').trigger('click');
				} 
				
				
			}
		}); 
		
		$('.show_on_table').trigger('change');
		/*-------------------[SHOW TABLE CHECKED / UNCHECKED]-----------------*/
		
		 
		
		/*------------------------[ADD NEW RULES FIELD]-----------------------*/
		
		// CREATE RULES FIELD
		var clicked = 0;
		$(document).on('click','.add_rules',function(){ 
			var data_id     = $(this).attr('data-id');  
			var data_type   = $(this).attr('data-type');  
			clicked += 1;
			var rules = ''; 
			rules +='<div class="rules_row_'+data_id+'">';
				rules +='<div class="col-md-11 form-group rules_main_'+data_id+'">';
					rules +='{if isset($rules)}';
					rules +='<select class="select rules rules_'+data_id+'" data-id="'+data_id+'" clicked-id="'+clicked+'" data-type="'+data_type+'" style="padding:0px;" name="'+data_type+'['+data_id+'][rules]['+clicked+']">';
						rules +='{foreach from=$rules key=rule item=param}';
						rules +='<option value="{$rule}" {if $param} data-param="1" {else} data-param="0" {/if}>{$rule}</option>';
						rules +='{/foreach}';
					rules +='</select>';
					rules +='{/if} ';
				rules +='</div>';
				rules +='<div class="col-md-1 form-group rules_delete_'+data_id+'" style="padding: 8px;">'; 
					rules +='<a href="#" data-popup="tooltip" class="rulesdelete" title="" style="margin-left:15px;" data-original-title="{translate('fields_general_delete')}"><i class="icon-trash"></i></a>';
				rules +='</div>';
				rules +='<div class="col-md-11 form-group imported"></div>';
			rules +='</div>'; 
			$('.rulesarea_'+data_id).append(rules); 
			$('.select').select2();
		});
		 
		// CREATE RULES PARAMETR FIELD
		$(document).on('change','.rules', function(e){ 
			var val         = $(this).val();
			var data_id     = $(this).attr('data-id'); 
			var clicked_id  = $(this).attr('clicked-id');  
			var data_type   = $(this).attr('data-type'); 
			var param       = $(this).find('option[value="'+val+'"]').attr('data-param'); 
			
			if(param == 1)
			{ 
				var input ='<div class="input-group"><input type="text" name="'+data_type+'['+data_id+'][rules_parametr]['+clicked_id+']" value="" class="form-control field_parametr rules_parametr_'+data_id+'"></div>'; 
				$(this).parent().parent().find('div.imported').html(input);
			}
			else 
			{
				$(this).parent().parent().find('div.imported').empty();
			}
		});
		 
		// DELETE RULES FIELD AND RULES PARAMETR FIELD
		$(document).on('click','a.rulesdelete',function(e){ 
			e.preventDefault();
			$(this).parent().parent().remove();
			e.preventDefault();
			return false;
		});
		 
		/*------------------------[ADD NEW RULES FIELD]-----------------------*/
		
		 
		
		/*-------------------[MULTILENGUAL ENABLE / DISABLE]------------------*/
		
		$(document).on('change','#multilingual', function(){ 
			if($(this).is(':checked'))
			{
				$('.translation').show();
				$('.general a').trigger('click');
				$('#language_id').prop("disabled", false);
			}
			else 
			{
				$('.translation').hide();
				$('.general a').trigger('click');
				$('#language_id').prop("disabled", true);
				$('#language_id').val('0').trigger('change');
			}
		}); 
		
		// TRIGGER MULTILENGUAL
		$('#multilingual').trigger('change'); 
		
		/*-------------------[MULTILENGUAL ENABLE / DISABLE]------------------*/
		
		
		
	});
	 
</script>
{literal} 
<script> 
	$(document).on('change','.form_function',function(){
		var value 	= $(this).val();
		var data_id = $(this).find('option[value="'+value+'"]').attr('data-id'); 
		var param 	= $(this).find('option[value="'+value+'"]').attr('data-param'); 
		$.ajax({
			url: "/'.$admin_url.'/extension/get_params/",
			type: "post",
			data: {'method':value},
			success: function (data) {  
				var obj = jQuery.parseJSON( data );
				var iprove = '';
				if(obj.length > 0)
				{
					$.each( obj, function( key, value ) {
						iprove +='<div class="form-group" style="margin-top:10px;margin-bottom:0px;">';
							iprove +='<label>'+value+'</label>';
							iprove +='<input type="text" name="'+param+'['+data_id+']['+value+']" value="" placeholder="'+value+'" class="form-control '+value+' '+value+'_'+data_id+'"/>';
						iprove +='</div>';
					}); 
					$('.'+param+'_form_function_inner_'+data_id).html(iprove);
				}
				else 
				{
					$('.'+param+'_form_function_inner'+data_id).empty();
				} 
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(textStatus, errorThrown);
			} 
		}); 
	}); 
	
	$(document).on('change','.table_function',function(){
		var value 	= $(this).val();
		var data_id = $(this).find('option[value="'+value+'"]').attr('data-id'); 
		var param 	= $(this).find('option[value="'+value+'"]').attr('data-param'); 
		$.ajax({
			url: "/'.$admin_url.'/extension/get_params/",
			type: "post",
			data: {'method':value},
			success: function (data) {  
				var obj = jQuery.parseJSON( data );
				var iprove = '';
				if(obj.length > 0)
				{
					$.each( obj, function( key, value ) {
						iprove +='<div class="form-group" style="margin-top:10px;margin-bottom:0px;">';
							iprove +='<label>'+value+'</label>';
							iprove +='<input type="text" name="'+param+'['+data_id+']['+value+']" value="" placeholder="'+value+'" class="form-control '+value+' '+value+'_'+data_id+'"/>';
						iprove +='</div>';
					}); 
					$('.'+param+'_table_function_inner_'+data_id).html(iprove);
				}
				else 
				{
					$('.'+param+'_table_function_inner_'+data_id).empty();
				} 
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(textStatus, errorThrown);
			} 
		}); 
	});

	$(document).on('change','.all_tables',function(){
		var value = $(this).val();
		var param = $(this).find('option[value="'+value+'"]').attr('data-id');  
		var type  = $(this).find('option[value="'+value+'"]').attr('data-type');  
		$.ajax({
			url: "/'.$admin_url.'/extension/database/",
			type: "post",
			data: {'value':value,'param':param,'type':type},
			success: function (data) { 
				var migration =''; 
				
				var obj = jQuery.parseJSON( data );
				
				migration +='<div class="form-group col-md-12">';
				migration +='<label class="control-label">Key</label>';
				migration +='<select class="select select-search all_tables all_tables_'+param+'" name="'+type+'['+param+'][connected_key]" style="width: 215px;">';  
				$.each( obj, function( key, value ) { migration +='<option data-id="'+param+'" value="'+value+'">'+value+'</option>'; }); 
				migration +='</select>';
				migration +='</div>';
				
				migration +='<div class="form-group col-md-12">';
				migration +='<label class="control-label">Value</label>';
				migration +='<select class="select select-search all_tables all_tables_'+param+'" name="'+type+'['+param+'][connected_value]" style="width: 215px;">';  
				$.each( obj, function( key, value ) { migration +='<option data-id="'+param+'" value="'+value+'">'+value+'</option>';  }); 
				migration +='</select>';
				migration +='</div>';
				
				$('.field_element_'+param).html(migration);
				$('.select').select2();
			},
			error: function(jqXHR, textStatus, errorThrown) {
			   console.log(textStatus, errorThrown);
			} 
		}); 
	});
	
	var Select2Selects = function () { 
		var _componentSelect2 = function () {
			if (!$().select2) { console.warn('Warning - select2.min.js is not loaded.'); return; }
			$('.select').select2({ minimumResultsForSearch: Infinity });
			$('.select-search').select2(); 
			// Format icon
			function iconFormat(icon) {
				var originalOption = icon.element;
				if (!icon.id) {return icon.text;}
				var $icon = '<i class="' + $(icon.element).val() + '"></i>' + icon.text;
				return $icon;
			}
			// Initialize with options
			$('.select-icons').select2({ templateResult: iconFormat, minimumResultsForSearch: Infinity, templateSelection: iconFormat, escapeMarkup: function (m) { return m; } });
		}; 
		// Return objects assigned to module 
		return { init: function () { _componentSelect2(); } }
	}(); 
	// Initialize module
	document.addEventListener('DOMContentLoaded', function () {
		Select2Selects.init();
	});
</script>
{/literal}
{/block}