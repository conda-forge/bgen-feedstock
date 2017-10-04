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

mkdir build
cd build

copy %LIBRARY_BIN%\zlib.dll .
copy %LIBRARY_BIN%\zlib.dll z.dll
copy %LIBRARY_BIN%\libzstd.dll .

cmake -G "NMake Makefiles" ^
         -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=TRUE ^
         -DCMAKE_INSTALL_PREFIX:PATH=%PREFIX% ^
         %SRC_DIR%
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

ctest
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
