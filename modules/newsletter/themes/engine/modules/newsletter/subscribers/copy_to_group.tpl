<form class="form-horizontal" action="module/run/newsletter/subscribers/copyToGroup" method="post" id="copyToGroupForm">
    <div class="form-group">
        <label for="group_id" class="col-md-3 control-label">Select group</label>
        <div class="col-md-9">
            <select class="form-control" name="group_id" id="group_id" >
                {foreach $groups as $group}
                    <option value="{$group.id}">{$group.name}</option>
                {/foreach}
            </select>
        </div>
    </div>
    <input type="hidden" name="action" value="do">
    <input type="hidden" name="token" value="{$token}">
    {if $items|count}
        {foreach $items as $i=>$item}
            <input type="hidden" name="items[]" value="{$item}">
        {/foreach}
    {/if}
</form>