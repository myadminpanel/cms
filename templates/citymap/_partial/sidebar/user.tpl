<div class="aside-menu-block">
	<ul class="user-panel-ul nav nav-tabs"  role="tablist">
		<li><a {if current_url() eq site_url_multi('user/profile')}class="active" {/if}href="{site_url_multi('user/profile')}"><i class="fas fa-user"></i> {translate('user_profile', true)}</a></li>
		<li><a {if current_url() eq site_url_multi('user/company')}class="active" {/if}href="{site_url_multi('user/company')}"><i class="fas fa-building"></i> {translate('user_company', true)}</a></li>
		<li><a {if current_url() eq site_url_multi('notification')}class="active" {/if}href="{site_url_multi('notification')}"><i class="fas fa-bell"></i> {translate('user_notification', true)}</a></li>
		<!-- <li><a {if current_url() eq site_url_multi('message')}class="active" {/if}href="{site_url_multi('message')}"><i class="fas fa-envelope"></i> {translate('user_messages', true)}</a></li> -->
		<li><a {if current_url() eq site_url_multi('favorite')}class="active" {/if}href="{site_url_multi('favorite')}"><i class="fas fa-star"></i> {translate('user_favorite', true)}</a></li>
		<li><a {if current_url() eq site_url_multi('following')}class="active" {/if}href="{site_url_multi('following')}"><i class="fas fa-eye"></i> {translate('user_following', true)}</a></li>
		<!-- <li><a {if current_url() eq site_url_multi('user/setting')}class="active" {/if}href="{site_url_multi('user/setting')}"><i class="fas fa-cog"></i> {translate('user_setting', true)}</a></li> -->
		<li><a {if current_url() eq site_url_multi('user/change_password')}class="active" {/if}href="{site_url_multi('user/change_password')}"><i class="fas fa-lock"></i> {translate('user_change_password', true)}</a></li>
		<li><a href="{site_url_multi('user/logout')}"><i class="fas fa-power-off"></i> {translate('user_logout', true)}</a></li>
	</ul>
</div>