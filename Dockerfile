# Compile stage
FROM golang:1.17 AS build-env

# Build Delve
RUN go install github.com/go-delve/delve/cmd/dlv@latest

RUN chmod 777 /go/bin/dlv

FROM gcr.io/distroless/static:debug-nonroot

WORKDIR /

COPY --from=build-env /go/bin/dlv /
COPY helm helm
COPY core core
COPY unpack unpack
COPY webhooks webhooks
COPY crdvalidator crdvalidator
COPY rukpakctl rukpakctl

EXPOSE 8080
