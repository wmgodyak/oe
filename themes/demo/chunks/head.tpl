<!DOCTYPE html>
<html lang="en">
<head>
    <base href="{$base_url}">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{$page.title}</title>
    <meta name="description" content="{$page.description|escape}"/>
    <meta name="keywords" content="{{$page.keywords|escape}}" />
    <meta name="generator" content="OYi.Engine7">

    <!-- Bootstrap -->
    <link href="{$theme_url}assets/css/bootstrap.min.css" rel="stylesheet">
    <!-- custome-css -->
    <link href="{$theme_url}assets/css/jquery-ui.min.css" rel="stylesheet" type="text/css" media="screen">
    <link href="{$theme_url}assets/css/style.css" rel="stylesheet" type="text/css" media="screen">
    <!-- font awesome for icons -->
    <link href="{$theme_url}assets/css/font-awesome.min.css" rel="stylesheet">
    <!-- google font -->
    <link href='https://fonts.googleapis.com/css?family=Merriweather:300,400,700' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>
    <!-- Fav and touch icons -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="{$theme_url}assets/images/favicon-icon/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="{$theme_url}assets/images/favicon-icon/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="{$theme_url}assets/images/favicon-icon/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="{$theme_url}assets/images/favicon-icon/apple-touch-icon-57-precomposed.png">
    <link rel="shortcut icon" href="{$theme_url}assets/images/favicon-icon/favicon.png">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script>
        var TOKEN = '{$token}', LANG_ID={$page.languages_id * 1}, CONTENT_ID = {$page.id};
    </script>
</head>
<body data-id="{$page.id}" data-type="{$page.types_id}" data-template="{$page.template}">