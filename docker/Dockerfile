ARG BASE_IMAGE

FROM $BASE_IMAGE
MAINTAINER Deven Desai <deven.desai@amd.com>

ARG FBGEMM_REPO_DIR=/workspace/FBGEMM-private

ENV SCRIPTS_DIR=/scripts

WORKDIR /workspace

RUN wget -qO - https://repo.radeon.com/rocm/rocm.gpg.key | apt-key add -;

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update --allow-insecure-repositories && \
  apt-get install -y --allow-unauthenticated \
  git \
  jq \
  sshfs \
  sshpass \
  unzip 

# add locale en_US.UTF-8
RUN apt-get install -y locales
RUN locale-gen en_US.UTF-8
 
# click for DLRM
RUN pip3 install click
RUN pip3 install jinja2
RUN pip3 install ninja
RUN pip3 install scikit-build

# explicitly upgrade the version of the hypothesis package
# this is because the pre-installed version is old and does not support
# an attribute that is used in one of the unit tests
# unit-test : merge_pooled_embeddings_test.py
# attirubute : use_true_random in routine strategies.randoms
RUN pip3 install --upgrade hypothesis

# record configuration for posterity
RUN pip3 list

COPY scripts/ $SCRIPTS_DIR

RUN $SCRIPTS_DIR/clone_and_prep_fbgemm_repo.sh $FBGEMM_REPO_DIR

RUN $SCRIPTS_DIR/build_fbgemm.sh $FBGEMM_REPO_DIR
