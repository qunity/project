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
 * Initialization
 */
function init(): void
{
    /** Project base directory */
    define('BASE_DIR', realpath(__DIR__ . '/../'));

    $composer = json_decode((string)file_get_contents(BASE_DIR . '/composer.json'), true);

    /** Project release version */
    define('PROJECT_VERSION', $composer['version'] ?? null);

    /** Project release time */
    define('PROJECT_TIME', $composer['time'] ?? null);

    /** Project name */
    define('PROJECT_NAME', (string)getenv('PROJECT_NAME'));

    /** Project mode (production|development) */
    define('PROJECT_MODE', (string)getenv('PROJECT_MODE'));
}

/**
 * Require files by path pattern
 * @param string $pattern
 */
function require_files(string $pattern): void
{
    if ($paths = glob($pattern, GLOB_NOSORT)) {
        array_walk(
            $paths,
            function (string $path): void {
                /** @noinspection PhpIncludeInspection */
                require $path;
            }
        );
    }
}
