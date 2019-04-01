<ul class="rating-blogs-ul">
	<li class="header"> <span> {translate('popular_services', true)} </span> </li>
	{if isset($popular_services) && !empty($popular_services)}
		{foreach from=$popular_services item=row}
			<li>
				<a href="{$row->link}">{$row->name}</a>
				<span> {$row->date} </span>
			</li>
		{/foreach}
	{/if}
</ul>