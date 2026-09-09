FROM golang:1.27@sha256:512690a5660563b57d37ecc31129e7f136e831db2aed24a1dbeb8ad7380dc0fa as builder

ARG VERSION

ENV CGO_ENABLED=0
WORKDIR /go/src/app
COPY . .
RUN go build -ldflags "-s -w -X github.com/kobtea/sample-github-actions/cmd.Version=$VERSION"

FROM scratch
COPY --from=builder /go/src/app/sample-github-actions /sample-github-actions
ENTRYPOINT ["/sample-github-actions"]
