# docker-emacs-eclim

Enterprise Java development in Emacs running in a Docker container

[![Docker Repository on Quay.io](https://quay.io/repository/tatsuya6502/emacs-eclim/status "Docker Repository on Quay.io")](https://quay.io/repository/tatsuya6502/emacs-eclim)

This container is powered by the following open source software
products:

- **GNU Emacs 24** running in terminal (`emacs-nox`).
- **Eclipse Mars** with **OpenJDK 7**
- **[eclim](http://eclim.org/)** -- eclim brings Eclipse functionality
  to the Vim editor
- **[Emacs Eclim](http://www.emacswiki.org/emacs/EmacsEclim)** --
  emacs-eclim brings some of the great eclipse features to emacs
  developers. It is based on the eclim project
  * [how-to](http://www.skybert.net/emacs/java/)
- **[Auto Complete](http://www.emacswiki.org/emacs/AutoComplete)** --
  Auto completion with popup menu.

[`phusion/baseimage`](https://hub.docker.com/r/phusion/baseimage/) is
used as the base image, which is built upon Ubuntu 14.04 LTS.


## Running the Docker Container

The Docker images is published at [quay.io](http://quay.io/tatsuya6502/emacs-eclim).
You can just pull the image and run it.

```
$ docker run -it --name=emacs-eclim \
             quay.io/tatsuya6502/emacs-eclim:latest \
             /sbin/my_init -- su - docker
```

This will start xvfb service in order to create a fake display for
Eclipse, and then drop you in a shell with `docker` user.


### Start Eclipse via eclimd

Inside the container, start Eclipse via eclimd.

```
$ tmux
$ DISPLAY=:1 ./eclipse/eclimd
```

You should wait for the following message before connecting from
Emacs.

```
INFO  [org.eclim.eclipse.EclimDaemon] Eclim Server Started on: 127.0.0.1:9091
```

Alternatively, you can start eclimd with background option.

```
$ DISPLAY=:1 ./eclipse/eclimd -b
```


### Start Emacs

Press `C-b c` to create a new tmux screen. Then start Emacs.

```
$ emacs
```

Try to open the Eclipse project list by `M-x eclim-project-mode`.
This will open up a buffer `*eclim: projects*`.

You can run `M-x eclim-project-create` to create a project. Or
`M-x eclim-project-import` to import an existing one in the
container's local file system.


## Persisting Your Projects with Docker Volumes

Since this is a Docker environment, you will lose all changes in your
container when you kill it (unless you do `docker commit`).

You can use Docker volumes with bind mount to map the host
directories/files to the container.

For example,

```
$ docker run -it --name=emacs-eclim \
             -v /path/to/myproject:/home/docker/workspace/myproject \
             quay.io/tatsuya6502/emacs-eclim:latest \
             /sbin/my_init -- su - docker
```

Then change the owner of the project folder and files in the container

```
$ sudo chown -R docker:docker ~/workspace/myproject
```

My Java projects are mirrored in remote git repositories via ssh
access and some of them uses Maven or Ivy. So I usually start the
container with something like the following:

```
$ docker run -it --name=emacs-eclim \
             -v /path/to/myproject:/home/docker/workspace/myproject \
             -v /path/to/ssh:/home/docker/.ssh \
             -v /path/to/gitconfig:/home/docker/.gitconfig \
             -v /path/to/m2:/home/docker/.m2 \
             -v /path/to/ivy2:/home/docker/.ivy2 \
             quay.io/tatsuya6502/emacs-eclim:latest \
             /sbin/my_init -- su - docker
```

For further details about Docker volumes, see the
[Docker Cheat-Sheet](https://github.com/wsargent/docker-cheat-sheet#volumes)


## What's Next?

I would recommend the following wiki and articles:

- [Emacs Eclim Project Home](https://github.com/senny/emacs-eclim) and
  the [WiKi](https://github.com/senny/emacs-eclim/wiki)
- [Enterprise Java Development in Emacs](http://www.skybert.net/emacs/java/) --
  How-to guide with screenshots
- [Emacs WiKi/EmacsEclim](http://www.emacswiki.org/emacs/EmacsEclim)


## (Optional) Customizing Emacs

If you want to customize Emacs, edit the elisp files found in
`emacs.d/inits/` in this repository, and build a new Docker image
using the `Dockerfile`.


## (Optional) X Window based Graphical User Interface

I have not tried this by myself, but you could run a remote desktop
server such as vnc or [`X2Go`](http://wiki.x2go.org/doku.php/doc:newtox2go)
in the container.


## Special Thanks!

This Docker images was inspired by the following Japanese article:

- [Docker開発環境をつくる - Emacs24とEclimからEclipseに接続するJava開発環境](http://masato.github.io/2014/10/04/docker-devenv-emacs24-eclim-java/)

Thanks Masato Shimizu for the article. It was very helpful!
