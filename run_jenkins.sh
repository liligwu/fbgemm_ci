set -eux

env 

DOCKER_IMAGE=rocm/fbgemm-private:latest_v0.1.1

docker pull $DOCKER_IMAGE

JENKINS_REPO_DIR=fbgemm-private-jenkins

JENKINS_REPO_DIR_BAREMETAL=$PWD/$JENKINS_REPO_DIR

JENKINS_REPO_DIR_DOCKER=/workspace/$JENKINS_REPO_DIR

DOCKER_OPTIONS="\
-it \
--network=host \
--ipc=host \
--shm-size 16G \
--group-add video \
--cap-add=SYS_PTRACE \
--security-opt seccomp=unconfined \
--device=/dev/kfd \
--device=/dev/dri \
-v $JENKINS_REPO_DIR_BAREMETAL:$JENKINS_REPO_DIR_DOCKER
"

docker run $DOCKER_OPTIONS $DOCKER_IMAGE
