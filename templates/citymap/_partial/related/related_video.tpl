{if isset($relateds) && !empty($relateds)}
<section class="default-section last-added-section use-partner-blog " >
		<div class="container">
			<div class="section-header">
				<div class="row">
					<h3>{translate('related_videos', true)}</h3>
				</div>
			</div>
			<div class="last-added-block">
				<ul class="last-added-ul" >
					{foreach from=$relateds item=$row}
					<li>
						<div class="last-added-image">
							<a href="{$row->link}"> <img src="{$row->image}" alt="{$row->name}" /> </a>
						</div>
						<div class="last-added-content">
							<h3> <a href="{$row->link}" class="bold-header-14">  {$row->name} </a> </h3>
						</div>
					</li>
					{/foreach}
				</ul>
			</div>
		</div>
</section>
{/if}