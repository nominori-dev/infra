backup_path=/var/mariadb/backups/
expiry_date=5
current_date=$(date +%Y-%m-%d)

# create folder if it does not exist
if [ ! -d "$backup_path" ]; then
        mkdir "$backup_path"
fi

if [ ! -d "$backup_path/$current_date" ]; then
    mkdir -p "$backup_path/$current_date"
    if [ ! -f $backup_path/$current_date/db-$(date +%H%M).sql ]; then
            mysqldump --all-databases | gzip -c > $backup_path/$current_date/db-$(date +%H%M).sql.gz
    fi
else
    if [ ! -f $backup_path/$current_date/db-$(date +%H%M).sql ]; then
            mysqldump --all-databases | gzip -c > $backup_path/$current_date/db-$(date +%H%M).sql.gz
    fi
fi
# delete backup older than x day
find $backup_path -type d -mtime +$expiry_date | xargs rm -Rf
