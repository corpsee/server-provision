<?php

$config            = include (CONFIG_PATH . 'base.php');
$config_additional = [
    'environment' => 'production',
    'database'    => [
        'type'     => 'pgsql',
        'dns'      => 'pgsql:host=127.0.0.1;port=5432;dbname={{ corpsee_site_db_name }}',
        'user'     => '{{ corpsee_site_db_user }}',
        'password' => '{{ corpsee_site_db_password }}'
    ],
    'migrations' => [
        'paths' => [
            'migrations' => APPLICATION_PATH . 'Migrations/',
        ],
        'environments' => [
            'default_migration_table' => 'migrations',
            'default_database'        => 'corpsee_site',
            'corpsee_site'            => [
                'adapter' => 'pgsql',
                'name'    => '{{ corpsee_site_db_name }}',
                'host'    => '127.0.0.1',
                'user'    => '{{ corpsee_site_db_user }}',
                'pass'    => '{{ corpsee_site_db_password }}',
            ],
        ],
    ],
];

return array_replace_recursive($config, $config_additional);
