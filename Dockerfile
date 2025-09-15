# --- Build stage: Go 1.25 ---
FROM golang:1.25 AS build

WORKDIR /src

COPY . .

ENV CGO_ENABLED=0
RUN go build \
    -trimpath \
    -ldflags='-s -w -extldflags "-static"' \
    -o /out/editthispdf ./


# --- User stage: create unprivileged user ---
FROM alpine:3 AS user
RUN adduser -D -H -u 10001 appuser


# --- Final stage: scratch ---
FROM scratch
COPY --from=user /etc/passwd /etc/passwd
COPY --from=build /out/editthispdf /editthispdf
USER appuser
EXPOSE 8080
ENTRYPOINT ["/editthispdf"]


