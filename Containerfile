ARG BASE_VERSION="latest"
ARG BASE_IMAGE="ghcr.io/centos-workstation/main"
ARG CACHE_ID_SUFFIX="chonky-beardy-latest"

FROM scratch AS ctx
COPY / /

FROM ${BASE_IMAGE}:${BASE_VERSION}

ARG MAJOR_VERSION="${CENTOS_MAJOR_VERSION:-stream10}"
ARG IMAGE_VENDOR="beardy-os"
ARG IMAGE_NAME="chonky-beardy"

# # Update image info
# RUN \
#     --mount=type=bind,from=ctx,source=/,target=/ctx \
#     /ctx/build_files/image-info.sh && \
#     ostree container commit

# Add additional packages
# RUN \
#     --mount=type=cache,dst=/var/cache/rpm-ostree,id=rpm-ostree-cache-${CACHE_ID_SUFFIX},sharing=locked \
#     --mount=type=cache,dst=/var/cache/libdnf,id=dnf-cache-${CACHE_ID_SUFFIX},sharing=locked \
#     dnf -y install tig && \
#     ostree container commit

# TODO: lint is failing in centos-workstation/main:latest as well, related to adding kernel modules
# disable here as well for now until resolved upstream
## Final command 
RUN bootc container lint || exit 0
