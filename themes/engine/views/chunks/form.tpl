<form class="form-horizontal" action="chunks/process/{$data.id}"  method="post" id="form" data-success="engine.chunks.on{ucfirst($action)}Success">
    <div class="row">
        <div class="col-md-9">
            <fieldset>
                <legend>Основне</legend>
                <div class="form-group">
                    <label for="data_name" class="col-sm-3 control-label required">{$t.chunks.name}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[name]" id="data_name" value="{$data.name}" required placeholder="[a-zA-Zа-яА-Я0-9]+">
                    </div>
                </div>
                <div class="form-group">
                    <label for="data_template" class="col-sm-3 control-label required">{$t.chunks.type}</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="data[template]" id="data_template" value="{$data.template}" required placeholder="[a-z0-9]+">
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
                        <textarea name="template" id="template" style="width: 100%; height: 500px;">{$template}</textarea>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>

     <input type="hidden" name="token" value="{$token}">
     <input type="hidden" name="action" value="{$action}">
     <input type="hidden" name="data[id]" value="{$data.id}">
    <link rel="stylesheet" href="{$theme_url}assets/js/vendor/codemirror/lib/codemirror.css">
    <script src="{$theme_url}assets/js/vendor/codemirror/lib/codemirror.js"></script>
    <script src="{$theme_url}assets/js/vendor/codemirror/mode/css.js"></script>
    <script src="{$theme_url}assets/js/vendor/codemirror/mode/php.js"></script>
    <script src="{$theme_url}assets/js/vendor/codemirror/mode/htmlmixed.js"></script>
    <script src="{$theme_url}assets/js/vendor/codemirror/mode/sql.js"></script>
    <script src="{$theme_url}assets/js/vendor/codemirror/mode/javascript.js"></script>
    <script>
        var cm = CodeMirror.fromTextArea(document.getElementById('template'), {
            theme: 'neo',
//                        mode: 'htmlmixed',
            styleActiveLine: true,
            lineNumbers: true,
            lineWrapping: true,
            autoCloseTags: true,
            matchBrackets: true
        });

        cm.on("change", function() {
        cm.save();
        var c = cm.getValue();
        $("textarea#template").html(c);
        });
    </script>
</form>