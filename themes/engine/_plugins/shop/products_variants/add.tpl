{function name=fvOptions}
    {foreach $items as $item}
        {if $item.type=='folder'}
            <optgroup label="{$item.name}">
                {call fvOptions items=$item.items parent=$item.name}
            </optgroup>
        {else}
            <option value="{$item.id}">{$item.name}</option>
        {/if}
    {/foreach}
{/function}
<form action="plugins/productsVariants/add/{$content_id}" method="post" id="productsVariantsForm" class="form-horizontal">
    <div class="row">
        <div class="col-md-4">
            <div class="form-group">
                <div class="col-md-12">
                    <select name="data[features_id][]" id="" class="form-control variants-feature" required>
                        {call fvOptions items=$features}
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group">
                <div class="col-md-12">
                    <select name="data[values_id][]" id="" class="form-control variants-values" disabled required></select>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="form-group">
                <div class="col-md-12">
                    <button class="btn btn-primary b-variants-add-row" title="Додати ще" type="button"><i class="fa fa-plus-circle"></i></button>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="add">
</form>
<script>
    var FV = {json_encode($features)};
</script>
<div style="display: none;" id="vCnt">
    <div class="row">
        <div class="col-md-4">
            <div class="form-group">
                <div class="col-md-12">
                    <select name="data[features_id][]" id="" class="form-control variants-feature" required>
                        {call fvOptions items=$features}
                    </select>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="form-group">
                <div class="col-md-12">
                    <select name="data[values_id][]" id="" class="form-control variants-values" disabled required></select>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="form-group">
                <div class="col-md-12">
                    <button class="btn btn-primary b-variants-add-row" title="Додати ще" type="button"><i class="fa fa-plus-circle"></i></button>
                    <button class="btn btn-primary b-variants-rm-row" title="Видалити" type="button"><i class="fa fa-remove"></i></button>
                </div>
            </div>
        </div>
    </div>
</div>