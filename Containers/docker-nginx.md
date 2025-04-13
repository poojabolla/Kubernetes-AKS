## Working around Nginx and custom Dockerfile

This talks about building a custom docker image with ubuntu as base

```Dockerfile
# Step 1: Use Ubuntu as the base image
FROM ubuntu:latest

# Step 2: Update package list and install Nginx
RUN apt update && apt install -y nginx

# Step 3: Copy the HTML files into the Nginx default HTML directory
COPY index.html /usr/share/nginx/html

# Step 5: Expose port 80 (default port for HTTP)
EXPOSE 80

# Step 6: Start Nginx in the foreground (this is important in Docker containers)
CMD ["nginx", "-g", "daemon off;"]
```

Now create a custom index.html file

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to DevOps</title>
</head>
<body>
    <h1>Hello, welcome to DevOps!</h1>
</body>
</html>
```

Now build the docker image using docker build command

```bash
docker build -t nginx-new .
```
 
If Dockerfile is in diff location give `-f <path-to-dockerfile>`

Once the image is build, run it exposing the port 

```bash
docker run -d -p 81:80 nginx-new
```

Access the nginx on browser

```bash
http://<server-ip>:81
```
If you are working on Docker for Desktop, use `localhost`
