develop: [![travis-ci.org/1138-4EB/elide/develop](https://img.shields.io/travis/1138-4EB/elide/develop.svg?style=flat-square)](https://travis-ci.org/1138-4EB/elide/develop)  stable: [![travis-ci.org/1138-4EB/elide/stable](https://img.shields.io/travis/1138-4EB/elide/stable.svg?style=flat-square)](https://travis-ci.org/1138-4EB/elide/stable) master: [![travis-ci.org/1138-4EB/elide/master](https://img.shields.io/travis/1138-4EB/elide/master.svg?style=flat-square)](https://travis-ci.org/1138-4EB/elide/master) [![github.com/1138-4EB/elide/releases](https://img.shields.io/github/commits-since/1138--4EB/elide/latest.svg?style=flat-square)](https://github.com/1138-4EB/elide/releases) 	

# Lightweight web-based IDE with GHDL, VUnit and gtkwave

Images `ghdl/ext:ide` and `ghdl/ext:ide-gtkwave` are based on `ghdl/ext:vunit` and `ghdl/ext:vunit-gtkwave`, respectively. On top of HDL-related tools, the latest version of [hacdias/filemanager ](https://github.com/hacdias/filemanager) is added, along with a custom configuration file. This provides a lightweight web-based IDE alike.

---

To use the version without gtkwave, start a container as shown below:

```
docker run -dp <HOST_PORT>:80 [-v <ABS_PATH>://srv] ghdl/ext:ide
```

`-v` is optional. it is a bind mount. use it only if you want a local directory to be available.
you can upload and download files without using `-v`, through the web interface. But, right now, uploading groups of files is not supported, neither uploading a compressed file and extracting it.

Example, run `docker run -dp 2000:80 -v /$(pwd)://src ghdl/ext:ide`, then browse `localhost:2000`.

---

In order to use the version with gtkwave, you will need an X11 server running on the host. In windows, you can use Xming or XXXXX. See xxxxx.

`docker_guiapp.sh` works with GNU/Linux and Windows (XMing).

```
./docker_guiapp.sh -dp <HOST_PORT>:80 [-v <ABS_PATH>://srv]  ghdl/ext:ide
```

---

Currently there are a lot of missing features for a useful IDE. This is because filemanager is not meant to be used as an IDE. There is ongoing effort to enhance it, including the possibility to either add some features as optional plugins or fork it to build a larger app on top of it.

---

curl -L https://raw.githubusercontent.com/1138-4EB/ghdl/builders/dist/docker_guiapp.sh | sh -S ghdl/ext:gui ls
