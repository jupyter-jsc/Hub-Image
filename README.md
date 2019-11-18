# JupyterHub Docker Image
Install [jupyter-jsc/JupyterHub-extended](https://github.com/jupyter-jsc/JupyterHub-extended).
Add a few monkey patches to JupyterHub 1.0. This allows us to run multiple JupyterHub instances behind a single configuration-http-proxy.

## Mounts
The following paths has to be mounted:
```
/etc/j4j/j4j_mount/j4j_common
/etc/j4j/j4j_mount/j4j_token
/etc/j4j/j4j_mount/j4j_hub
```
To understand what's in each of these directories, have a look at our [Configuration](https://github.com/jupyter-jsc/Configuration) repository.
