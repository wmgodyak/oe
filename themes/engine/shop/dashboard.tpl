<div class="col-md-6">
    <fieldset>
        <legend>Останні статті</legend>
        {foreach $items as $item}
            <div class="row">
                <div class="col-md-12">
                    <p><small>{date('d.m.Y H:i:s', strtotime($item.created))}</small> <small>Автор: {$item.author}</small></p>
                    <p>{$item.name}</p>
                    <hr>
                </div>
            </div>
        {/foreach}
        <p style="text-align: right"><a href="module/run/shop">Всі статті</a></p>
    </fieldset>
</div>