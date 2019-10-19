FROM archlinux/base
MAINTAINER heliary rydesun@gmail.com

# 加入中国镜像源和社区仓库
RUN curl 'https://www.archlinux.org/mirrorlist/?country=CN&protocol=https&ip_version=4' \
        | sed 's/^#Server/Server/' > /etc/pacman.d/mirrorlist \
 && curl 'https://raw.githubusercontent.com/archlinuxcn/mirrorlist-repo/master/archlinuxcn-mirrorlist' \
        | sed 's/^#Server/Server/' > /etc/pacman.d/archlinuxcn-mirrorlist \
 && echo '[archlinuxcn]' >> /etc/pacman.conf \
 && echo 'SigLevel = Optional TrustedOnly' >> /etc/pacman.conf \
 && echo 'Include = /etc/pacman.d/archlinuxcn-mirrorlist' >> /etc/pacman.conf \
 && pacman -Syy \
 # 更新pacman密钥
 && pacman-key --init \
 && pacman-key --populate archlinux \
 && pacman -S --noconfirm archlinuxcn-keyring \
 # 设置中国时区
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 # 清理缓存
 && pacman --noconfirm -Scc

CMD /bin/bash
