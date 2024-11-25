setlocal
@echo off

mkdir build 2> NUL
mkdir build\asm 2> NUL
mkdir build\bin 2> NUL

pushd build

set PATH=..\tools\cvbasic;%PATH%

del *.bas
copy /Y ..\src\*.bas .


:: TI-99
cvbasic --ti994a pico9918tool.bas asm\pico9918tool_ti99.a99 lib
call assm asm/pico9918tool_ti99.a99
if %errorlevel% neq 0 exit /b %errorlevel%
linkticart.py pico9918tool_ti99_b00.bin bin\pico9918tool_ti99_8.bin "PICO9918 CONFIG TOOL"
copy /Y bin\pico9918tool_ti99_8.bin c:\tools\Classic99

:: ColecoVision
cvbasic pico9918tool.bas asm\pico9918tool_cv.asm lib
gasm80 asm\pico9918tool_cv.asm -o bin\pico9918tool_cv.rom
copy /Y bin\pico9918tool_cv.rom c:\tools\Classic99Phoenix

:: MSX
cvbasic --msx pico9918tool.bas asm\pico9918tool_msx.asm lib
gasm80 asm\pico9918tool_msx.asm -o bin\pico9918tool_msx.rom


popd