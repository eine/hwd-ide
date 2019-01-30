FROM ghdl/ext:vunit AS ide

RUN mkdir /opt/filebrowser && cd /opt/filebrowser \
  && URL="$(curl -s https://api.github.com/repos/filebrowser/filebrowser/releases/latest | grep "browser_download_url.*linux-amd64.*tar.gz" | sed 's/.* "\(.*\)"/\1/g')" \
  && [ "$(echo "$URL" | cut -c1-5)" != "https" ] && URL="https://github.com/filebrowser/filebrowser/releases/download/v2.0.2/linux-amd64-filebrowser.tar.gz"; echo "URL: $URL" \
  && curl -fsSL "$URL" | tar xvz filebrowser -C /usr/local/bin

COPY filebrowser.config.yml /etc/filebrowser/.config.yml
VOLUME /srv
EXPOSE 8080/tcp
CMD ["/opt/filebrowser/filebrowser", "--config", "/opt/filebrowser/.config.yml"]

#---

FROM ghdl/ext:broadway AS ide-gtkwave

COPY --from=ide /usr/local/bin/filebrowser /usr/local/bin/filebrowser
COPY --from=ide /etc/filebrowser/.config.yml /etc/filebrowser
VOLUME /srv
EXPOSE 8080/tcp
CMD ["/opt/filebrowser/filebrowser", "--config", "/opt/filebrowser/.config.yml"]
