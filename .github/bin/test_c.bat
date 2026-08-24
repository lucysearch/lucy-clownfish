call "C:\Program Files\Microsoft Visual Studio\18\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64

cd compiler\c
call configure.bat || exit /b 1
nmake || exit /b 1
nmake test || exit /b 1

cd ..\..\runtime\c
call configure.bat || exit /b 1
nmake || exit /b 1
nmake test || exit /b 1
