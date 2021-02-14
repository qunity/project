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

    $composer = json_decode(file_get_contents(BASE_DIR . '/composer.json'), true);
    define('PROJECT_VERSION', $composer['version'] ?? null);
    define('PROJECT_AUTHORS', $composer['authors'] ?? []);
    define('PROJECT_TIME', $composer['time'] ?? null);

    define('PROJECT_MODE', getenv('PROJECT_MODE'));
}

/**
 * Display welcome
 */
function welcome(): void
{
    if (PHP_SAPI == 'cli') {
        $info = (PROJECT_VERSION != null ? " version \e[33m" . PROJECT_VERSION . "\e[0m" : '') .
            (PROJECT_TIME != null ? ' ' . PROJECT_TIME : '');
        print "\e[32mQunity\e[0m" . ($info ?: ' Welcome') . "\n";
    } else {
        $info = (PROJECT_VERSION != null ? 'v.' . PROJECT_VERSION : '') .
            (PROJECT_TIME != null ? ' ' . PROJECT_TIME : '');
        print preg_replace(
            ['%>(\s)+%s', '%(\s)+<%s', '%(\s)+%s'],
            ['>', '<', "$1"],
            <<<HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Qunity Welcome</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
            crossorigin="anonymous"></script>
    <link href="http://fonts.cdnfonts.com/css/trivial" rel="stylesheet">
    <style>
        * {
            -webkit-touch-callout: none;
              -webkit-user-select: none;
               -khtml-user-select: none;
                 -moz-user-select: none;
                  -ms-user-select: none;
                      user-select: none;
        }
        html, body {
            height: 100%;
            margin: 0;
            cursor: default;
        }
        .wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 70%;
        }
        .welcome > div {
            opacity: 0;
            font-family: 'Trivial', sans-serif;
            font-weight: bold;
        }
        .title {
            text-transform: uppercase;
            font-size: 112px;
            color: #808080;
        }
        .info {
            margin-top: 25px;
            text-align: center;
            font-size: 9px;
            color: #ccc;
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="welcome">
        <div class="title">q&nbsp;u&nbsp;n&nbsp;i&nbsp;t&nbsp;y</div>
        <div class="info">${info}</div>
        <script>
            $(function () {
                $(".title").fadeTo(200, 1).next(".info").delay(750).fadeTo("slow", 1);
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
        array_walk($paths, function (string $path): void {
            require $path;
        });
    }
}
