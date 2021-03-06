# Docker Workshop
## taken from https://docs.docker.com/get-started/



execute sample docker image to verfiy installation
	
	docker run hello-world
	
check current state
	
	docker image ls
	docker container ls

# Get startet:part2 
## Building our own image

files to be created in sub-folder app

	app.py
	dockerfile
	requirements.txt

compose file to configure service
	
	docker-compose.yml

create image using this directory's dockerfile
	
	docker build -t friendlyhello .

run "friendlyname" mapping port 4000 to 80
	
	docker run -p 4000:80 friendlyhello

same, but in detached mode
	
	docker run -d -p 4000:80 friendlyhello         

visit http://localhost:4000

list all running containers
	
	docker container ls
	docker container stop <name>

tag our image
	
	docker tag friendlyhello tredecker/get-started:part2  


# Get startet:part3
## deploy as service

list stacks or apps
	
	docker stack ls                                            

deploy the app
	
	docker stack deploy -c docker-compose.yml getstartedlab

list running services associated with an app
	
	docker service ls

list container IDs

	docker container ls -q                                      

tear down an application

	docker stack rm getstartedlab                             

# Get startet:part4
## setup docker swarm

check current state
	
	docker-machine ls

create virtual machines
	
	docker-machine create --driver virtualbox myvm1

	docker-machine create --driver virtualbox myvm2

get machine's IPs
	
	docker-machine ls

init swarm
	
	docker-machine ssh myvm1 "docker swarm init --advertise-addr 192.168.99.100"

	docker-machine ssh myvm2 "docker swarm join --token <token> <ip>:2377" ## replace <token> and <ip>

check result
	
	docker-machine ssh myvm1 "docker node ls"

configure shell to talk to myvm1
get the command
	
	docker-machine env myvm1
command
	
	eval $(docker-machine env myvm1)

### deploy app on swarm
	
	docker stack deploy -c docker-compose.yml getstartedlab

check result
	
	docker stack ps getstartedlab

unsetting docker-machine shell variable settings
	
	eval $(docker-machine env -u)

start and stop docker machines
	
	docker-machine start <machine-name>
	docker-machine stop <machine-name>

# Get startet:part5
## deploy service on stack (use docker-compose2.yml !!!)

configure shell to talk to myvm1
get the command
	
	docker-machine env myvm1
command
	
	eval $(docker-machine env myvm1)

deploy new stack
	
	docker stack deploy -c docker-compose2.yml getstartedlab
	docker stack ps getstartedlab

create directory within virtual machine
	
	docker-machine ssh myvm1 "mkdir ./data"

get the command
	
	docker-machine env myvm1
command
	
	eval $(docker-machine env myvm1)

## deploy new stack (now use docker-compose3.yml !!!)
	
	docker stack deploy -c docker-compose3.yml getstartedlab

visit http://192.168.99.100:8080 --> visualiser
and http://192.168.99.101:80   --> WebApp
