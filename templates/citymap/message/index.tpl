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
								<h3> Mesajlar </h3>
								<a href="#"> <i class="fas fa-trash-alt"></i> Bütün bildirşləri təmizlə </a>
							</div>
							<div class="d-flex space-between">
								<ul class="message-list">
									<li> <a href="#"> Citymap MMC </a> </li>
									<li> <a href="#"> Citymap MMC </a> </li>
									<li> <a href="#"> Citymap MMC </a> </li>
									<li> <a href="#"> Citymap MMC </a> </li>
									<li> <a href="#"> Citymap MMC </a> </li>
									<li> <a href="#"> Citymap MMC </a> </li>
									<li> <a href="#"> Citymap MMC </a> </li>
									<li> <a href="#"> Citymap MMC </a> </li>
									<li> <a href="#" class="active"> Kamran Nəcəfzadə </a> </li>
								</ul>
								<div class="message-block">
									<div class="message-header d-flex space-between"> <h4> Şirkət məlumatları </h4>  <a href="#"> Mesajı sil </a> </div>
									<div class="message-content">
										<p>
											Hörmətli istifadəçi, <br>
											Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod 
											tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, 
											quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo 
											consequat. 
										</p>
									</div>
									<div class="message-footer">
										<form>
											<div class="form-group">
												<label> Cavab : </label>
												<input type="text" placeholder="" class="form-control" />
												<button type="submit" class=" waves-effect btn-style-1 green"> Göndər </button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
{/block}