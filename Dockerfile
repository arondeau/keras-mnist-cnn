FROM debian:8.5

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git g++

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Miniconda3-latest-Linux-x86_64.sh

ENV PATH /opt/conda/bin:$PATH

RUN conda install -y nose numpy pillow h5py jupyter

RUN conda install -c conda-forge tensorflow

RUN pip install git+git://github.com/fchollet/keras.git

ADD ./mnist_cnn.ipynb ./mnist_cnn.ipynb
ADD ./run_notebook.sh ./run_notebook.sh
ADD ./four.png ./four.png

EXPOSE 8888

CMD ["./run_notebook.sh"]
