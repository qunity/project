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
    define('BASE_DIR', realpath(__DIR__ . '/../'));

    $composer = json_decode((string)file_get_contents(BASE_DIR . '/composer.json'), true);
    define('PROJECT_VERSION', $composer['version'] ?? null);
    define('PROJECT_TIME', $composer['time'] ?? null);

    define('PROJECT_NAME', (string)getenv('PROJECT_NAME'));
    define('PROJECT_MODE', (string)getenv('PROJECT_MODE'));
}

/**
 * Display welcome
 */
function welcome(): void
{
    $project = PROJECT_NAME;
    if (PHP_SAPI == 'cli') {
        $info = ((PROJECT_VERSION != null ? " version \e[33m" . PROJECT_VERSION . "\e[0m" : '') .
            (PROJECT_TIME != null ? ' ' . PROJECT_TIME : '')) ?: ' Welcome';
        $content = "\e[32m" . $project . "\e[0m" . $info . "\n";
    } else {
        $info = ((PROJECT_VERSION != null ? 'v.' . PROJECT_VERSION : '') .
            (PROJECT_TIME != null ? ' ' . PROJECT_TIME : '')) ?: 'welcome';
        $content = preg_replace(
            ['%>(\s)+%s', '%(\s)+<%s', '%(\s)+%s'],
            ['>', '<', '\\1'],
            <<<HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>{$project}</title>
    <link rel="icon" type="image/svg+xml" href="favicon.svg">
    <link rel="icon" href="data:,">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <style>
        @font-face { /* variants: https://fonts.googleapis.com/css2?family=Jost:wght@300&display=swap */
            font-family: 'Jost';
            font-style: normal;
            font-weight: 300;
            src: url(https://fonts.gstatic.com/s/jost/v6/92zPtBhPNqw79Ij1E865zBUv7mz9JTVBNIg.woff2) format('woff2');
            unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074,
                           U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
        }
        * {
            -webkit-touch-callout: none;
              -webkit-user-select: none;
                 -moz-user-select: none;
                  -ms-user-select: none;
                      user-select: none;
        }
        html,body {
            height: 100%;
            margin: 0;
            cursor: default;
        }
        .wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 75%;
        }
        .welcome>* {
            text-align: center;
            line-height: 1.2em;
            font-family: 'Jost', sans-serif;
        }
        .title {
            text-transform: uppercase;
            letter-spacing: 0.6em;
            word-spacing: 0.2em;
            font-size: 5em;
            color: #999;
        }
        .info {
            text-transform: lowercase;
            letter-spacing: 0.1em;
            word-spacing: 0.5em;
            font-size: 0.8em;
            color: #ccc;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="welcome">
            <div class="title">{$project}</div>
            <div class="info">{$info}</div>
            <script>
                $(function () {
                    $('.title').css('opacity', 0).fadeTo(250, 1);
                    $('.info').css('opacity', 0).delay(750).fadeTo('slow', 1);
                });
            </script>
        </div>
    </div>
</body>
</html>
HTML
        );
    }
    print $content;
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
