{include file="chunks/head.tpl"}

<link rel="stylesheet" type="text/css" href="{$theme_url}assets/css/vendor/flipclock.css">
<script src="{$theme_url}assets/js/vendor/flipclock/libs/base.js"></script>
<script src="{$theme_url}assets/js/vendor/flipclock/flipclock.js"></script>
<script src="{$theme_url}assets/js/vendor/flipclock/faces/hourlycounter.js"></script>


<body id="coming-soon" class="dark">

<div class="container">
    <div class="row info">
        <div class="col-md-12">
            <h1><a href="1">Отакої</a></h1>
            <h3>на сайті проводяться технічні роботи</h3>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div id="countdown">
                <div id="clock"></div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <form class="form-inline" role="form">
                <div class="form-group">
                    <label class="sr-only" for="exampleInputEmail2">Введіть ваш email</label>
                    <input type="email" class="form-control" id="exampleInputEmail2" placeholder="Введіть ваш emaill">
                </div>
                <a href="1" class="button">Повідомте мене</a>
                <!-- <button type="submit" class="btn btn-primary">Notify me</button> -->
            </form>
        </div>
    </div>

</div>

<script type="text/javascript">
    $(function () {

        var clock;

        // Grab the current date
        var currentDate = new Date();

        // Set some date in the future. In this case, it's always Jan 1
        var futureDate  = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate(), currentDate.getHours() + 20);

        // Calculate the difference in seconds between the future and current date
        var diff = futureDate.getTime() / 1000 - currentDate.getTime() / 1000;

        // Instantiate a coutdown FlipClock
        clock = $('#clock').FlipClock(diff, {
            countdown: true
        });
    });
</script>
</body>