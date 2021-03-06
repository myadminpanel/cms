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
				<div class="col-lg-12 col-md-12 sm-padding-l p-r user-p-exist">
					<ul class="page-tabs nav nav-tabs" role="tablist">
						<li><a href="{site_url_multi('user/company')}">{translate('company')}</a></li>
						<li><a class="active" href="{site_url_multi('user/gallery')}">{translate('gallery')}</a></li>
						<li><a href="{site_url_multi('user/video')}">{translate('video')}</a></li>
						<li><a href="{site_url_multi('user/news')}">{translate('news')}</a></li>
						<li><a href="{site_url_multi('user/product')}">{translate('product')}</a></li>
						<li><a href="{site_url_multi('user/service')}">{translate('service')}</a></li>
						<li><a href="{site_url_multi('user/discount')}">{translate('discount')}</a></li>
					</ul>
					<div class="combo-jumbotron comment-form">
						<div class="comment-form-header">
							<h5>{translate('all_gallery')}</h5>
							<a href="{site_url_multi('gallery/add')}"><i class="fas fa-plus"></i> {translate('add_gallery')}</a>
						</div>
						<div class="style-table">
							<table>
								<thead>
									<tr>
										<th>{translate('gallery_name')}</th>
										<th>{translate('gallery_company')}</th>
										<th>{translate('gallery_status')}</th>
										<th>{translate('gallery_date')}</th>
										<th>{translate('gallery_action')}</th>
									</tr>
								</thead>
								<tbody>
									{if isset($rows) && !empty($rows)}
										{foreach from=$rows item=row}
											<tr>
												<td>{$row->name}</td>
												<td>{$row->company}</td>
												<td>{$row->status}</td>
												<td>{$row->date}</td>
												<td>
													<div class="panel-control">
														{if $row->link}
															<a href="{$row->link}"><i class="far fa-eye"></i> </a>
														{/if}
														<a href="{$row->edit_link}"> <i class="fas fa-pencil-alt"></i> </a>
														<a href="{$row->delete_link}"> <i class="far fa-trash-alt"></i> </a>
													</div>
												</td>
											</tr>
										{/foreach}
									{else}
									<tr>
										<td colspan="5"><div class="alert alert-danger">{translate('gallery_not_found')}</div></td>
									</tr>
									{/if}
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
{/block}