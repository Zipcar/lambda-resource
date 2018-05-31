FROM golang:alpine AS build

COPY . /go/src/github.com/Zipcar/lambda-resource

RUN cd /go/src/github.com/Zipcar/lambda-resource && \
    go build -o /go/src/github.com/Zipcar/lambda-resource/bin/lambda-resource-linux-amd64


FROM alpine:edge AS resource

COPY --from=build /go/src/github.com/Zipcar/lambda-resource/bin/lambda-resource-linux-amd64 /opt/resource/check

RUN apk add --no-cache ca-certificates && \
    cd /opt/resource && \
    ln -s check out && \
    ln -s check in

FROM resource
