<?php

/**
 * This file is part of the Qunity package.
 *
 * Copyright (c) Rodion Kachkin <kyleRQWS@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

/**
 * Autoload file for PHPStan
 */

require_once __DIR__ . '/../../../vendor/autoload.php';
require_files(__DIR__ . '/../../code/*/*/test/autoload.php');

init();