<form action="./components/install" method="post" id="componentsInstall" class="form-horizontal" enctype="multipart/form-data">
    <div class="form-group">
        <label for="data_parent_id" class="col-sm-3 control-label">{$t.components.install_label_tree}</label>
        <div class="col-sm-9">
            <select name="data[parent_id]" id="data_parent_id" class="form-control">
                <option value="0">{$t.components.install_label_tree_home}</option>
                {foreach $tree as $item}
                    <option value="{$item.id}">{$t[$item.controller].action_index}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="type" class="col-sm-3 control-label">{$t.components.type}</label>
        <div class="col-sm-9">
            <select name="data[type]" id="type" class="form-control">
                {foreach $ctype as $k=>$item}
                    <option value="{$item}">{$item}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <div class="form-group">
        <label for="file" class="col-sm-3 control-label">{$t.components.label_file}</label>
        <div class="col-sm-9">
            <input name="file" id="data_file" class="form-control" type="file" required />
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="action" value="install">
</form>