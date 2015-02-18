#!/bin/bash -e

dir="`dirname $0`"
SDIR="$dir/.."
BDIR="$dir/build-win32"

test -d "$BDIR" || mkdir -p "$BDIR"

if [ "$HOST" != "vagrant" ] || [ "$USER" != "vagrant" ]
then
	# We're running on the host, check if guest is up
	if ! vagrant status 2>&1 | grep -q running
	then
		echo "E: Vagrant VM is not running. Read Vagrant-README for setup."
		exit 1
	fi

	# The guest share skews timestamps and confuses Git
	GITREV="`git rev-parse --verify --short HEAD`"

	if git diff-index --name-only HEAD | read dummy; then
		GITREV="${GITREV}-dirty"
	fi

	echo "$GITREV" > "$BDIR/.gitrev"

	exec vagrant ssh -- /srv/cyphre-client/Cyphre/build-win32.sh
fi

# Assume we are running in the vagrant VM

cd $BDIR

GITREV="`cat $BDIR/.gitrev`"

cmake -DMIRALL_VERSION_SUFFIX="-$GITREV" -DOEM_THEME_DIR="$SDIR/Cyphre" \
	-DCMAKE_TOOLCHAIN_FILE="$SDIR/admin/win/Toolchain-mingw32-openSUSE.cmake" \
	-DCMAKE_BUILD_TYPE="Debug" "$SDIR"

make -j2

"$SDIR/admin/win/download_runtimes.sh"

make package
