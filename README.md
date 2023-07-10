# omnibuild

A container image for building projects, with file permission and cache handled properly

## Toolsets

* `golang=1.20.x`
* `nodejs=18.16.1`
* `jdk=11.0.19+7`
* `maven=3.8.8`

## Environment Variables

* `HOST_UID` - the UID of the user who runs the container (required)
* `HOST_GID` - the GID of the user who runs the container (required)

## Directories

* `/build/workspace` - the workspace directory
* `/build/home` - the home directory of build user

## Usage

```bash
docker run --rm -ti \
    -v "$(pwd):/build/workspace" \
    -v "${HOME}/.omnibuild:/build/home" \
    -e HOST_UID=$(id -u) -e HOST_GID=$(id -g) \
    guoyk/omnibuild:latest \
    bash -c 'whoami && id && pwd && echo "HOME: ${HOME}"'
```

## Credits

GUO Y.K., MIT License