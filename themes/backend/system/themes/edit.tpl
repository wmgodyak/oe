{if isset( $error)}
    <div class="alert alert-error">{$error}</div>
{/if}
{if isset($img)}
    <div class="row col-md-8 col-md-offset-2"><img src="{$img}" style="max-width: 100%;" alt=""></div>
{/if}
{if isset($source)}
<form id="form" action="themes/updateSource" method="post"  class="form-horizontal">
    <div class="row">
        <div class="col-md-12">
            <div class="response"></div>
            <fieldset>
                <legend>{$path}</legend>
                <div class="form-group">
                    <div class="col-sm-12">
                        <textarea name="source" id="source" style="width: 100%; height: 500px;">{$source}</textarea>
                    </div>
                </div>
            </fieldset>
        </div>
    </div>

    <input type="hidden" name="token" value="{$token}">
    <input type="hidden" name="path" value="{$path}">
    <input type="hidden" name="theme" value="{$theme}">
</form>

    <link rel="stylesheet" href="{$theme_url}assets/js/vendor/codemirror/lib/codemirror.css">
    <script src="{$theme_url}assets/js/vendor/codemirror/lib/codemirror.js"></script>
    <script src="{$theme_url}assets/js/vendor/codemirror/mode/css.js"></script>
    <script src="{$theme_url}assets/js/vendor/codemirror/mode/php.js"></script>
    <script src="{$theme_url}assets/js/vendor/codemirror/mode/htmlmixed.js"></script>
    <script src="{$theme_url}assets/js/vendor/codemirror/mode/sql.js"></script>
    <script src="{$theme_url}assets/js/vendor/codemirror/mode/javascript.js"></script>
    <script>
        var cm = CodeMirror.fromTextArea(document.getElementById('source'), {
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
            $("textarea#source").html(c);
        });
    </script>
{/if}
{if isset($table)}{$table}{/if}
<script>
    $(document).ready(function(){
        var  $tree = new engine.tree('themesTree');
        $tree.setUrl('./themes/tree/{$theme}').init();
        engine.validateAjaxForm('#adminLogin', function (res) {
            engine.alert(d.m, res.s > 0 ? 'success' : 'error');
        });
    });
</script>