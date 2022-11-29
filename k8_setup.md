## Kubernetes

Go  to Docker app -> Settings -> Enable Kubernetes.

This will take a few minutes.

Once done, open GitBash and enter the command

```
kubectl
```

You should get the following cheatsheet:

```
kubectl controls the Kubernetes cluster manager.

 Find more information at: https://kubernetes.io/docs/reference/kubectl/

Basic Commands (Beginner):
  create          Create a resource from a file or from stdin
  expose          Take a replication controller, service, deployment or pod and expose it as a new Kubernetes service
  run             Run a particular image on the cluster
  set             Set specific features on objects

Basic Commands (Intermediate):
  explain         Get documentation for a resource
  get             Display one or many resources
  edit            Edit a resource on the server
  delete          Delete resources by file names, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout         Manage the rollout of a resource
  scale           Set a new size for a deployment, replica set, or replication controller
  autoscale       Auto-scale a deployment, replica set, stateful set, or replication controller

Cluster Management Commands:
  certificate     Modify certificate resources.
  cluster-info    Display cluster information
  top             Display resource (CPU/memory) usage
  cordon          Mark node as unschedulable
  uncordon        Mark node as schedulable
  drain           Drain node in preparation for maintenance
  taint           Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe        Show details of a specific resource or group of resources
  logs            Print the logs for a container in a pod
  attach          Attach to a running container
  exec            Execute a command in a container
  port-forward    Forward one or more local ports to a pod
  proxy           Run a proxy to the Kubernetes API server
  cp              Copy files and directories to and from containers
  auth            Inspect authorization
  debug           Create debugging sessions for troubleshooting workloads and nodes

Advanced Commands:
  diff            Diff the live version against a would-be applied version
  apply           Apply a configuration to a resource by file name or stdin
  patch           Update fields of a resource
  replace         Replace a resource by file name or stdin
  wait            Experimental: Wait for a specific condition on one or many resources
  kustomize       Build a kustomization target from a directory or URL.

Settings Commands:
  label           Update the labels on a resource
  annotate        Update the annotations on a resource
  completion      Output shell completion code for the specified shell (bash, zsh, fish, or powershell)

Other Commands:
  alpha           Commands for features in alpha
  api-resources   Print the supported API resources on the server
  api-versions    Print the supported API versions on the server, in the form of "group/version"
  config          Modify kubeconfig files
  plugin          Provides utilities for interacting with plugins
  version         Print the client and server version information

Usage:
  kubectl [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).

```

Checks K8 connection
```
kubectl get service
# Use kubectl geet ... to commincate with cluster
```

## Using k8

Make a folder called k8

In that folder make a yaml file called `docker-compose.yml` This will be what we use to create a k8 deployment.

Add the following code:

```
# use spaces not tabs
apiVersion: apps/v1 # Which api to use
kind: Deployment # What type of service/object do you want to create

# What do you want to call the deployment 
metadata: 
  name: nginx-deploy # name of deployment
spec: 
  selector:
    matchLabels:
      app: nginx # Look for this label to match with k8 service

  # How many pods to create
  replicas: 3
  
  template:
    metadata: 
      labels: 
        app: nginx # This label conneccts to the service or any other k8 components 
    # Container spec
    spec: 
      containers:
      - name: nginx # name of containers
        image: lsf970/eng130_luke_cv:latest # image to use
        ports:
         - containerPort: 80 # port for the containers created

```
Run:

```
kubectl apply -f nginx-deploy.yml
```
This will create the deployment. Check it has been successful with:

```
kubectl get deploy
```

To delete a deployment:
```
kubectl delete deploy nginx-deployment
```

However if you check localhost in your browser, you will still see an error. Why?

This is because the k8 cluster does ot have an EXTERNAL IP given to it automatically. Run `kubectl get svc` to check this. We need to make a k8 service to give it one.

This needs to be done in another yaml file.

In the same folder make a file along the lines of `nginx-service.yml`. here we will define the service for exposing the pods.

Add the following code:

```
# Select the type of API version and type of service/object
apiVersion: v1
kind: Service
# Metadata for name
metadata:
  name: nginx-svc
  namespace: default # sre
# Specification to includeports Selector to connect to the deployment
spec:
  ports:
  - nodePort: 30001 # Range is 30000 - 32768
    port: 80


    targetPort: 80


# Let's define the selector and label to connect to nginx deployment
  selector:
    app: nginx # This label connects this service to the deployment

  # Creating NodePort type of deployment
  type: NodePort # Also use LoadBalancer - for local use cluster IP
```

Now in terminal run:

```
kubectl apply -f nginx-service.yml
```
This should create the service. Now run:

```
kubectl get services
```
This will show that the service has been created

If you want to delete the service, you can run:

```
kubectl delete service nginx-svc
```

## Node app deployment with k8

Make a folder called k8_node

In this folder, make a file called node_deploy.yml

Copy and paste the nginx code into this file

```
# use spaces not tabs
apiVersion: apps/v1 # Which api to use
kind: Deployment # What type of service/object do you want to create

# What do you want to call the deployment 
metadata: 
  name: node-deploy # name of deployment
spec: 
  selector:
    matchLabels:
      app: node # Look for this label to match with k8 service

  # How many pods to create
  replicas: 3
  
  template:
    metadata: 
      labels: 
        app: node # This label conneccts to the service or any other k8 components 
    # Container spec
    spec: 
      containers:
      - name: node # name of containers
        image: lsf970/eng130_app_v1:latest # image to use
        ports:
         - containerPort: 3000 # port for the containers created

```

Changes have been made to remove the nginx specific parrts and replace them with node. make sure to use a DockerHub image that functions correctly.

No do the same for the service yaml file. Create node-service.yml and copy the nginx version's contents over to it.

```
# Select the type of API version and type of service/object
apiVersion: v1
kind: Service
# Metadata for name
metadata:
  name: node-svc
  namespace: default # sre
# Specification to includeports Selector to connect to the deployment
spec:
  ports:
  - nodePort: 30001 # Range is 30000 - 32768
    port: 3000
    protocol: TCP


    targetPort: 3000


# Let's define the selector and label to connect to nginx deployment
  selector:
    app: node # This label connects this service to the deployment

  # Creating NodePort type of deployment
  type: NodePort # Also use LoadBalancer - for local use cluster IP
```




