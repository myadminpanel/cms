<ul class="rating-blogs-ul">
	<li class="header"> <span> {translate('popular_products', true)} </span> </li>
	{if isset($popular_products) && !empty($popular_products)}
		{foreach from=$popular_products item=row}
			<li>
				<a href="{$row->link}">{$row->name}</a>
				<span> {$row->date} </span>
			</li>
		{/foreach}
	{/if}
</ul>