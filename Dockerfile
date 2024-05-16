FROM fedora:38

RUN dnf groupinstall -y 'development tools' && dnf groupinstall -y xfce

RUN bash -c 'echo PREFERRED=/usr/bin/xfce4-session > /etc/sysconfig/desktop'

RUN dnf install -y xrdp xorgxrdp vim neovim wget wireshark htop && dnf update -y --exclude=kernel*
RUN dnf install -y docker mc firefox powerline vim-powerline fastfetch
RUN dnf install -y awesome-vim-colorschemes vim-fugitive

COPY build/etc/yum.repos.d/google-cloud.repo /etc/yum.repos.d/google-cloud.repo
RUN dnf install -y libxcrypt-compat google-cloud-cli

RUN dnf install -y bind-utils

COPY build/etc/xrdp/* /etc/xrdp/
RUN chmod a+x /etc/xrdp/startwm.sh

COPY build/usr/local/bin/* /usr/local/bin
RUN chmod +x /usr/local/bin/install-toolbox.sh /usr/local/bin/install-sdkman.sh

COPY build/etc/profile.d/*.sh /etc/profile.d/
COPY build/etc/vimrc.local /etc/

COPY build/run.sh /
RUN chmod +x /run.sh

EXPOSE 3389

ENTRYPOINT ["/run.sh"]