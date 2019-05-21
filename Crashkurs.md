# ---------------------- Docker Workshop ----------------------


## Execute Sample Docker image to verfiy installation
docker run hello-world

## check current state
docker image ls
docker container ls

# Get startet:part2 (Building our own image)
## files to be created in sub-folder app
	app.py
	dockerfile
	requirements.txt

## Compose file
	docker-compose.yml

## Create image using this directory's Dockerfile
docker build -t friendlyhello .

## Run "friendlyname" mapping port 4000 to 80
docker run -p 4000:80 friendlyhello

### Same, but in detached mode
docker run -d -p 4000:80 friendlyhello         

visit http://localhost:4000

## List all running containers
docker container ls
docker container stop <name>

## Tag image
docker tag friendlyhello tredecker/get-started:part2  


# Get startet:part3 (deploy as service)
## List stacks or apps
docker stack ls                                            

## deploy the app
docker stack deploy -c docker-compose.yml getstartedlab

## List running services associated with an app
docker service ls 
## List container IDs
docker container ls -q                                      
## Tear down an application
docker stack rm getstartedlab                             

# Get startet:part4 (Setup Docker swarm)

## check current state
docker-machine ls

## create virtual machines
docker-machine create --driver virtualbox myvm1
docker-machine create --driver virtualbox myvm2

## get machine's IPs
docker-machine ls

## init swarm
docker-machine ssh myvm1 "docker swarm init --advertise-addr 192.168.99.100"
docker-machine ssh myvm2 "docker swarm join --token <token> <ip>:2377" ## replace <token> and <ip>

## check result
docker-machine ssh myvm1 "docker node ls"

## configure shell to talk to myvm1
### get the command
docker-machine env myvm1
### command
eval $(docker-machine env myvm1)

## deploy app on swarm
docker stack deploy -c docker-compose.yml getstartedlab

## check result
docker stack ps getstartedlab

## Unsetting docker-machine shell variable settings
eval $(docker-machine env -u)

## Start and stop Docker machines
docker-machine start <machine-name>
docker-machine stop <machine-name>

# Get startet:part5 (Deploy Service on Stack))
## --- use docker-compose2.yml !!! ---

## configure shell to talk to myvm1
### get the command
docker-machine env myvm1
### command
eval $(docker-machine env myvm1)

## deploy new stack
docker stack deploy -c docker-compose2.yml getstartedlab
docker stack ps getstartedlab


## --- now use docker-compose3.yml !!! ---

## create directory within virtual machine
docker-machine ssh myvm1 "mkdir ./data"

## get the command
docker-machine env myvm1
## command
eval $(docker-machine env myvm1)

## deploy new stack
docker stack deploy -c docker-compose3.yml getstartedlab

http://192.168.99.100:8080 --> visualiser
http://192.168.99.101:80   --> WebApp

# ---------------------- Workshop ends here ----------------------
