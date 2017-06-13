<form action="module/run/shop/products/kits/create/{$products_id}" method="post" id="productsKitsForm">
    <div class="form-group">
        <label class="col-sm-3 control-label">Enter name</label>
        <div class="col-sm-9">
            <input type="text" class="form-control" name="data[name]" required>
            <input type="hidden" class="form-control" name="data[products_id]" value="{$products_id}">
            <input type="hidden" class="form-control" name="token" value="{$token}">
            <input type="hidden" class="form-control" name="action" value="save">
        </div>
    </div>
</form>