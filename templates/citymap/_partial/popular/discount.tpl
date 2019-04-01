<ul class="rating-blogs-ul">
	<li class="header"> <span> {translate('popular_discounts', true)} </span> </li>
	{if isset($popular_discounts) && !empty($popular_discounts)}
		{foreach from=$popular_discounts item=row}
			<li>
				<a href="{$row->link}">{$row->name}</a>
				<span> {$row->date} </span>
			</li>
		{/foreach}
	{/if}
</ul>