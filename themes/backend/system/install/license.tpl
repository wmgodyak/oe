<div class="row">
    <div class="col-md-12">
        <fieldset>
            <legend>Будь-ласка, ознайомтесь з текстом публічної оферти</legend>
        </fieldset>
        <form action="" method="post">
            <textarea class="form-control" style='100%; height:500px;' readonly>{$text}</textarea>
            <br>
            <div class="row">
                <div class="col-md-9">
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" id="agree"> я прочитав і погоджуюсь
                        </label>
                    </div>
                </div>
                <div class="col-md-3 text-right">
                    <button class="btn btn-default" id="next"  style="display: none"  >Далі</button>
                </div>
            </div>
            <input type="hidden" name="action" value="server_check">
        </form>
    </div>
</div>