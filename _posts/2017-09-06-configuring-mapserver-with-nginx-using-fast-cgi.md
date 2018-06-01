---
layout: post
title: "Configuring Mapserver With NGINX Using Fast CGI"
tags: linux sysadmin
---
Mapserver is an Open Source platform for publishing spatial data and interactive mapping application to the web. In this tutorial we will using `nginx` as reverse proxy to forward request to mapserver cgi process in the backgraound.

## Prerequisites

- Mapserver (available in ubuntu main repository 16.04 and above)
- nginx webserver

This tutorial assuming that mapserver is installed in as */usr/bin/mapserv*, if your mapserver installed in different path, please adapt accordingly.

## Configure Mapserver as cgi worker with spawn-fcgi

Install spawn-fcgi if not already installed.

```bash
sudo apt-get install spawn-fcgi
```

## Fast CGI config

Running mapserver as cgi service. Create file in */etc/init.d/mapserv* with superuser privilege. Put this content and save.

```shell
#!/usr/bin/env sh
#
# description: Mapserver Service Manager
# processname: lt-mapserv
# pidfile: /var/run/mapserv.pid
# Source function library.
#. /etc/init.d/functions
# Check that networking is up.
#. /etc/sysconfig/network
if [ "$NETWORKING" = "no" ]
then
    exit 0
fi
PREFIX=/usr
NAME=mapserv
PID=/var/run/mapserv.pid
DAEMON=$PREFIX/bin/spawn-fcgi
DAEMON_OPTS=" -a 127.0.0.1 -p 9999 -F 4 -u www-data -U www-data -P $PID $PREFIX/bin/mapserv"
start () {
    echo -n $"Starting $NAME "
        exec $DAEMON $DAEMON_OPTS >> /dev/null
        daemon --pidfile $PID
        RETVAL=$?
        echo
    [ $RETVAL -eq 0 ]
}
stop () {
    echo -n $"Stopping $NAME "
        killproc -p $PID
        #make sure all mapservers are closed
        pkill -f lt-mapserv
        RETVAL=$?
        echo
    if [ $RETVAL -eq 0 ] ; then
        rm -f $PID
    fi
}
restart () {
    stop
    start
}
# See how we were called.
case "$1" in
    start)
        start
    ;;
    stop)
        stop
    ;;
    status)
        status lt-mapserv
        RETVAL=$?
    ;;
    restart)
        restart
    ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart}"
        RETVAL=2
    ;;
esac
exit $RETVAL
```
Add execute permission to the file.

```bash
sudo chmod +x /etc/init.d/mapserv
```

Start mapserver service with command

```bash
sudo /etc/init.d/mapserv start
```

## Nginx configuration

```nginx
server {
    listen 80;
    listen [::]:80;
    server_name mapserver.local;

    add_header Access-Control-Allow-Origin *;

    location / {
        # Load from /etc/init.d/mapserv
        fastcgi_pass 127.0.0.1:9999;
        include fastcgi_params;
        fastcgi_param SCRIPT_NAME /usr/bin/mapserv$fastcgi_script_name;
    }
}
```

## URL Rewrite

From nginx configuration file above, we can add rewrite rule to simplify our resource url. Without rewrite, the url would become

```
http://mapserver-example.com/?map=/path/to/mapfile.map
```

If we don't want to expose sensitive information such as mapfile location, we can hide it using url rewrite.
From configuration file above, add the following code to location block

```nginx
rewrite ^/(.*)$ /?map=/path/to/location/of/mapfile.map$1 break;
```

So the configuration file would become

```nginx
# Server block

location / {
        # Load from /etc/init.d/mapserv
        fastcgi_pass 127.0.0.1:9999;

        # Rewrite url to hide mapfile path
        rewrite ^/(.*)$ /?map=/path/to/location/of/mapfile.map$1 break;

        include fastcgi_params;
        fastcgi_param SCRIPT_NAME /usr/bin/mapserv$fastcgi_script_name;
    }
```

## Reference

- http://dotrem.blogspot.co.id/2013/06/mapservernginxfastcgi-on-ubuntu.html
