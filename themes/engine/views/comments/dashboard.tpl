<div class="col-md-6">
    <fieldset>
        <legend>Останні коментарі</legend>
        {foreach $items as $item}
            <div class="row">
                <div class="col-md-12">
                    <p><small>{date('d.m.Y H:i:s', strtotime($item.created))}</small> <small>Автор: {$item.user.name} {$item.user.surname}</small></p>
                    <p>{$item.message}</p>
                    <hr>
                </div>
            </div>
        {/foreach}
        <p style="text-align: right"><a href="module/run/comments">Всі коментарі</a></p>
    </fieldset>
</div>