<li>
	<div class="company-image">
		<a href="{$row->link}">
			<img src="{$row->image}" alt="{$row->name}" data-filter="false">
			<span class="price">{$row->price} AZN</span>
		</a>
	</div>
	<div class="company-content">
		<h3> <a href="{$row->link}" class="bold-header-18">{$row->name}</a></h3>
		<span class="content">{$row->description}</span>
		<span class="light-header-12 float-right"> <i class="far fa-eye"></i> {$row->view}</span>
		<span class="light-header-12"> <i class="far fa-calendar-alt"></i> {$row->date}</span>
	</div>
</li>