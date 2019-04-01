{if get_banner('banner_service_sidebar')}
{assign var=banner_service_sidebar value=get_banner('banner_service_sidebar')}
<div class="mini-banner">
	<a target="_blank" href="{$banner_service_sidebar->url}"> <img src="/uploads/{$banner_service_sidebar->image}" /> </a>
</div>
{/if}