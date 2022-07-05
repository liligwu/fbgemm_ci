#!/bin/bash

# exit immediately on failure, or if an undefined variable is used
set -eux

FBGEMM_REPO_DIR=${1:-/workspace/FBGEMM-private}

cd $FBGEMM_REPO_DIR

cd fbgemm_gpu

export MAX_JOBS=`nproc`
export PYTORCH_ROCM_ARCH="gfx908"
CXX=hipcc python setup.py build develop
