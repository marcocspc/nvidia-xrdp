FROM fedora:35

#any user package could be provided as this environment variable
ARG USER_PACKAGES="firefox"

#install dependencies to compile xorgxrdp with hardware acceleration
#this is only for nvidia of course
RUN dnf install -y git \
		patch \
		gcc \
		make \
		autoconf \
		libtool \
		automake \
		pkgconfig \
		openssl-devel \
		gettext \
		file \
		pam-devel \
		libX11-devel \
		libXfixes-devel \
		libXrandr-devel \
		libjpeg-devel \
		fuse-devel \
		flex \
		bison \
		gcc-c++ \
		libxslt \
		perl-libxml-perl \
		xorg-x11-font-utils \
		nasm \
		xorg-x11-server-devel \
		xrdp-devel \
		mesa-* \
		libdrm-devel \
		libepoxy-devel

#install user packages
RUN dnf install -y $USER_PACKAGES

#clone the nvidia hack repository
RUN cd / && git clone https://github.com/jsorg71/xorgxrdp/ --branch nvidia_hack --recursive
#copy and link some stuff
RUN cp -r /usr/include/libdrm/* /xorgxrdp
RUN for i in /usr/include/libdrm/* ; do ln -s $i /usr/include/ ; done
#compile and install
RUN cd /xorgxrdp && \
    ./bootstrap && \
    ./configure --enable-glamor --enable-rfxcodec --enable-mp3lame --enable-fdkaac --enable-opus --enable-pixman --enable-fuse --enable-jpeg --includedir=/usr/include/  && \ 
    make && \
    make install

#now clone xrdp repository
RUN cd / && git clone https://github.com/neutrinolabs/xrdp.git
#set up the repository
RUN cd /xrdp && \
    git checkout tags/v0.9.17 && \
    ./bootstrap && \
    ./configure --enable-glamor
#compile and install
RUN cd /xrdp && \
    make && \
    make install

#install xfce desktop
RUN dnf groupinstall -y 'Xfce desktop'

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3389
CMD ["/entrypoint.sh"]
