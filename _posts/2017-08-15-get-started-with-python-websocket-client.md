---
layout: post
title: "Getting Started With Python Websocket Client"
category: en
tags: python websocket
---
The main purpose of this article is for archive and personal blog about what I'm doing in my work. For more info and best practice, I suggest you should visit official website of [pypi](https://pypi.python.org/pypi/websocket-client).

I'm not familiar with python, but since I need to use python with my raspberry pi project I think this is a good chance to getting started. In my case, I need to transmit data from sensor that connected to GPIO to online server so that other people can monitor the what the current status of my sensor. Originally I will using `http` protocol to send data from raspberry pi via `curl` but this won't work if we want to get realtime data since there will be too much latency. Then again this won't be efficient if we have to sending data with say, 10 second interval?

After spending some time reading article from internet, I found about websocket. Even thought I'm a web developer, I don't even know about websocket until recently. So here it is.

## Requirement

Fortunately, python (version 2.7) comes preinstalled in raspbian-jessie that I'm using. So I don't have to install it manually. All I need is to install websocket client library using command `sudo pip install websocket-client` and done. I'm ready to write a python script.
For more info about installation, please read the [official repository](https://pypi.python.org/pypi/websocket-client).

## The Code

Let't start it by creating a project directory named `my-websocket-client-project`. Now we can change to working directory and create a new file name `my-websocket.py` and type this code

> **Note:** please make sure that your filename is not conflicting with library that we will import.

```python
#!/usr/bin/python
import websocket
import thread
import time

def on_message(ws, message):
    print message

def on_error(ws, error):
    print error

def on_close(ws):
    print "### closed ###"
    # Attemp to reconnect with 2 seconds interval
    time.sleep(2)
    initiate()

def on_open(ws):
    print "### Initiating new websocket connection ###"
    def run(*args):
        for i in range(30000):
            # Sending message with 1 second intervall
            time.sleep(1)
            ws.send("Hello %d" % i)
        time.sleep(1)
        ws.close()
        print "thread terminating..."
    thread.start_new_thread(run, ())

def initiate():
    websocket.enableTrace(True)
    ws = websocket.WebSocketApp("ws://echo.websocket.org/",
        on_message = on_message,
        on_error = on_error,
        on_close = on_close)
    ws.on_open = on_open

    ws.run_forever()

if __name__ == "__main__":
    initiate()
```

There you have it, run it with command `python my-websocket.py`. To stop it, press <kbd>ctrl</kbd>+<kbd>c</kbd> twice.

Next time we will sending actual data to server from sensor.

## Reference

- https://pypi.python.org/pypi/websocket-client
