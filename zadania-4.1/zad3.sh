#!/bin/bash

echo “disk space usage for Docker volumes:"
echo "------------------------------------------------------"

docker volume ls -q | while read volume; do
  mount_point=$(docker volume inspect "$volume" -f '{{ .Mountpoint }}')

  if [ -d "$mount_point" ]; then
    usage=$(df -h "$mount_point" | awk 'NR==2 {print $5}') 
    echo "$volume: $usage"
  else
    echo “volume $volume does not exist (no directory).”
  fi
done
