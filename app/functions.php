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
 * Display welcome
 */
function welcome(): void
{
    if (PHP_SAPI == 'cli') {
        print "\e[32m" . PROJECT_NAME . "\e[0m" .
            (((PROJECT_VERSION != null ? " version \e[33m" . PROJECT_VERSION . "\e[0m" : '') .
                (PROJECT_TIME != null ? ' ' . PROJECT_TIME : '')) ?: ' Welcome') . "\n";
    } else {
        $data = new stdClass();
        $data->title = PROJECT_NAME;
        $data->project = implode('&ensp;', str_split(strtoupper(PROJECT_NAME)));
        $data->info = ((PROJECT_VERSION != null ? 'v.' . PROJECT_VERSION : '') .
            (PROJECT_TIME != null ? ' ' . PROJECT_TIME : '')) ?: 'WELCOME';
        print preg_replace(
            ['%>(\s)+%s', '%(\s)+<%s', '%(\s)+%s'],
            ['>', '<', '\\1'],
            <<<HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>$data->title</title>
    <link rel="icon" type="image/x-icon" href="favicon.svg">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Wallpoet&display=swap');
        html, body { height: 100%; margin: 0; cursor: default; }
        #wrapper { display: flex; align-items: center; justify-content: center; height: 80%; }
        #welcome > * { text-align: center; }
        #project { font-size: 3em; font-family: 'Wallpoet', cursive; color: #999; }
        #info { letter-spacing: 0.1em; word-spacing: 0.5em; font-family: sans-serif; font-size: 0.6em; color: #ccc; }
    </style>
</head>
<body>
<div id="wrapper">
    <div id="welcome"><div id="project">$data->project</div><div id="info">$data->info</div></div>
    <script>
        $(function () {
            $('#project').css('opacity', 0).fadeTo(250, 1);
            $('#info').css('opacity', 0).delay(750).fadeTo('slow', 1);
        });
    </script>
</div>
</body>
</html>
HTML
        );
    }
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
