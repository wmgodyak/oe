<fieldset>
    <legend>Ціни</legend>
    <div class="row">
        {if count($groups) == 1}
            <div class="col-md-9 col-md-offset-3">
                <div class="form-inline">
                    <div class="form-group" style="margin-left:0; margin-right: 0;">
                        {foreach $groups as $g}
                            <input type="text" name="prices[{$g.id}]" class="form-control" required value="{if isset($group_prices[$g.id])}{$group_prices[$g.id]}{/if}">
                        {/foreach}
                    </div>
                    <div class="form-group" style="margin-left:0; margin-right: 0;">
                        <select name="content[currency_id]" id="content_currency" class="form-control">
                            {foreach $currency as $c}
                                <option {if $content.currency_id==$c.id}selected{/if} value="{$c.id}">{$c.code}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group" style="margin-left:0; margin-right: 0;">
                        за
                        <select name="content[unit_id]" id="content_units" class="form-control">
                            {foreach $units as $unit}
                                <option {if $content.unit_id==$unit.id}selected{/if} value="{$unit.id}">{$unit.name}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="form-group" style="margin-left:0; margin-right: 0;">
                        <select name="content[in_stock]" id="content_stock" class="form-control">
                            <option {if $content.in_stock==1}selected{/if} value="1">в наявності</option>
                            <option {if $content.in_stock==2}selected{/if} value="2">під замовлення</option>
                            <option {if $content.in_stock==0}selected{/if} value="0">немає</option>
                        </select>
                    </div>

                    <div class="form-group" style="margin-left:0; margin-right: 0;">
                        <label for="content_code" class="col-md-3 control-label">Артикул</label>
                        <div class="col-md-9">
                            <input name="content[code]" id="content_code" class="form-control" value="{$content.code}">
                        </div>
                    </div>
                </div>
            </div>
            {else}
            <div class="col-md-8">
                <table style="width: 100%" class="table">
                    <tr>
                        <th>Ціна / Група</th>
                        {foreach $groups as $g}
                            <th>{$g.name}</th>
                        {/foreach}
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        {foreach $groups as $g}
                            <td><input type="text" name="prices[{$g.id}]" class="form-control" required value="{if isset($group_prices[$g.id])}{$group_prices[$g.id]}{/if}"></td>
                        {/foreach}
                    </tr>
                </table>
            </div>

            <div class="col-md-4">
                <div class="col-md-12">
                    <div class="form-group">
                        <label for="content_code" class="col-md-3 control-label">Артикул</label>
                        <div class="col-md-9">
                            <input name="content[code]" id="content_code" class="form-control" value="{$content.code}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="content_units" class="col-md-3 control-label">Од. виміру</label>
                        <div class="col-md-9">
                            <select name="content[unit_id]" id="content_units" class="form-control">
                                {foreach $units as $unit}
                                    <option {if $content.unit_id==$unit.id}selected{/if} value="{$unit.id}">{$unit.name}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="content_currency" class="col-md-3 control-label">Валюта</label>
                        <div class="col-md-9">
                            <select name="content[currency_id]" id="content_currency" class="form-control">
                                {foreach $currency as $c}
                                    <option {if $content.currency_id==$c.id}selected{/if} value="{$c.id}">{$c.code}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="content_in_stock" class="col-md-3 control-label">Наявність</label>
                        <div class="col-md-9">
                            <select name="content[in_stock]" id="content_in_stock" class="form-control">
                                <option {if $content.in_stock==1}selected{/if} value="1">в наявності</option>
                                <option {if $content.in_stock==2}selected{/if} value="2">під замовлення</option>
                                <option {if $content.in_stock==0}selected{/if} value="0">немає</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        {/if}

    </div>
</fieldset>