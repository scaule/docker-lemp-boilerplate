# Scripts

## Data (mysql dumps, uploads, ...)

### Backup data from a container

[data-backup.sh](./data-backup.sh)


```
Usage: ./data-backup.sh [app]

Available apps:
    db
```

### Restore a volume from a file

[data-restore.sh](./data-restore.sh)


```
Usage: ./data-restore.sh [app]

Available container names:
    db
```
```

## Debug

### Enable xdebug

[enable-xdebug.sh](./enable-xdebug.sh)

```
Usage: ./enable-xdebug.sh
```

### Disable xdebug

[disable-xdebug.sh](./disable-xdebug.sh)

```
Usage: ./disable-xdebug.sh
```