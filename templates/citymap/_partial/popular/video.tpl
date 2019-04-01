<ul class="rating-blogs-ul">
	<li class="header"> <span> {translate('popular_videos', true)} </span> </li>
	{if isset($popular_videos) && !empty($popular_videos)}
		{foreach from=$popular_videos item=row}
			<li>
				<a href="{$row->link}">{$row->name}</a>
				<span> {$row->date} </span>
			</li>
		{/foreach}
	{/if}
</ul>