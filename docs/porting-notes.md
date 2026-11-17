# Courbet bring-up notes

## Observed boot environment

- Architecture: `aarch64`
- Kernel: `6.17.0-courbet+`
- Root filesystem: `ext4`, `/dev/sda34`
- DRM nodes: `/dev/dri/card0`, `/dev/dri/renderD128`
- USB UDC: `a600000.usb`

## Touchscreen

The vendor touchscreen is exposed as a Focaltech SPI controller using:

- compatible: `xiaomi,spits`
- bus: `qupv3_se4_spi` / `spi4`
- reset GPIO: TLMM 8
- IRQ GPIO: TLMM 9
- maximum contacts: 10

The DTS node alone is insufficient. The vendor driver must compile and bind to
`spi4`; after boot, verify with:

```sh
cat /proc/bus/input/devices
ls -l /dev/input/event*
dmesg | grep -iE 'focal|touch|spi4|input'
```

## USB networking

The kernel contains configfs gadget functions for ECM and RNDIS, but the host
must enumerate the corresponding gadget function before `usb0` can reach the
computer. If only `ttyGS0` appears, inspect the configfs gadget setup rather
than changing the IP address repeatedly.
