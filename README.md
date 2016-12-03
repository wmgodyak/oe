Server requirements

Operating systems (Linux x86-64)
Linux distributions such as RedHat Enterprise Linux (RHEL), CentOS, Ubuntu, Debian, and so on

Memory requirement
OYiEngine is simple and use minimum RAM. For a basic build requires at least 16 MB of RAM

Web servers
Apache 2.2 or 2.4
In addition, the apache mod_rewrite module must be enabled. mod_rewrite enables the server to perform URL rewriting.
Nginx 1.8 (or latest mainline version)

Database
MySQL 5.6 (or latest mainline version)
MariaDB and Percona are compatible with OYi Engine because we support MySQL 5.6 APIs.

PHP
5.6.x
5.5.x, where x is 22 or greater
7.0.2, 7.0.6 up to but not including 7.1, except for 7.0.5. PHP 7.1 is not supported.
There is a known PHP 7.0.5 issue that affects our code compiler; to avoid the issue, do not use PHP 7.0.5.

Instalation

Download and unpack it to your web root directory.
Create database.
Change permissions to writable (0755) to /tmp/*, /uploads/*, /config/*, themes/*.

After instalation change permissions to config/ to 0644

About file structure.

config/ - here is configuration files (bootstrap, routes, database, etc). 
helpers/ - in this directory placed helpers classes and functions. 
helpers/functions/ - here is funtions files. They are loading automaticly by system. You can use it in all project
logs/ This directory have multiple log files (cron, payment, sms, exchange, etc.)
modules/ - here is plased all modules. About modules we tolk bellow.
tmp/ - this directory have compiled themes files, exchange files, etc. Must be writable by system.
uploads/ - in this directory placed all uploads (images, files, etc). File manager have access to this directory. All pages images placed on content/y/m/d/size/image-name.jpg|png.
vendor/ - it contains all third party libraries



Its All.
Happy coding!


