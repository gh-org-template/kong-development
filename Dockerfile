ARG OSTYPE=linux-gnu
ARG ARCHITECTURE=x86_64
ARG DOCKER_REGISTRY=ghcr.io
ARG DOCKER_IMAGE_NAME
ARG DOCKER_ARCHITECTURE

# List out all image permutations to trick dependabot
FROM --platform=linux/${DOCKER_ARCHITECTURE} ghcr.io/gh-org-template/kong-runtime:1.0.0-${OSTYPE} AS build

COPY . /tmp
WORKDIR /tmp

COPY kong /kong

# Run our predecessor tests
# Configure, build, and install
# Run our own tests
# Re-run our predecessor tests
ENV DEBUG=0
RUN /test/*/test.sh && \
    /tmp/build.sh && \
    /tmp/test.sh && \
    /test/*/test.sh

# Test scripts left where downstream images can run them
COPY test.sh /test/kong-development/test.sh


# Copy the build result to scratch so we can export the result
FROM scratch AS package
COPY --from=build /tmp/build /