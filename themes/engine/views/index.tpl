<!DOCTYPE html>
<html>
<head>
    <base href="{$base_url}">
    <meta charset="utf-8" />
    <!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    <title>SmartEngine 7</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
    <link href="{$template_url}assets/css/vendor/style.css" rel="stylesheet">
    <link href="{$template_url}assets/css/vendor/jquery.materialripple.css" rel="stylesheet">
    <link href="{$template_url}assets/css/style.css" rel="stylesheet">
</head>

<body {$controller} {$action}>
    {$body}
<script src="{$template_url}assets/js/vendor/jquery-1.11.3.min.js"></script>
<script src="{$template_url}assets/js/vendor/pace.js"></script>
<script src="{$template_url}assets/js/vendor/jstree.min.js"></script>
<script src="{$template_url}assets/js/vendor/jquery.materialripple.js"></script>
<script src="{$template_url}assets/js/vendor/jquery.dataTables.min.js"></script>
<script src="{$template_url}assets/js/vendor/jquery-ui.min.js"></script>
<script src="{$template_url}assets/js/vendor/jquery.form.min.js"></script>
<script src="{$template_url}assets/js/vendor/jquery.validate.min.js"></script>
<script>
    var TOKEN = '{$token}', ONLINE = 0;

    jQuery.extend(jQuery.validator.messages, {
        required: "Це поле обов'язкове",
        remote: "Будь ласка, перевірте це поле",
        email: "Введіть коректну електронну скриньку"
    });
</script>
<script src="{$template_url}assets/js/main.js"></script>
</body>
</html>