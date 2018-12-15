FROM openjdk:8 AS builder

ARG SRC_REPO=https://github.com/tomasbjerre/git-changelog-command-line.git

RUN git clone $SRC_REPO
RUN echo "Building git-changelog-command-line from sources.." >&2 && \
    cd git-changelog-command-line && \
    ./gradlew clean build
RUN cd git-changelog-command-line/build/distributions && \
    rm -f *shadow* && \
    unzip *-SNAPSHOT.zip

FROM openjdk:8-alpine

COPY --from=builder git-changelog-command-line/build/distributions/*-*SNAPSHOT/* /usr/local/
