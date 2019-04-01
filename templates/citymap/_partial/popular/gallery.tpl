<ul class="rating-blogs-ul">
	<li class="header"> <span> {translate('popular_galleries', true)} </span> </li>
	{if isset($popular_galleries) && !empty($popular_galleries)}
		{foreach from=$popular_galleries item=row}
			<li>
				<a href="{$row->link}">{$row->name}</a>
				<span> {$row->date} </span>
			</li>
		{/foreach}
	{/if}
</ul>