#!/bin/bash
apt update && apt upgrade -qy && apt install docker.io -qy
service docker start
docker run -d --network host -p 8000:8000 -p 8200:8200 -p 18888:18888 -p 8080:8080 -p 8081:8081 -p 5696:5696 -e ADMIN_ACCESS_ID="${admin_access_id}" -e ALLOWED_ACCESS_IDS="${allowed_access_ids}" -e CLUSTER_URL="https://${domain_name}:8000" -e CLUSTER_NAME="${name}" --name akeyless-gw akeyless/base
