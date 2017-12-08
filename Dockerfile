FROM ubuntu:14.04
MAINTAINER support@civisanalytics.com

# Ensure UTF-8 locale.
RUN locale-gen en_US.UTF-8

# Set environment variables for UTF-8, conda, and shell environments
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    CONDARC=/opt/conda/.condarc \
    BASH_ENV=/etc/profile \
    PATH=/opt/conda/bin:$PATH \
    CIVIS_CONDA_VERSION=4.3.30 \
    CIVIS_PYTHON_VERSION=2.7.13 \
    DEFAULT_KERNEL=python2 \
    CIVIS_JUPYTER_NOTEBOOK_VERSION=0.2.4 \
    TINI_VERSION=v0.16.1

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y --no-install-recommends && \
  apt-get install -y --no-install-recommends software-properties-common && \
  apt-get install -y --no-install-recommends \
        make \
        automake \
        libpq-dev \
        libffi-dev \
        gfortran \
        g++ \
        git \
        libboost-program-options-dev \
        libtool \
        libxrender1 \
        wget \
        ca-certificates \
        curl && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*

# Conda install.
#
# Everything is installed in the root environment. This allows for
# upgrades to the packages and eliminates the pain of trying to activate
# some other environment automatically for the many different ways
# people can use a docker image.
#
# Things are pinned to prevent upgrades from conda and force it to
# resolve dependencies relative to a fixed conda & python version.
#
# Note that the python version is also listed in the enviornment.yml
# file. The version in CIVIS_PYTHON_VERSION is the source of truth.
# If you want to change the python version, you need to change it in
# **both** places. The python version has been left in the `environment.yml`
# file so that people can create environments equivalent to this
# container.
#
# The ordering of these steps seems to matter. You seem to have to
# install a specific python version by hand and then pin it.
# 1) install conda
# 2) pin conda to the version given by CIVIS_CONDA_VERSION
# 3) install the python version CIVIS_PYTHON_VERSION
# 4) pin the python version
#
# Extra symlinks are added at the end because...
#   Red Hat and Debian use different names for this file. git2R wants the latter.
#   See conda-recipes GH 423
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-${CIVIS_CONDA_VERSION}-Linux-x86_64.sh && \
    /bin/bash /Miniconda2-${CIVIS_CONDA_VERSION}-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda2-${CIVIS_CONDA_VERSION}-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==${CIVIS_CONDA_VERSION} && \
    echo "conda ==${CIVIS_CONDA_VERSION}" > /opt/conda/conda-meta/pinned && \
    conda install --yes python==${CIVIS_PYTHON_VERSION} && \
    echo "python ==${CIVIS_PYTHON_VERSION}" >> /opt/conda/conda-meta/pinned && \
    conda clean --all -y && \
    ln -s /opt/conda/lib/libopenblas.so /opt/conda/lib/libblas.so && \
    ln -s /opt/conda/lib/libopenblas.so /opt/conda/lib/liblapack.so && \
    ln -s /opt/conda/lib/libssl.so /opt/conda/lib/libssl.so.6 && \
    ln -s /opt/conda/lib/libcrypto.so /opt/conda/lib/libcrypto.so.6

# Install boto in the base environment for private s3 channel support.
# Install Python Packages
COPY .condarc /opt/conda/.condarc
COPY environment.yml environment.yml
RUN conda install -y boto && \
    conda install -y nomkl && \
    conda env update -f environment.yml -n root && \
    conda clean --all -y && \
    rm -rf ~/.cache/pip

# We aren't running a GUI, so force matplotlib to use
# the non-interactive "Agg" backend for graphics.
# Run matplotlib once to build the font cache.
ENV MATPLOTLIBRC=${HOME}/.config/matplotlib/matplotlibrc
RUN mkdir -p ${HOME}/.config/matplotlib && \
    echo "backend      : Agg" > ${HOME}/.config/matplotlib/matplotlibrc && \
    python -c "import matplotlib.pyplot"

# Instruct joblib to use disk for temporary files. Joblib defaults to
# /shm when that directory is present. In the Docker container, /shm is
# present but defaults to 64 MB.
# https://github.com/joblib/joblib/blob/0.11/joblib/parallel.py#L328L342
ENV JOBLIB_TEMP_FOLDER=/tmp

# Install Tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

###############################################
# Notebook-specific configuration is below here
RUN pip install git+https://github.com/civisanalytics/civis-jupyter-notebook.git@c1e082f9e6a9a7c1606554dc016f2de69b0fc4cc && \
    civis-jupyter-notebooks-install

EXPOSE 8888
WORKDIR /root/work

# Configure container startup
ENTRYPOINT ["/tini", "--"]
CMD ["civis-jupyter-notebooks-start"]
