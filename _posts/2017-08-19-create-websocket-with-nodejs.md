---
layout: post
title: "How To Create Secure WebSocket With Node.JS \"ws\" Module"
categoty: en
tags: ssl tutorial websocket
---
In this tutorial, we will create ssl enable websocket using [ws](https://github.com/websockets/ws) module.

## Requirements

- nodejs with npm
- certbot to generate ssl certificate from letsencrypt

## Step 1 — Generating SSL Certificate

Assuming you use ubuntu 16.04 the step are following

```bash
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install certbot
```

If you're using different system, please refer to [this official documentation](https://certbot.eff.org/).

After certbot successfully installed, we can generate ssl certificate with command

```bash
sudo certbot certonly --webroot -w /var/www/html -d example.com -d www.domain.com
```

Otherwise, if we don't want to use webroot plugin we can use *--standalone* flag to generate ssl certificate.

> Please make sure that port 443 is not being used when generating ssl certificate using *standalone* mode. We can temporarily stopping webserver/other process for using port 443 and start again webserver when we done.

```bash
sudo certbot certonly --standalone -d example.com -d www.example.com
```

This command will generate a single certificate for domain **example.com** and **www.example.com**. Now we can copy certificate file located in (usually) `/etc/letsencrypt/live/example.com/`.

## Step 2 — Create WebSocket Server Project

For now, lets create a project name *secure-websocket* in our home directory and initiating nodejs project.

```bash
cd
mkdir secure-websocket
cd secure-websocket
npm init
# Fill all the necessary information
npm install ws --save
npm install fs --save
npm install https --save
```

All dependencies is ready, now we need to copy our ssl certificate so the application can access it without superuser privileges.

```bash
# create directory to contain ssl certificate
mkdir ssl-cert

# copy ssl certificate to our project directory
sudo cp /etc/letsencrypt/live/example.com/fullchain.pem ssl-celt/fullchain.pem
sudo cp /etc/letsencrypt/live/example.com/privkey.pem ssl-celt/privkey.pem
```

After ssl certificate is ready we can write our application code. Create a new file named **index.js** and copy this code.

```javascript
// Minimal amount of secure websocket server
var fs = require('fs');

// read ssl certificate
var privateKey = fs.readFileSync('ssl-cert/privkey.pem', 'utf8');
var certificate = fs.readFileSync('ssl-cert/fullchain.pem', 'utf8');

var credentials = { key: privateKey, cert: certificate };
var https = require('https');

//pass in your credentials to create an https server
var httpsServer = https.createServer(credentials);
httpsServer.listen(8443);

var WebSocketServer = require('ws').Server;
var wss = new WebSocketServer({
    server: httpsServer
});

wss.on('connection', function connection(ws) {
    ws.on('message', function incoming(message) {
        console.log('received: %s', message);
        ws.send('reply from server : ' + message)
    });

    ws.send('something');
});
```

To start websocket server run following command

```bash
nodejs index.js
```

We can test it with [this chrome extension](https://chrome.google.com/webstore/detail/simple-websocket-client/pfdhoblngboilpfeibdedpjgfnlcodoo?hl=en) or other client to access *wss://example.com:8443*.
