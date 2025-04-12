## What are containers?

Containers are standardized, portable packages that bundle an application with all its necessary files, libraries, and dependencies into one runtime environment. This allows developers to easily move and run applications across different operating systems and environments with minimal changes. Think of it as a self-contained "box" that carries everything an application needs to run, ensuring consistency and portability. 

- Traditional deployment challenges (VMs, OS dependencies)
- Lightweight, portable, and consistent environments
- Runs isolated processes on a shared OS kernel

# Benefits of containers:

- Fast startup
- Easy scaling
- Environment consistency

## Introduction to Docker

Docker is a containerization platform that helps build, ship, and run containers.

**Key Docker components:**

- Dockerfile
- Images
- Containers
- Docker Hub (registry)

**Basic Commands**

- docker build
- docker run
- docker ps
- docker images
- docker exec
- docker logs

**Install Docker**

```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 

sudo docker run hello-world
```

Ref: https://docs.docker.com/engine/install/ubuntu/