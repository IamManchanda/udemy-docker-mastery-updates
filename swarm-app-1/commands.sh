# Overlay's
docker network create -d overlay backend
docker network create -d overlay frontend

# Vote Service (Python)
docker service create --name vote -p 80:80 --network frontend --replicas 2 bretfisher/examplevotingapp_vote

# Redis Cache Service
docker service create --name redis --network frontend redis:3.2

# PostgreSQL Database Service
docker service create --name db --network backend -e POSTGRES_HOST_AUTH_METHOD=trust --mount type=volume,source=db-data,target=/var/lib/postgresql/data postgres:9.4

# Worker Service to Process Data (Java)
docker service create --name worker --network frontend --network backend bretfisher/examplevotingapp_worker:java

# Result Service (Node.js)
docker service create --name result --network backend -p 5001:80 bretfisher/examplevotingapp_result
