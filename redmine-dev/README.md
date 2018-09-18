Redmine development
===

* Configure under REDMINE_ROOT/config/

* Setup once.
  ```bash
  $ cd /path/to/REDMINE_ROOT 
  $ docker run -ti --rm -v `pwd`:/redmine -u `id -u`:`id -g` redmine-dev scl enable rh-ruby24 "cd /redmine && bundle install --path vendor/bundle"
  ```

* Run redmine
  ```bash
  $ cd /path/to/REDMINE_ROOT 
  $ docker run -ti --rm -p 3000:3000 -v `pwd`:/redmine -u `id -u`:`id -g` redmine-dev
  ```

