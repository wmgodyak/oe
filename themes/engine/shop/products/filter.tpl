<fieldset>
    {*<legend>Фільтр</legend>*}
    <form action="">
        <div class="row">
            <div class="col-md-6">
                <div class="form-group">
                    <label for="minp" class="col-md-2 control-label">Ціна</label>
                    <div class="col-md-3">
                        <input name="minp" id="minp" class="form-control" onchange="this.value = parseInt(this.value); if(typeof this.value == 'NaN') this.value=''" placeholder="від" value="{$smarty.get.minp}">
                    </div>
                    <div class="col-md-3">
                        <input name="maxp" id="maxp" class="form-control" onchange="this.value = parseInt(this.value); if(typeof this.value == 'NaN') this.value=''" placeholder="до" value="{$smarty.get.maxp}">
                    </div>
                    <div class="col-md-4">
                        <select name="group_id" id="group_id">
                            {foreach $groups as $group}
                                <option value="{$group.id}">{$group.name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="sku" class="col-md-4 control-label">Артикул</label>
                    <div class="col-md-8">
                        <input name="sku" id="sku" class="form-control" value="{$smarty.get.sku}">
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="status" class="col-md-3 control-label">Статус</label>
                    <div class="col-md-9">
                        <select name="status" id="status" class="form-control">
                            <option value="">Всі</option>
                            <option value="published" {if $smarty.get.status == 'published'}selected{/if}>Опубліковані</option>
                            <option value="hidden" {if $smarty.get.status == 'hidden'}selected{/if}>Приховані</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
                <div class="form-group">
                    <button class="btn btn-primary">Фільтр</button>
                </div>
            </div>
        </div>
    </form>
</fieldset>