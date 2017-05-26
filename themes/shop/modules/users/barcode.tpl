{if $user.barcode == ''}
    <div class="bs-callout bs-callout-danger">
        <p>у вас ще немає бонусної картки</p>
    </div>
{else}
<div class="bs-callout bs-callout-infp">
    <p>Номер вашої карти: {$user.barcode}</p>
</div>
{/if}
{*<pre>{print_r($user)}</pre>*}