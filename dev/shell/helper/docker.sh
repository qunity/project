#!/usr/bin/env bash

# +----------------------------------------------------------------------------+
# |                                                                            |
# | This file is part of the Qunity package.                                   |
# |                                                                            |
# | Copyright (c) Rodion Kachkin <kyleRQWS@gmail.com>                          |
# |                                                                            |
# | For the full copyright and license information, please view the LICENSE    |
# | file that was distributed with this source code.                           |
# |                                                                            |
# +----------------------------------------------------------------------------+

# ------------------------------------------------------------------------------
# Initialize
# ------------------------------------------------------------------------------
# shellcheck disable=SC2034

DOCKER_DIR="$(readlink --canonicalize-existing --verbose "${BASE_DIR}/docker")"
DOCKER_COMPOSE_FILE="$(readlink --canonicalize-existing --verbose "${DOCKER_DIR}/docker-compose.yml")"
DOCKER_ENV_FILE="$(readlink --canonicalize-existing --verbose "${DOCKER_DIR}/.env")"
