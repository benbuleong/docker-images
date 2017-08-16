FROM ubuntu:16.04
MAINTAINER Ben Leong <cleong@ets.org>

RUN apt-get update && \
	apt-get install -y \
	build-essential \
	checkinstall \
	clang-3.7 \
	clang++-3.7 \
	cmake \
	git \
	libavcodec-dev \
	libavformat-dev \
	libboost-all-dev \
	libc++abi-dev \
	libc++-dev \
	libdc1394-22-dev \
	libgtk2.0-dev \
	libjasper-dev \
	libjpeg-dev \
	liblapack-dev \
	libopenblas-dev \
	libpng-dev \
	libswscale-dev \
	libtbb2 \
	libtbb-dev \
	libtiff-dev \
	llvm \
	pkg-config \
	python-dev \
	python-numpy \
	sshfs \
	unzip \
	wget

RUN wget https://github.com/Itseez/opencv/archive/3.1.0.zip && \
	unzip 3.1.0.zip -d /opt && \
	cd /opt/opencv-3.1.0 && \
	mkdir build && \
	cd build && \
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D WITH_TBB=ON -D BUILD_SHARED_LIBS=OFF .. && \
	make -j2 && \
	make install

# successfully built using commit SHA f571af1c8414d1dc9df02d71c967126d7863662c
RUN cd /opt && \
	git clone https://github.com/TadasBaltrusaitis/OpenFace.git && \
	cd OpenFace && \
	git reset --hard f571af1c8414d1dc9df02d71c967126d7863662c && \
	mkdir build && \
	cd build && \
	cmake -D CMAKE_BUILD_TYPE=RELEASE .. && \
	make

# install editors
RUN apt-get install -y \
	emacs \
	vim

# clean up
RUN rm 3.1.0.zip

# set working directory
WORKDIR /opt/OpenFace/build/bin

# copy feature extraction script over
COPY ./start_feature_extraction.sh /opt/OpenFace/build/bin
