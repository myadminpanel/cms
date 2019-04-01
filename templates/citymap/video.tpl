{extends file=$layout}
{block name=content}
	<!-- ==== ==== ==== ==== Random company start ==== ==== ==== ==== -->
	<section class="default-section full-company">
		<div class="container">
			<div class="section-header">
				<div class="row">
					<h3 class="big-title" >{$title}</h3>
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 p-l-r">
					<div class="control-items">
						<div class="order-block">
							<!-- <span> Sırala: </span>
							<select class="form-control">
								<option value="0">  Seçilməyib </option>
								<option value="1">  A-Z </option>
								<option value="2"> Z-A </option>
							</select> -->
						</div>
						<div class="listed-style-block">
							<button type="button" data-product-filter="list" class=" waves-effect btn-style-2 white-border active"> <i class="fas fa-th-large"></i> </button>
							<button type="button" data-product-filter="large" class=" waves-effect btn-style-2 white-border"> <i class="fas fa-list"></i> </button>
						</div>
					</div>
					<div class="company-block product">
						<ul class="company-ul">
							{if isset($rows) && !empty($rows)}
								{foreach from=$rows item=row}
								<li>
									<div class="company-image">
										<a href="{$row->link}"><img src="{$row->image}" alt="{$row->name}" /> </a>
									</div>
									<div class="company-content">
										<h3> <a href="{$row->link}" class="bold-header-18"> {$row->name}</a> </h3>
										<span class="light-header-12 float-right"><i class="far fa-eye"></i> {$row->view}</span>
										<span class="light-header-12"> <i class="far fa-calendar-alt"></i> {$row->date}</span>
									</div>
								</li>
								{/foreach}
							{/if}
						</ul>
						{$pagination}
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- ==== ==== ==== ==== Random company start ==== ==== ==== ==== -->
{/block}