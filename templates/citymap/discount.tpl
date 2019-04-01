{extends file=$layout}
{block name=content}

	<!-- ==== ==== ==== ==== Random company start ==== ==== ==== ==== -->
	<!-- <section class="default-section full-company">
		<div class="container">
			<div class="section-header">
				<div class="row">
					<h3 class="big-title" >{$title}</h3>
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<div class="random-company" >
				<div class="rand-big-item"><a href="#"> <img src="{base_url('templates/citymap/assets/image/banners/banner1.png')}" alt="" /> </a> </div>
				<div class="rand-big-item">
					<div class="rand-medium-item">
						<a href="#"> <img src="{base_url('templates/citymap/assets/image/banners/banner2.png')}" alt="banner3" /> </a> 
						<a href="#"> <img src="{base_url('templates/citymap/assets/image/banners/banner2.png')}" alt="banner3" /> </a> 
					</div>
					<div class="rand-mini-item">
						<a href="#"> <img src="{base_url('templates/citymap/assets/image/banners/banner3.png')}" alt="banner3" /> </a> 
						<a href="#"> <img src="{base_url('templates/citymap/assets/image/banners/banner3.png')}" alt=" banner3" /> </a> 
						<a href="#"> <img src="{base_url('templates/citymap/assets/image/banners/banner3.png')}" alt="banner3" /> </a> 
					</div>
				</div>
			</div>
		</div>
	</section> -->
	<!-- ==== ==== ==== ==== Random company start ==== ==== ==== ==== -->
	<!-- ==== ==== ==== ==== company item slider  start ==== ==== ==== ==== -->
	<!-- <section class="default-section">
		<div class="container">
			<div class="company-block relative">
				<ul class="company-ul relative owl-carousel" jsGet='carousel'>
					<li>
						<div class="company-image">
							<a href="#"> <img src="{base_url('templates/citymap/assets/image/image1.png')}" alt="company" /> </a>
						</div>
					</li>
					<li>
						<div class="company-image">
							<a href="#"> <img src="{base_url('templates/citymap/assets/image/image1.png')}" alt="company" /> </a>
						</div>
					</li>
					<li>
						<div class="company-image">
							<a href="#"> <img src="{base_url('templates/citymap/assets/image/image1.png')}" alt="company" /> </a>
						</div>
					</li>
					<li>
						<div class="company-image">
							<a href="#"> <img src="{base_url('templates/citymap/assets/image/image1.png')}" alt="company" /> </a>
						</div>
					</li>
					<li>
						<div class="company-image">
							<a href="#"> <img src="{base_url('templates/citymap/assets/image/image1.png')}" alt="company" /> </a>
						</div>
					</li>
				</ul>
				<div class="slider-buttons position">
					<button type="button" jsClick="prevSlide" class="prev-slider"> <i class="fas fa-chevron-left"></i> </button>
					<button type="button" jsClick="nextSlide" class="next-slider"> <i class="fas fa-chevron-right"></i> </button>
				</div>
			</div>
		</div>
	</section> -->
	<!-- ==== ==== ==== ==== company item slider  start ==== ==== ==== ==== -->
	<!-- ==== ==== ==== ==== Company  start ==== ==== ==== ==== -->
	<section class="default-section full-company">
		<div class="container">
			<div class="section-header">
				<div class="row">
					<h3 class="big-title" > {$title} </h3>
					{include file="templates/citymap/_partial/breadcrumb.tpl"}
				</div>
			</div>
			<!-- <div class="section-header">
				<div class="row">
					<h3> Son əlavə edilənlər </h3>
					<div class="order-block">
						<span> Sırala: </span>
						<select class="form-control">
							<option value="0">  Seçilməyib </option>
							<option value="1">  A-Z </option>
							<option value="2"> Z-A </option>
						</select>
					</div>
				</div>
			</div> -->
			{if isset($rows) && !empty($rows)}
			<div class="company-block">
				<ul class="company-ul" >
					{foreach from=$rows item=row}
					<li>
						<div class="company-image">
							<a href="{$row->link}"> <img src="{$row->image}" alt="{$row->name}" /> </a>
						</div>
						<div class="company-content">
							<h3> <a href="{$row->link}" class="bold-header-14">{$row->name}</a></h3>
							<span class="light-header-12"><i class="far fa-calendar-alt"></i> {$row->date}</span>
						</div>
					</li>
					{/foreach}
				</ul>
			</div>
			{/if}
		</div>
	</section>
{/block}