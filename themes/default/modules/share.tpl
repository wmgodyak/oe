<div class="row like-block">
    <span class="m_hearth-like">
        <span class="hearth-like__link wishlist-add {if isset($smarty.session.wishlist[$product.id])}hearth-like__link--liked{/if}" data-id="{$product.id}" data-has-variants="{$product.has_variants}">
           Мені подобається
        </span>
    </span>
</div>
<div class="row">
    <div class="share">
        <div class="heading">
            ПОДІЛИТИСЯ З ДРУЗЯМИ У СОЦМЕРЕЖАХ:
        </div>
        <div class="social-row">
            <a href="javascript:;" class="share-icon vk share-link" data-href="{$page.id}" data-title="{$page.title}" data-img="{$app->images->cover($page.id, 'source')}"></a>
            <a href="javascript:;" class="share-icon fb share-link" data-href="{$product.id}"></a>
            <a href="javascript:;" class="share-icon ok share-link" data-href="{$product.id}"></a>
        </div>
    </div>
</div>