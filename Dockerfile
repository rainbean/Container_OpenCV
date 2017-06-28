FROM rainbean/tensorflow:latest

LABEL maintainer "Jimmy Lee"

ARG OPENCV_VERISON="3.2.0"

# install opencv dependencies
RUN apt-get update && \
    apt-get install -y  --no-install-recommends \
	   cmake \
	   libgtk2.0-dev \
	   pkg-config \
	   libtbb2 \
	   libtbb-dev \
	   libjpeg-dev \
	   libpng-dev \
	   libtiff-dev \
	   libjasper-dev \
	   ffmpeg \
	   libxvidcore-dev \
	   libx264-dev \
	   libatlas-base-dev \
	   openexr \
	   libopenblas-dev \
	   liblapacke-dev \
	   && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install extra library
RUN pip3 --no-cache-dir install future imutils	

# build opencv
RUN curl -sL https://github.com/opencv/opencv/archive/$OPENCV_VERISON.tar.gz | tar xvz -C /tmp && \
    mkdir -p /tmp/opencv-$OPENCV_VERISON/build && \
	cd /tmp/opencv-$OPENCV_VERISON/build && \
	cmake -DWITH_FFMPEG=ON -DWITH_OPENEXR=ON -DWITH_CUDA=OFF .. && \
	make && \
	make install && \
	echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf && \
	ldconfig && \
	ln /dev/null /dev/raw1394 && \
	rm -fr /tmp/opencv-$OPENCV_VERISON

# Copy sample notebooks.
COPY notebooks /notebooks
