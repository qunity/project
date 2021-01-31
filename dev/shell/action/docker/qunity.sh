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
# Execute
# ------------------------------------------------------------------------------
function Shell::Execute() {
  Shell::Load helper:docker!
  Shell::Load::File "${DOCKER_ENV_FILE}!"

  docker-compose --file "${DOCKER_COMPOSE_FILE}" --project-directory "${DOCKER_DIR}" \
    exec --user "${PROJECT_USER}" php ./bin/qunity "$@"
}
