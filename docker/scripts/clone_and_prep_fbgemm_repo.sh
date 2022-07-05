#!/bin/bash

# exit immediately on failure, or if an undefined variable is used
set -eux

FBGEMM_REPO_DIR=${1:-/workspace/FBGEMM-private}

git clone https://streamhsa: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@github.com/ROCmSoftwarePlatform/FBGEMM.git $FBGEMM_REPO_DIR

cd $FBGEMM_REPO_DIR

git fetch && \
    git checkout rocm_changes && \
    git submodule sync && \
    git submodule update --init --recursive && \

cd fbgemm_gpu
