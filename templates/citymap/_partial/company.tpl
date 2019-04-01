<li>
	<div class="last-added-image">
		<a href="{$row->link}">
		{if isset($row->country_code) && $row->country_code}
			<div class="m-mini-icon">
				<img src="{$row->country_code}"/>
			</div>
		{/if}
		<img src="{$row->image}" alt="{$row->name}" /> </a>
	</div>
	<div class="last-added-content">
		<h3> <a href="{$row->link}" class="bold-header-14">{$row->name}</a></h3>
		<span class="light-header-12"> {$row->description}</span>
	</div>
</li>