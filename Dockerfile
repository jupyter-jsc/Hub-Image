FROM jupyterhub/jupyterhub:1.0

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y tzdata=2019c-0ubuntu0.18.04 iputils-ping && ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

RUN /opt/conda/bin/pip install oauthenticator==0.8.2 psycopg2-binary==2.8.2

RUN /opt/conda/bin/pip install -e git+https://github.com/jupyter-jsc/JupyterHub-extended.git@1.0.0#egg=jupyter4jsc

RUN adduser --disabled-password --gecos '' jupyter

COPY --chown=jupyter:jupyter ./start.sh /srv/jupyterhub/start.sh

COPY --chown=jupyter:jupyter ./patches /srv/jupyterhub/src/patches

RUN git clone -q https://github.com/jupyterhub/jupyterhub.git /srv/jupyterhub/src/jupyterhub; cd /srv/jupyterhub/src/jupyterhub; git checkout -q 4e24276d40ad83fd113c7c2f1f8619a9ba3af0d8

RUN cp -r /srv/jupyterhub/src/patches/multiple_instances/* /srv/jupyterhub/src/jupyterhub/. ; /opt/conda/bin/pip install /srv/jupyterhub/src/jupyterhub

# USER jupyter

CMD /srv/jupyterhub/start.sh