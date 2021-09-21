# GOLANG BUILDER
FROM golang:1.13 AS builder
COPY . /go/src/authenticator-service
WORKDIR /go/src/authenticator-service
RUN go mod tidy
RUN go build -o=authenticator-service
# SERVICE BUILDER
FROM ubuntu

WORKDIR /app
COPY --from=builder /go/src/authenticator-service ./

RUN chmod +x ./authenticator-service
EXPOSE 3000
ENV PORT 3000
CMD ./authenticator-service server