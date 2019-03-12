FROM tensorflow/tensorflow:1.13.1-py3-jupyter

# Install R
RUN apt update
RUN apt install apt-transport-https ed git libgit2-dev libssl-dev software-properties-common -y
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/'
RUN apt update
RUN apt install r-base -y

# Install R packages
RUN R -e "install.packages(\
    c('ggplot2',\
      'faraway',\      
      'repr',\
      'IRdisplay',\
      'evaluate',\
      'crayon',\
      'pbdZMQ',\
      'devtools',\
      'uuid',\
      'digest'),\
    repos='http://cran.us.r-project.org');\
    devtools::install_github('IRkernel/IRkernel');\
    IRkernel::installspec(user=FALSE);"

# Python Integration with R
RUN pip install --upgrade pip
RUN pip install nose
RUN pip install rpy2
RUN pip install tzlocal
RUN pip install --upgrade numpy
RUN pip install --upgrade scipy
RUN pip install seaborn
RUN pip install statsmodels
RUN pip install --upgrade tensorboard
RUN pip install tensorflow_probability

# Install INLA
RUN R -e "install.packages(\
  'INLA', \
  repos=c(getOption('repos'), \
  INLA='https://inla.r-inla-download.org/R/stable'), \
  dep=TRUE);"

RUN R -e "install.packages(c(\
    'clubSandwich',\
    'data.table',\
    'gee',\
    'geepack',\
    'lasso2',\
    'penalized',\
    'VGAM'),\
  repos='http://cran.us.r-project.org',\
  dep=TRUE);"
