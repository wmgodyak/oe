<div class="row">
    <div class="col-md-6 col-md-offset-3">
        <fieldset>
            <legend>Імпорт товарів</legend>
            <form action="module/run/shop/import/process" enctype="multipart/form-data" method="post" id="shopImport">
                <p>Макс. розмір файлу: {ini_get('post_max_size')}</p>
                <div class="form-group">
                    <label for="adapter" class="col-sm-3 control-label">Виберіть адаптер</label>
                    <div class="col-sm-9">
                        <select class="form-control" name="adapter" id="adapter">
                            {foreach $adapters as $item}
                                <option value="{$item.module}">{$item.name}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="file" class="col-sm-3 control-label">Виберіть файл</label>
                    <div class="col-sm-9">
                        <input type="file" name="file" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="file" class="col-sm-3 control-label">Що імпортуємо?</label>
                    <div class="col-sm-9">
                        <input type="radio" name="type" value="categories"> категорії
                        <input type="radio" name="type" value="products"> товари
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-9 col-md-offset-3">
                        <button type="submit" class="btn btn-large btn-success">Погнали</button>
                    </div>
                </div>
                <input type="hidden" name="token" value="{$token}">
            </form>
            <div class="progress">
                <div class="bar"></div >
                <div class="percent">0%</div >
            </div>

            <div id="status"></div>
        </fieldset>
    </div>
</div>