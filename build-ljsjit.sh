#! bash
echo MSYSTEM=$MSYSTEM
echo MSYSTEM_CARCH=$MSYSTEM_CARCH
echo MINGW_PACKAGE_PREFIX=$MINGW_PACKAGE_PREFIX
echo MINGW_PREFIX=$MINGW_PREFIX
rootdir=`pwd`
echo rootdir=$rootdir
sleep 3

pacman -S --needed --noconfirm svn
pacman -S --needed --noconfirm make
pacman -S --needed --noconfirm sed
pacman -S --needed --noconfirm $MINGW_PACKAGE_PREFIX-toolchain

rm -rf ljsjit-$MSYSTEM_CARCH
svn export -r 35 https://github.com/mingodad/ljsjit/trunk ljsjit-$MSYSTEM_CARCH

cd ljsjit-$MSYSTEM_CARCH
make BUILDMODE=static

mkdir -p $rootdir/lua-all
mkdir -p $rootdir/lua-all/bin-$MSYSTEM_CARCH
mkdir -p $rootdir/lua-all/lib/ljsjit-$MSYSTEM_CARCH
cd $rootdir/ljsjit-$MSYSTEM_CARCH
cd src && cp -p libluajit.a libljsjit.a
cd $rootdir/ljsjit-$MSYSTEM_CARCH
cd src && cp -p luajit.exe ljsjit.exe
cd $rootdir/ljsjit-$MSYSTEM_CARCH
cd src && install -p -m 0755 ljsjit $MINGW_PREFIX/bin
cd $rootdir/ljsjit-$MSYSTEM_CARCH
cd src && install -p -m 0755 ljsjit $rootdir/lua-all/bin-$MSYSTEM_CARCH
cd $rootdir/ljsjit-$MSYSTEM_CARCH
cd src && install -p -m 0644 luajit.h lua.h luaconf.h lualib.h lauxlib.h lua.hpp $rootdir/lua-all/lib/ljsjit-$MSYSTEM_CARCH
cd $rootdir/ljsjit-$MSYSTEM_CARCH
cd src && install -p -m 0644 libljsjit.a $rootdir/lua-all/lib/ljsjit-$MSYSTEM_CARCH

cd $rootdir
