# Database
`docker run --name alfresco-postgres -e POSTGRES_DB=alfresco -e POSTGRES_USER=alfresco -e POSTGRES_PASSWORD=alfresco -p 5432:5432 -d postgres:9.4`

Options:
* `POSTGRES_DB` Database name in PostgreSQL.
* `POSTGRES_USER` Owner of the database.
* `POSTGRES_PASSWORD` Password that should be used for the user.
* `postgres:<version>` Name of the database image + version.

# Alfresco docker
Alfresco 5.1.1 clean docker image.  
Install Docker on your machine:  
https://docs.docker.com/engine/installation/

Flow:   
1. `build` Build an image from the Dockerfile;   
2. `run` Create AND start a container from the image;   
3. `stop/start` Stop or start an existing container;

#### Create an image using the Dockerfile
This command creates an image called `alfresco-511`  
`docker build -t alfresco-511 .`

#### Create and run the container (only needed once)
This command creates a named Docker container from the image and starts it. It also maps port 8080 of the container to port 8080 of your machine, so you can use localhost:8080/share to access your Alfresco.  
`docker run --name='alfresco' -d -p 8080:8080 --link alfresco-postgres:alfresco-postgres alfresco-511`  
Go to localhost:8080/share to visit your Alfresco. (This takes a few min just like any Alfresco)

#### 'SSH' into your container
`docker exec -it alfresco bash`

### Stopping and starting the created container
`docker stop alfresco` Stops the running container named 'alfresco'.  
`docker start alfresco` resumes the stopped container named 'alfresco'. This container will be in the same state you left it last time, you just need to start Alfresco again with the command `/usr/bin/supervisord`.  
`docker ps -a` will show you all running docker containers.  
`docker rm alfresco` will remove the container named 'alfresco'

### Links
https://github.com/gui81/docker-alfresco
