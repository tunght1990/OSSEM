# Mordor script: Jupyter Environment Dockerfile
# Author: Roberto Rodriguez (@Cyb3rWard0g)
# License: GPL-3.0

FROM cyb3rward0g/jupyter-base:0.0.6
LABEL maintainer="Roberto Rodriguez @Cyb3rWard0g"
LABEL description="Dockerfile OSSEM Project."

ARG NB_USER
ARG NB_UID
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}
ENV PATH "$HOME/.local/bin:$PATH"

USER root

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

USER ${NB_USER}

RUN mkdir -p ${HOME}/docs/notebooks \
    && python3 -m pip install requests PyYAML attackcti==0.3.3 pandas==1.1.3 bokeh==2.2.3 networkx==2.5 --user

COPY docs/notebooks ${HOME}/docs/notebooks

USER root

RUN chown -R ${NB_USER}:${NB_USER} ${HOME} ${JUPYTER_DIR}

WORKDIR ${HOME}

USER ${NB_USER}