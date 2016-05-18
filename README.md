# Prosody Docker

This is the Prosody Docker image building repository. Its only really designed to be used on the Prosody build server for pushing to the [Docker registry](https://registry.hub.docker.com).

For images please see here: [Prosody on Docker](https://registry.hub.docker.com/u/jcfigueiredo/prosody/).

It works by coping in a recently built `deb` file and running the install on the system.

## Running

Docker images are built off an __Ubuntu Trusty__ base.

```bash
docker run --name prosody -d -P jcfigueiredo/prosody
```

A user can be created by using environment variables `LOCAL`, `DOMAIN`, and `PASSWORD`. This performs the following action on startup:

  prosodyctl register *local* *domain* *password*

Any error from this script is ignored. Prosody will not check the user exists before running the command (i.e. existing users will be overwritten). It is expected that [mod_admin_adhoc](http://prosody.im/doc/modules/mod_admin_adhoc) will then be in place for managing users (and the server).

Mod admin web is enabled by default.

### Ports

The image exposes the following ports to the docker host:

* __80__: HTTP port
* __5222__: c2s port
* __5269__: s2s port
* __5347__: XMPP component port
* __5280__: BOSH / websocket port
* __5281__: Secure BOSH / websocket port

Note: These default ports can be changed in your configuration file. Therefore if you change these ports will not be exposed.

### Volumes

Volumes can be mounted at the following locations for adding in files:

* __/etc/prosody__:
  * Prosody configuration file(s)
  * SSL certificates
* __/usr/lib/prosody-modules__ (suggested):
  * Location for including additional modules
  * Note: This needs to be included in your config file, see http://prosody.im/doc/installing_modules#paths

### Example

#### first time running (creating the container, creates the user)
```
docker run --name prosody -d \
  -p 5222:5222 \
  -p 5281:5281 \
  -p 0.0.0.0:5347:5347 \
  -e LOCAL=manager \
  -e DOMAIN=localhost \
  -e PASSWORD=poker 
  jcfigueiredo/prosody

```

#### running without creating the user
```
docker run --name prosody -d \
  -p 5222:5222 \
  -p 5281:5281 \
  -p 0.0.0.0:5347:5347 \
  jcfigueiredo/prosody

```

#### running with local mapping 
```

docker run --name prosody -d \
    -p 5222:5222 \
    -p 5280:5280 \
    -p 5281:5281 \
    -p 5269:5269 \
    -p 0.0.0.0:5347:5347 \
    -e LOCAL=manager \
    -e DOMAIN=localhost \
    -e PASSWORD=poker \
    -v `pwd`/configuration:/etc/prosody \
    -v `pwd`/modules:/usr/lib/prosody/custom-modules/ \
    -v `pwd`/run:/var/run/prosody/ \
    -v `pwd`/certs:/etc/certs/ \
    jcfigueiredo/prosody

```

## accesing the web admin

* go to https://localhost:5281/admin/
* log in using the LOCAL@DOMAIN + PASSWORD 

## Building

```bash
docker build -t prosody .
```

## Managing

Examples of management commands (with a running conainer)

* docker exec -it prosody /bin/bash # shell inside the container
* docker exec prosody prosodyctl about # info about the running instance
* docker logs prosody # log output

