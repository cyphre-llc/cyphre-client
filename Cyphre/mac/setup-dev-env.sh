#!/bin/bash -ex

# Verifies that Xcode.app is installed
xcode-select -p

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew doctor
brew tap owncloud/owncloud

brew install autoconf automake cmake curl gettext git gnu-sed intltool \
	libffi libtool makedepend openssl pkg-config qt5 readline scons \
	unrar wget xz

brew install qtkeychain

# Install Packages.dmg
TOOLS="Packages.dmg"
echo "Downloading $TOOLS"
curl -o "$TOOLS" \
	"http://s.sudre.free.fr/Software/files/$TOOLS"
TMPMOUNT=`/usr/bin/mktemp -d /tmp/xcode.XXXX`
hdiutil attach "$TOOLS" -mountpoint "$TMPMOUNT"
sudo installer -pkg "$TMPMOUNT/packages/Packages.pkg" -target /
hdiutil detach "$TMPMOUNT"
rm -rf "$TMPMOUNT"
rm -f "$TOOLS"

# Install Sparkle
rm -rf ~/Library/Frameworks/Sparkle.framework
TOOLS="Sparkle-1.8.0.tar.bz2"
echo "Downloading $TOOLS"
TMPMOUNT=`/usr/bin/mktemp -d /tmp/xcode.XXXX`
cd $TMPMOUNT
curl -o "$TOOLS" \
	"https://github.com/sparkle-project/Sparkle/releases/download/1.8.0/$TOOLS"
tar jxfv "$TOOLS"
mkdir -p ~/Library/Frameworks
rsync -av Sparkle.framework ~/Library/Frameworks/
cd ~/
rm -rf "$TMPMOUNT"
