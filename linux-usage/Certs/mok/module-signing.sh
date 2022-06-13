#!/usr/bin/env bash

KEY_NAME="MOK.priv"
DER_NAME="MOK.der"
SIGNFILE="/usr/src/kernels/$(uname -r)/scripts/sign-file"

function create_cert()
{
    echo "Create cert"
    openssl req -new -x509 -newkey rsa:2048 -keyout $KEY_NAME \
        -outform DER -out $DER_NAME -nodes -days 36500 \
        -subj "/CN=Private Driver Signing"

    mokutil --import $DER_NAME
}

function signing()
{
    local readonly hash_algo='sha256'
    local readonly key=$KEY_NAME
    local readonly x509=$DER_NAME

    local readonly name="$(basename $0)"
    local readonly esc='\e'
    local readonly reset="${esc}[0m"

    green() { local string="${1}"; echo "${esc}[32m${string}${reset}"; }
    blue() { local string="${1}"; echo "${esc}[34m${string}${reset}"; }
    log() { local string="${1}"; echo "[$(blue $name)] ${string}"; }


    [ -z "${KBUILD_SIGN_PIN}" ] && read -p "Passphrase for ${key}: " \
        KBUILD_SIGN_PIN
    export KBUILD_SIGN_PIN

    echo "sign-file"
    $SIGNFILE "${hash_algo}" "${key}" "${x509}" \
        "/lib/modules/$(uname -r)/extra/VirtualBox/vboxdrv.ko"

    $SIGNFILE "${hash_algo}" "${key}" \
        "${x509}" "/lib/modules/$(uname -r)/extra/VirtualBox/vboxnetflt.ko"

    $SIGNFILE "${hash_algo}" "${key}" "${x509}" \
        "/lib/modules/$(uname -r)/extra/VirtualBox/vboxnetadp.ko"
}

# start from here
if [ ! -e $DER_NAME ]
then
    create_cert
fi
signing
