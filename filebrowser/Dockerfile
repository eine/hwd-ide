FROM ghdl/ext:vunit AS ide

RUN mkdir /opt/filebrowser && cd /opt/filebrowser \
  && curl -L $( \
         curl -s https://api.github.com/repos/filebrowser/filebrowser/releases/latest \
       | grep "browser_download_url.*linux-amd64.*tar.gz" \
       | cut -d : -f 2,3 \
       | tr -d \" \
     ) \
     | tar -xvz filebrowser

COPY filebrowser.config.yml /opt/filebrowser/.config.yml
EXPOSE 80/tcp
ENTRYPOINT ["/opt/filebrowser/filebrowser"]
CMD ["--config" "/opt/filebrowser.config.yml"]

#---

FROM ghdl/ext:vunit-gtkwave AS ide-gtkwave

COPY --from=ide /opt/filebrowser /opt/
EXPOSE 80/tcp
ENTRYPOINT ["/opt/filebrowser/filebrowser"]
CMD ["--config" "/opt/filebrowser.config.yml"]
