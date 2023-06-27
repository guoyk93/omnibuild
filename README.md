# omnibuild

A container image for building projects, with file permission and cache handled properly

## Toolsets

* `golang=1.20.x`
* `nodejs=18.16.1`
* `jdk=11.0.19+7`

## Usage

```bash
docker run --rm -ti \
    -v "$(pwd):/build/workspace" \
    -v "${HOME}/.omnibuild/home:/build/home" \
    -e EUID=$(id -u) -e EGID=$(id -g) \
    guoyk/omnibuild:latest \
    bash -c "whoami && id && pwd && echo 'hello world'"
```

## Credits

GUO Y.K., MIT License