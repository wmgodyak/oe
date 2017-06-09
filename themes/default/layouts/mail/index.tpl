<html lang="{block name="mail.html.lang"}en{/block}">

<head>{block name="mail.head"}{/block}</head>

<body class="{block name="mail.body.class"}{/block}">

{$events->call('mail.body.before')}

{block name='mail.body'}
    Mail source
{/block}

{$events->call('mail.body.after')}
</body>
</html>