
@rem Clean previous build
if exist dist\windows rmdir /s /q dist\windows

cd luajit\src
call msvcbuild.bat lua52compat static
cd ..\..

@rem Create distribution directory structure

if not exist dist mkdir dist
mkdir dist\windows
mkdir dist\windows\bin
mkdir dist\windows\lib
mkdir dist\windows\include
mkdir dist\windows\include\luajit-2.1
mkdir dist\windows\share
mkdir dist\windows\share\lua
mkdir dist\windows\share\lua\5.1
mkdir dist\windows\share\lua\5.1\jit

@rem Copy build results
copy luajit\src\luajit.exe dist\windows\bin\
copy luajit\src\lua51.lib dist\windows\lib\
copy luajit\src\lua.h dist\windows\include\luajit-2.1\
copy luajit\src\lualib.h dist\windows\include\luajit-2.1\
copy luajit\src\lauxlib.h dist\windows\include\luajit-2.1\
copy luajit\src\luaconf.h dist\windows\include\luajit-2.1\
copy luajit\src\luajit.h dist\windows\include\luajit-2.1\
copy luajit\src\lua.hpp dist\windows\include\luajit-2.1\

xcopy luajit\src\jit\*.lua dist\windows\share\lua\5.1\jit\ /I /Y

@echo.
@echo === Build results copied to dist\windows ===
