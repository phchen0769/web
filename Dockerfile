FROM alpine:latest

LABEL MAINTAINER="Fedorov"


# 替换apk使用的源
RUN echo "https://dl-cdn.alpinelinux.org/alpine/latest-stable/main" > /etc/apk/repositories && \
    echo "https://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories


# 设定容器时间
RUN echo "export TZ='UTC'" > /etc/profile

# Install required packages and remove the apt packages cache when done.
RUN apk update && apk add --no-cache --update-cache libuv\
    nodejs \
	gcc \
	make \
	g++ \
	git \
	npm \
	python3 \
	openssh-client

RUN npm config set registry https://registry.npmmirror.com/

WORKDIR /workspaces/web

EXPOSE 5173

CMD ["npm", "run", "serve"]