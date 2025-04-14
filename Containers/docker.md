## Docker commands

```bash
docker ps
```
```bash
docker ps -a
```
```bash
docker run
```
```bash
docker pull
```
```bash
docker tag
```
```bash
docker push
```

## Committing changes of a container

```bash
docker run -it -d ubuntu

docker exec -it f88282209de8 bash

apt-get update

apt install apache2	

apt install docker.io -y

exit

docker commit f88282209de8 my-ubuntu