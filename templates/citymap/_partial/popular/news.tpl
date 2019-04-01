<ul class="rating-blogs-ul">
	<li class="header"> <span> {translate('popular_news', true)} </span> </li>
	{if isset($popular_news) && !empty($popular_news)}
		{foreach from=$popular_news item=row}
			<li>
				<a href="{$row->link}">{$row->name}</a>
				<span> {$row->date} </span>
			</li>
		{/foreach}
	{/if}
</ul>