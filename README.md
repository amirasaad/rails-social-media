# Social Media App

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