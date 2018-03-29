# alpine-docker-compose
Vagrantfile to build Alpine Linux box with docker and docker-compose

Releases can be found at: https://app.vagrantup.com/avangel/boxes/alpine-docker-compose  
In case a newer version is needed, please create an issue.

To build:
```
./build.sh
```

NOTE: `vagrant halt` does not work, you can substitute that with e.g.
```
vagrant ssh -- 'sudo poweroff'
# NOTE: it does not wait until the VM shuts down.
```
