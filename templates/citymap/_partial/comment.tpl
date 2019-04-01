<!-- comment  -->
<div class="comment-block">
		{include file="templates/citymap/_partial/comment_form.tpl"}
		{if isset($comments) && !empty($comments)}
			{foreach from=$comments item=comment}
				<div class="comment-exist-block">
					<div class="comment-exist">
						<div class="comment-header">
							<img src="{$comment->author_image}">
							<h3 class="name"> <a href="{$comment->author_username}">{$comment->author}</a> ( <span class="job"> {$comment->user_type} </span>)
								{if $type eq 'company'}
								<div class="rating">
									{for $i=1 to 5}
									<input id="rating-{$i}" type="radio" name="rating" value="{$i}" {if $i eq $comment->star}checked="checked"{/if} /><label for="rating-{$i}"><i class="fas fa-star"></i></label>
									{/for}
								</div>
							{/if}
							</h3>
						</div>
						{if $comment->text}
						<div class="comment-content">
							<p>
								{$comment->text}
							</p>
						</div>
						{/if}
					</div>
				</div>
			{/foreach}
		{/if}
	</form>
</div>