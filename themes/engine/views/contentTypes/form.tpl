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
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label for="bu_select_grid" class="col-sm-3 control-label">Сітка</label>
                            <div class="col-sm-8">
                                <select id="bu_select_grid" class="form-control">
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
                                   <div class="box">
                                       <fieldset>
                                           <legend>
                                               <span class="box-name">Основне</span>
                                               <a href="" onclick="return false;" class="b-move"><i class="fa fa-arrows"></i></a>
                                               <a href="" onclick="return false;" class="b-field-add"><i class="fa fa-plus"></i></a>
                                               <a href="" onclick="return false;" class="b-box-edit"><i class="fa fa-pencil"></i></a>
                                               <a href="" onclick="return false;" class="b-box-remove"><i class="fa fa-remove"></i></a>
                                           </legend>
                                           <ul class="form-fields">
                                               <li class="field">
                                                   <span class="name">Назва</span>
                                                   <a href="" onclick="return false;" class="b-field-edit"><i class="fa fa-pencil"></i></a>
                                                   <a href="" onclick="return false;" class="b-field-remove"><i class="fa fa-remove"></i></a>
                                                   <input type="hidden" class="field-settings" value="title=%D0%9D%D0%B0%D0%B7%D0%B2%D0%B0&type=text&name=info%5B%24lang.id%5D%5Bname%5D&placeholder=%D0%9C%D0%B0%D0%BA%D1%81.+160+%D1%81%D0%B8%D0%BC%D0%B2%D0%BE%D0%BB%D1%96%D0%B2&required=on">
                                               </li>
                                               <li class="field">
                                                   <span class="name">Url</span>
                                                   <a href="" onclick="return false;" class="b-field-edit"><i class="fa fa-pencil"></i></a>
                                                   <a href="" onclick="return false;" class="b-field-remove"><i class="fa fa-remove"></i></a>
                                                   <input type="hidden" class="field-settings" value="title=Url&type=text&name=info%5B%24lang.id%5D%5Burl%5D&placeholder=%D0%9C%D0%B0%D0%BA%D1%81.160+%D1%81%D0%B8%D0%BC%D0%B2%D0%BE%D0%BB%D1%96%D0%B2&required=on">
                                               </li>
                                           </ul>
                                       </fieldset>
                                   </div>
                                   <div class="box">
                                       <fieldset>
                                           <legend>
                                               <span class="box-name">Мета дані</span>
                                               <a href="" onclick="return false;" class="b-move"><i class="fa fa-arrows"></i></a>
                                               <a href="" onclick="return false;" class="b-field-add"><i class="fa fa-plus"></i></a>
                                               <a href="" onclick="return false;" class="b-box-edit"><i class="fa fa-pencil"></i></a>
                                               <a href="" onclick="return false;" class="b-box-remove"><i class="fa fa-remove"></i></a>
                                           </legend>
                                           <ul class="form-fields">
                                               <li class="field">
                                                   <span class="name">Title</span>
                                                   <a href="" onclick="return false;" class="b-field-edit"><i class="fa fa-pencil"></i></a>
                                                   <a href="" onclick="return false;" class="b-field-remove"><i class="fa fa-remove"></i></a>
                                                   <input type="hidden" class="field-settings" value="title=%D0%9D%D0%B0%D0%B7%D0%B2%D0%B0&type=text&name=info%5B%24lang.id%5D%5Bname%5D&placeholder=%D0%9C%D0%B0%D0%BA%D1%81.+160+%D1%81%D0%B8%D0%BC%D0%B2%D0%BE%D0%BB%D1%96%D0%B2&required=on">
                                               </li>
                                               <li class="field">
                                                   <span class="name">Keywords</span>
                                                   <a href="" onclick="return false;" class="b-field-edit"><i class="fa fa-pencil"></i></a>
                                                   <a href="" onclick="return false;" class="b-field-remove"><i class="fa fa-remove"></i></a>
                                                   <input type="hidden" class="field-settings" value="title=Url&type=text&name=info%5B%24lang.id%5D%5Burl%5D&placeholder=%D0%9C%D0%B0%D0%BA%D1%81.160+%D1%81%D0%B8%D0%BC%D0%B2%D0%BE%D0%BB%D1%96%D0%B2&required=on">
                                               </li>
                                               <li class="field">
                                                   <span class="name">Description</span>
                                                   <a href="" onclick="return false;" class="b-field-edit"><i class="fa fa-pencil"></i></a>
                                                   <a href="" onclick="return false;" class="b-field-remove"><i class="fa fa-remove"></i></a>
                                                   <input type="hidden" class="field-settings" value="title=Url&type=text&name=info%5B%24lang.id%5D%5Burl%5D&placeholder=%D0%9C%D0%B0%D0%BA%D1%81.160+%D1%81%D0%B8%D0%BC%D0%B2%D0%BE%D0%BB%D1%96%D0%B2&required=on">
                                               </li>
                                           </ul>
                                       </fieldset>
                                   </div>
                                   <div class="box">
                                       <fieldset>
                                           <legend>
                                               <span class="box-name">Контент</span>
                                               <a href="" onclick="return false;" class="b-move"><i class="fa fa-arrows"></i></a>
                                               <a href="" onclick="return false;" class="b-field-add"><i class="fa fa-plus"></i></a>
                                               <a href="" onclick="return false;" class="b-box-edit"><i class="fa fa-pencil"></i></a>
                                               <a href="" onclick="return false;" class="b-box-remove"><i class="fa fa-remove"></i></a>
                                           </legend>
                                           <ul class="form-fields">
                                               <li class="field">
                                                   <span class="name">Контент</span>
                                                   <a href="" onclick="return false;" class="b-field-edit"><i class="fa fa-pencil"></i></a>
                                                   <a href="" onclick="return false;" class="b-field-remove"><i class="fa fa-remove"></i></a>
                                                   <input type="hidden" class="field-settings" value="title=%D0%9D%D0%B0%D0%B7%D0%B2%D0%B0&type=text&name=info%5B%24lang.id%5D%5Bname%5D&placeholder=%D0%9C%D0%B0%D0%BA%D1%81.+160+%D1%81%D0%B8%D0%BC%D0%B2%D0%BE%D0%BB%D1%96%D0%B2&required=on">
                                               </li>
                                           </ul>
                                       </fieldset>
                                   </div>
                                   <div class="box">
                                       <fieldset>
                                           <legend>
                                               <span class="box-name">Параметри</span>
                                               <a href="" onclick="return false;" class="b-move"><i class="fa fa-arrows"></i></a>
                                               <a href="" onclick="return false;" class="b-field-add"><i class="fa fa-plus"></i></a>
                                               <a href="" onclick="return false;" class="b-box-edit"><i class="fa fa-pencil"></i></a>
                                               <a href="" onclick="return false;" class="b-box-remove"><i class="fa fa-remove"></i></a>
                                           </legend>
                                           <ul class="form-fields">
                                               <li class="field">
                                                   <span class="name">Шаблон</span>
                                                   <a href="" onclick="return false;" class="b-field-edit"><i class="fa fa-pencil"></i></a>
                                                   <a href="" onclick="return false;" class="b-field-remove"><i class="fa fa-remove"></i></a>
                                                   <input type="hidden" class="field-settings" value="title=%D0%9D%D0%B0%D0%B7%D0%B2%D0%B0&type=text&name=info%5B%24lang.id%5D%5Bname%5D&placeholder=%D0%9C%D0%B0%D0%BA%D1%81.+160+%D1%81%D0%B8%D0%BC%D0%B2%D0%BE%D0%BB%D1%96%D0%B2&required=on">
                                               </li>
                                               <li class="field">
                                                   <span class="name">Статус</span>
                                                   <a href="" onclick="return false;" class="b-field-edit"><i class="fa fa-pencil"></i></a>
                                                   <a href="" onclick="return false;" class="b-field-remove"><i class="fa fa-remove"></i></a>
                                                   <input type="hidden" class="field-settings" value="title=Url&type=text&name=info%5B%24lang.id%5D%5Burl%5D&placeholder=%D0%9C%D0%B0%D0%BA%D1%81.160+%D1%81%D0%B8%D0%BC%D0%B2%D0%BE%D0%BB%D1%96%D0%B2&required=on">
                                               </li>
                                           </ul>
                                       </fieldset>
                                   </div>
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
                <div class="ui-sortable htmlpage" id="builder"></div>
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
        .boxes .box fieldset {
            display: inline-block;
            padding: 0;
            margin-bottom:0;
            border:0;
        }
        .boxes .box fieldset ul{display: none;}

        .boxes .box fieldset legend{
            display: inline-block;
            padding: 0;
            margin-bottom:0;
            border:0;
            font-size:12px;
        }
        .boxes .box fieldset legend a.b-field-add,
        .boxes .box fieldset legend a.b-box-edit,
        .boxes .box fieldset legend a.b-box-remove
        {
            display: none;
        }
        .boxes .box fieldset legend a.b-move{
            float: left;
            margin-right:0.5em;
        }

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
        .htmlpage .row a {
            border: 1px solid #DDDDDD;
            border-radius: 4px 0 4px 0;
            color: #9DA0A4;
            font-size: 12px;
            font-weight: bold;
            padding: 3px 7px;
            position: absolute;
            top: 1px;
            cursor:pointer
        }
        .htmlpage .row a.b-row-remove {
            right: 1px;
         }
        .htmlpage .row a.b-move {
            right: 30px;
            cursor:move;
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
        .htmlpage .box fieldset legend{
            position: relative;
            padding-right:140px;
            /*cursor: move;*/
        }
        .htmlpage .box fieldset legend a.b-box-remove{
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
        .htmlpage .box fieldset legend a.b-box-edit{
            border: 1px solid #DDDDDD;
            border-radius: 4px 0 4px 0;
            color: #9DA0A4;
            font-size: 12px;
            font-weight: bold;
            padding: 3px 7px;
            position: absolute;
            top: 1px;
            right: 31px;
            cursor:pointer
        }
        .htmlpage .box fieldset legend a.b-field-add{
            border: 1px solid #DDDDDD;
            border-radius: 4px 0 4px 0;
            color: #9DA0A4;
            font-size: 12px;
            font-weight: bold;
            padding: 3px 7px;
            position: absolute;
            top: 1px;
            right: 61px;
            cursor:pointer;
        }
        .htmlpage .box fieldset legend a.b-move{
            border: 1px solid #DDDDDD;
            border-radius: 4px 0 4px 0;
            color: #9DA0A4;
            font-size: 12px;
            font-weight: bold;
            padding: 3px 7px;
            position: absolute;
            top: 1px;
            right: 91px;
            cursor:move;
        }
        .htmlpage .box fieldset ul li{
            position: relative;
            display: block;
            padding: 10px 15px;
            margin-bottom: -1px;
            background-color: #fff;
            border: 1px solid #ddd;
        }
        .htmlpage .box fieldset ul a.b-field-remove{
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
        .htmlpage .box fieldset ul a.b-field-edit{
            border: 1px solid #DDDDDD;
            border-radius: 4px 0 4px 0;
            color: #9DA0A4;
            font-size: 12px;
            font-weight: bold;
            padding: 3px 7px;
            position: absolute;
            top: 1px;
            right: 31px;
            cursor:pointer
        }
        .htmlpage .box .editable{
            background: #fff;
            border:1px solid #f1f1f1;
            line-height:16px;
            padding: 0 5px;
        }
    </style>
{/literal}