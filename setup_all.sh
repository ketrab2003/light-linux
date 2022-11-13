#!/bin/sh

export SETUP_DRIVE=/dev/sda
export SETUP_USERNAME=ketrab
export SETUP_PASSWORD=1
export SETUP_LOCATION=/home/${SETUP_USERNAME}/system_config  # absolute path, in new filesystem

exec ./setup_system.sh

# copy all installation files to new system
mkdir -p /mnt${SETUP_LOCATION}
cp -r * /mnt${SETUP_LOCATION}/

arch-chroot /mnt /bin/bash <<EOF
  export SETUP_USERNAME=${SETUP_USERNAME}
  export SETUP_PASSWORD=${SETUP_PASSWORD}
  export SETUP_LOCATION=${SETUP_LOCATION}

  cd ${SETUP_LOCATION}

  exec ./setup_awesome.sh
EOF

echo "Done all!"
reboot