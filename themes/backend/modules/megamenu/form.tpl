{*{d($data)}*}
{*<pre>*}
{*[id] => 1*}
{*[] => oyi-top-menu*}
{*[] => Top Menu*}
{*[] => 1*}
{*[] => 0*}
{*[] => 1*}
{*[] =>*}

{*[] => horizontal*}
{*[] => 0*}
{*[] => hover*}
{*[] =>*}
{*[] =>*}
{*[] => 0*}
{*</pre>*}

<form class="form-horizontal" action="module/run/users/process/{if isset($data.id)}{$data.id}{/if}" enctype="multipart/form-data" method="post" id="form">
    <div class="row">
        <div class="col-md-9">
            <fieldset>
                <legend>{$t.common.legend_main}</legend>
                <div class="form-group">
                    <label for="data_name" class="col-sm-3 control-label">{$t.megamenu.form.name}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[name]" id="data_name" value="{if isset($data.name)}{$data.name}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_alias" class="col-sm-3 control-label">{$t.megamenu.form.alias}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[alias]" id="data_alias" value="{if isset($data.alias)}{$data.alias}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_status" class="col-sm-3 control-label">{$t.megamenu.form.status}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[status]" id="data_status" value="{if isset($data.status)}{$data.status}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_mobile_template" class="col-sm-3 control-label">{$t.megamenu.form.mobile_template}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[mobile_template]" id="data_mobile_template" value="{if isset($data.mobile_template)}{$data.mobile_template}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_disable_bellow" class="col-sm-3 control-label">{$t.megamenu.form.disable_bellow}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[disable_bellow]" id="data_disable_bellow" value="{if isset($data.disable_bellow)}{$data.disable_bellow}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_html" class="col-sm-3 control-label">{$t.megamenu.form.html}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[html]" id="data_html" value="{if isset($data.html)}{$data.html}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_desktop_template" class="col-sm-3 control-label">{$t.megamenu.form.desktop_template}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[desktop_template]" id="data_desktop_template" value="{if isset($data.desktop_template)}{$data.desktop_template}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_disable_iblocks" class="col-sm-3 control-label">{$t.megamenu.form.disable_iblocks}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[disable_iblocks]" id="data_disable_iblocks" value="{if isset($data.disable_iblocks)}{$data.disable_iblocks}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_event" class="col-sm-3 control-label">{$t.megamenu.form.event}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[event]" id="data_event" value="{if isset($data.event)}{$data.event}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_classes" class="col-sm-3 control-label">{$t.megamenu.form.classes}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[classes]" id="data_classes" value="{if isset($data.classes)}{$data.classes}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_width" class="col-sm-3 control-label">{$t.megamenu.form.width}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[width]" id="data_width" value="{if isset($data.width)}{$data.width}{/if}" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_scrolltofixed" class="col-sm-3 control-label">{$t.megamenu.form.scrolltofixed}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[scrolltofixed]" id="data_scrolltofixed" value="{if isset($data.scrolltofixed)}{$data.scrolltofixed}{/if}" required>
                    </div>
                </div>






                {*<div class="form-group">*}
                    {*<label for="data_surname" class="col-sm-3 control-label">{$t.megamenu.form.alias}</label>*}
                    {*<div class="col-sm-9">*}
                        {*<input type="text" class="form-control" name="data[surname]" id="data_surname" value="{if isset($data.surname)}{$data.surname}{/if}" required>*}
                    {*</div>*}
                {*</div>*}
                {*<div class="form-group">*}
                    {*<label for="data_email" class="col-sm-3 control-label">{$t.megamenu.form.mobile_template}</label>*}
                    {*<div class="col-sm-9">*}
                        {*<input type="email" class="form-control" name="data[email]" id="data_email" value="{if isset($data.email)}{$data.email}{/if}" required>*}
                    {*</div>*}
                {*</div>*}
                {*<div class="form-group">*}
                    {*<label for="data_phone" class="col-sm-3 control-label">{$t.megamenu.form.disable_bellow}</label>*}
                    {*<div class="col-sm-9">*}
                        {*<input type="tel" class="form-control" name="data[phone]" id="data_phone" value="{if isset($data.phone)}{$data.phone}{/if}">*}
                    {*</div>*}
                {*</div>*}
                {*<div class="form-group">*}
                    {*<label for="data_group_id" class="col-sm-3 control-label">{$t.megamenu.form.status}</label>*}
                    {*<label for="data_group_id" class="col-sm-3 control-label">{$t.megamenu.form.html}</label>*}
                    {*<label for="data_group_id" class="col-sm-3 control-label">{$t.megamenu.form.desktop_template}</label>*}
                    {*<label for="data_group_id" class="col-sm-3 control-label">{$t.megamenu.form.desktop_template}</label>*}
                    {*<label for="data_group_id" class="col-sm-3 control-label">{$t.megamenu.form.disable_iblocks}</label>*}
                    {*<label for="data_group_id" class="col-sm-3 control-label">{$t.megamenu.form.event}</label>*}
                    {*<label for="data_group_id" class="col-sm-3 control-label">{$t.megamenu.form.classes}</label>*}
                    {*<label for="data_group_id" class="col-sm-3 control-label">{$t.megamenu.form.width}</label>*}
                    {*<label for="data_group_id" class="col-sm-3 control-label">{$t.megamenu.form.scrolltofixed}</label>*}
                    {*<div class="col-sm-9">*}
                        {*<select class="form-control" name="data[group_id]" id="data_group_id">*}
                            {*{foreach $groups as $group}*}
                                {*{if $group.isfolder}*}
                                    {*<optgroup label="{$group.name}">*}
                                        {*{foreach $group.items as $item}*}
                                            {*<option {if isset($data.group_id) && $data.group_id == $item.id}selected{/if} value="{$item.id}">{$item.name}</option>*}
                                        {*{/foreach}*}
                                    {*</optgroup>*}
                                {*{else}*}
                                    {*<option {if isset($data.group_id) && $data.group_id == $group.id}selected{/if} value="{$group.id}">{$group.name}</option>*}
                                {*{/if}*}
                            {*{/foreach}*}
                        {*</select>*}
                    {*</div>*}
                {*</div>*}

                {*<div class="form-group">*}
                    {*<label for="is_main" class="col-sm-3 control-label"></label>*}
                    {*<div class="col-sm-9">*}

                        {*<div class="checkbox">*}
                            {*<label>*}
                                {*<input type="hidden" name="notify" value="0">*}
                                {*<input type="checkbox" name="notify" id="notify" value="1"> {$t.megamenu.form.notify}*}
                            {*</label>*}
                        {*</div>*}
                    {*</div>*}
                {*</div>*}
            </fieldset>
        </div>
        {*<div class="col-md-3">*}
            {*<fieldset style="height: 330px;">*}
                {*<legend>{$t.megamenu.form.avatar}</legend>*}
                {*<div style="text-align: center; margin-bottom: 1em;">*}
                    {*<img src="{if isset($data.avatar)}{$data.avatar}{/if}" alt="" class="edit-customer-avatar customer-avatar" style="max-width: 130px;">*}
                {*</div>*}
                {*<div style="display: none">*}
                    {*<input type="file" name="avatar" id="customerAvatar">*}
                {*</div>*}
                {*{if $action == 'edit' }*}
                    {*<div style="text-align: center">*}
                        {*<button type="button" id="changeCustomerAvatar" class="btn btn-default">{$t.megamenu.form.btn_change}</button>*}
                    {*</div>*}
                {*{/if}*}
            {*</fieldset>*}
        {*</div>*}
    </div>

    <input type="hidden" name="action" value="{$action}">
    <input type="hidden" name="token" value="{$token}">
</form>