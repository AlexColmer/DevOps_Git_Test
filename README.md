## Microservices
Microservice = A service that does one job, and has an endpoint to connect to (e.g. API, IP, Webhook etc.)

Great article: https://www.atlassian.com/microservices/microservices-architecture/microservices-vs-monolith#:~:text=A%20monolithic%20application%20is%20built,of%20smaller%2C%20independently%20deployable%20services.

NOTE - Monoliths and two-tier architecctures are still vaible and can be the correct dpeloyment structure in certain use cases. For example for a small projecct with a low number of users, and the user base is not expected to increase. A monolith architecture is most effective.

#### Benefits of Microservices
- Agility
- Flexible Scaling
- Easy Deployment
- Technological Freedom
- Reusable Code
- Resilience

Microservices becomes more and more viable the large the project/app is and the larger the user base is.

#### Examples of users:
- Twitter
- Spotify
- Ebay
- Amazon
- Netflix
- Uber
- PayPal
- Many, many more

### Monolith architecture vs Microservices architecture

A monolith application is built as a single unified unit, while a microservices architecture is a collection of smaller, independantly deployable services. Monolith's are not obsolete by any means. They are convinient to set up and allows for the entire project's code to be kept in one place, making it's management and deployment easy too.

Monolith advantages:
- Easy deployment
- Easier to develop (less to manage)
- Improved performance (less API's needed for example)
- Simple testing (end to end is all in one system)
- Easy debugging (code is in one place so it's easier to follow the path to the root cause of an issue)

Monolith disadvantages:
- 

![Alt text](/images/atlassian_monolith.png "Monolith architecture by Atlassian")

![Alt text](/images/monolith-vs-microservice2.png "Monolith's vs Microservices2")


## Docker

One of the hottest skills in tech currently - Used for CONTAINERISATION.

Docker is an open source platform that enables developers to build, deploy, run, update and manage containers—standardized, executable components that combine application source code with the operating system (OS) libraries and dependencies required to run that code in any environment.

Virtualisaation takes too much processing power! Docker doesn't reservce resources, instead it only uses them when it needs to. Makes your machine and processing faster.

# Containerisation
A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another. This means we don't have to use virtulaisation, which takes up a set amount of resources even if it is not running. Instead, software running in a container only uses the resources it needs, when it needs them.

![Alt text](/images/containers-vms.png "Containers vs VMs")

### Why use Docker?
- Improved and seamless container portability
- Even lighter weight and more granular updates
- Automated container creation
- Container versioning
- Container reuse
- Shared container libraries

### Initial setup

- Sign up for docker at https://hub.docker.com/ (use personal email)
- Download for windows: https://www.docker.com/products/docker-desktop/
- Open .exe to run installer (it will take a few minutes)
- Restart machine if prompted to
- On restart Docker desktop app should automatically run, if not open it as admin
- You may need to install WS2 separately: https://learn.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package
- If you needed to install WS2 separtaly, kill the old Docker process in Task Manager. Then run it again.
- run `docker --version` in terminal/gitbash to check version (`docker` for cheat-sheet)

## Early commands
- Run `docker pull hello-world`
- Run `docker images` -> Will show images downloaded (just this one now)
- If you need to login, please use `alias docker="winpty docker"`
- You can also use docker ddesktop app to verify the image has downloaded

![Alt text](/images/docker_hello-world.jpg "Hello-world image in desktop app")

- Now run `docker run hello-world`

Output:

![Alt text](/images/docker_hello-world_run.jpg "Hello-world image running after command")

- Check running containers on the maachine
```
docker ps
```

- Check all containers (on or off)
```
docker ps -a
```

Delete a process:
```
docker rm ID -f
```

Run a detached container with the program so we can still use out terminal
```
docker run -d -p 80:80 nginx
```

See logs of a detached container
```
docker logs ID
```

## Powerful example
Full Docker documentation running on your machine with one command:
```
docker run -d -p 4000:4000 docs/docker.github.io
```

A heavy duty dynamic site out of the box.

 ![Alt text](/images/docker_docs_running.jpg "Full documentation of docker running on my machine")

Top tip: Conatiners are persistent, this means data in them will remain availbe as long as it is not terminated.

## How to enter the container:
```
docker exec -it ID bash
```
If you cannot get in, run: `alias docker="winpty docker"` and try again

From here we can run all the usual commands. Make sure to check the OS with `uname -a` before you start.

Note, most containers will have absolutely nothing on them, so you my need to `apt install` things like sudo and nano etc.

## using Docker in practice

We are going to make a static website (thus only needing one container), and make an image of it in Docker that we can use for easy access to it going forward.

Step 1: Create index.html locally
- Create index.html locally (wherever you want) and save it.
- Add your html, for this case I am just going to take a template from https://devsnap.me/html-resume-templates
- Save

Step 2: Copy the file to the container
- Run `docker ps`, to get the id of the container
- Enter the container and delete the index.html already in: usr/share/nginx/html
- Run the command: `docker cp index.html conatiner_id:usr/share/nginx/html/index.html`
- This should copy the file to the correct directory on the container
- Log in to the container again, navigate to usr/share/nginx/html and run `ls` the file should be there
- Run `cat index.html` to verify the contents have been copied
- Go to localhost in your browser, the file should be dispalyed.

Step 3: Add css to container
- Repeat step two, this time for your css file
- Check localhost to see the changes in effect

Step 4: Add image from folder
- To add a single file from a folder use this:
`docker cp images/luke_iamge_2.jpg e4f41158e8e9:usr/share/nginx/html/images/luke_image_2.jpg`

Step 5: create a new image with the static website included
- Tag the current container `docker tag e786aaf0622d eng130_luke_cv`
- Stop the current container
- Run the new version `docker run -d -p 80:80 eng130_luke_cv`
- Commit the image to your repo `docker commit container name (will be random) lsf970/eng130_luke_cv:latest` 
- Push to dockerhub `docker push lsf970/eng130_luke_cv:latest`
- Check Dockerhub, image should be there

## Automating the process

Make a Dockerfile in the same folder (on localhost):

`nano Dockerfile`

Note that it is extensionless

In the Dockerfile add:

```
FROM nginx
# Who is creating this? Optional
LABEL MAINTAINER=luke@spartaglobal.com

# Created index.html cv - copy to container (default location -> usr/share/nginx/html/)
COPY index.html /usr/share/nginx/html/

# Commit the change

# Push the new image

# Pull the image from repo

# Run -> run -d -p 80:80 name

# Port number
EXPOSE 80

# Launch the server
CMD ["nginx", "-g", "daemon off;"]

# Note - each command is a layer in the eventual zip

```

Now save it with Ctrl + X

Run `docker build -t lsf970/eng130_cv_html_only .`

Screenshot of successful build:


Run `docker run -d -p 80:80 lsf970/eng130_cv_html_only`
This makes a container of the image

Verify the continer is working as expected, by going to localhost

Once verified we can push it to a new repository

Make a new repository on dockerhub

Then commit the container with the command:

```
# example with place holders
# docker commit container_id _or_name dockerhub_username/repo_name:tag

# Real command
docker commit nice_hawking lsf970/eng130_app_v1:latest
```
Now we can push to that repo
```
docker push lsf970/eng130_app_v1:latest
```
Check the repo on dockerhub, the image should now be there

In order to verify it's contents and functionality, run:
```
docker pull lsf970/eng130_app_v1
```

And then run the new version
```
docker ps # get the id of current container process
docker stop container_id # stop the old version
docker run -d -p 80:3000 lsf970/eng130_app_v1 # run the pulled version
# check localhost to verify
```

## How to set up the node app as a Docker image
Step 1: Create a new folder and a new Dockerfile within it

Step 2: Copy the app folder with the node app to the new folder

Step 3: Go into the Dockerfile with `nano Dockerfile`, and add YAML

Step 3.1:
```
FROM nginx
```
We still want to use nginx as a webserver, so use it as a base image

Step 3.2:
```
LABEL MAINTAINER=eng130-luke
```
Optional but you can add your name to the image

Step 3.3:
```
  WORKDIR /home/
  COPY app /home/ 
```
Here we set the working directory on the ccontainer and copy our app folder

Step 3.4:
```
EXPOSE 80
EXPOSE 3000
```
Expose the required ports. 80 for http and 3000 for nodejs

Step 3.5: 
```
  RUN apt-get update
  RUN apt-get install -y
  RUN apt-get install software-properties-common -y
  RUN apt-get install npm -y
```
Run the required commmands on the container to get node and npm

Step 3.6:
```
CMD ["nginx", "-g", "daemon off;"]
WORKDIR /home/app
RUN npm install
# CMD ["npm", "start"]
CMD ["node", "app.js"]
```
Start nginx, install the app with npm install and start it with npm install

Step 3.7: Bring it all together
```
FROM nginx

  LABEL MAINTAINER=eng130-luke

  WORKDIR /home/
  COPY app /home/ 
  # COPY environment /home/

  EXPOSE 80
  EXPOSE 3000

  RUN apt-get update
  RUN apt-get install -y
  RUN apt-get install software-properties-common -y
  RUN apt-get install npm -y

  CMD ["nginx", "-g", "daemon off;"]
  WORKDIR /home/app
  RUN npm install
  # CMD ["npm", "start"]
  CMD ["node", "app.js"]

```
Step 4:
Now we can build the image:
```
docker build -t lsf970/eng130_app_v1 .
```

Step 5: Run the image as a container
```
docker run -d -p 80:3000 eng130_v1 . 
```
Step 5.1: Check it  works in the browser

Step 6: If it does, commit the image
```
docker commit container_id lsf970/eng130_app_v1:latest
```

Step 7: Push the image to dockerhub
```
docker push lsf970/eng130_app_v1:latest
```
Step 8: Pull the version from dockerhub
```
docker pull lsf970/eng130_app_v1
```

Step 9: stop the current running container and then run the new on that you have pulled

Note: Remove a docker image 
```
docker rmi -f image_id
```

## Docker cheat-sheet
```
A self-sufficient runtime for containers

Options:
      --config string      Location of client config files (default
                           "C:\\Users\\Luke\\.docker")
  -c, --context string     Name of the context to use to connect to the
                           daemon (overrides DOCKER_HOST env var and
                           default context set with "docker context use")
  -D, --debug              Enable debug mode
  -H, --host list          Daemon socket(s) to connect to
  -l, --log-level string   Set the logging level
                           ("debug"|"info"|"warn"|"error"|"fatal")
                           (default "info")
      --tls                Use TLS; implied by --tlsverify
      --tlscacert string   Trust certs signed only by this CA (default
                           "C:\\Users\\Luke\\.docker\\ca.pem")
      --tlscert string     Path to TLS certificate file (default
                           "C:\\Users\\Luke\\.docker\\cert.pem")
      --tlskey string      Path to TLS key file (default
                           "C:\\Users\\Luke\\.docker\\key.pem")
      --tlsverify          Use TLS and verify the remote
  -v, --version            Print version information and quit

Management Commands:
  builder     Manage builds
  buildx*     Docker Buildx (Docker Inc., v0.9.1)
  compose*    Docker Compose (Docker Inc., v2.12.2)
  config      Manage Docker configs
  container   Manage containers
  context     Manage contexts
  dev*        Docker Dev Environments (Docker Inc., v0.0.3)
  extension*  Manages Docker extensions (Docker Inc., v0.2.13)
  image       Manage images
  manifest    Manage Docker image manifests and manifest lists
  network     Manage networks
  node        Manage Swarm nodes
  plugin      Manage plugins
  sbom*       View the packaged-based Software Bill Of Materials (SBOM) for an image (Anchore Inc., 0.6.0)
  scan*       Docker Scan (Docker Inc., v0.21.0)
  secret      Manage Docker secrets
  service     Manage services
  stack       Manage Docker stacks
  swarm       Manage Swarm
  system      Manage Docker
  trust       Manage trust on Docker images
  volume      Manage volumes

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  build       Build an image from a Dockerfile
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  exec        Run a command in a running container
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  images      List images
  import      Import the contents from a tarball to create a filesystem image
  info        Display system-wide information
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  login       Log in to a Docker registry
  logout      Log out from a Docker registry
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  run         Run a command in a new container
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  search      Search the Docker Hub for images
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  version     Show the Docker version information
  wait        Block until one or more containers stop, then print their exit codes

Run 'docker COMMAND --help' for more information on a command.

To get more help with docker, check out our guides at https://docs.docker.com/go/guides/

```

