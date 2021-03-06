FROM rainbean/tensorflow:latest

LABEL maintainer "Jimmy Lee"

# install opencv dependencies
RUN apt-get update && \
    apt-get install -y  --no-install-recommends \
	   ffmpeg openexr webp libgtk2.0-0 \
	   && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install opencv-python binding with ffmpeg support
RUN pip3 --no-cache-dir install \
       future imutils \
       https://bazel.blob.core.windows.net/opencv/opencv_python-3.3.0-cp35-cp35m-linux_x86_64.whl

# Copy sample notebooks.
COPY notebooks /notebooks
