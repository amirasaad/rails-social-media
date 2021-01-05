# Social Media App
[![Build Status](https://travis-ci.com/amirasaad/rails-social-media.svg?branch=dev)](https://travis-ci.com/amirasaad/rails-social-media)
## Getting started
First build the image
```bash
$ docker build -t sm:latest server
```

### Testing

```bash
$ docker build -t sm:server server
$ docker run -it sm:server rake test
```