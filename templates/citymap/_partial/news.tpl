<div class="col-md-4 col-sm-6 col-12">
	<div class="blog-image">
		<a href="{$row->link}"> <img src="{$row->image}" alt="{$row->name}" /> </a>
	</div>
	<div class="blog-content">
		<h3> <a href="{$row->link}" class="bold-header-14"> {$row->name}</a> </h3>
		<h5 class="light-header-16">{$row->description}</h5>
		<div class="f-flex-inline">
			<span class="light-header-12"><i class="far fa-calendar-alt"></i> {$row->date}</span>
			<span class="light-header-12"><i class="fas fa-user-alt"></i> {$row->author}</span>
		</div>
	</div>
</div>