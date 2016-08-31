<div class="form-group">
    <label for="product_main_categories_id" class="col-md-2 control-label">
        {$t.shop.main_category}
    </label>
    <div class="col-md-10">
        <p class="form-control-static">
            <a href="module/run/shop/categories/edit/{$main_category.id}" id="a_main_cat_id" target="_blank">{$main_category.name}</a>
            <a href="javascript:;" title="Змінити" class="shop-product-change-main-category" data-id="{$main_category.id}"><i class="fa fa-pencil"></i></a>
        </p>
        <input type="hidden" name="main_categories_id" id="inp_main_categories_id">
    </div>
</div>

<div class="form-group">
    <label for="categories" class="col-md-2 control-label">Дод. категорії</label>
    <div class="col-md-10">
        <p class="form-control-static" id="sp_selected_categories">
            {foreach $selected_categories as $cat}
                <span class="badge badge-info">
                <a href="module/run/shop/categories/edit/{$cat.id}" target="_blank">{$cat.name}</a>
                <a href="javascript:;" title="Змінити" class="shop-product-delete-category" data-id="{$cat.id}"><i class="fa fa-remove"></i></a>
                </span>
            {/foreach}
            <a href="javascript:;" title="Додати" class="shop-product-add-category" data-id="{$cat.id}"><i class="fa fa-plus-circle"></i></a>
        </p>
    </div>
</div>