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

    define('PROJECT_MODE', getenv('PROJECT_MODE'));
}

/**
 * Display welcome
 */
function welcome(): void
{
    $version = 'v.' . (PROJECT_VERSION != null ? PROJECT_VERSION : 'dev');
    $authors = array_diff(array_map(function (array $author): string {
        return implode(' ', $author);
    }, PROJECT_AUTHORS), ['']);

    if (PHP_SAPI == 'cli') {
        $line1 = '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~';
        $line2 = "\n " . substr($line1, strlen($version) + 1);
        $authors = ($authors != [] ? "\n (c) " . implode("\n     ", $authors) . "\n" : '') . "\n";
        print <<<EOD
\n\e[33m $line1\e[32m 
    _____  _     _ __   _ _____ _______ __   __   
   |   __| |     | | \  |   |      |      \_/     
   |____\| |_____| |  \_| __|__    |       |      
\e[33m $line2\e[37m $version 
\e[37m $authors
EOD;
    } else {
        $authors = $authors != [] ? '(c) ' . implode(', ', $authors) : '-';
        print <<<HTML
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Welcome</title>
    <meta name="author" content="$authors">
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        .wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
        }
        .wrapper .welcome {
            font: 76px Verdana, Geneva, sans-serif;
            font-weight: bold;
            border: 7px solid #707070;
            border-left-style: none;
            border-right-style: none;
        }
        .wrapper .title {
            text-transform: uppercase;
            letter-spacing: 10px;
            color: #505050;
        }
        .wrapper .version {
            font-size: 12px;
            vertical-align: sub;
            color: #707070;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <div class="welcome">
            <span class="title">Qunity</span><span class="version">$version</span>
        </div>
    </div>
</body>
</html>
HTML;
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
