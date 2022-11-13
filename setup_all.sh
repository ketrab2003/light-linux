#!/bin/sh

set -a
export SETUP_DRIVE=/dev/sda
export SETUP_USERNAME=ketrab
export SETUP_PASSWORD=1
export SETUP_LOCATION=/home/${SETUP_USERNAME}/system_config  # absolute path, in new filesystem

./setup_system.sh

arch-chroot /mnt /bin/bash <<EOF
  export SETUP_USERNAME=${SETUP_USERNAME}
  export SETUP_PASSWORD=${SETUP_PASSWORD}
  export SETUP_LOCATION=${SETUP_LOCATION}

  mkdir -p ${SETUP_LOCATION}
  git clone https://github.com/ketrab2003/light-linux ${SETUP_LOCATION}
  cd ${SETUP_LOCATION}

  ./setup_awesome.sh
  ./setup_zsh.sh

  chown -R "${SETUP_USERNAME}":"${SETUP_USERNAME}" /home/${SETUP_USERNAME}
EOF

echo "Done all!"
reboot