FROM golang:1.22.5 as base

WORKDIR /app

copy go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

#final image -- distroless image

From gcr.io/distroless/base

copy    --from=base /app/main .

copy    --from=base /app/static ./static

expose 8080

cmd ["./main"]