FROM ubuntu:18.04
MAINTAINER Ben Leong <cleong@ets.org>

RUN apt-get update && apt-get install -y \
	build-essential g++-8 \
	cmake \
	libopenblas-dev \
	git \
	libgtk2.0-dev \
	pkg-config \
	libavcodec-dev \
	libavformat-dev \
	libswscale-dev \
	python-dev \
	python-numpy \
	libtbb2 \
	libtbb-dev \
	libjpeg-dev \
	libpng-dev \
	libtiff-dev \
	libdc1394-22-dev \
	wget \
	unzip \
	libboost-all-dev

RUN wget https://github.com/opencv/opencv/archive/4.1.0.zip && \
	unzip 4.1.0.zip -d /opt && \
	cd /opt/opencv-4.1.0 && \
	mkdir build && \
	cd build && \
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D BUILD_TIFF=ON -D WITH_TBB=ON .. && \
	make -j2 && \
	make install

RUN wget http://dlib.net/files/dlib-19.13.tar.bz2 && \
	tar xf dlib-19.13.tar.bz2 && \
	cd dlib-19.13 && \
	mkdir build && \
	cd build && \
	cmake .. && \
	cmake --build . --config Release && \
	make install && \
	ldconfig && \
	cd ../..

RUN cd /opt && \
	git clone https://github.com/TadasBaltrusaitis/OpenFace.git && \
	cd OpenFace && \
	mkdir build && \
	cd build && \
	cmake -D CMAKE_CXX_COMPILER=g++-8 -D CMAKE_C_COMPILER=gcc-8 -D CMAKE_BUILD_TYPE=RELEASE .. && \
	make

RUN apt-get install -y sshfs

# clean up
RUN rm 4.1.0.zip

# set working directory
WORKDIR /opt/OpenFace/build/bin

# internal use only
# copy model files
COPY ./cen_patches*dat /opt/OpenFace/build/bin/model/patch_experts/

# internal use only
# copy feature extraction script over
COPY ./start_feature_extraction.sh /opt/OpenFace/build/bin

RUN chmod +x start_feature_extraction.sh

RUN mkdir -p /opt/OpenFace/build/bin/classifiers

COPY ./haarcascade_frontalface_alt.xml /opt/OpenFace/build/bin/classifiers

