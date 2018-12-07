FROM       golang:alpine as builder

RUN apk --no-cache add curl git make perl
RUN curl -s https://glide.sh/get | sh
COPY . /go/src/github.com/chienfuchen32/mongodb_exporter
RUN cd /go/src/github.com/chienfuchen32/mongodb_exporter && make release

FROM       alpine:3.4
MAINTAINER Jeff Chen <chienfuchen32@gmail.com>
EXPOSE     9001

RUN apk add --update ca-certificates
COPY --from=builder /go/src/github.com/chienfuchen32/mongodb_exporter/release/mongodb_exporter-linux-amd64 /usr/local/bin/mongodb_exporter

ENTRYPOINT [ "mongodb_exporter" ]
