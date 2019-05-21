eval $(docker-machine env -u)

docker-machine stop myvm2
docker-machine stop myvm1

docker-machine rm -f myvm2
docker-machine rm -f myvm1

docker swarm leave --force

