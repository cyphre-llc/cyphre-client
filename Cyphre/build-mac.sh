#!/bin/bash -e

SDK="10.9"

SDIR="`pwd`/.."
BDIR="`pwd`/build-mac"

test -d "$BDIR" || mkdir -p "$BDIR"

cd "$BDIR"

GITREV="`git rev-parse --verify --short HEAD`"

if git diff-index --name-only HEAD | read dummy; then
	GITREV="${GITREV}-dirty"
fi

export PATH="/usr/local/Cellar/qt5/5.4.0/bin:/usr/local/Cellar/neon/0.30.0_1/bin:$PATH"
export PKG_CONFIG_PATH="/usr/local/opt/neon/lib/pkgconfig"

cmake -DCMAKE_CXX_FLAGS="--sysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX${SDK}.sdk" \
	-DMIRALL_VERSION_SUFFIX="-$GITREV" -DOEM_THEME_DIR="$SDIR/Cyphre" -DCMAKE_BUILD_TYPE="Debug" -DCMAKE_INSTALL_PREFIX=../install "$SDIR"
make -j8

make install

./admin/osx/create_mac.sh ../install . 'Developer ID Installer: Benjamin Collins (VJAD6F74WN)'
