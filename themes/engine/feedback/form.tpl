<form action="module/run/feedback/process/{$data.id}" method="post" id="form" class="form-horizontal">
    <div class="form-group">
        <label for="data_name" class="col-sm-3 control-label">{$t.feedback.name}</label>
        <div class="col-sm-9">
            <input readonly id="data_name"  class="form-control" value="{if isset($data.name)}{$data.name}{/if}">
        </div>
    </div>
    <div class="form-group">
        <label for="data_phone" class="col-sm-3 control-label">{$t.feedback.phone}</label>
        <div class="col-sm-9">
            <input readonly id="data_phone"  class="form-control" value="{if isset($data.phone)}{$data.phone}{/if}">
        </div>
    </div>
    <div class="form-group">
        <label for="data_email" class="col-sm-3 control-label">{$t.feedback.email}</label>
        <div class="col-sm-9">
            <input readonly id="data_email"  class="form-control" value="{if isset($data.email)}{$data.email}{/if}">
        </div>
    </div>
    
    <div class="form-group">
        <label for="data_message" class="col-sm-3 control-label">{$t.feedback.message}</label>
        <div class="col-md-9">
            <textarea readonly id="data_message" class="form-control" style="height: 150px;" placeholder="{$t.feedback.message}">{if isset($data.message)}{$data.message}{/if}</textarea>
        </div>
    </div>

    <div class="form-group">
        <label for="data_message" class="col-sm-3 control-label">{$t.feedback.status}</label>
        <div class="col-md-9">
            <select name="data[status]" id="data_status">
                {foreach $statuses as $k=>$s}
                    <option value="{$s}" {if $data.status == $s}selected{/if}>{$s}</option>
                {/foreach}
            </select>
        </div>
    </div>


    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="data[status]" value="processed">
    <input type="hidden" name="data[manager_id]" value="{$admin.id}">
</form>