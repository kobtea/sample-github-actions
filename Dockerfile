FROM golang:1.27@sha256:205c7636d74e0ffbe3d007162df7d74f859f5a8c8322dfb9f907977686c126cf as builder

ARG VERSION

ENV CGO_ENABLED=0
WORKDIR /go/src/app
COPY . .
RUN go build -ldflags "-s -w -X github.com/kobtea/sample-github-actions/cmd.Version=$VERSION"

FROM scratch
COPY --from=builder /go/src/app/sample-github-actions /sample-github-actions
ENTRYPOINT ["/sample-github-actions"]
