#!/bin/bash

docker system prune -f > /dev/null

# コンテナの削除
CONTAINERS=$(docker ps -a -q)
if [ -n "$CONTAINERS" ]; then
    docker rm -f $CONTAINERS > /dev/null 2>&1
fi

# イメージの削除
IMAGES=$(docker images -a -q)
if [ -n "$IMAGES" ]; then
    docker rmi -f $IMAGES > /dev/null 2>&1
fi

# ボリュームの削除
VOLUMES=$(docker volume ls -q)
if [ -n "$VOLUMES" ]; then
    docker volume rm -f $VOLUMES > /dev/null
fi

# ネットワークの削除
NETWORKS=$(docker network ls -q)
if [ -n "$NETWORKS" ]; then
    for network in $NETWORKS; do
			network_name=$(docker network inspect -f '{{.Name}}' $network)
		
		  # デフォルトネットワークはスキップ
			if [[ "$network_name" =~ ^(bridge|host|none)$ ]]; then
    		continue
			fi

      # 使用中のネットワークは削除できないため通知してスルー
      if ! docker network rm $network > /dev/null 2>&1; then
          echo "使用中のNetworkを削除できません: $(docker network inspect -f '{{.Name}}' $network)"
      fi
   done
fi

# ビルダーキャッシュの削除
docker builder prune -f > /dev/null
