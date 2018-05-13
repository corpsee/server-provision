<?php

define('START_TIME', microtime(true));
define('START_MEMORY', memory_get_usage());

define('ROOT_PATH', dirname(__DIR__) . '/');
define('APPLICATION_PATH', ROOT_PATH . 'src/');
define('CONFIG_PATH', APPLICATION_PATH . 'configs/');

define('PUBLIC_PATH', ROOT_PATH . 'www/');
define('FILE_PATH', PUBLIC_PATH . 'files/');

define('FILE_PATH_URL', '/files/');

define('POSTGRES', 'Y-m-d H:i:sP');

require_once ROOT_PATH . 'vendor/autoload.php';

// Production
use Nameless\Core\HttpCache;
use Symfony\Component\HttpKernel\HttpCache\Store;
use Nameless\Core\Application;

$options = [
    'debug'                  => false,
    'default_ttl'            => 0,
    'private_headers'        => ['Authorization', 'Cookie'],
    'allow_reload'           => true,
    'allow_revalidate'       => true,
    'stale_while_revalidate' => 2,
    'stale_if_error'         => 60,
];

$framework = new HttpCache(new Application(), new Store(ROOT_PATH . 'cache'), null, $options);
$framework->run();
