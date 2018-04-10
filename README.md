[![travis-ci.org/1138-4EB/hwd-ide/develop](https://img.shields.io/travis/1138-4EB/hwd-ide/develop.svg?style=flat-square)](https://travis-ci.org/1138-4EB/hwd-ide/develop) [develop] | [![travis-ci.org/1138-4EB/hwd-ide/master](https://img.shields.io/travis/1138-4EB/hwd-ide/master.svg?style=flat-square)](https://travis-ci.org/1138-4EB/hwd-ide/master) [master] | [![github.com/1138-4EB/hwd-ide/releases](https://img.shields.io/github/commits-since/1138--4EB/hwd-ide/latest.svg?style=flat-square)](https://github.com/1138-4EB/hwd-ide/releases) 	

# Lightweight web-based IDE for hardware design

This wiki started in [tgingold/ghdl#111](https://github.com/tgingold/ghdl/issues/111). It is meant to be a joint effort to bring together existing tools/apps/projects in order to achieve a libre framework/IDE for hardware design based on (V)HDL.

The reference development platform is *Debian* (*Stretch*) with [GHDL](https://github.com/ghdl/ghdl), [VUnit](https://github.com/VUnit/vunit) and (optional) [GtkWave](http://gtkwave.sourceforge.net/). This platform is available as docker images (`ghdl/ext:vunit` and `ghdl/ext:vunit-gtkwave`), in order to provide seamless usage on *GNU/Linux*, *Windows* and/or *macOS*.

On top of the reference platform, multiple proofs of concepts (PoCs) are built and partially integrated. Images `ghdl/ext:ide` and `ghdl/ext:ide-gtkwave` are built, respectively, on top of the ones mentioned above, and are the test platform from the user's point of view. The (PoCs) currently available are:

- The latest version of [filebrowser/filebrowser](https://github.com/filebrowser/filebrowser) is added, along with a custom configuration file. This provides a lightweight web-based IDE alike that allows to: i) create/edit/delete text files, and ii) execute cli apps. Currently there are a lot of missing features for a useful IDE. This is because *filebrowser* is not meant to be used as an IDE. There is ongoing analysis to enhance it, including the possibility to either add some features as optional plugins or fork it to build a larger app on top of it.

---

To use the version without *GtkWave*, start a container as shown below:

```
docker run -dp <HOST_PORT>:80 [-v <ABS_PATH>://srv] ghdl/ext:ide
```

`-v` declares an optional bind mount. Use it only if you want a local directory to be available inside the test environment. You can upload and download files without using `-v`, through the web interface. But, neither uploading groups of files nor uploading a compressed file and extracting it is supported (yet).

For example, run `docker run -dp 2000:80 -v /$(pwd)://src ghdl/ext:ide`, then browse `localhost:2000`.

---

In order to use the version with *GtkWave*, you will need an *X11* server running on the host. On Windows, you can use [Xming](https://sourceforge.net/projects/xming/), [VcXsrv](https://sourceforge.net/projects/vcxsrv/) or [Cygwin/X](https://x.cygwin.com/).

A script is provided to help define the required parameters to let GUI applications inside a docker container use the X server on the host. `docker_guiapp.sh` works with GNU/Linux and Windows (XMing):

```
./docker_guiapp.sh -dp <HOST_PORT>:80 [-v <ABS_PATH>://srv]  ghdl/ext:ide
```
