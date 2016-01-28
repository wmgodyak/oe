<form action="./plugins/process/{$data.id}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label for="data_parent_id" class="col-sm-3 control-label">{$t.plugins.install_label_tree}</label>
        <div class="col-sm-9">
            <select class="form-control" name="data[parent_id]" id="data_parent_id">
                <option value="0" selected>{$t.plugins.install_label_tree_home}</option>
                {foreach $tree as $item}
                    <option {if $data.id == $item.id}disabled{/if} {if $data.parent_id == $item.id}selected{/if}  value="{$item.id}">{$t[$item.controller].action_index}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="icon" class="col-sm-3 control-label">{$t.plugins.icon}</label>
        <div class="col-sm-9">
            <input name="data[icon]" id="icon"  class="form-control" value="{$data.icon}" required>
        </div>
    </div>
    <div class="form-group">
        <label for="position" class="col-sm-3 control-label">{$t.plugins.position}</label>
        <div class="col-sm-9">
            <input name="data[position]" id="position"  class="form-control" value="{$data.position}" required>
        </div>
    </div>
    <div class="form-group">
        <label for="published" class="col-sm-3 control-label">{$t.common.published}</label>
        <div class="col-sm-9">
            <input name="data[published]" id="published"  class="form-control" value="{$data.published}" required>
        </div>
    </div>
    <div class="form-group">
        <label for="rang" class="col-sm-3 control-label">{$t.plugins.rang}</label>
        <div class="col-sm-9">
            <input name="data[rang]" id="rang"  class="form-control" value="{$data.rang}" required>
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="c" value="{$plugins}">
</form>