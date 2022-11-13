#!/bin/sh

SETUP_DRIVE=/dev/sda
SETUP_USERNAME=ketrab
SETUP_PASSWORD=1
SETUP_LOCATION=/home/${SETUP_USERNAME}/system_config  # absolute path, in new filesystem

exec ./setup_system.sh

# copy all installation files to new system
mkdir -p /mnt${SETUP_LOCATION}
cp -r * /mnt/${SETUP_LOCATION}/

arch-chroot /mnt /bin/bash <<EOF
  SETUP_USERNAME=${SETUP_USERNAME}
  SETUP_PASSWORD=${SETUP_PASSWORD}

  cd ${SETUP_LOCATION}
EOF

echo "Done!"
reboot