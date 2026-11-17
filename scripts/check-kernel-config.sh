#!/bin/sh
set -eu
CONFIG_FILE="${1:-.config}"
[ -f "$CONFIG_FILE" ] || { echo "Usage: $0 /path/to/.config" >&2; exit 2; }
for option in \
  CONFIG_INPUT_TOUCHSCREEN=y \
  CONFIG_SPI=y \
  CONFIG_SPI_QCOM_GENI=y \
  CONFIG_TOUCHSCREEN_FTS=y \
  CONFIG_USB_LIBCOMPOSITE=y \
  CONFIG_USB_CONFIGFS=y \
  CONFIG_USB_CONFIGFS_RNDIS=y \
  CONFIG_USB_CONFIGFS_ECM=y
 do
  grep -qx "$option" "$CONFIG_FILE" && echo "OK   $option" || echo "MISS $option"
done
