<form class="form-horizontal" action="contentTypes/process/{$data.id}"  method="post" id="form" data-success="engine.contentTypes.on{ucfirst($action)}Success">
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
                    <div class="col-sm-9 col-sm-offset-3">
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" name="show_nav" value="1"> Показувати в меню
                            </label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="settings_icon" class="col-sm-3 control-label">Клас іконки</label>
                    <div class="col-sm-9">
                        <input type="text" class="form-control" name="settings[icon]" id="settings_icon" value="{$data.settings.icon}" placeholder="[a-z0-9]+">
                    </div>
                </div>
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <fieldset>
                <legend>Конфігурація полів</legend>
                <div class="row" id="configComponents">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="bu_select_grid" class="col-sm-3 control-label">Сітка</label>
                            <div class="col-sm-8">
                                <select id="bu_select_grid" class="form-control" name="grid">
                                    <option value="">Виберіть</option>
                                    <option value="12">12</option>
                                    <option value="6x6">6x6</option>
                                    <option value="4x4x4">4x4x4</option>
                                    <option value="3x3x3x3">3x3x3x3</option>
                                    <option value="8x4">8x4</option>
                                    <option value="4x8">4x8</option>
                                    <option value="9x3">9x3</option>
                                    <option value="3x9">3x9</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="bu_select_grid" class="col-sm-3 control-label">Компоненти</label>
                            <div class="col-sm-8">
                               <div class="boxes" id="baseComponents">
                                   {literal}
                                   <div class="box" id="main">
                                       <div class="preview">
                                           <fieldset>
                                               <legend>
                                                   <span class="box-name" contenteditable="true">Основне</span>
                                               </legend>
                                               <a href="" onclick="return false;" class="b-move" title="Таскати"><i class="fa fa-arrows"></i></a>
                                               <a href="" onclick="return false;" class="b-field-add" title="Додати поле"><i class="fa fa-plus"></i></a>
                                               <!--a href="" onclick="return false;" class="b-box-edit"><i class="fa fa-pencil"></i></a-->
                                               <a href="" onclick="return false;" class="b-box-remove" title="Видалити блок"><i class="fa fa-remove"></i></a>
                                               <ul>
                                                   <li id="info_name">
                                                       <span class="name">Назва</span>
                                                       <a href="" onclick="return false;" class="b-field-edit"><i class="fa fa-pencil"></i></a>
                                                       <a href="" onclick="return false;" class="b-field-remove"><i class="fa fa-remove"></i></a>
                                                   </li>
                                                   <li id="info_url">
                                                       <span class="name">Url</span>
                                                       <a href="" onclick="return false;" class="b-field-edit"><i class="fa fa-pencil"></i></a>
                                                       <a href="" onclick="return false;" class="b-field-remove"><i class="fa fa-remove"></i></a>
                                                   </li>
                                               </ul>
                                           </fieldset>
                                       </div>
                                       <div class="source">
                                           <fieldset>
                                               <legend>
                                                   <span class="box-name">Основне</span>
                                               </legend>
                                               {foreach $languages as $lang}
                                                   <div class="form-group" id="info_name_group">
                                                       <label for="info_{$lang.code}_name" class="col-sm-3 control-label">Назва({$lang.code}):</label>
                                                       <div class="col-sm-9">
                                                           <input type="text" class="form-control" name="info[{$lang.id}][name]" id="info_{$lang.code}_name" required="">
                                                       </div>
                                                   </div>
                                                   <div class="form-group">
                                                       <label for="info_{$lang.code}_url" class="col-sm-3 control-label">Url({$lang.code}):</label>
                                                       <div class="col-sm-9">
                                                           <input type="text" class="form-control" name="info[{$lang.id}][url]" id="info_{$lang.code}_url" required="">
                                                       </div>
                                                   </div>
                                               {/foreach}
                                           </fieldset>
                                       </div>
                                   </div>
                                   {/literal}
                               </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="bu_select_grid" class="col-sm-3 control-label">Плагіни</label>
                            <div class="col-sm-8">

                            </div>
                        </div>
                    </div>
                </div>
                <div class="ui-sortable htmlpage" id="builder">{$data.settings.form}</div>
                <textarea style="height: 500px;width:100%" name="data[settings][form]" id="data_settings_form">{$data.settings.form}</textarea>
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
{literal}

    <script type="text/template" id="sourceTplText">
        <div class="form-group" id="<%-id%>_group">
            <label for="<%-name%>" class="col-sm-3 control-label"><%-title%></label>
            <div class="col-sm-9">
                <% if(type == 'text') { %>
                <input type="text" class="form-control" name="<%-name%>" id="<%-name%>" placeholder="<%-placeholder%>" <% if(required) { %> required <% } %>>
                <% } else if(type == 'textarea') { %>
                <textarea class="form-control" name="<%-name%>" id="<%-id%>" placeholder="<%-placeholder%>" <% if(required) { %> required <% } %>></textarea>
                <% } else if(type == 'editor') { %>
                <textarea class="form-control ckeditor" name="<%-name%>" id="<%-name%>" placeholder="<%-placeholder%>" <% if(required) { %> required <% } %>></textarea>
                <% } %>
            </div>
        </div>
    </script>

    <script type="text/template" id="editFieldTpl">
        <form id="fieldEditForm" class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-3 control-label">Заголовок:</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control do-kp" id="t_title" required name="title" value="<%-data.title%>">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Тип:</label>
                <div class="col-sm-9">
                    <select name="type" class="form-control do-kp" id="t_type">
                        <option value="text">input:text</option>
                        <option value="textarea">textarea</option>
                        <option value="editor">editor</option>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Назва:</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control do-kp" id="t_name" required name="name" value="<%-data.name%>">
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-3 control-label">Плейсхолдер:</label>
                <div class="col-sm-9">
                    <input type="text" class="form-control do-kp" name="placeholder" id="t_placeholder" value="<%-data.placeholder%>">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-8 col-sm-offset-4">
                    <div class="checkbox">
                        <input type="checkbox" class="do-kp" id="t_required" <%-data.required%> name="required"> Обов'язкове
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-12 ">
                    <textarea id="htmlOut" style="width:100%;height:200px"><%=data.source%></textarea>
                </div>
            </div>
        </form>
    </script>

    <style>
        .boxes {
            position: relative;
        }
        .boxes .box {
            cursor: move;
            display: inline-block;
            padding: 5px;
            line-height:20px;
            background: #89BDFF;
            color: #fff;
        }
        .boxes .box .preview {
            display: inline-block;
            padding: 0;
            margin-bottom:0;
            border:0;
            padding-left: 20px;
        }
        .boxes .box .preview fieldset {
            border:0;
            padding: 0;
            display: inline;
            margin-bottom:0;
        }
        .boxes .box .preview fieldset legend{
            border:0;
            padding: 0;
            display: inline;
            margin-bottom:0;
        }
        .boxes .box .preview a, .boxes .box .preview ul{
            display: none
        }
        .boxes .box .preview a.b-move{
            display: inline-block;
            position: absolute;
            top:5px;left:5px;
        }
        .boxes .box .source{display: none;}

        .htmlpage {
            background: #fff;
            position: relative;
            width:100%;
        }
        .htmlpage .row{margin-left:0;margin-right:0;}
        .htmlpage .box:hover { border : 2px dashed #89BDFF}
        .htmlpage .active { border : 2px dashed #89BDFF }
        .htmlpage .row {
            box-sizing: border-box;
            border: 1px solid #DDDDDD;
            position: relative;
        }

        .htmlpage .row > a{
            position: absolute;
            top:1px;
            right:1px;
            border: 1px solid #DDDDDD;
            border-radius: 4px 0 4px 0;
            color: #9DA0A4;
            font-size: 12px;
            font-weight: bold;
            padding: 3px 7px;
            position: absolute;
            top: 1px;
            right: 1px;
            cursor:pointer
        }
        .htmlpage .row > a.b-move{
            right:31px;
        }
        .htmlpage .column:after {
            border: 1px solid #DDDDDD;
            border-radius: 4px 0 4px 0;
            color: #9DA0A4;
            content: "Колонка";
            font-size: 12px;
            font-weight: bold;
            left: -1px;
            padding: 3px 7px;
            position: absolute;
            top: -1px;
        }
        .htmlpage .column {
            border: 1px dashed #DDDDDD;
            border-radius: 4px 4px 4px 4px;
            padding: 39px 19px 24px;
            position: relative;
        }
        .htmlpage .ui-sortable-placeholder { outline: 1px dashed #578 ; background: #f1f1f1; visibility: visible!important; border-radius: 4px;}

        .htmlpage .box {
            position: relative;
            width:100%;
        }
        .htmlpage .box .source{
            display: none;
        }
        .htmlpage .box .preview fieldset{
            position: relative;
        }
        .htmlpage .box .preview fieldset > a{

            position: absolute;
            top:16px;
            right:1px;
            border: 1px solid #DDDDDD;
            border-radius: 4px 0 4px 0;
            color: #9DA0A4;
            font-size: 12px;
            font-weight: bold;
            padding: 3px 7px;
            cursor:pointer
        }
        .htmlpage .box .preview fieldset > a.b-box-remove{
            right:31px;
        }
        /*
        .htmlpage .box .preview fieldset > a.b-box-edit{
            right:61px;
        }*/
        .htmlpage .box .preview fieldset > a.b-field-add{
            right:61px;
        }
        .htmlpage .box .preview fieldset ul li{
            position: relative;
            display: block;
            padding: 10px 15px;
            margin-bottom: -1px;
            background-color: #fff;
            border: 1px solid #ddd;
        }

        .htmlpage .box .preview fieldset ul li > a{
            position: absolute;
            top:16px;
            right:31px;
            border: 1px solid #DDDDDD;
            border-radius: 4px 0 4px 0;
            color: #9DA0A4;
            font-size: 12px;
            font-weight: bold;
            padding: 3px 7px;
            cursor:pointer
        }
        .htmlpage .box .preview fieldset ul li > a + a{
            right:1px;
        }
    </style>
{/literal}