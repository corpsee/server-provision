[www]

user  = www-data
group = www-data

listen       = /var/run/php{{ php.version }}-fpm.sock
listen.owner = www-data
listen.group = www-data
listen.mode  = 0666

pm                   = dynamic
pm.max_children      = 5
pm.start_servers     = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3

pm.max_requests = 500

request_terminate_timeout = 180s

chdir = /
