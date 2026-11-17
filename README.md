# Manjaro ARM on Xiaomi Mi 11 Lite 4G (courbet)

Source and patch workspace for the Manjaro ARM port on Xiaomi Mi 11 Lite 4G,
board codename `courbet`, using the custom `6.17.0-courbet+` kernel.

## Current status

- Manjaro ARM rootfs boots from `/dev/sda34`.
- Display / DRM is detected by the kernel.
- USB gadget support is present in the kernel configuration.
- Touchscreen is not yet confirmed working.
- The material in this repository is source/patch material, **not a flashable boot image**.

## Layout

- `patches/sm7150-xiaomi-courbet-touch.patch` — adds the Focaltech SPI touchscreen node to `spi4`.
- `patches/sm7150-xiaomi-courbet-touch.dts` — complete DTS checkpoint with the touch node.
- `patches/focaltech-kconfig-makefile.patch` — kernel integration points for the Focaltech driver.
- `docs/porting-notes.md` — known hardware and bring-up notes.
- `scripts/check-kernel-config.sh` — checks the required kernel options.
- `boot/` — intentionally empty; generated `boot.img` files should be kept out of Git.

## Required kernel options

```text
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_SPI=y
CONFIG_SPI_QCOM_GENI=y
CONFIG_TOUCHSCREEN_FTS=y
CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_CONFIGFS=y
CONFIG_USB_CONFIGFS_RNDIS=y
CONFIG_USB_CONFIGFS_ECM=y
```

## Build flow

1. Start from the matching `6.17.0-courbet` kernel source tree.
2. Add the vendor Focaltech SPI driver under `drivers/input/touchscreen/focaltech_spi/`.
3. Apply the Kconfig/Makefile integration patch.
4. Apply the `sm7150-xiaomi-courbet-touch.patch` DTS patch to the matching board DTS.
5. Enable the required options above and build the kernel and DTB.
6. Package the new kernel/DTB into the boot image used by the device.
7. Test `/dev/input/event*` and `libinput list-devices` before enabling a desktop.

Do not flash a DTB alone and expect touch to work: the controller driver must
also be compiled into the kernel and the DTB must match the kernel build.
