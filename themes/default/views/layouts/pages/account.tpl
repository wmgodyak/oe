{*
 * OYiEngine 7
 * @author Володимир Годяк mailto:support@otakoi.com
 * @copyright Copyright (c) 2016 Otakoyi.com
 * Date: 2016-03-21T14:44:29+02:00
 * @name 404
 *}
{include file="chunks/head.tpl"}
<body id="signup">

<div class="container">
    <div class="row header">
        <div class="col-md-12">
            <h3 class="logo">
                <a href="1">OYi.Engine7</a>
            </h3>
            <h4>Set up your new account today.</h4>
            <p>
                30-day money-back guarantee that starts after your first payment.
            </p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="wrapper clearfix">
                <div class="formy">
                    <div class="row">
                        <div class="col-md-12">
                            {$acc_content}
                        </div>
                    </div>
                </div>
            </div>
            <div class="already-account">
                Already have an account?
                <a href="signin.html" data-toggle="popover" data-placement="top" data-content="Go to sign in!" data-trigger="manual">Sign in here</a>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $(".already-account a").popover();
        $(".already-account a").popover('show');
    });
</script>