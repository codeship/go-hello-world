# first stage does the building
# for UX purposes, I'm naming this stage `build-stage`

FROM golang:1.8 as build-stage
WORKDIR /go/src/github.com/codeship/go-hello-world
COPY hello-world.go .
RUN go build -o hello-world .


# starting second stage
FROM alpine:latest
RUN	apk --no-cache add ca-certificates
RUN	apk --no-cache add tzdata
RUN	apk --no-cache add libc6-compat
# copy the binary from the `build-stage`
COPY --from=build-stage /go/src/github.com/codeship/go-hello-world/hello-world /bin

CMD hello-world
