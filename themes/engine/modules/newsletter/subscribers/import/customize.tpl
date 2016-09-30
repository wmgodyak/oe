<form action="module/run/newsletter/subscribers/import/process" method="post" enctype="multipart/form-data" id="usersImportCustomizeForm">
    <p>Налаштуйте поля</p>
    <div class="form-group">

        <div class="col-md-12">
            {foreach $csv_cols as $ck=>$col}
                <div class="row">
                    <div class="col-md-6">
                        {$col}
                    </div>
                    <div class="col-md-6">
                        <select name="csv_conf[{$ck}]" data-id="{$ck}" class="form-control csv-conf">
                            <option value="">--</option>
                            {foreach $allowed_cols as $k=>$name}
                                <option value="{$k}">{$name}</option>
                            {/foreach}
                            <option value="meta">Meta</option>
                        </select>
                        <div class="meta-col-{$ck}" style="display: none;">
                            <input type="text" name="meta[{$ck}]" class="form-control" placeholder="enter meta_k">
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="file" value="{$file}">
</form>