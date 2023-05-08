FROM docker.io/library/golang:alpine as builder

WORKDIR /home/prometheus

COPY go.* .
RUN go mod download

COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -installsuffix cgo -ldflags '-extldflags "-static"' -o ./hello-prometheus

FROM scratch

COPY --from=builder /home/prometheus .

ENV GIN_MODE release
EXPOSE 8080
ENTRYPOINT ["./hello-prometheus"]
