#!/bin/bash

# Считываем переменные из .env
set -a
source /home/ib/pz-server/scripts/.env   # пусть до файла с переменными .env
set +a

# Объявляем переменные
BACKUP_DIR=$BACKUP_DIR
SAVE_PATH=$SAVE_PATH
DATE=$DATE
ARCHIVE_NAME=$ARCHIVE_NAME
SAVE_PATH=$SAVE_PATH
CONTAINER_NAME=$CONTAINER_NAME
RCON_PASSWORD=$RCON_PASSWORD
RCON_PORT=$RCON_PORT
RETENTION_DAYS=$RETENTION_DAYS

# Создаем BACKUP_DIR, если папки нет, ошибки не будет
mkdir -pv $BACKUP_DIR 

# Сохранение мира через RCON
echo "Идет сохранение мира..."
docker exec $CONTAINER_NAME rcon-cli -a localhost:$RCON_PORT -p "$RCON_PASSWORD" save
sleep 10

#
echo "Создается резервная копия..."
tar -czf $BACKUP_DIR/$ARCHIVE_NAME -C $SAVE_PATH .

# Проверка создания бэкапа
if [ $? -eq 0 ]; then
    echo "Бэкап успешно создан: $BACKUP_DIR/$ARCHIVE_NAME"
    echo "Размер бэкапа: $(du -h $BACKUP_DIR/$ARCHIVE_NAME | cut -f1)"
else
    echo "Ошибка при создании бэкапа!"
    exit 1
fi

# Очистка старых бэкапов
echo "Идет очситка бэкапов старше $RETENTION_DAYS дней..."
find $BACKUP_DIR -name "pz-server-backup-*.tar.gz" -type f -mtime +$RETENTION_DAYS -delete

echo "Бэкапирование завершено!"