{if get_banner('banner_product_sidebar')}
{assign var=banner_product_sidebar value=get_banner('banner_product_sidebar')}
<div class="mini-banner">
	<a target="_blank" href="{$banner_product_sidebar->url}"> <img src="/uploads/{$banner_product_sidebar->image}" /> </a>
</div>
{/if}