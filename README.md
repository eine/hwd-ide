[![travis-ci.org/1138-4EB/hwd-ide/develop](https://img.shields.io/travis/1138-4EB/hwd-ide/develop.svg?style=flat-square)](https://travis-ci.org/1138-4EB/hwd-ide/develop) [develop] | [![travis-ci.org/1138-4EB/hwd-ide/master](https://img.shields.io/travis/1138-4EB/hwd-ide/master.svg?style=flat-square)](https://travis-ci.org/1138-4EB/hwd-ide/master) [master] | [![github.com/1138-4EB/hwd-ide/releases](https://img.shields.io/github/commits-since/1138--4EB/hwd-ide/latest.svg?style=flat-square)](https://github.com/1138-4EB/hwd-ide/releases)

# Lightweight web-based IDE for hardware design

This repo started in [tgingold/ghdl#111](https://github.com/tgingold/ghdl/issues/111). It is meant to be a joint effort to bring together existing tools/apps/projects in order to achieve a libre framework/IDE for hardware design based on (V)HDL.

The reference development platform is *Debian* (*Buster*) with [GHDL](https://github.com/ghdl/ghdl), [VUnit](https://github.com/VUnit/vunit) and (optional) [GtkWave](http://gtkwave.sourceforge.net/). This platform is available as docker images (`ghdl/ext:vunit` and `ghdl/ext:broadway`), in order to provide seamless usage on *GNU/Linux*, *Windows* and/or *macOS*.

On top of the reference platform, multiple proofs of concepts (PoCs) are built and partially integrated. These are the test platform from the user's point of view. The (PoCs) currently available are:


- `ghdl/ext:ide` and `ghdl/ext:gtk-ide` are built, respectively, on top of the ones mentioned above. The latest version of [filebrowser/filebrowser](https://github.com/filebrowser/filebrowser) is added, along with a custom configuration file. This provides a lightweight web-based IDE alike that allows to: i) create/edit/delete text files, and ii) execute CLI apps. Currently there are a lot of missing features for a useful IDE. This is because *filebrowser* is not meant to be used as an IDE. There is ongoing analysis to enhance it, including the possibility to either add some features as optional plugins or fork it to build a larger app on top of it.

---

To use the version without *GtkWave*, start a container as shown below:

``` bash
docker run -dp <HOST_PORT>:80 [-v <ABS_PATH>://srv] ghdl/ext:ide
```

`-v` declares an optional bind mount. Use it only if you want a local directory to be available inside the test environment. You can upload and download files without using `-v`, through the web interface. But, neither uploading groups of files nor uploading a compressed file and extracting it is supported (yet).

For example, run `docker run -dp 2000:80 -v /$(pwd)://src ghdl/ext:ide`, then browse `localhost:2000`. There is a default admin user named `hwd` with password `admin`.

---

In order to use the version with *GtkWave*, you will need an *X11* server running on the host.

It is highly recommended to use [x11docker](https://github.com/mviereck/x11docker) in order to execute containers that require GUI features on either GNU/Linux or Windows. x11docker is a helper script to enable GUI apps inside the containers to use a X server on the host. It does also have a specific security setup to enhance container isolation from host system. Besides providing several options for GNU/Linux hosts, `x11docker` supports multiple X servers on Windows: [VcXsrv](https://sourceforge.net/projects/vcxsrv/) or [Cygwin/X](https://x.cygwin.com/). See [MSYS2, Cygwin and WSL on MS Windows](https://github.com/mviereck/x11docker#msys2-cygwin-and-wsl-on-ms-windows).

``` bash
x11docker -- -dp <HOST_PORT>:8080 [-v <ABS_PATH>://srv] -- ghdl/ext:ide
```

As an alternative to using an X server on the host, a [GTK+ Broadway](https://developer.gnome.org/gtk3/stable/gtk-broadway.html) server can be started. This is a backend for displaying GTK+ applications in a web browser. Precisely, ghdl/ext:gtk-ide includes a script that checks if the environment variable BROADWAY is not empty, to start it on port `$((8080 + $BROADWAY))`. For example:

``` bash
# [winpty docker run --rm] OR [x11docker] \
  -it -- \
  -p <HOST_PORT_BROADWAY>:8085 -e BROADWAY=5 \
  -p <HOST_PORT_FILEBROWSER>:8080 \
  -- ghdl/ext:gtk-ide bash
```
