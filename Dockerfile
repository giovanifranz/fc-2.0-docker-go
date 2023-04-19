FROM golang:1.16-alpine AS builder

WORKDIR /app

COPY rocks.go ./

RUN go build -ldflags "-s -w" rocks.go

FROM scratch AS runtime

COPY --from=builder /app/rocks /rocks

CMD [ "/rocks" ]