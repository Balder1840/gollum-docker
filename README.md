## Features
- target multi-platform for [gollum](https://github.com/gollum/gollum) by `docker buildx`
- add [gollum-auth](https://github.com/bjoernalbers/gollum-auth) to do the basic authentication
- use rackup to start
- a customized collapsable sidebar

## Contents

### gollum
the modified gollum files
- add activemodel to `gollum.gemspec` as the gollum-auth need it
- in Dockerfile, install the self-build gem file `gollum-auth-0.7.1.gem`,
as there is conflict issue when using docker build gollum with gollum-auth installed from gem sources 

### gollum-auth
the http basic authentication middleware for gollum
- change the references to the latest gems, as it has conflicts with gollum

use docker to build the gem file:  
`docker build -t gollum-auth .`

copy the file out:  
`docker cp gollum-auth:/pkg/gollum-auth-0.7.1.gem ~/`

### wiki
the customized js & css, and config.ru for rack, including the enhanced [NiceTOC](https://github.com/gollum/gollum/wiki/Custom-macros) as sidebar that can be collapsed

## How to

### usefull commands
- `docker context ls`
- `docker buildx ls`
- `docker buildx create --use --name mybuilder #node-amd64`
- `docker buildx inspect mybuilder --bootstrap`

### build the image

1. pull the latest gollum and use the modified files to override them
2. build <br>
    - push to docker hub:  
      `docker buildx build --platform=linux/amd64,linux/arm64,linux/arm/v7 --push -t balder1840/gollum:v5.3.0 .`  
    - or output as local image:  
      `docker buildx build --platform=linux/amd64,linux/arm64,linux/arm/v7 --out=type=image -t balder1840/gollum:v5.3.0 .`

### use the image

1. create a folder let's say ~/wiki
2. move config.ru, costum.css, custom.js to ~/wiki and use git to check in 
3. run 
 ```bash
   docker run -d \
   --name gollum \
   -p 8080:4567 \
   -e GOLLUM_AUTHOR_USERNAME=xxx \
   -e GOLLUM_AUTHOR_EMAIL=xxx@google.com \
   -v ~/wiki:/wiki balder1840/gollum:tagname \
   --host 0.0.0.0 \
   --port 4567
```
or
 ```bash
   docker run -d \
   --name gollum \
   -p 8080:4567 \
   -e GOLLUM_AUTHOR_USERNAME=xxx \
   -e GOLLUM_AUTHOR_EMAIL=xxx@google.com \
   -v ~/wiki:/wiki balder1840/gollum:tagname \
   -v ~/YourConfigRu:/config.ru \
   /config.ru \
   --host 0.0.0.0 \
   --port 4567
```

> you can find a image here at [docker hub](https://hub.docker.com/r/balder1840/gollum)


## Refs
- [Docker Buildx](https://docs.docker.com/buildx/working-with-buildx/)
- [docker buildx build](https://docs.docker.com/engine/reference/commandline/buildx_build/)
- [Leverage multi-CPU architecture support](https://docs.docker.com/desktop/multi-arch/)
- [Multi-Platform Docker Builds](https://www.docker.com/blog/multi-platform-docker-builds/)
