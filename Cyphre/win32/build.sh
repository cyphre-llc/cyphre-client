#!/bin/bash -e

dir="`dirname $0`"
SDIR="$dir/../.."
BDIR="$dir/build"

test -d "$BDIR" || mkdir -p "$BDIR"

if [ "$HOST" != "vagrant" ] || [ "$USER" != "vagrant" ]
then
	# We're running on the host, check if guest is up
	if ! vagrant status 2>&1 | grep -q running
	then
		echo "E: Vagrant VM is not running. Read Vagrant-README for setup."
		exit 1
	fi

	exec vagrant ssh -- /cyphre-client/Cyphre/win32/build.sh
fi

# Assume we are running in the vagrant VM

cd $BDIR

cmake -DOEM_THEME_DIR="$SDIR/Cyphre" \
	-DCMAKE_TOOLCHAIN_FILE="$SDIR/admin/win/Toolchain-mingw32-openSUSE.cmake" \
	"$SDIR"

make -j2

"$SDIR/admin/win/download_runtimes.sh"

make package
