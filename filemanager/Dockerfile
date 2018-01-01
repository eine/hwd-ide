FROM ghdl/ext:vunit AS ide

RUN mkdir /opt/filemanager \
  && curl -L https://github.com/hacdias/filemanager/releases/download/v1.4.0/linux-amd64-filemanager.tar.gz | tar xvz -C /opt/filemanager

COPY filemanager.config.yml /opt/filemanager/.config.yml
EXPOSE 80/tcp
ENTRYPOINT ["/opt/filemanager/filemanager"]
CMD ["--config" "/opt/filemanager.config.yml"]

#---

FROM ghdl/ext:vunit-gtkwave AS ide-gtkwave

COPY --from=ide /opt/filemanager /opt/
EXPOSE 80/tcp
ENTRYPOINT ["/opt/filemanager/filemanager"]
CMD ["--config" "/opt/filemanager.config.yml"]
