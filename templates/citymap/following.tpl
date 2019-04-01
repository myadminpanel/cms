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
								{if count($companies) > 0}<a href="#" class="following_delete_all"><i class="fas fa-trash-alt"></i> {translate('unfollow_all')} </a>{/if}
							</div>
							{if isset($companies) && !empty($companies)}
								<div class="last-added-block">
									<ul class="last-added-ul" >
										{foreach from=$companies item=row}
										<li class="followed_company">
											<div class="last-added-image">
												<a href="{$row->link}"> <img src="{$row->image}" alt="{$row->name}" /> </a>
											</div>
											<div class="last-added-content">
												<h3> <a href="{$row->link}" class="bold-header-14">  {$row->name} </a> </h3>
												<span class="light-header-12"> {$row->description} </span>
												<button type="button" data-id="{$row->id}" class="btn btn-sm btn-block btn-danger following_delete"><i class="fas fa-minus-circle"></i> {translate('unfollow')}</button>
											</div>
										</li>
										{/foreach}
									</ul>
								</div>
							{/if}
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	{literal}
	<script type="text/javascript">
	$('.following_delete').on('click', function(){
		let element = $(this);
		let company_id = $(this).data('id');
		$.ajax({
			type: "POST",
			url: '/following/remove',
			data: {'company_id': company_id},
			dataType: 'json',
			success: function (response) {
				if(response.success)
				{
					alert(response.message);
					element.parent().parent().fadeOut();
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
	$('.following_delete_all').on('click', function(){
		let element = $(this);
		let company_id = $(this).data('id');
		$.ajax({
			type: "POST",
			url: '/following/remove_all',
			dataType: 'json',
			success: function (response) {
				if(response.success)
				{
					alert(response.message);
					$('.followed_company').fadeOut();
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