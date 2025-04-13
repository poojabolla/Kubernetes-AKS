## Volumes in Docker

There are 2 types of volumes in Docker
1. Docker Volumes
2. Bind Mounts

---

### Docker Volumes
A Docker volume is a mountable entity which can be used to store data in the docker filesystem.

**Usage**
Create the volume from the path on local system,

```bash
docker volume create volume -o type=none -o device=/home/ubuntu -o o=bind
```
If no path is provided the volume is stored in docker's default location `/var/lib/docker/volumes/`

Now this volume can be mounted to multiple containers and they share the same files

```bash
docker run -it -d --mount source=volume,destination=/volume nginx
```
Exec to docker to validate the files
```bash
docker exec -it f3719eef2bf7 bash
```
Check for the volume in destination path and validate the files shared by container and local system

---

### Bind Mounts

Bind Mounts mount a directory of the host machine to the docker container. 

**Usage**
```bash
docker run -d -it -v <source>:<destination> <image-name>
```

Example:
```bash
docker run -d -it -v /home/ubuntu:/volume-mount nginx
```