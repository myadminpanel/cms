
{if !get_setting('comment_enable') || is_loggedin()}
{form_open('/review/add','id="review_form"')}

{if $type eq 'company'}
<div class="comment-value-block">
	<div class="d-flex">
		<div class="c-profile-rating">
			<span class="light-header-20"> {translate('review_company')} </span>
			<div class="rating">
				{for $i=1 to 5}
				<input id="rating-{$i}" type="radio" name="rating" value="{$i}"/><label for="rating-{$i}"><i class="fas fa-star"></i></label>
				{/for}
			</div>
		</div>
	</div>
	{if $comment_count}
		<div class="c-value-right-panel">
			<span class="light-header-20"> {$comment_count} {translate('reviews')}</span>
		</div>
	{/if}
</div>
{/if} 
<div class="comment-form">
	<div class="comment-form-header">
		<h3> <i class="fas fa-comment"></i> {translate('write_comment', true)} </h3>
	</div>
	{if !is_loggedin()}
	<div class="d-flex flex-48 space-between">
		<div class="form-group">
			<input type="text" class="form-control" name="fullname" placeholder="{translate('fullname', true)}" />
		</div>
		<div class="form-group">
			<input type="email" class="form-control" name="email" placeholder="{translate('email', true)}" />
		</div>
	</div>
	{/if}
	<div class="form-group">
		<textarea class="form-control" name="text" placeholder="{translate('comment', true)}"></textarea>
	</div>
	<input type="hidden" value="{$id}" name="data_id" />
	<input type="hidden" value="0" name="parent_id" />
	<input type="hidden" value="{$type}" name="type" />
	<div class="form-group">
		<button type="button" class=" waves-effect btn-style-1 large green" id="btnComment">{translate('submit', true)}</button>
	</div>
</div>
{form_close()}
<script>
	var form_labels = {
		error_fill_all_inputs: "{translate('form_error_fill_all_inputs')}"
	};
	{literal}
	$("button#btnComment").on("click",function(){
		
			var element = $(this);
			$.ajax({
				type: "POST",
				url: '/review/add',
				data: $('#review_form').serialize(),
				dataType: 'json',
				success: function (response) {
					if(response.success) {
						$('textarea[name="text"]').val("");
						alert(response.message);
					} else {
						alert(response.message);
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					console.log(textStatus, errorThrown);
				}
			});
		
	});
	$('input[name="rating"]').on('change', function() {
		let star = $("input[name='rating']:checked").val();
		if(star != 1)
		{
			$('textarea[name="text"]').focus();
		}

	});
	{/literal}
</script>
{else}
	<div class="alert alert-danger">{translate('comment_only_registered_user', true)}</div>
{/if}