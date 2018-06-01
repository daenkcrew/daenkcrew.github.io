---
layout: post
title: Using Gulp To Automatically Run PHPUnit Test After Saving File
tags: automation tool
---
One of the most annoying as developer/programmer is to do repetitive task over and over again. Why not just automate it? We are programmer right? It's our job to solve this kind of problem.

The usual workflow of testing with `phpunit` is *write test -> run phpunit -> edit source -> run php unit -> repeat*. As we can see, in a single cyclus we run phpunit twice just to check if our source is passing the test. What if after editing the source the test is still failed? We need to edit the source and run phpunit again to check if the test is passing. This kind of repetitive task of cource can be automated right?

## Requirement

**- NodeJS** with npm

## Installation

Open terminal and change to project directory and install gulp with npm

```shell
npm install --save-dev gulp
```

## Configuration

Create a new file with `gulpfile.js` name and paste code below.

```javascript
var gulp = require('gulp');
var exec = require('child_process').exec;

gulp.task('phpunit', function() {
    exec('vendor/bin/phpunit --colors=always', function(error, stdout) {
        console.log(stdout);
    });
});

gulp.task('default', function() {
    gulp.watch('**/*.php', {debounceDelay: 2000}, ['phpunit']);
});
```

> Note: in this configuration we assume that phpunit is installed with composer. If your phpunit is installed globally, you can just type `phpunit` as exec parameter.

## Run phpunit test after saving file

To run gulp just type `node_modules/.bin/gulp` from ternimal. Alternatively we can store this task into `package.json` as npm script.

```json
...
"scripts": {
    "start": "gulp"
}
...
```

Now, everytime we need to run gulp we can invoke it with `npm start`. With this, after we edit php source and save it, the phpunit will be automatically run and we can monitor the result from terminal.
