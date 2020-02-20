#/usr/bin/env bash

OPERATING_SYSTEM=""
OPERATING_SYSTEM_VERSION=""

# Functions
check_operating_system() {
    if [[ -e /etc/centos-release ]];then
        # CentOS
        OPERATING_SYSTEM=$(cat /etc/centos-release | awk '{print $1}')
        OPERATING_SYSTEM_VERSION=$(cat /etc/centos-release | awk '{print $4}' | awk -F . '{print $1}')
    elif [[ -e /etc/issue ]];then
        # Ubuntu or Debian or unsupported
        OPERATING_SYSTEM=$(cat /etc/issue | awk '{print $1}')
        if [[ $OPERATING_SYSTEM == 'Ubuntu' ]];then
            # Ubuntu
            OPERATING_SYSTEM_VERSION=$(cat /etc/issue | awk '{print $2}' | awk -F . '{print $1}')
        elif [[ $OPERATING_SYSTEM == 'Debian' ]];then
            # Debian
            OPERATING_SYSTEM_VERSION=$(cat /etc/issue | awk '{print $3}' | awk -F . '{print $1}')
        else
            # Unsupported
            OPERATING_SYSTEM_VERSION='Unsupported'
        fi
    else
        # macOS or unsupported OS
        OPERATING_SYSTEM=$(uname -a | awk '{print $1}')
        OPERATING_SYSTEM_VERSION=$(uname -a | awk '{print $3}' | awk -F . '{print $1}')
    fi
}