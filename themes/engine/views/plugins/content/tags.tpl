<fieldset>
    <legend>Мітки</legend>
    {foreach $languages as $lang}
        <div class="form-group">
            <label for="content_published" class="col-md-3 control-label">{$lang.name}</label>
            <div class="col-md-9">
                <input data-role="tagsinput" type="text" name="tags[{$lang.id}]" id="tags_{$lang.id}" value="{if isset($content_tags[$lang.id])}{implode(',', $content_tags[$lang.id])}{/if}" class="tags-input form-control">
            </div>
        </div>
    {/foreach}
</fieldset>
{literal}
<style>

    .bootstrap-tagsinput {
        background-color: #fff;
        border: 1px solid #eee;
        display: inline-block;
        padding: 5px 5px 0;
        margin-bottom: 10px;
        color: #555;
        vertical-align: middle;
        border-radius: 3px;
        width: 100%;
        min-height: 37px;
        line-height: 20px;
        font-size: 0
    }

    .bootstrap-tagsinput input {
        position: relative;
        border: 0;
        box-shadow: none;
        outline: 0;
        background-color: transparent;
        padding: 0;
        margin: 0;
        width: auto !important;
        max-width: inherit;
        font-size: 14px
    }

    .bootstrap-tagsinput input:focus {
        border: 0;
        box-shadow: none
    }

    .bootstrap-tagsinput .tag {
        display: inline-block;
        margin-right: 5px;
        margin-bottom: 5px;
        padding: 8px;
        color: #fff;
        font-size: 14px;
        font-weight: normal;
        border-radius: 3px;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        -o-user-select: none;
        user-select: none;
        cursor: default
    }

    .bootstrap-tagsinput .tag [data-role="remove"] {
        margin-left: 8px;
        cursor: pointer;
        opacity: .5;
        filter: alpha(opacity=50)
    }

    .bootstrap-tagsinput .tag [data-role="remove"]:after {
        content: "\F057";
        font-family: FontAwesome;
        font-weight: normal;
        font-style: normal;
        text-decoration: inherit;
        -webkit-font-smoothing: antialiased
    }

    .bootstrap-tagsinput .tag [data-role="remove"]:hover, .bootstrap-tagsinput .tag [data-role="remove"]:active {
        opacity: 1;
        filter: alpha(opacity=100)
    }
    .bootstrap-tagsinput .tag.label-info{
        background: #0a6aa1;
    }
</style>
{/literal}