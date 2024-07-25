FROM osrf/ros:humble-desktop

# Install ros2 packages
#========= ros package ===============================

RUN apt update && \
    apt install -y \
    ros-humble-xacro \
    ros-humble-joint-state-publisher-gui

#=====================================================


COPY ./entrypoint.sh /
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]