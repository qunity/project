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
 * @SuppressWarnings(Superglobals)
 */
function init(): void
{
    define('BASE_DIR', realpath(__DIR__ . '/../'));
    define('BASE_URL', PHP_SAPI != 'cli' ? $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] : null);

    $composer = json_decode(file_get_contents(BASE_DIR . '/composer.json'), true);
    define('PROJECT_VERSION', $composer['version'] ?? null);
    define('PROJECT_AUTHORS', $composer['authors'] ?? []);

    define('PROJECT_MODE', getenv('PROJECT_MODE'));
}

/**
 * Display welcome
 */
function welcome(): void
{
    $data = new StdClass();

    if (PHP_SAPI == 'cli') {
        if (!empty(PROJECT_VERSION)) {
            $data->version = "\n\e[2;37m version: " . PROJECT_VERSION . "\e[0m";
        }

        if (!empty(PROJECT_AUTHORS)) {
            $data->authors = "\n\e[2;37m authors: (c) " .
                implode(
                    "\n" . str_repeat(' ', 14),
                    array_map(function (array $author): string {
                        return implode(' ', $author);
                    }, PROJECT_AUTHORS)
                ) . "\e[0m";
        }

        print "\n \e[1;2;4;32m   Q U N I T Y   \e[0m\n" .
            ($data->version ?? '') .
            ($data->authors ?? '') .
            "\n" . ((array)$data != [] ? "\n" : '');
    } else {
        if (!empty(PROJECT_VERSION)) {
            $data->version = 'v.' . PROJECT_VERSION;
        }

        if (!empty(PROJECT_AUTHORS)) {
            $data->authors = '(c) ' .
                implode(
                    '<br>',
                    array_map(function (array $author): string {
                        return implode(' ', $author);
                    }, PROJECT_AUTHORS)
                );
        }

        $config = new StdClass();
        $config->style = BASE_URL . '/static/style/welcome.css';
        $config->script = BASE_URL . '/static/script/welcome.js';

        include BASE_DIR . '/app/template/welcome.phtml';
    }
}

/**
 * Require files by path pattern
 * @param string $pattern
 */
function require_files(string $pattern): void
{
    if ($paths = glob($pattern, GLOB_NOSORT)) {
        array_walk($paths, function (string $path): void {
            require $path;
        });
    }
}
