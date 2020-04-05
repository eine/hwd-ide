# Lightweight resources for hardware design with GHDL

This repo started in [ghdl/ghdl#111](https://github.com/ghdl/ghdl/issues/111). It is meant to be a joint effort to bring together existing tools/apps/projects in order to achieve a libre framework/IDE for hardware design based on [GHDL](https://github.com/ghdl). See [wiki](https://github.com/eine/hwd-ide/wiki).

The reference development platform is *Debian* (*Buster*) with [GHDL](https://github.com/ghdl/ghdl), [VUnit](https://github.com/VUnit/vunit) and (optional) [GtkWave](http://gtkwave.sourceforge.net/). This platform is available as docker images (see [ghdl/docker](https://github.com/ghdl/docker)), in order to provide seamless usage on *GNU/Linux*, *Windows* and/or *macOS*.

---

An *X11* server is required to use GUI tools inside the containers. It is highly recommended to use [x11docker](https://github.com/mviereck/x11docker) in order to execute containers that require GUI features on either GNU/Linux or Windows. x11docker is a helper script to enable GUI apps inside the containers by using an X server on the host. It does also have an specific security setup to enhance container isolation from host system. Besides providing several options for GNU/Linux hosts, `x11docker` supports multiple X servers on Windows: [VcXsrv](https://sourceforge.net/projects/vcxsrv/) or [Cygwin/X](https://x.cygwin.com/). See [MSYS2, Cygwin and WSL on MS Windows](https://github.com/mviereck/x11docker#msys2-cygwin-and-wsl-on-ms-windows).

``` bash
x11docker -i [-- [-v <ABS_PATH>://srv] --] ghdl/ext:latest bash
```

As an alternative to using an X server on the host, a [GTK+ Broadway](https://developer.gnome.org/gtk3/stable/gtk-broadway.html) server can be started. This is a backend for displaying GTK+ applications in a web browser. Precisely, `ghdl/ext:broadway` includes a script that checks if the environment variable BROADWAY is not empty, to start it on port `$((8080 + $BROADWAY))`. For example:

``` bash
# [winpty docker run --rm -it] OR [x11docker -i] \
  -- \
  -p <HOST_PORT>:8085 -e BROADWAY=5 \
  -- ghdl/ext:broadway bash
```
