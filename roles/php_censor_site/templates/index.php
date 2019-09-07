<?php

header('Location: https://github.com/php-censor/php-censor#readme', true, 301);

echo '
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="refresh" content="0;url=https://github.com/php-censor/php-censor#readme" />

        <title>Redirecting to https://github.com/php-censor/php-censor#readme</title>
    </head>
    <body>
        Redirecting to <a href="https://github.com/php-censor/php-censor#readme">https://github.com/php-censor/php-censor#readme</a>.
    </body>
</html>';

die();
