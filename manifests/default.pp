include apache
include mysql
include php::apache2
include php::fpm

php::module { ['xdebug', 'pdo', 'pdo_mysql', 'curl', 'gd', 'mbstring'] : 
    notify => [ Class['php::fpm::service'], Service['httpd'], ],
}