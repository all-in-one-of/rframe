FROM nvidia/cudagl:10.2-devel-centos7
#LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"
USER root

# yum installs
RUN yum -y install epel-release && \
    yum -y install centos-release-scl && \
    yum -y install \
    devtoolset-7-gcc-c++ \
    make \
    cmake3 \
    python3-devel \
    automake \
    libtool \
    which \
    zlib-devel \
    boost-devel \
    libtiff-devel \
    libpng-devel \
    libjpeg-turbo-devel \
    giflib-devel \
    bzip2-devel \
    LibRaw-devel \
    libwebp-devel \
    freeglut-devel \
    fltk-devel \
    boost-python36-devel.x86_64



RUN pip3 install numpy


ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib64:/opt/rh/devtoolset-7/root/usr/lib64:/opt/rh/devtoolset-7/root/usr/lib:${LD_LIBRARY_PATH}
ENV PATH=/usr/local/bin:/opt/rh/devtoolset-7/root/usr/bin:/opt/app-root/src/bin:/opt/rh/devtoolset-7/root/usr/bin/:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin

#install OpenEXR
ARG OPENEXR_ROOT=/opt/openexr
ARG OPENEXR_VER=2.4.0
ARG BUILDDIR=/opt/openexr/build
WORKDIR ${OPENEXR_ROOT}
RUN curl -O -L https://github.com/openexr/openexr/archive/v${OPENEXR_VER}.tar.gz && \
    tar -xvzf v${OPENEXR_VER}.tar.gz && \
    mkdir ${BUILDDIR}  && \
    cd ${BUILDDIR} && \
    cmake3 "${OPENEXR_ROOT}/openexr-${OPENEXR_VER}" && \
    make && \
    make install


# OIIO EXTRA DEPENDECIES
RUN yum install -y qt5-qtbase-devel && yum -y install git 

# TODO INSTALL OPENCV AND LINK TO OPENEXR


ARG PYTHON_VERSION=3.6
ARG OPENIMAGEIO_ROOT=/opt/oiio
ARG OPENIMAGEIO_VER=Release-2.1.11.0
WORKDIR ${OPENIMAGEIO_ROOT}
RUN curl -O -L https://github.com/OpenImageIO/oiio/archive/${OPENIMAGEIO_VER}.tar.gz && \
    tar -xvzf ${OPENIMAGEIO_VER}.tar.gz && \
    cd oiio-${OPENIMAGEIO_VER} && \
    # enable gcc 7
    source /opt/rh/devtoolset-7/enable && \
    mkdir build && \
    cd build && \
    cmake3 -DOIIO_BUILD_TESTS=1 -DUSE_OPENGL=1 -DUSE_QT=1 -DUSE_PYTHON=1 -DUSE_FIELD3D=0 -DUSE_FFMPEG=0 -DUSE_OPENJPEG=0 -DUSE_OPENCV=1 -DUSE_OPENSSL=0 -DUSE_PTEX=0 -DUSE_NUKE=0 -DUSE_DICOM=0 -DPYTHON_LIBRARY="/usr/lib64" -DPYTHON_INCLUDE_DIR="/usr/include/python3.6m" ../ && \
    make && \
    make install


ENV PYTHONPATH=/opt/oiio/"oiio-${OPENIMAGEIO_VER}"/build/lib/python/site-packages

RUN pip3 install jupyter scipy matplotlib
ENV JUPYTER_PATH="${JUPYTER_PATH}:${PYTHONPATH}"
RUN echo $JUPYTER_PATH


#ENV JUPYTER_PATH=$PYTHONPATH
EXPOSE 8888
WORKDIR /env2/Projects/rFrame/rframe
CMD ["/bin/bash", "-c", "jupyter notebook --ip 0.0.0.0 --no-browser --allow-root"]

