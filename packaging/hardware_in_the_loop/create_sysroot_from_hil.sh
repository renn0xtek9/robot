#!/bin/bash
set -euxo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

MACHINE=max@hectorindialima1
PACKAGE_NAME="hil-sysroot"
BUILD_DIR="/tmp/$PACKAGE_NAME"
mkdir -p "$BUILD_DIR"
cp -r "$DIR"/"$PACKAGE_NAME"/* "$BUILD_DIR"

SYSROOT_DEST="$BUILD_DIR"/"$PACKAGE_NAME"/debian/"$PACKAGE_NAME"
mkdir -p "$SYSROOT_DEST"
rsync -avz $MACHINE:/usr "$SYSROOT_DEST"
rsync -avz $MACHINE:/lib "$SYSROOT_DEST"
rsync -avz $MACHINE:/opt "$SYSROOT_DEST"

cd "$BUILD_DIR"
dpkg-buildpackage -us -uc

PACKAGE_FILE="$(find "$(dirname "$BUILD_DIR")" -maxdepth 1 -type f -name "${PACKAGE_NAME}_*.deb" -print -quit)"
if [[ -z "$PACKAGE_FILE" ]]; then
	echo "No Debian package was created for $PACKAGE_NAME" >&2
	exit 1
fi
echo Created debian package for sysroot: "$PACKAGE_FILE"
scp "$PACKAGE_FILE" max@charlieindia1:/var/www/packages/incoming
