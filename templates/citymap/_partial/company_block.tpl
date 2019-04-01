{if isset($company) && !empty($company)}
	<div class="mini-company-block">
		<div class="mini-company-image">
			<img src="{$company->image}" alt="{$company->name}" />
		</div>
		<div class="mini-company-header">
			<h3>{$company->name}</h3>
		</div>
		<div class="mini-company-content">
			<p>{$company->description}</p>
		</div>
		<div class="mini-company-url">
			<a href="{$company->url}" class=" waves-effect btn-style-2 green" >{translate('company_profile', true)}</a>
		</div>
	</div>
{/if}