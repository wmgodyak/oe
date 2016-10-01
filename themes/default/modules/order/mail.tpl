<a href="{$appurl}" style="width:100%;text-align:center;display:block" target="_blank">
    <img src="{$theme_url}/assets/img/logo-text.png" style="border:0" /></a>

<div id="mailsub" style="width:660px">
    <div style="padding-left:50px">
        <p style="font-size:11pt;margin-top:12px;margin-bottom:12px">Вітаємо вас, {$data.user.name}!</p>
        <h3 style="font-size:15pt;margin-top:12px;margin-bottom:12px;font-weight:bold">
            Ваше замовлення прийняте. Для підтвердження замовлення наш менеджер зв'яжеться з вами найближчим часом.
        </h3>
        <p style="font-size:11pt;margin-top:12px;margin-bottom:12px">Замовленню присвоєний номер: <strong>{$data.oid}</strong></p>
        <p style="font-size:11pt;margin-top:12px;margin-bottom:4px">Статус замовлення ви можете відстежити в особистому кабінеті </p>
        {if $data.payment_id==2}
            <p>Після перевірки замовлення менеджером, ви зможете його оплатити з особистого кабінету або по посиланню, яке вам прийде на пошту.</p>
        {/if}
        <div style="border-top:1px dotted #D3D4D3;border-bottom:1px dotted
#D3D4D3;padding-top:2px;padding-bottom:2px;margin-top:10px;margin-bottom:30px">
            <p style="font-size:11pt;margin-top:12px;margin-bottom:12px;font-weight:bold">Деталі замовлення:</p>
            {assign var='amount' value="0"}
            <table style="width:600px;">
                {foreach $data.products as $product}
                    {assign var='img' value=$app->images->cover($product.products_id, 'thumbs')}
                    <tr>
                        <td>
                            <a style="color:#2379DA" href="{$product.products_id}"><img src="{if $img == ''}http://{$smarty.server['HTTP_HOST']}/uploads/noimage.jpg{else}{$img}{/if}"  style="border:0; "/></a>
                        </td>
                        <td>
                            <a style="color:#2379DA" href="{$product.products_id}">{$app->page->name($product.products_id)}</a>
                            <br />
                            {round($product.price * $product.quantity, 2)}{$t.shop.currency.uah}
                            {assign var='amount' value= $amount + round($product.price * $product.quantity, 2)}
                        </td>
                     </tr>
                {/foreach}
            </table>
        </div>
        <p style="font-size:11pt;margin-top:4px;margin-bottom:4px">Загальна вартість замовлення: <strong>{$amount}{$t.shop.currency.uah}</strong></p>
		<p style="font-size:11pt;margin-top:4px;margin-bottom:30px">Якщо у вас виникли запитання щодо замовлення або робити інтернет-магазину, будь-ласка, зв’яжіться з нами: {$settings.company_phone} </p>
                <p style="font-size:12pt;margin-top:24px;margin-bottom:6px">З повагою, команда {$settings.company_name}</p>
        <p
          style="color:#303030;font-size:10pt;margin-top:6px;margin-bottom:12px">Даний лист створено автоматично, будь ласка не відповідайте на нього.</p>
      </div>
    </div>