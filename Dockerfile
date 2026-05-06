FROM golang:1.17@sha256:87262e4a4c7db56158a80a18fefdc4fee5accc41b59cde821e691d05541bbb18 as builder

ARG VERSION

ENV CGO_ENABLED=0
WORKDIR /go/src/app
COPY . .
RUN go build -ldflags "-s -w -X github.com/kobtea/sample-github-actions/cmd.Version=$VERSION"

FROM scratch
COPY --from=builder /go/src/app/sample-github-actions /sample-github-actions
ENTRYPOINT ["/sample-github-actions"]
