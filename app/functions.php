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
    <meta http-equiv="Cache-control" content="public">
    <title>$data->title</title>
    <link rel="shortcut icon" href="data:image/svg+xml;base64,
PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDI0IDI0IiBoZWlnaHQ9IjQ4cHgiIHZp
ZXdCb3g9IjAgMCAyNCAyNCIgd2lkdGg9IjQ4cHgiCiAgICAgZmlsbD0iIzk5OSI+CiAgICA8Zz4KICAgICAgICA8cGF0aCBkPSJNMCwwaDI0djI0SDBWMHoi
IGZpbGw9Im5vbmUiLz4KICAgICAgICA8cGF0aCBkPSJNMTkuMTQsMTIuOTRjMC4wNC0wLjMsMC4wNi0wLjYxLDAuMDYtMC45NGMwLTAuMzItMC4wMi0wLjY0
LTAuMDctMC45NGwyLjAzLTEuNThjMC4xOC0wLjE0LDAuMjMtMC40MSwwLjEyLTAuNjEgbC0xLjkyLTMuMzJjLTAuMTItMC4yMi0wLjM3LTAuMjktMC41OS0w
LjIybC0yLjM5LDAuOTZjLTAuNS0wLjM4LTEuMDMtMC43LTEuNjItMC45NEwxNC40LDIuODFjLTAuMDQtMC4yNC0wLjI0LTAuNDEtMC40OC0wLjQxIGgtMy44
NGMtMC4yNCwwLTAuNDMsMC4xNy0wLjQ3LDAuNDFMOS4yNSw1LjM1QzguNjYsNS41OSw4LjEyLDUuOTIsNy42Myw2LjI5TDUuMjQsNS4zM2MtMC4yMi0wLjA4
LTAuNDcsMC0wLjU5LDAuMjJMMi43NCw4Ljg3IEMyLjYyLDkuMDgsMi42Niw5LjM0LDIuODYsOS40OGwyLjAzLDEuNThDNC44NCwxMS4zNiw0LjgsMTEuNjks
NC44LDEyczAuMDIsMC42NCwwLjA3LDAuOTRsLTIuMDMsMS41OCBjLTAuMTgsMC4xNC0wLjIzLDAuNDEtMC4xMiwwLjYxbDEuOTIsMy4zMmMwLjEyLDAuMjIs
MC4zNywwLjI5LDAuNTksMC4yMmwyLjM5LTAuOTZjMC41LDAuMzgsMS4wMywwLjcsMS42MiwwLjk0bDAuMzYsMi41NCBjMC4wNSwwLjI0LDAuMjQsMC40MSww
LjQ4LDAuNDFoMy44NGMwLjI0LDAsMC40NC0wLjE3LDAuNDctMC40MWwwLjM2LTIuNTRjMC41OS0wLjI0LDEuMTMtMC41NiwxLjYyLTAuOTRsMi4zOSwwLjk2
IGMwLjIyLDAuMDgsMC40NywwLDAuNTktMC4yMmwxLjkyLTMuMzJjMC4xMi0wLjIyLDAuMDctMC40Ny0wLjEyLTAuNjFMMTkuMTQsMTIuOTR6IE0xMiwxNS42
Yy0xLjk4LDAtMy42LTEuNjItMy42LTMuNiBzMS42Mi0zLjYsMy42LTMuNnMzLjYsMS42MiwzLjYsMy42UzEzLjk4LDE1LjYsMTIsMTUuNnoiLz4KICAgIDwv
Zz4KPC9zdmc+Cg=="/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <style>
        @import url(https://fonts.googleapis.com/css2?family=Wallpoet&display=swap);
        html,body { height: 100%; margin: 0; cursor: default; }
        #wrapper { display: flex; align-items: center; justify-content: center; height: 80%; }
        #welcome>* { text-align: center; }
        #project { font-size: 3em; font-family: Wallpoet, sans-serif; color: #999; }
        #info { letter-spacing: 0.1em; word-spacing: 0.5em; font-family: sans-serif; font-size: 0.6em; color: #ccc; }
    </style>
</head>
<body>
<div id="wrapper">
    <div id="welcome"><div id="project">$data->project</div><div id="info">$data->info</div></div>
    <script>
        if (typeof $ !== 'undefined') {
            $('#project').css('opacity', 0).fadeTo(250, 1);
            $('#info').css('opacity', 0).delay(750).fadeTo('slow', 1);
        }
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
