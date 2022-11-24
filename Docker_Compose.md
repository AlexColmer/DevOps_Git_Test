## Using Docker Compose

Docker is great for making images of single services. But we can use it to create multiple images using just one command. And these images can communicate to each other at that! We can do this using our old friend YAML.

## docker-compose.yaml

In order to start multiple containers using one command, we need to use yaml. The paricular file we need to create is call `docker-compose.yml`. This file needs to be created in the directory above the two projects you want to containerize:

![Alt text](/images/docker-compose-structure.jpg "Proper file structure for docker-compose.yml")

Here you can see the docker-compose.yml file is in the root app folder with the folders containing the two projects ("app" and "db"). This means the compose file can find each project to build and the two dockerfiles use to build them.

Let's leave the yaml file blank for now. We need to make Dockerfiles in "app" and "db"

## Making the app Dockerfile

In the Dockerfile within our app, we need to get our app copied to t he conatainer, dependencies installed and the app needs to be started.

```
# first we get a node image and call it app, so we can properly point to it when needed
FROM node as app

# Now we need to set the (current) working directory within the app container
WORKDIR /usr/src/app

# Copy only the required files. In this case json files. Use a wildcard (*) to do this 
COPY package*.json ./

# Install npm as a dependency (specifically 7.20.6)
RUN npm install -g npm@7.20.6

# Copy the required files for the node app
COPY . .

# open the required port (3000)
EXPOSE 3000

# Run the app
CMD ["node", "app.js"]
```

This will work, but the container will be very large with all those files. Lets layer the application:

```
# Production ready image

# Use a skinnier image
FROM node:alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install -g npm@7.20.6

# Copy the contents of app from the 1st image
COPY --from=app /usr/src/app /usr/src/app

# This is how we will seed the database. It is commented for now as db does not exist.
# ENTRYPOINT [ "seed-database.sh" ]

EXPOSE 3000

CMD ["node", "app.js"]
```

This makes the app container smaller in size (MB) and thus it will run faster with lower latency. Now we can move on to making the DB dockerfile.

## db Dockerfile

- Move to the db folder and make a Dockerfile.
- Make mongod.conf in the same folder (db).

Remember we need to make sure all users can access the db. In mongod.conf add:
```
# mongod.conf



# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/



# Where and how to store data.
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true
#  engine:
#  mmapv1:
#  wiredTiger:



# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log



# network interfaces
net:
  port: 27017
  bindIp: 0.0.0.0
```
## Back to the db Dockerfile

There is a lot less to do in this container. Add the following code to the db Dockerfile

```
# pull an image with Mongodb set up
FROM mongo

# Set the (current) working directory to db
WORKDIR /usr/src/db/

# Copy the mongo configuration file to correct location in the container. 
COPY ./mongod.conf /etc/

# make the correct port available, for mongo it is 27017
EXPOSE 27017

# Start the database in the conatiner with the mongod command
CMD ["mongod"]
```

## Bring it together with the docker-compose.yml file

So these two Dockerfiles if ran individually (while in either "app" or "db" in your terminal) will spin up two containers (app and db). But we want them both to be started with one command, and we want them to talk to each other. To do this we need the docker-compose.yml file.

Go into the file and add the following code:
```
volumes:
  db:
services:
  db:
    image: mongo:4.0.4
    ports:
      - "27017:27017"
    volumes:
      - ./db/mongod.conf:/etc/mongod.conf
```
Volumes are shared resources between multiple services. Specify the first as db. Then add a service called db also. Use the image for mongo and use the correct port (27017). Finally use a nested volume, this can be used to point to the file in the image we want to send to the container. In this case /db/mongod.conf.

Now we nned to specifiy the app. add this to the file (note the nesting, it is important):
```
app:
    build: ./app/app
    restart: always
    ports:
      - "80:3000"
    environment:
      - DB_HOST=mongodb://db:27017/posts
    depends_on:
      - db
```

App is built from our Dockerfile in /app/app. Specify the ports (80 and 3000 for reverse proxy). The most important part is to specify the environment variable that will connect the app container to the db container. As we have named the container db we can simply use that instead of an ip.

Full docker-compose.yml file:
```
volumes:
  db:
services:
  db:
    image: mongo:4.0.4
    ports:
      - "27017:27017"
    volumes:
      - ./db/mongod.conf:/etc/mongod.conf

  app:
    build: ./app/app
    restart: always
    ports:
      - "80:3000"
    environment:
      - DB_HOST=mongodb://db:27017/posts
    depends_on:
      - db
```

And that is it! If we run `docker compose up` from the root directory the YAML file will make both containers automatically and connecct them due to the steps we have given. If there are any errors they will be printed into the terminal. 

Check localhost to see if the app is working. Then check localhost/posts to see if the database is connected and seeded.

Now you have confimred this, stop the two containers with `docker stop` and the container id. Once both are stopped use `docker compose up -d` to run both containers in the background. This gives you access to your terminal while the conatiners run.