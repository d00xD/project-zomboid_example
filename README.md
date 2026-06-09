# The file is written in 2 languages ​​RU/EN
# Файл написан на 2 языках RU/EN
---
# English version

# Project Zomboid Server Config Docs (Docker)

## Overview

This repo has the config for running a dedicated **Project Zomboid** server using Docker Compose. The server is based on the [indifferentbroccoli/projectzomboid-server-docker](https://hub.docker.com/r/indifferentbroccoli/projectzomboid-server-docker) image and is configured via environment variables.

## Config Files

### 1. `docker-compose.yml`

```yaml
services:
  projectzomboid:
    image: indifferentbroccoli/projectzomboid-server-docker
    restart: unless-stopped
    container_name: projectzomboid
    stop_grace_period: 30s
    ports:
      - 16261:16261/udp
      - 16262:16262/udp
      - 27015:27015/tcp
    env_file:
      - .env
    volumes:
      - ./projectzomboid/data:/project-zomboid
      - ./projectzomboid/config:/project-zomboid-config
```
# Parameters explained:
- image - __indifferentbroccoli/projectzomboid-server-docker__ — the Docker image being used. 
- restart - __unless-stopped__ — auto-restart the container (unless you stop it manually). 
- container_name - __projectzomboid__ — name of the container. 
- stop_grace_period - __30s__ — how long to wait before force-stopping. 
- ports - __16261/udp, 16262/udp, 27015/tcp__ — port forwarding between host and container. 
- env_file - __.env__ — file with environment variables. 
- volumes - __./projectzomboid/data, ./projectzomboid/config__ — mounting folders to save data and configs.

# Ports:
- 16261 — UDP — main game port. 
- 16262 — UDP — extra game port. 
- 27015 — TCP — port for RCON (remote control).

# Volumes: 
- ./projectzomboid/data — world saves and game data. 
- ./projectzomboid/config — server config files.

### 2. '.env'
```ini
ADMIN_USERNAME=admin-username
ADMIN_PASSWORD=admin-password
RCON_PASSWORD=rcon-password
RCON_PORT=27015
SERVER_NAME=server-name
MEMORY_XMX_GB=6
MEMORY_XMS_GB=2
UPDATE_ON_START=true
SERVER_BRANCH=unstable
PUID=your-UID
PGID=your-GID
```

# Available environment variables:
- ADMIN_USERNAME — server admin name.
- ADMIN_PASSWORD — server admin password.
- RCON_PASSWORD — password for RCON connection.
- RCON_PORT — RCON port.
- SERVER_NAME — display name of the server.
- MEMORY_XMX_GB — max memory (in GB).
- MEMORY_XMS_GB — initial memory (in GB).
- UPDATE_ON_START — check and install updates on startup.
- SERVER_BRANCH — server branch (stable, unstable, legacy).
- PUID — user ID for volume access permissions.
- PGID — group ID for volume access permissions.

# Setup recommendations:
- PUID/PGID — set your current user's UID and GID so the container has the right write permissions on volumes. You can check these values with the `id` command.
- MEMORY_XMX_GB — give the server no more than 70.

# Starting the server

## 1. Copy `.env.example` to `.env`.
## 2. Edit `.env` and put your own values in there.
## 3. Start the container:
```bash
docker compose up -d
```
## 4. Check the logs:
```bash
docker compose logs -f
```

# Backup
- Info coming soon

# License
- This config is for personal use. The server image is distributed under its own license.

# Useful links:
- [Official Project Zomboid site](https://projectzomboid.com/)
- [Indifferent Broccoli Docker Image](https://github.com/indifferentbroccoli/projectzomboid-server-docker)
- [RCON docs](https://pzwiki.net/wiki/RCON)
---
---
# Русская версия

# Документация конфигурации сервера Project Zomboid (Docker)

## Обзор

Этот репозиторий содержит конфигурацию для запуска выделенного сервера **Project Zomboid** в Docker-compose. Сервер основан на образе [indifferentbroccoli/projectzomboid-server-docker](https://hub.docker.com/r/indifferentbroccoli/projectzomboid-server-docker) и настраивается через переменные окружения.

## Файлы конфигурации

### 1. `docker-compose.yml`

```yaml
services:
  projectzomboid:
    image: indifferentbroccoli/projectzomboid-server-docker
    restart: unless-stopped
    container_name: projectzomboid
    stop_grace_period: 30s
    ports:
      - 16261:16261/udp
      - 16262:16262/udp
      - 27015:27015/tcp
    env_file:
      - .env
    volumes:
      - ./projectzomboid/data:/project-zomboid
      - ./projectzomboid/config:/project-zomboid-config
```
# Описание параметров:
- image - __indifferentbroccoli/projectzomboid-server-docker__ используемый docker-образ сервера.
- restart - __unless-stopped__ автоматический перезапуск контейнера (кроме ручной остановки).
- container_name - __projectzomboid__ имя контейнера.
- stop_grace_period - __30s__ время ожидания перед принудительной остановкой.
- ports - __16261/udp, 16262/udp, 27015/tcp__ проброс портов между хостом и контейнером.
- env_file - __.env__ файл с переменными окружения.
- volumes - __./projectzomboid/data, ./projectzomboid/config__ монтирование директорий для сохранения данных и конфигурации.

# Порты
- 16261 - UDP - основной игровой порт.
- 16262 - UDP - дополнительный игровой порт.
- 27015 - TCP - порты для RCON (удалённое управление).

# Тома
- ./projectzomboid/data — сохранения мира и игровые данные.
- ./projectzomboid/config — конфигурационные файлы сервера.

### 2. `.env`

```ini
ADMIN_USERNAME=admin-username
ADMIN_PASSWORD=admin-password
RCON_PASSWORD=rcon-password
RCON_PORT=27015
SERVER_NAME=server-name
MEMORY_XMX_GB=6
MEMORY_XMS_GB=2
UPDATE_ON_START=true
SERVER_BRANCH=unstable
PUID=your-UID
PGID=your-GID
```

# Доступные переменные окружения:
- ADMIN_USERNAME - имя администратора сервера.
- ADMIN_PASSWORD - пароль администратора.
- RCON_PASSWORD - пароль для RCON-подключения.
- RCON_PORT - порт RCON.
- SERVER_NAME - отображаемое имя сервера.
- MEMORY_XMX_GB - максимальный объём памяти (в GB).
- MEMORY_XMS_GB - начальный объём памяти (в GB).
- UPDATE_ON_START - проверять и устанавливать обновления при запуске.
- SERVER_BRANCH - ветка сервера (stable, unstable, legacy).
- PUID - ID пользователя для прав доступа к томам.
- PGID - ID группы для прав доступа к томам.

# Рекомендации по настройке:
- PUID/PGID - укажите UID и GID текущего пользователя, чтобы контейнер имел правильные права на запись в тома. Узнать значения можно командой id.
- MEMORY_XMX_GB - выделите серверу не более 70–80% от доступной оперативной памяти хоста.
- SERVER_BRANCH:
    - stable — стабильная версия
    - unstable — нестабильная версия (бета)
    - legacy — старая версия
- UPDATE_ON_START - если false, сервер не будет проверять обновления при каждом запуске.
---
# Запуск сервера.

## 1. Скопируйте `.env.example` в `.env`.
## 2. Отредактируйте `.env`, указав свои значения.
## 3. Запустите контейнер:
```bash
docker compose up -d
```
## 4. Проверьте логи:
```bash
docker compose logs -f
```

# Резервное копирование
- Информация дополняется

# Лицензия
Данная конфигурация предназначена для личного использования. Образ сервера распространяется в соответствии с его собственной лицензией.

# Полезные ссылки:
- [Официальный сайт Project Zomboid](https://projectzomboid.com/)
- [Indifferent Broccoli Docker Image](https://github.com/indifferentbroccoli/projectzomboid-server-docker)
- [Документация по RCON](https://pzwiki.net/wiki/RCON)