{extends file=$layout}
{block name=content}
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
						<form action="{current_url()}" method="POST">
							<div class="comment-form">
								<div class="comment-form-header">
									<h3>{$title}</h3>
								</div>
								{if isset($response) && !empty($response)}
									<div class="alert {if $response.success}alert-success{else}alert-danger{/if}">{$response.message}</div>
								{/if}
								<div class="row">
									<div class="col-md-6 offset-md-3">
										<div class="image_container">
											<img id="preview_image" src="{if set_value('image')}{base_url('uploads')}/{set_value('image')}{elseif $user.image}{base_url('uploads/')}{$user.image}{else}{base_url('templates/citymap/assets/image/nophoto.png')}{/if}" class="image" style="" title="{translate('click_and_change_image')}">
											<input type="file" name="file" accept="image/*" style="display:none">
											<input type="hidden" name="image">
											<div class="image_middle">
												<div class="image_text">{translate('upload')}</div>
											</div>
										</div>
									</div>
								</div>
								<div class="d-flex flex-48 space-between">
									<div class="form-group required">
										<label>{translate('firstname')} <sup>*</sup></label>
										<input type="text" name="firstname" value="{$user.firstname}" class="form-control" placeholder="{translate('firstname')}" />
									</div>
									<div class="form-group required">
										<label>{translate('lastname')} <sup>*</sup></label>
										<input type="text" name="lastname" value="{$user.lastname}" class="form-control" placeholder="{translate('lastname')}" />
									</div>
									<div class="form-group required">
										<label>{translate('email')} <sup>*</sup></label>
										<input type="email" name="email" value="{$user.email}" class="form-control" placeholder="{translate('email')}"/>
									</div>
									<div class="form-group required">
										<label>{translate('mobile')} <sup>*</sup></label>
										<input type="text" name="mobile" value="{$user.mobile}"  class="form-control" placeholder="{translate('mobile')}" />
									</div>
								</div>
								<div class="form-group">
									<button type="submit" class=" waves-effect btn-style-1 large green"> {translate('update_profile')} </button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
{literal}
<style>
	#preview_image {
		witdh:200px;
		height:200px;
		cursor:pointer;
		padding:5px;
		border: 1px solid #dfdfdf;
		border-radius: 50%;
	}
	.image_container {
		position: relative;
		width: 200px;
		border-radius: 50%;
		margin: 0 auto;
	}
	.image {
		opacity: 1;
		display: block;
		width: 100%;
		height: auto;
		transition: .5s ease;
		backface-visibility: hidden;
		border-radius: 50%;
	}
	.image_middle {
		transition: .5s ease;
		opacity: 0;
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		-ms-transform: translate(-50%, -50%);
		text-align: center;
	}
	.image_container:hover .image {
		opacity: 0.3;
	}
	.image_container:hover .image_middle {
		opacity: 1;
	}

	.image_text {
		background-color: #0b7a50;
		color: white;
		font-size: 12px;
		padding: 12px 12px;
		cursor:pointer;
	}
	</style>
	<script>
		$('.image_text').on('click', function() {

		$('input[name=\'file\']').trigger('click');

		if (typeof timer != 'undefined') {
			clearInterval(timer);
		}

		timer = setInterval(function() {
			if ($('input[name=\'file\']').val() != '') {
				clearInterval(timer);
				data = new FormData();
				 data.append('file', $('input[name=\'file\']')[0].files[0]);
				$.ajax({
					url: '/attachment/upload',
					type: 'post',
					dataType: 'json',
	 				enctype: 'multipart/form-data',
					data: data,
					cache: false,
					contentType: false,
					processData: false,
					success: function(response) {
						if (response.success) {
							$('input[name="image"]').val(response.image);
							$('#preview_image').attr('src', '/uploads/'+response.image);
						}
					},
					error: function(xhr, ajaxOptions, thrownError) {
						alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				});
			}
		}, 500);
	});
	</script>
	{/literal}
</style>
{/block}