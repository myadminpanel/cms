{extends file=$layout}
{block name=content}
<!-- ==== ==== ==== ==== User Profile start ==== ==== ==== ==== -->
	<section class="default-section full-company">
		<div class="container">
			<div class="section-header">
				<div class="row">
					<div class="section-header">
						<h3 class="medium-title">{$title}</h3>
					</div>
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<div class="row">
				<div class="col-lg-3 col-md-12 sm-padding-r p-l">
					{include file="templates/citymap/_partial/sidebar/user.tpl"}
				</div>
				<div class="col-lg-9 col-md-12 sm-padding-l p-r user-p-exist">
					<div class="combo-jumbotron tab-content">
						<div class="comment-form">
							<div class="comment-form-header">
								<h3>{$title}</h3>
								{if isset($notifications) && !empty($notifications)}<a href="#" class="notification_delete_all"> <i class="fas fa-trash-alt"></i> {translate('clean_all_notification')}</a>{/if}
							</div>
							{if isset($notifications) && !empty($notifications)}
								{foreach from=$notifications item=notification}
									<div class="alert alert-unread alert-dismissible fade show notification" role="alert">
										<button type="button" class="close notification_delete" data-id="{$notification->id}">
											<span aria-hidden="true">&times;</span>
										</button>
										{$notification->text}
									</div>
								{/foreach}
							{else}
								<div class="alert alert-warning">{translate('notification_not_found')}</div>
							{/if}							
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	{literal}
	<script type="text/javascript">
	$('.notification_delete').on('click', function(){
		let element = $(this);
		let notification_id = $(this).data('id');
		$.ajax({
			type: "POST",
			url: '/notification/delete',
			data: {'notification_id': notification_id},
			dataType: 'json',
			success: function (response) {
				if(response.success)
				{
					alert(response.message);
					element.parent().fadeOut();
				}
				else
				{
					alert(response.message);
				}

			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(textStatus, errorThrown);
			}
		});
	});
	</script>

	<script type="text/javascript">
	$('.notification_delete_all').on('click', function(){
		$.ajax({
			type: "POST",
			url: '/notification/delete_all',
			dataType: 'json',
			success: function (response) {
				if(response.success)
				{
					alert(response.message);
					$('.notification').fadeOut();
				}
				else
				{
					alert(response.message);
				}

			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.log(textStatus, errorThrown);
			}
		});
	});
	</script>
	{/literal}
{/block}