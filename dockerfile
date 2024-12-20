FROM ubuntu:24.04

# ENV LLVM_VERSION=19

ENV DEBIAN_FRONTEND=noninteractive

# Install base packages
RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get install --no-install-recommends -y \
		cmake \
        clang \
        clang-tidy \
		clangd \
		gcc \
		gcc-multilib \
		gcovr \
		gdb \
		git \
		lcov \
		llvm \
		locales \
		make \
		ninja-build \
		pkg-config \
		python3-dev \
		python3-pip \
		python3-setuptools \
		python-is-python3 \
		srecord \
		sudo \
		unzip \
		valgrind \
		wget

# RUN wget https://apt.llvm.org/llvm.sh && \
#     chmod +x llvm.sh && \
#     sudo ./llvm.sh ${LLVM_VERSION} all

# RUN sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${LLVM_VERSION} 10 && \
#     sudo update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${LLVM_VERSION} 10

RUN bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)"

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

SHELL ["/bin/bash", "-c"]