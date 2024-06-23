# pytorch用のDocker image (cudaのバージョンに合わせて選択すること)
# https://hub.docker.com/r/pytorch/pytorch/tags
# FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-runtime

# pythonのdocker image
# バージョンは固定したほうが良い
FROM python:3.8

WORKDIR /app

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    git \
    build-essential \
    make \
    wget \
    curl

RUN pip3 install --upgrade pip \
    && pip3 install poetry \
    && poetry config virtualenvs.create false

COPY pyproject.toml /app
RUN poetry install

COPY ./ /app
