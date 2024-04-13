# Build Stage
FROM lacion/alpine-golang-buildimage:1.13 AS build-stage

LABEL app="build-pocket-project"
LABEL REPO="https://github.com/soliton2022/pocket-project"

ENV PROJPATH=/go/src/github.com/soliton2022/pocket-project

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /go/src/github.com/soliton2022/pocket-project
WORKDIR /go/src/github.com/soliton2022/pocket-project

RUN make build-alpine

# Final Stage
FROM lacion/alpine-base-image:latest

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/soliton2022/pocket-project"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/pocket-project/bin

WORKDIR /opt/pocket-project/bin

COPY --from=build-stage /go/src/github.com/soliton2022/pocket-project/bin/pocket-project /opt/pocket-project/bin/
RUN chmod +x /opt/pocket-project/bin/pocket-project

# Create appuser
RUN adduser -D -g '' pocket-project
USER pocket-project

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/pocket-project/bin/pocket-project"]
