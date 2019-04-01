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
						<form action="{current_url()}" method="POST">
							<div class="comment-form">								
								<div class="comment-form-header">
									<h3>{$title}</h3>
								</div>
								{if isset($response) && !empty($response)}
									<div class="alert {if $response.success}alert-success{else}alert-danger{/if}">{$response.message}</div>
								{/if}
								<div class="d-flex flex-48 space-between">
									<div class="form-group required">
										<label>{translate('new_password')} <sup>*</sup></label>
										<input type="password" name="password" class="form-control" placeholder="{translate('new_password')}" />
									</div>
									<div class="form-group required">
										<label>{translate('new_repassword')} <sup>*</sup></label>
										<input type="password" name="repassword" class="form-control" placeholder="{translate('new_repassword')}" />
									</div>									
								</div>
								<div class="form-group">
									<button type="submit" class=" waves-effect btn-style-1 large green">{translate('change_password')}</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
{/block}