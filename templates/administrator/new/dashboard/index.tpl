{extends file=$layout}
{block name=content}
	<div class="content">
		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-white">
					<div class="panel-heading">
						<h5 class="panel-title">Gözləmədə olanlar</h5>
					</div>
					<div class="panel-body">
						{if $waitings}
						{foreach from=$waitings item=module}
							<div class="col-lg-3 col-md-6 col-sm-6">
								<div class="panel panel-body panel-body-accent" style="min-height:114px;">
									<div class="media no-margin">
										<div class="media-left media-middle">
											<a href="{$module->link}"><i class="{$module->icon} icon-3x text-info-800"></i></a>
										</div>

										<div class="media-body text-right">
											<h3 class="no-margin text-semibold"><span class="text-danger">{$module->count}</span></h3>
											<span class="text-uppercase text-size-mini text-muted">{$module->name}</span>
										</div>
									</div>
								</div>
							</div>
							
						{/foreach}
					{/if}
					</div>
				</div>
				<div class="panel panel-white">
					<div class="panel-heading">
						<h5 class="panel-title">Notification</h5>
					</div>
					<div class="panel-body">
						{if isset($notifications) && !empty($notifications)}
							{foreach from=$notifications item=notification}
							<div class="alert alert-primary no-border">
								<strong>{$notification->created_at}</strong> {$notification->text}
							</div>
							{/foreach}
						{/if}
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="row">
					{if $modules}
						{foreach from=$modules item=module}
							<div class="col-lg-4 col-md-6 col-sm-6">
								<div class="panel panel-body panel-body-accent" style="min-height:114px;">
									<div class="media no-margin">
										<div class="media-left media-middle">
											<a href="{$module->link}"><i class="{$module->icon} icon-3x text-info-800"></i></a>
										</div>

										<div class="media-body text-right">
											<h3 class="no-margin text-semibold"><span class="text-success">{$module->active_count}</span> / <span class="text-danger">{$module->deactive_count}</span></h3>
											<span class="text-uppercase text-size-mini text-muted">{$module->name}</span>
										</div>
									</div>
								</div>
							</div>
							
						{/foreach}
					{/if}
				</div>
			</div>
		</div>
	</div>
{/block}