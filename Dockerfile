FROM jupyter/datascience-notebook:r-4.0.3

USER root

#install jupyter lab git extension
RUN conda install jupyterlab-git

#install conda kernels for accesing R
RUN conda install nb_conda_kernels

#install git, nano, less, cleanup
RUN apt-get update && \
    apt-get install --yes \
    git \
    nano-tiny \
    less \ 
    curl

# create folder for scripts
RUN mkdir -p /scripts

# create folder for notebook
RUN mkdir -p /notebooks

#add script file to folder
COPY /scripts/install_packages.R /scripts/install_packages.R 

#copy jupyter notebook into folder
COPY /notebooks/submission.ipynb /notebooks/submission.ipynb 

#run r packages
RUN Rscript /scripts/install_packages.R 

# RUN apt-get clean && rm -rf var/lib/apt/lists/*
#create port
EXPOSE 8888

# #swap to jupyter user
# USER $NB_UID

#working directory
WORKDIR "/notebooks"






