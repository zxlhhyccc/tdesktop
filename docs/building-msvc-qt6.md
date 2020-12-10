

git clone https://github.com/webmproject/libwebp.git
cd libwebp
git checkout v1.1.0
mkdir build
cd build
cmake .. ^
    -G "Visual Studio 16 2019" ^
    -A Win32 ^
    -D CMAKE_INSTALL_PREFIX=%LibrariesPath%/WebP
cmake --build . --config Debug --parallel
cmake --build . --config Release --parallel
cmake --install .
cd ..

SET LibrariesPath=%cd%
SET "LibrariesPathUnix=%LibrariesPath:\=/%"
git clone git://code.qt.io/qt/qt5.git qt_6_0_0
cd qt_6_0_0
git checkout v6.0.0
perl init-repository --module-subset=qtbase,qtimageformats,qt5compat
cd qtbase
for /r %i in (..\..\patches\qtbase_6_0_0\*) do git apply %i
cd ..
cd qtimageformats
for /r %i in (..\..\patches\qtimageformats_6_0_0\*) do git apply %i
cd ..

mkdir build
cd build

..\configure ^
    -prefix "%LibrariesPathUnix%/Qt-6.0.0" ^
    -debug-and-release ^
    -force-debug-info ^
    -opensource ^
    -confirm-license ^
    -static ^
    -static-runtime ^
    -no-opengl ^
    -openssl-linked ^
    -nomake examples ^
    -nomake tests ^
    -platform win32-msvc ^
    -- ^
    -DOPENSSL_FOUND=ON ^
    -DOPENSSL_INCLUDE_DIR="%LibrariesPathUnix%/openssl_1_1_1/include" ^
    -DLIB_EAY_LIBRARY_DEBUG="%LibrariesPathUnix%/openssl_1_1_1/out32.dbg/libcrypto.lib" ^
    -DLIB_EAY_LIBRARY_RELEASE="%LibrariesPathUnix%/openssl_1_1_1/out32/libcrypto.lib" ^
    -DSSL_EAY_LIBRARY_DEBUG="%LibrariesPathUnix%/openssl_1_1_1/out32.dbg/libssl.lib" ^
    -DSSL_EAY_LIBRARY_RELEASE="%LibrariesPathUnix%/openssl_1_1_1/out32/libssl.lib" ^
    -DJPEG_INCLUDE_DIR="%LibrariesPathUnix%/mozjpeg" ^
    -DJPEG_LIBRARY_DEBUG="%LibrariesPathUnix%/mozjpeg/Debug/jpeg-static.lib" ^
    -DJPEG_LIBRARY_RELEASE="%LibrariesPathUnix%/mozjpeg/Release/jpeg-static.lib" ^
    -DWebP_DIR="%LibrariesPathUnix%/WebP/share/WebP/cmake"
    
    cmake --build . --parallel
    cmake --install
