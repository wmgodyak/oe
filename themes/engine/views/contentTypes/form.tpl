<form class="form-horizontal" action="contentTypes/process/{$data.id}" enctype="multipart/form-data" method="post" id="form" data-success = 'engine.contentTypes.on{ucfirst($action)}Success' >
    <div class="row">
        <div class="col-md-9">
            <fieldset>
                <legend>Основне</legend>
                <div class="form-group">
                    <label for="data_name" class="col-sm-3 control-label required">{$t.contentTypes.name}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[name]" id="data_name" value="{$data.name}" required placeholder="[a-zA-Zа-яА-Я0-9]+">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_type" class="col-sm-3 control-label required">{$t.contentTypes.type}</label>
                    <div class="col-sm-9">
                        <input {if $data.isfolder}readonly{/if} type="text" class="form-control" name="data[type]" id="data_type" value="{$data.type}" required placeholder="[a-z0-9]+">
                    </div>
                </div>
            </fieldset>
        </div>
        <div class="col-md-3">
            <fieldset>
                <legend>Параметри</legend>
                <div class="form-group">
                    <label for="data_name" class="col-sm-3 control-label required">Показувати в меню</label>
                    <div class="col-sm-9">

                    </div>
                </div>
                <div class="form-group">
                    <label for="data_type" class="col-sm-3 control-label">Клас іконки</label>
                    <div class="col-sm-9">

                    </div>
                </div>
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>Конфігурація полів</legend>
                <div class="form-group">
                    <div class="col-sm-12">

                    </div>
                </div>
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>Вміст шаблону на сайті</legend>
                <div class="form-group">
                    <div class="col-sm-12">
                        <textarea name="template" id="template" style="width: 100%; height: 500px;">{$data.template}</textarea>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>


     <input type="hidden" name="token" value="{$token}">
     <input type="hidden" name="action" value="{$action}">
     <input type="hidden" name="data[parent_id]" value="{$data.parent_id}">
     <input type="hidden" name="data[id]" value="{$data.id}">
</form>