FROM 10.0.24.10:50000/jupyter4jsc/j4j_hub_base:1.0

RUN /opt/conda/bin/pip install -e git+https://github.com/jupyter-jsc/JupyterHub-extended.git@integration#egg=jupyter4jsc

RUN adduser --disabled-password --gecos '' jupyter

COPY --chown=jupyter:jupyter ./start.sh /srv/jupyterhub/start.sh

COPY --chown=jupyter:jupyter ./patches /srv/jupyterhub/src/patches

RUN git clone -q https://github.com/jupyterhub/jupyterhub.git /srv/jupyterhub/src/jupyterhub; cd /srv/jupyterhub/src/jupyterhub; git checkout -q 4e24276d40ad83fd113c7c2f1f8619a9ba3af0d8

RUN cp -r /srv/jupyterhub/src/patches/multiple_instances/* /srv/jupyterhub/src/jupyterhub/. ; /opt/conda/bin/pip install /srv/jupyterhub/src/jupyterhub

# USER jupyter

CMD /srv/jupyterhub/start.sh
