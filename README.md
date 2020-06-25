# mod_python_quickstart
Example of configuring mod_python in Docker

## Usage
1. `git clone https://github.com/profiprog/mod_python_quickstart.git` 
2. `cd mod_python_quickstart`
3. `./do` - this build image, start container and open bash of running container
4. `[inside_container]# get` - alias requesting http://localhost/service/example.py

## Notes
* Request to example service can be also outside container at url: http://localhost:8080/service/example.py
    * port cam be customized by env PORT when starting container. \
    Like: `PORT=8393 ./do` or `PORT=8393 ./do start`

* `./do logs` - open and watch apache logs of running container

* `./do stop` - stop and remove running container

* `./do [<command> [...<args>]]` - this build image, start container and open commad (default `bash`)
    * Of course, command can't be none of `start`, `stop`, `logs` or `exec`

* `./do exec [<command> [...<args>]]` - execute command inside runing container (default `bash`)

* When you exit from container's bash, which was open after executing `./do`, the container continues to run. \
You can attach to same container by `./do exec`

* When you are starting new container (by `./do` or `./do start`),\
the old one is automatically stoped and removed (no need to execute `./do stop` before)

* Service handler `example.py` is serving directly form dir `./service`. It's not copied into docker image. \
So you can modify handler and just refresh url (no need to restart container).

* `[inside_container]# conf` - alias opening apache config file `/usr/local/apache2/conf/httpd.conf` by _vim_ editor
