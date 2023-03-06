FROM jupyter/datascience-notebook:r-4.0.3

USER root

#install jupyter lab git extension
RUN pip install jupyterlab-git

#install git, nano, less, cleanup
RUN apt-get update && \
    apt-get install --yes \
    git \
    nano-tiny \
    less \ 
    curl

#run r packages
RUN Rscript /milestone1_load_packages.R

# RUN apt-get clean && rm -rf var/lib/apt/lists/*


#mount volumes 
RUN mkdir -p /opt/notebooks

#create port
EXPOSE 8888



# #swap to jupyter user
# USER $NB_UID

#install r packages for jupyter file
WORKDIR "/opt/notebooks"






