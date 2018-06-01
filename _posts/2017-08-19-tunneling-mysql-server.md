---
layout: post
title: "How To Tunneling MySQL Server"
tags: ssh
---
For security reason, usually (and it should) root access won't be allowed from remote address. So how do we can access mysql server using root credential from remote address? The usual way is, we access our remote server via ssh then access mysql from command line (shell).

The problem is, with this method we can't use graphical mysql client such as Mysql Workbench (assuming we run headless server). So how do we access mysql with root credential securely?

The simple answer is to use ssh tunneling. The workflow goes like this:

- login to remote server using ssh credential
- create a tunnel to mapping remote port to local port
- access remote service (port) using that has been mapped to local machine

With this method, when we access the service it will be treated that we access via local machine. To start an ssh tunneling run this command

```bash
ssh -f -N -M -S /tmp/mysql.sock -L3310:localhost:3306 remote_user@remote_server
```

Explanation:

|Flag|Description|
|---|---|
|**-f**|Requests **ssh** to go to background just before command execution. This is useful if **ssh** is going to ask for passwords or passphrases, but the user wants it in the background. This implies **-n**. The recommended way to start X11 programs at a remote site is with something like **ssh -f host xterm**.|
|**-N**|Do not execute a remote command.  This is useful for just forwarding ports (protocol version 2 only).|
|-M|Places the ssh client into “master” mode for connection sharing. Refer to the description of **ControlMaster** in **ssh_config(5)** for details.|
|**-S** *ctl_path*|Specifies the location of a control socket for connection sharing. Refer to the description of **ControlPath** and **ControlMaster** in **ssh_config(5)** for details.|
|**-L** [*bind_address*:]*port*:*host*:*hostport*|Specifies that the given port on the local (client) host is to be forwarded to the given host and port on the remote side. This works by allocating a socket to listen to port on the local side, optionally bound to the specified bind_address.  Whenever a connection is made to this port, the connection is forwarded over the secure channel, and a connection is made to host port hostport from the remote machine.  Port forwarding can also be specified in the configuration file.  IPv6 addresses can be specified with an alternative syntax: [bind_address/]port/host/hostport or by enclosing the address in square brackets.  Only the superuser can forward privileged ports. By default, the local port is bound in accordance with the **GatewayPorts** setting. However, an explicit bind_address may be used to bind the connection to a specific address. The bind_address of “localhost” indicates that the listening port be bound for local use only, while an empty address or ‘*’ indicates that the port should be available from all interfaces.|

After tunneling is done, we can accessing mysql server using root credential.

```bash
mysql -u root --host=127.0.0.1 --port=3310 -p
```

Of course we can use graphical interface to access this mysql tunnel.

> **Note**: we need to explicitly specify which host and port we want to access. If in our local machine has mysql service already running, using *--host=localhost* or without *--host* flag will ignore which port we want to access since mysql using unix socket to manage connection

## Stopping tunneling

Simply run this command to stop ssh tunneling

```bash
ssh -S /tmp/mysql-tunnel.sock -O exit remote_user@remote_server
```

## Reference

- http://linuxcommand.org/man_pages/ssh1.html
