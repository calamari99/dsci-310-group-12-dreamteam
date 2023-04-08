FROM jupyter/r-notebook:r-4.2.3

# USER root

# #install jupyter lab git extension
# RUN conda install --yes \
#     jupyterlab-git \
#     nb_conda_kernels 

# Install packages for Jovyan:
USER ${NB_UID}

RUN Rscript -e "require(devtools); install_version('caTools', version='1.18.2', repos='http://cran.us.r-project.org')"
RUN Rscript -e "require(devtools); install_version('tidyverse', version='2.0.0', repos='http://cran.us.r-project.org')"
RUN Rscript -e "require(devtools); install_version('repr', version='1.1.6', repos='http://cran.us.r-project.org')"
RUN Rscript -e "require(devtools); install_version('tidymodels', version='1.0.0', repos='http://cran.us.r-project.org')"
RUN Rscript -e "require(devtools); install_version('kknn', version='1.3.1', repos='http://cran.us.r-project.org')"
RUN Rscript -e "require(devtools); install_version('MASS', version='7.3-58.3', repos='http://cran.us.r-project.org')"
RUN Rscript -e "require(devtools); install_version('cowplot', version='1.1.1', repos='http://cran.us.r-project.org')"
RUN Rscript -e "require(devtools); install_version('ggplot2', version='3.4.1', repos='http://cran.us.r-project.org')"
RUN Rscript -e "require(devtools); install_version('gridExtra', version='2.3', repos='http://cran.us.r-project.org')"
RUN Rscript -e "require(devtools); install_version('docopt', version='0.7.1', repos='http://cran.us.r-project.org')"

# a install --yes -c conda-forge \
#     r-caTools=1.18.2 \
#     r-tidyverse=2.0.0 \
#     r-repr=1.1.6 \
#     r-tidymodels=1.0.0 \
#     r-kknn=1.3.1 \
#     r-MASS=7.3-58.3 \
#     r-cowplot=1.1.1 \
#     r-ggplot2=3.4.1 \
#     r-gridExtra=2.3 && \
#     fix-permissions "${CONDA_DIR}" && \
#     fix-permissions "/home/${NB_USER}"

## RUNNING WITH AN R SCRIPT?
# # create folder for scripts
# RUN mkdir -p /scripts

# # create folder for notebook
# RUN mkdir -p /notebooks

# #add script file to folder
# COPY /scripts/install_packages.R /scripts/install_packages.R 

# #copy jupyter notebook into folder
# COPY /notebooks/submission.ipynb /notebooks/submission.ipynb 

# #run r packages
# RUN Rscript /scripts/install_packages.R 
