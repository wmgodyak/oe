<table class="table">
    <thead>
    <tr>
        <th>Дата</th>
        <th>Статус</th>
        <th>Коментар</th>
    </tr>
    </thead>
    <tbody>
    {foreach $history as $item}
        <tr>
            <td>{date('d.m.Y H:i:s', strtotime($item.created))}</td>
            <td style="text-align: left;">{$item.status}</td>
            <td>{$item.comment}</td>
        </tr>
    {/foreach}
    </tbody>
</table>