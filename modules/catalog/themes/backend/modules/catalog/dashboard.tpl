<div class="col-md-6">
    <fieldset>
        <legend>New products</legend>
        {foreach $items as $item}
            <div class="row">
                <div class="col-md-12">
                    <p><small>{date('d.m.Y H:i:s', strtotime($item.created))}</small> <small>Author: {$item.author}</small></p>
                    <p>{$item.name}</p>
                    <hr>
                </div>
            </div>
        {/foreach}
        <p style="text-align: right"><a href="module/run/catalog/products">All products</a></p>
    </fieldset>
</div>