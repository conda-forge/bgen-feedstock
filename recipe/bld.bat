set LIB=%LIBRARY_LIB%;.\lib;%LIB%
set LIBPATH=%LIBRARY_LIB%;.\lib;%LIBPATH%
set INCLUDE=%LIBRARY_INC%;%INCLUDE%

copy %LIBRARY_LIB%\z.lib %LIBRARY_BIN%
copy %LIBRARY_LIB%\zdll.lib %LIBRARY_BIN%
copy %LIBRARY_LIB%\zlib.lib %LIBRARY_BIN%
copy %LIBRARY_LIB%\libzstd.lib %LIBRARY_BIN%

copy %LIBRARY_LIB%\z.lib .
copy %LIBRARY_LIB%\zdll.lib .
copy %LIBRARY_LIB%\zlib.lib .
copy %LIBRARY_LIB%\libzstd.lib .

dir %LIBRARY_BIN%
copy %LIBRARY_BIN%\zlib.dll .

mkdir build
cd build

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
