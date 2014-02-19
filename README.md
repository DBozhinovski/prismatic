## Prismatic
#### *A node js wrapper for ffmpeg*

### Features
- Promise based - uses Q ( https://github.com/kriskowal/q )
- Formats ffmpeg output in a sane manner, wrapping it in objects. Can calculate progress.
- Uses (mostly) continuation-passing style, ie. tries to be "functional" for the most part.

### Getting started
Prismatic can be used:

1. As a command line utility (for testing purposes only): Clone the repository, install packages via NPM and use the prismatic executable located in /bin
2. As a library: Clone the repository, install packages via NPM and build the package via `npm build`. Install the produced .tgz via `npm install {path}` anywhere needed. Installing via npm coming soon. 

Usage [examples](Wikiexamples)

### Requirements
* A recent version of ffmpeg
* Node.js, NPM
* CoffeeScript (if you need to edit the source)
* Q, Lodash and Commander (installable through NPM)
