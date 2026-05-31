# Sexology

Magento 2 project with a [Warden](https://docs.warden.dev)-based local development environment
and a `qunity` CLI wrapper for common development tasks.

**Local URL:** `https://app.sexology.test`

---

## Stack

| Service    | Version |
|------------|---------|
| PHP        | 8.2     |
| MariaDB    | 10.6    |
| OpenSearch | 2.5     |
| Redis      | 7.0     |
| Composer   | 2.2     |

---

## Requirements

- [Docker](https://www.docker.com) with Docker Compose
- [Warden](https://docs.warden.dev)
- Git
- Bash 3.2+

---

## Setup

### 1. Configure environment settings

Copy the sample file and fill in the required values:

```bash
cp .qunity/.env.sample .qunity/.env
```

| Variable                    | Description                                   |
|-----------------------------|-----------------------------------------------|
| `MAGENTO_REPOSITORY`        | SSH URL of the Magento source repository      |
| `MAGENTO_ADMIN_*_IDENTITY`  | Admin identity in `lastname:firstname` format |
| `MAGENTO_ADMIN_*_USER`      | Admin username                                |
| `MAGENTO_ADMIN_*_EMAIL`     | Admin email address                           |
| `MAGENTO_ADMIN_*_PASSWORD`  | Admin password                                |
| `MAGENTO_ADMIN_*_FIRSTNAME` | Admin first name                              |
| `MAGENTO_ADMIN_*_LASTNAME`  | Admin last name                               |

To add multiple admins, repeat the block with a different `LASTNAME_FIRSTNAME` suffix,
and use the same suffix as the identity value (e.g. `MAGENTO_ADMIN_DOE_JOHN_IDENTITY=doe:john`).

### 2. Deploy

```bash
./qunity deploy
```

This runs the full deployment sequence:

1. Stops and removes the existing Warden environment
2. Downloads the Magento repository
3. Starts the Warden environment
4. Installs Composer packages and runs Magento setup
5. Creates admin users
6. Runs all indexers
7. Flushes the cache
8. Generates PhpStorm URN catalog
9. Creates required Magento development directories

---

## CLI Reference

Run `./qunity` or `./qunity --help` to see the full command list.

---

### `deploy`

Runs the full deployment sequence described above.

```bash
./qunity deploy
```

---

### `warden:up`

Starts the Warden Docker environment. Creates SSL certificates for the project domain
automatically if they do not exist yet.

```bash
./qunity warden:up
```

---

### `warden:down`

Stops the Warden Docker environment.

```bash
./qunity warden:down [options]
```

| Option           | Description                                          |
|------------------|------------------------------------------------------|
| `-r`, `--remove` | Also remove all Compose volumes and SSL certificates |

---

### `warden:status`

Checks whether the Warden environment is running and PHP / Composer are accessible.

```bash
./qunity warden:status
```

---

### `magento:download`

Clones the Magento repository into the web root directory.

```bash
./qunity magento:download [options]
```

| Option          | Description                                  |
|-----------------|----------------------------------------------|
| `-f`, `--force` | Remove the existing directory before cloning |

---

### `magento:install`

Installs Composer packages and runs `magento setup:install`.

```bash
./qunity magento:install
```

---

### `magento:admin:create`

Creates the admin users defined in `.qunity/.env`. Without arguments, creates all configured admins.

```bash
./qunity magento:admin:create [options]
```

| Option                        | Description                                          |
|-------------------------------|------------------------------------------------------|
| `-a`, `--admin <identity>...` | Create specific admins by identity (e.g. `doe:john`) |

---

### `magento:reindex`

Runs Magento indexers. Without arguments, reindexes everything.

```bash
./qunity magento:reindex [options]
```

| Option                     | Description                   |
|----------------------------|-------------------------------|
| `-i`, `--index <index>...` | Reindex specific indexes only |

---

### `magento:cache`

Flushes the Magento cache. Without arguments, flushes all cache types.

```bash
./qunity magento:cache [options]
```

| Option                     | Description                     |
|----------------------------|---------------------------------|
| `-c`, `--cache <cache>...` | Flush specific cache types only |

---

## Project Structure

```
.
├── .env                       # Warden environment configuration
├── .gitignore
├── .qunity/                   # CLI tooling
│   ├── .env                   # Local environment settings (git-ignored)
│   ├── .env.sample            # Environment settings template
│   ├── command/               # CLI commands (auto-discovered, numeric order)
│   │   ├── 010-deploy.sh
│   │   ├── 020-warden.sh
│   │   ├── 030-magento.sh
│   │   ├── magento/
│   │   │   ├── 010-download.sh
│   │   │   ├── 020-install.sh
│   │   │   ├── 030-admin.sh
│   │   │   ├── 040-reindex.sh
│   │   │   ├── 050-cache.sh
│   │   │   └── admin/
│   │   │       └── 010-create.sh
│   │   └── warden/
│   │       ├── 010-up.sh
│   │       ├── 020-down.sh
│   │       └── 030-status.sh
│   ├── helper/                # Internal helpers (not exposed as commands)
│   │   ├── download.sh
│   │   └── magento/
│   │       ├── create-directories.sh
│   │       └── urn-generate.sh
│   ├── library/               # Reusable function libraries
│   │   ├── question/
│   │   │   └── yesno.sh
│   │   ├── variable/
│   │   │   ├── list.sh
│   │   │   └── value.sh
│   │   └── warden/
│   │       └── exec.sh
│   └── replace/               # Files copied into the project after clone (git-ignored)
│       └── qunity/magento/
├── .warden/                   # Warden Docker Compose overrides
├── magento/                   # Magento source code (git-ignored)
└── qunity                     # CLI entry point
```
