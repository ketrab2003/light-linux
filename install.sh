#!/bin/sh

# This script should be run via curl:
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ketrab2003/light-linux/master/install.sh)"

# download only neccesary files
curl -fsSL https://raw.githubusercontent.com/ketrab2003/light-linux/master/setup_all.sh > setup_all.sh
curl -fsSL https://raw.githubusercontent.com/ketrab2003/light-linux/master/setup_system.sh > setup_system.sh
curl -fsSL https://raw.githubusercontent.com/ketrab2003/light-linux/master/packages.txt > packages.txt
chmod +x setup_all.sh setup_system.sh

./setup_all.sh