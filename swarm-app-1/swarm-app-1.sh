docker swarm init
docker network create --driver overlay frontend
docker network create --driver overlay backend
docker service create --name vote --network frontend -p 80:80 --replicas 2 dockersamples/examplevotingapp_vote:before
docker service create --name redis --network frontend --replicas 1 redis:3.2
docker service create --name worker --network frontend --network backend --replicas 1 dockersamples/examplevotingapp_worker
docker service create --name db --network backend --mount type=bind,source="$(pwd)"/db,target=/var/lib/postgresql/data --replicas 1 postgres:9.4
docker service create --name result --network backend -p 5001:80 --replicas 1 dockersamples/examplevotingapp_result:before
