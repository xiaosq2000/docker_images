FROM osrf/ros:noetic-desktop-full
LABEL maintainer="xiaosq2000@gmail.com"
SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        dbus-x11 \
		clang \
		cmake \
        git \
        vim \
        curl \
        wget \
        unzip \
		libcurl4-openssl-dev \
        python3-wstool \
        python3-rosdep \
		python3-sphinx \
        ninja-build \
		stow \
		protobuf-compiler \
		libgflags-dev \
		google-mock \
		libgmock-dev \
		libgoogle-glog-dev \
		libboost-all-dev \
		libsuitesparse-dev \
		libeigen3-dev \
		libceres-dev \
		libcairo2-dev \
		liblua5.2-dev && \
rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/catkin_ws && \
    cd /root/catkin_ws
WORKDIR /root/catkin_ws
RUN wstool init src && \
    wstool merge -t src https://raw.githubusercontent.com/cartographer-project/cartographer_ros/master/cartographer_ros.rosinstall && \
    wstool update -t src && \
    . src/cartographer/scripts/install_abseil.sh
RUN rosdep init || true && \
    rosdep update || true && \ 
    rosdep install --from-paths src --ignore-src --rosdistro=${ROS_DISTRO} -y || true

RUN source /opt/ros/noetic/setup.bash && \
    catkin_make_isolated --install --use-ninja

CMD ["bash"]
