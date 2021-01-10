# Social Media App
[![Build Status](https://travis-ci.com/amirasaad/rails-social-media.svg?branch=dev)](https://travis-ci.com/amirasaad/rails-social-media)
[![Rails Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop-hq/rubocop-rails)

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
