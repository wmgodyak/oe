<div class="row">
    <div class="col-md-12">
        <fieldset>
            <legend>Server Test</legend>
        </fieldset>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>Web-server version:</p>
            </div>
            <div class="col-md-6">
                <p>{$res.web_server.data}</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p>Required: Apache 2.0 and higher</p>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>PHP interface:</p>
            </div>
            <div class="col-md-6">
                <p>{$res.php_interface.data}</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p>It's recommended to run PHP as the Apache module. It's faster than CGI and allows more flexible settings</p>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>PHP version:</p>
            </div>
            <div class="col-md-6">
                <p>{$res.php_ver.data}</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p>Required version: 5.3 and higher</p>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>Memory limit value:</p>
            </div>
            <div class="col-md-6">
                <p>{$res.memory_limit.data}</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p>Memory limit settings should be not less than 32M (64M for "Professional" and higher editions). It is recommended to disable unused PHP modules in php.ini file to increase the memory size available to applications. </p>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>mod_rewrite module:</p>
            </div>
            <div class="col-md-6">
                <p>{if $res.mod_rewrite.status}Yes{else}No{/if}</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p></p>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>mbstring module:</p>
            </div>
            <div class="col-md-6">
                <p>{if $res.mbstring.status}Yes{else}No{/if}</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p></p>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>Mcrypt module:</p>
            </div>
            <div class="col-md-6">
                <p>{if $res.mcrypt.status}Yes{else}No{/if}</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p></p>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>Max execution time:</p>
            </div>
            <div class="col-md-6">
                <p>{$res.ex_time.data}</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p>Attempt to execute the script for 60 seconds </p>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>Disc space:</p>
            </div>
            <div class="col-md-6">
                <p>{$res.disc_space.data} Mb</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p>It is recommended to have not less than 50M</p>
    </div>
</div>

<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>Permissions for the /tmp dir:</p>
            </div>
            <div class="col-md-6">
                <p>{$res.dir_perm_tmp.data} {if $res.dir_perm_tmp.status}Yes{else}No{/if}</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p>Must be writable</p>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>Permissions for the /logs dir:</p>
            </div>
            <div class="col-md-6">
                <p>{$res.dir_perm_logs.data} {if $res.dir_perm_tmp.status}Yes{else}No{/if}</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p>Must be writable</p>
    </div>
</div>
<div class="row">
    <div class="col-md-6">
        <div class="row">
            <div class="col-md-6">
                <p>Permissions for the /uploads dir:</p>
            </div>
            <div class="col-md-6">
                <p>{$res.dir_perm_uploads.data} {if $res.dir_perm_uploads.status}Yes{else}No{/if}</p>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <p>Must be writable</p>
    </div>
</div>

<div class="row">
    <div class="col-md-3 col-md-offset-9 text-right">
        <form action="" method="post">
            <input type="hidden" name="action" value="db_config">
            <button class="btn btn-default">Вперед</button>
        </form>
    </div>
</div>