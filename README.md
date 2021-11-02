# Docker [Klipper](https://www.klipper3d.org/) image

### Making and flashing firmware updates

1. `docker exec -it klipper make menuconfig`
1. `docker exec -it klipper make`
1. `docker exec -it klipper make flash NOSUDO=true FLASH_DEVICE=/dev/serial/by-id/???`

    The `NOSUDO` option is used since we're already running as root in the
    container and don't have the sudo binary installed.
