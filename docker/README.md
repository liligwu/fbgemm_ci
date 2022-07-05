# Description

Script to build a docker image for the FBGEMM development environment.

The Dockerfile will create the docker image, clone the FBGEMM repo into it and build FBGEMM. There are individual scripts to clone the repo (and prep it), build fbgemm, and run the unit tests. All of these scripts are copied into the `/scripts` directory in the docker image


# How to build?

This directory contains one script `build_docker_image.sh`. Edit it if needed (to change the base docker image, docker image tag, etc) and run it.

By default, this script
* uses the `rocm/pytorch:rocm5.0_ubuntu18.04_py3.7_pytorch_1.10.0` as the base docker image
* tags the resulting docker image as `rocm/fbgemm-private:rocm5.0_ubuntu18.04_py3.7_pytorch_1.10.0_v0.1`