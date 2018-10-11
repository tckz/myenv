easy-airflow
===

Airflow for local execution.
Using sqlite for db.

# Requirements

* docker (Which has feature multi-stage build)

# Build

```bash
$ docker build -t easy-airflow .
```

# Runtime

* Start webserver & scheduler, Stop CTRL+C
  ```bash
  $ docker run -ti -p 8080:8080 -v /path/to/airflow:/airflow easy-airflow
  ```
 * Place DAGs under /path/to/airflow/dags/
 * Place plugins under /path/to/airflow/plugins/

# LICENSE

fs/requirements.txt is part of following repository.
https://github.com/GoogleCloudPlatform/python-docs-samples
composer/workflows/requirements.txt

# My Environment

* CentOS 7.5
* Docker 18.06.1-ce


