HOWTO
=======

* edit your `.docker/daemon.json` to include `"hosts": ["tcp://0.0.0.0:23900"],` and restart
* create remote desktop entry for `localhost:33890`
* modify docker-compose.yml command to use your username/password
* you may need to create home and Users volumes
* run `docker compose up`
* open rdp and connect with username password
* in container run `install-sdkman.sh && install-toolbox.sh`