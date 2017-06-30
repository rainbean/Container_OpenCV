FROM rainbean/tensorflow:latest

LABEL maintainer "Jimmy Lee"

# install opencv dependencies
RUN apt-get update && \
    apt-get install -y  --no-install-recommends \
	   ffmpeg openexr webp \
	   && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install extra library
RUN pip3 --no-cache-dir install future imutils

# install opencv-python binding with ffmpeg support
RUN pip3 install https://bazel.blob.core.windows.net/opencv/opencv_python-3.2.0-cp35-cp35m-linux_x86_64.whl

# Copy sample notebooks.
COPY notebooks /notebooks
