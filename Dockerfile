FROM python:3.7-alpine
MAINTAINER hynekdan

# recommended to do in case python runs in the Docker
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /app
WORKDIR /app
COPY ./app /app

# -D user to run the application only, no home dir, etc. otherwise the app is run as a root
RUN adduser -D user
USER user