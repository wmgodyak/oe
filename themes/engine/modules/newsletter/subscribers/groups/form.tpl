<form class="form-horizontal" action="module/run/newsletter/subscribers/groups/process/{if isset($data.id)}{$data.id}{/if}" method="post" id="newsletter_subscribers_group_form">
    <div class="form-group">
        <label for="name" class="col-md-3 control-label">Name</label>
        <div class="col-md-9">
            <input type="text" class="form-control" name="name" id="name" value="{if isset($data.name)}{$data.name}{/if}" required>
        </div>
    </div>
    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="token" value="{$token}">
</form>