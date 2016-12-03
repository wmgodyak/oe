# Server requirements

## Operating systems (Linux x86-64)

Linux distributions such as RedHat Enterprise Linux (RHEL), CentOS, Ubuntu, Debian, and so on

## Memory requirement

OYiEngine is simple and use minimum RAM. For a basic build requires at least 16 MB of RAM

## Web servers

Apache 2.2 or 2.4

In addition, the apache mod_rewrite module must be enabled. mod_rewrite enables the server to perform URL rewriting.

Nginx 1.8 (or latest mainline version)

## Database

MySQL 5.6 (or latest mainline version)

MariaDB and Percona are compatible with OYi Engine because we support MySQL 5.6 APIs.

##PHP

5.6.x

5.5.x, where x is 22 or greater

7.0.2, 7.0.6 up to but not including 7.1, except for 7.0.5. PHP 7.1 is not supported.

There is a known PHP 7.0.5 issue that affects our code compiler; to avoid the issue, do not use PHP 7.0.5.

##Instalation

Download and unpack it to your web root directory.

Create database.

Change permissions to writable (0755) to /tmp/*, /uploads/*, /config/*, themes/*.

After instalation change permissions to config/ to 0644

## About file structure.

config/ - here is configuration files (bootstrap, routes, database, etc). 

helpers/ - in this directory placed helpers classes and functions. 

helpers/functions/ - here is funtions files. They are loading automaticly by system. You can use it in all project

logs/ This directory have multiple log files (cron, payment, sms, exchange, etc.)

modules/ - here is plased all modules. About modules we tolk bellow.

system/ - system directory. Don`t change in it anything. It can be removed on after autoupdate.

themes/ - themes directory. Here is backend theme and frontend themes. 

tmp/ - this directory have compiled themes files, exchange files, etc. Must be writable by system.

uploads/ - in this directory placed all uploads (images, files, etc). File manager have access to this directory. All pages images placed on content/y/m/d/size/image-name.jpg|png.

vendor/ - it contains all third party libraries


## About module structure

Simple module example.

**/modules/example/** - module dir.

/modules/example/controllers/ - controllers dir

/modules/example/controllers/Excapmple.php - base class of module example. 

if module have models, you need to create directory models in module dir and place models there.

/modules/example/models/

/modules/example/models/Example.php

Some modules have extends database. All SQL commands placed here.

/modules/example/sql/

/modules/example/sql/install.sql - run on installing module.

/modules/example/sql/uninstall.sql - run on uninstalling module.

Some modules extend backend theme or have frontend theme templates. All files placed on directory themes. 

/modules/example/themes/

/modules/example/themes/backend/modules/example/myfile.tpl

or in frontend 

/modules/example/themes/default/modules/example/myfile.tpl

On instalation theme files was copied to current frontend and backend theme. Original files left on module/themes. Modify only copied files.

If module have javascript files, it is plased on 

/modules/example/js/

/modules/example/js/example.js - default frontend file.

/modules/example/js/admin/example.js - default backend file.

You can use more javascript files and include it on init() of module

public function init()
{
    ... 
    $this->template->assignScript("modules/banners/js/admin/banners.js");
    ...
}


You can create vendor directory to place custom libraries.

If your module have localization, create directory lang and create languages files.

/modules/example/lang/

/modules/example/lang/en.ini

Its All.

Happy coding!


