FROM golang:1.15.8-alpine3.13 AS builder

RUN apk add --no-cache --update git

WORKDIR /go/src/app
COPY . .

RUN go get -d -v \
    && go install -v \
    && go build

FROM scratch AS runtime
WORKDIR /tmp
COPY --from=builder /go/bin/app .
ENTRYPOINT ["/tmp/app"]