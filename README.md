## Microservices

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

![Alt text](/images/monolith_vs_microservices.png "Monolith's vs Microservices")

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

