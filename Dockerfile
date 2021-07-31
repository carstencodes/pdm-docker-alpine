# MIT License
# 
# Copyright (c) 2021 Carsten Igel
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice (including the next paragraph) shall be included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

ARG PYTHON_VERSION
ARG ALPINE_VERSION

FROM python:${PYTHON_VERSION}-alpine${ALPINE_VERSION}

ARG PDM_VERSION

RUN apk add --no-cache --virtual .build-deps alpine-sdk python3-dev libffi-dev openssl-dev \
    && pip install --no-input --no-cache-dir --upgrade pdm==${PDM_VERSION} \
    && apk del .build-deps

# This parts have been taken from the original file at
# https://github.com/pdm-project/pdm/blob/8e633c6a9b287192b89cc6f01c8ed18d3322c4b1/Dockerfile

WORKDIR /app

ONBUILD COPY pyproject.toml pyproject.toml
ONBUILD COPY pdm.lock pdm.lock
ONBUILD RUN pdm sync

CMD ["pdm"] 
