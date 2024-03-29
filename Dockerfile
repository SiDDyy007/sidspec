FROM ubuntu:22.04

RUN apt-get update && apt-get install -y build-essential libarchive-dev wget vim git-core coreutils

# Install Mamba
ENV CONDA_DIR /opt/conda
RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-aarch64.sh -O ~/miniforge.sh && /bin/bash ~/miniforge.sh -b -p /opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH

# Adding to bashrc
RUN echo "export PATH=$CONDA_DIR:$PATH" >> ~/.bashrc

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN pip install git+https://github.com/Wang-Bioinformatics-Lab/GNPSDataPackage.git

COPY . /app
WORKDIR /app