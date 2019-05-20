FROM golang:1.11.10 as build-env
MAINTAINER wangxk xinkuanwang@gmail.com

WORKDIR /GoProject/TaibaiSupport
COPY go.mod .
COPY go.sum .
RUN go mod download

ADD . /GoProject/TaibaiSupport
RUN go build --ldflags "-extldflags -static"


FROM alpine
RUN apk --no-cache add tzdata
WORKDIR /app
COPY --from=build-env /GoProject/TaibaiSupport/TaibaiSupport /app


EXPOSE 8888

ENTRYPOINT ["./TaibaiSupport"]


