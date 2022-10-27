FROM rust:1.64 as catfs-builder
RUN apt update && \
    apt install -y libfuse-dev
RUN mkdir -p /usr/src/github.com/kahing && \
        cd /usr/src/github.com/kahing/ && \
        git clone https://github.com/kahing/catfs.git
RUN cd /usr/src/github.com/kahing/catfs && \
    cargo build --release
RUN /usr/src/github.com/kahing/catfs/target/release/catfs --version


FROM golang:1.19 as goofys-builder

RUN mkdir -p $GOPATH/src/github.com/kahing && \
    cd $GOPATH/src/github.com/kahing/ && \
    git clone https://github.com/kahing/goofys.git && \
    export GOOFYS_HOME=$GOPATH/src/github.com/kahing/goofys/

RUN cd $GOPATH/src/github.com/kahing/goofys && \
    git submodule init && \
    git submodule update && \
    go install $GOPATH/src/github.com/kahing/goofys/

RUN PATH=$PATH:$GOPATH/bin; export PATH && \
    goofys --version

FROM debian
RUN apt update && apt install -y libfuse2 curl fuse && \
    rm -rf /var/lib/apt/lists/*
COPY --from=goofys-builder /go/bin/goofys /usr/local/bin/goofys
COPY --from=catfs-builder /usr/src/github.com/kahing/catfs/target/release/catfs /usr/local/bin/catfs
ADD run.sh /usr/local/bin/
ENTRYPOINT [""]
CMD ["/usr/local/bin/run.sh"]
