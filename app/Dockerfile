# FROM nginx

#   LABEL MAINTAINER=eng130-luke

#   WORKDIR /home/
#   COPY app /home/ 
#   # COPY environment /home/

#   EXPOSE 80
#   EXPOSE 3000

#   RUN apt-get update
#   RUN apt-get install -y
#   RUN apt-get install software-properties-common -y
#   RUN apt-get install npm -y

#   CMD ["nginx", "-g", "daemon off;"]
#   WORKDIR /home/app
#   RUN npm install
#   # CMD ["npm", "start"]
#   CMD ["node", "app.js"]

# V2
FROM node as app

WORKDIR /usr/src/app

# this will be /usr/src/app due to line 26
COPY package*.json ./

RUN npm install -g npm@7.20.6

COPY . .

EXPOSE 3000

CMD ["node", "app.js"]

# Create a multistage build

FROM node:alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install -g npm@7.20.6

# Magic line, compresses the image for us
COPY --from=app /usr/src/app /usr/src/app/

EXPOSE 3000

CMD ["node", "app.js"]

# docker build -t LSF970/node-app-prod:v1
