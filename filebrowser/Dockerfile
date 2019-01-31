FROM ghdl/ext:vunit AS ide

COPY filebrowser.config.yml /etc/filebrowser/.filebrowser.yml

RUN URL="$(curl -s https://api.github.com/repos/filebrowser/filebrowser/releases/latest | grep "browser_download_url.*linux-amd64.*tar.gz" | sed 's/.* "\(.*\)"/\1/g')" \
 && [ "$(echo "$URL" | cut -c1-5)" != "https" ] && URL="https://github.com/filebrowser/filebrowser/releases/download/v2.0.2/linux-amd64-filebrowser.tar.gz"; echo "URL: $URL" \
 && curl -fsSL "$URL" | tar -xvz -C /usr/local/bin filebrowser \
 && mkdir -p /var/lib/filebrowser/ \
 && filebrowser config init \
 && filebrowser users add hwd admin --commands '.*' --perm.admin

VOLUME /srv
EXPOSE 8080/tcp
CMD ["filebrowser"]

#---

FROM ghdl/ext:broadway as gtk

COPY bashrc.sh /usr/local/etc/hwd-ide.sh

RUN printf "\nsource /usr/local/etc/hwd-ide.sh\n" >> /etc/bash.bashrc

#---

FROM gtk AS gtk-ide

COPY --from=ide /usr/local/bin/filebrowser /usr/local/bin/filebrowser
COPY --from=ide /etc/filebrowser/.filebrowser.yml /etc/filebrowser/

RUN mkdir -p /var/lib/filebrowser/ \
 && filebrowser config init \
 && filebrowser users add hwd admin --commands '.*' --perm.admin

VOLUME /srv
EXPOSE 8080/tcp
CMD ["filebrowser"]
