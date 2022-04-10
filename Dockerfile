FROM python:3.7-alpine
MAINTAINER hynekdan

# recommended to do in case python runs in the Docker
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
# usually I never want to increase the size of the container with the cache
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
        gcc libc-dev linux-headers postgresql-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# -D user to run the application only, no home dir, etc. otherwise the app is run as a root
RUN adduser -D user
USER user