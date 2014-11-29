
CORRECTED_MSYS_BIN_PATH=`echo $DUST_MSYS_BIN | $DUST_MSYS_BIN/sed 's/C:/\/c/'`

#MAKE SURE MSYS EXECUTABLES COME FIRST WHEN RUNNING CONFIGURE SCRIPT (--> avoids conflicts with other "unix on windows" installations)
PATH=$CORRECTED_MSYS_BIN_PATH:$PATH

./configure CC=$DUST_GCC MAKE=$DUST_MAKE --prefix=$FFTW3_INSTALL_PREFIX --host=i686-w64-mingw32 --build=i686-w64-mingw32 --with-our-malloc16 --with-windows-f77-mangling --enable-shared --disable-static --enable-threads --with-combined-threads --enable-portable-binary --enable-sse2 --with-incoming-stack-boundary=2 #--enable-float

$DUST_MAKE -j8

$DUST_MAKE install