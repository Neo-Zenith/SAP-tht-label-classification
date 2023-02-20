FROM python:3.11-slim-buster

WORKDIR /app

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    pkg-config \
    libcairo2-dev \
    libharfbuzz-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff5-dev \
    libxcb1-dev \
    libfreetype6-dev \
    python3-dev \
    python3-pyqt5 \
    python3-pyqt5.qtsvg \
    python3-pyqt5.qtwebkit \
    python3-setuptools \
    python3-wheel

COPY requirements.txt .
RUN pip install -r requirements.txt

RUN git clone --depth 1 --branch=master https://github.com/amueller/word_cloud.git
WORKDIR /app/word_cloud
RUN python setup.py install

WORKDIR /app

COPY . /app

EXPOSE 5000

CMD ["python", "deployment.py"]