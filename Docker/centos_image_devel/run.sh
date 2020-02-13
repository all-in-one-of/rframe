#!/bin/bash
docker run -it -p 8888:8888 \
--mount type=bind,source=$(dirname "$(dirname `pwd`)"),target=/env2/Projects/rFrame/rframe \
 rf/centos_image_devel_v003
