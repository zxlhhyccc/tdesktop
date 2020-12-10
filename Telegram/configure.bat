@echo OFF

setlocal enabledelayedexpansion
set "FullScriptPath=%~dp0"

cd %FullScriptPath%..\..\Libraries
SET LibrariesPath=%cd%
SET "LibrariesPathUnix=%LibrariesPath:\=/%"
cd %FullScriptPath%

python %FullScriptPath%configure.py %* ^
    -DOPENSSL_FOUND=ON ^
    -DOPENSSL_INCLUDE_DIR="%LibrariesPathUnix%/openssl_1_1_1/include" ^
    -DLIB_EAY_LIBRARY_DEBUG="%LibrariesPathUnix%/openssl_1_1_1/out32.dbg/libcrypto.lib" ^
    -DLIB_EAY_LIBRARY_RELEASE="%LibrariesPathUnix%/openssl_1_1_1/out32/libcrypto.lib" ^
    -DSSL_EAY_LIBRARY_DEBUG="%LibrariesPathUnix%/openssl_1_1_1/out32.dbg/libssl.lib" ^
    -DSSL_EAY_LIBRARY_RELEASE="%LibrariesPathUnix%/openssl_1_1_1/out32/libssl.lib" ^
    -DJPEG_INCLUDE_DIR="%LibrariesPathUnix%/mozjpeg" ^
    -DJPEG_LIBRARY_DEBUG="%LibrariesPathUnix%/mozjpeg/Debug/jpeg-static.lib" ^
    -DJPEG_LIBRARY_RELEASE="%LibrariesPathUnix%/mozjpeg/Release/jpeg-static.lib"

if %errorlevel% neq 0 goto error

exit /b

:error
echo FAILED
exit /b 1
