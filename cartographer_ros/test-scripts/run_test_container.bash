#!/bin/bash

# Host Machine: WSL Ubuntu 18.04

container_name="cartographer_test_container"
image_name="cartographer_ros:noetic"
http_proxy=$http_proxy
https_proxy=$https_proxy
host_ip=$host_ip
vscode_config_path="/home/shuqi/docker_images/cartographer_ros/.vscode"
host_rosbag_path="/home/shuqi/cartographer_rosbag_dataset/cartographer_paper_deutsches_museum.bag"
container_rosbag_path="/root/cartographer_paper_deutsches_museum.bag"

docker container rm -f $container_name
docker run \
    --name=$container_name \
    --interactive \
    --detach \
    --mount type=bind,source=$host_rosbag_path,target=$container_rosbag_path,readonly \
    --env http_proxy=$http_proxy \
    --env https_proxy=$https_proxy \
	--env DISPLAY="$host_ip:0" \
    --env QT_X11_NO_MITSHM=1 \
    --volume "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	cartographer_ros:noetic
    
docker cp /home/shuqi/.vimrc $container_name:/root/.vimrc
docker cp $vscode_config_path $container_name:/root/catkin_ws/
docker exec $container_name bash -c "echo 'source /opt/ros/noetic/setup.bash' >> /root/.bashrc"
docker exec $container_name bash -c "echo 'source /root/catkin_ws/devel_isolated/setup.bash' >> /root/.bashrc"
docker exec $container_name bash -c "echo 'export container_rosbag_path=$container_rosbag_path' >> /root/.bashrc"
# docker exec -it $container_name bash -ic "roslaunch cartographer_ros demo_backpack_2d.launch bag_filename:=$container_rosbag_path; bash -i"
docker exec -it $container_name bash -i
