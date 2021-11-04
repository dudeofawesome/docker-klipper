# Docker [Klipper](https://www.klipper3d.org/) image

## Usage

### Environment Variables

-   `API_SOCKET`: string

    File location for the API socket.
    If not set, then no socket is created.

-   `API_SOCKET_UID_GID`: string, eg: `'1000:1001'`

    User and group IDs to `chown` the API socket to.
    If not set, maintains default ownership

### Healthcheck

Here's a semi-naïve healthcheck just checking for the existence the API socket

```
test "$$(env | grep API_SOCKET | cut -d = -f2-)"
```

### Making and flashing firmware updates

1. `docker exec -it klipper make menuconfig`
1. `docker exec -it klipper make`
1. `docker exec -it klipper make flash NOSUDO=true FLASH_DEVICE=/dev/serial/by-id/???`

    The `NOSUDO` option is used since we're already running as root in the
    container and don't have the sudo binary installed.
