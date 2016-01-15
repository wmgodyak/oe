<form action="./components/install" method="post" id="componentsInstall">
    <div class="form-group">
        <label for="data_name" class="col-sm-3 control-label">{$t.components.install_label_tree}</label>
        <div class="col-sm-9">
            <select name="data[parent_id]" id="data_parent_id" class="form-control">
                <option value="0">{$t.components.install_label_tree_home}</option>
                {foreach $tree as $item}
                    <option value="{$item.id}">{$t[$item.controller].action_index}</option>
                {/foreach}
            </select>
        </div>
    </div>

    <input type="hidden" name="data[type]" value="{$type}">
    <input type="hidden" name="t" value="{$type}">
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="c" value="{$component}">
    <input type="hidden" name="action" value="install">
</form>