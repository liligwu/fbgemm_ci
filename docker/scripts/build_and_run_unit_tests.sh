#!/bin/bash

# exit immediately on failure, or if an undefined variable is used
set -eux

FBGEMM_REPO_DIR=${1:-/workspace/FBGEMM}

git config --global --add safe.directory $FBGEMM_REPO_DIR
git config --global --add safe.directory $FBGEMM_REPO_DIR/third_party/asmjit
git config --global --add safe.directory $FBGEMM_REPO_DIR/third_party/cpuinfo
git config --global --add safe.directory $FBGEMM_REPO_DIR/third_party/googletest
git config --global --add safe.directory $FBGEMM_REPO_DIR/third_party/hipify_torch

apt-get update --allow-insecure-repositories && \
  apt-get install -y --allow-unauthenticated \
  git \
  jq \
  sshfs \
  sshpass \
  unzip

apt-get install -y locales
locale-gen en_US.UTF-8

pip3 install click
pip3 install jinja2
pip3 install ninja
pip3 install scikit-build
pip3 install --upgrade hypothesis

pip3 list

cd $FBGEMM_REPO_DIR

echo $PWD

ls -l

ls -l ./third_party

cd fbgemm_gpu

export MAX_JOBS=`nproc`
export PYTORCH_ROCM_ARCH="gfx908"
CXX=hipcc python setup.py build develop

export FBGEMM_TEST_WITH_ROCM=1

cd test

python layout_transform_ops_test.py --verbose

python permute_pooled_embedding_modules_test.py --verbose

python sparse_ops_test.py --verbose

python merge_pooled_embeddings_test.py --verbose

python quantize_ops_test.py --verbose

python split_embedding_inference_converter_test.py --verbose

python split_table_batched_embeddings_test.py --verbose
