set LIB=%LIBRARY_LIB%;.\lib;%LIB%
set LIBPATH=%LIBRARY_LIB%;.\lib;%LIBPATH%
set INCLUDE=%LIBRARY_INC%;%INCLUDE%

dir %LIBRARY_BIN%
dir %LIBRARY_LIB%

copy %LIBRARY_LIB%\zlib.dll %LIBRARY_BIN%
copy %LIBRARY_LIB%\libzstd.dll %LIBRARY_BIN%

copy %LIBRARY_LIB%\z.lib %LIBRARY_BIN%
copy %LIBRARY_LIB%\zdll.lib %LIBRARY_BIN%
copy %LIBRARY_LIB%\zlib.lib %LIBRARY_BIN%
copy %LIBRARY_LIB%\libzstd.lib %LIBRARY_BIN%

pushd . && mkdir build && cd build
if errorlevel 1 exit 1

copy %LIBRARY_BIN%\zlib.dll .
copy %LIBRARY_BIN%\zlib.dll z.dll
copy %LIBRARY_BIN%\libzstd.dll .

cmake -G "%CMAKE_GENERATOR%" ^
    -D CMAKE_BUILD_TYPE=Release ^
    -D CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE ^
    -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -D CMAKE_INSTALL_PREFIX:PATH=%LIBRARY_PREFIX% ^
    %SRC_DIR%
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1

ctest -V --output-on-failure -C Release
if errorlevel 1 exit 1

popd && rd /q /s build
if errorlevel 1 exit 1
