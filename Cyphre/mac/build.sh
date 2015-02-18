#!/bin/bash -ex

SDIR="`pwd`/../.."
BDIR="`pwd`/build"

# Do not build with 10.10 until neon conflict is resolved
SDK="10.9"

rm -rf "$BDIR"
mkdir -p "$BDIR"

cd "$BDIR"

rm -rf "../install"

# Use brew's openssl, and qt5
export PATH="/usr/local/Cellar/qt5/5.4.0/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

cmake -DCMAKE_CXX_FLAGS="--sysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${SDK}.sdk" \
	-DOEM_THEME_DIR="$SDIR/Cyphre" -DCMAKE_INSTALL_PREFIX=../install \
	"$SDIR"

make -j6

make install

./admin/osx/create_mac.sh ../install . 'Developer ID Installer: Benjamin Collins (VJAD6F74WN)'
