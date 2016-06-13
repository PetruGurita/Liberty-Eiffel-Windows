@echo off
setlocal enabledelayedexpansion

::Check if mingw-64 is installed & environment variable set
@echo Checking requirements...
WHERE gcc --version>nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo Please install mingw-64 compiler
    EXIT /B
)

::Create the configuration file in root HDD + 
::the folder where the binaries will be installed
@echo Preparing the files...

set installation_path=%~dp0
(
    echo [General]
    echo bin: %installation_path%bin
    echo sys: %installation_path%sys
    echo short: %installation_path%short
    echo flavor: Windows
    echo.
    echo [Environment]
    echo path_eiffel: %installation_path%
    echo path_eiffel_core: %installation_path%src\lib
    echo path_eiffel_extra: %installation_path%src\wrappers
    echo path_eiffel_staging: %installation_path%src\staging
    echo path_smarteiffel: %installation_path%src\smarteiffel
    echo path_tools: %installation_path%src\tools
    echo path_tutorial: %installation_path%tutorial
    echo path_work: %installation_path%work
    echo hyphen: -
    echo.
    echo [Loadpath]
    echo eiffel_core: ${path_eiffel_core}\loadpath.se
    echo eiffel_extra: ${path_eiffel_extra}\loadpath.se
    echo eiffel_staging: ${path_eiffel_staging}\loadpath.se
    echo test: ${path_eiffel}\test\loadpath.se
    echo smarteiffel: ${path_smarteiffel}\loadpath.se
    echo tools: ${path_tools}\loadpath.se
    echo tutorial: ${path_tutorial}\loadpath.se
    echo.
    echo [Tools]
    echo ace_check: ace_check
    echo c2c: compile_to_c
    echo c: compile
    echo class_check: class_check
    echo clean: clean
    echo doc: eiffeldoc
    echo find: finder
    echo make: se_make.sh
    echo mock: mock
    echo pretty: pretty
    echo short: short
    echo test: eiffeltest
    echo test_ng: eiffeltest_ng
    echo test_server: eiffeltest_server
    echo wrap: wrappers_generator
    echo x_int: extract_internals
    echo.
    echo [boost]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O2
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -${hyphen}no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe -O2
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -${hyphen}no-as-needed
    echo.
    echo [no_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -${hyphen}no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe -O1
    echo cpp_linker_path: g++
    echo cppecho _linker_options: -Xlinker -${hyphen}no-as-needed
    echo.
    echo [require_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -${hyphen}no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -${hyphen}no-as-needed
    echo.
    echo [ensure_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -${hyphen}no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -${hyphen}no-as-needed
    echo.
    echo [invariant_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -${hyphen}no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -${hyphen}no-as-needed
    echo.
    echo [loop_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -${hyphen}no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -${hyphen}no-as-needed
    echo. 
    echo [all_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -${hyphen}no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -${hyphen}no-as-needed
    echo. 
    echo [debug_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -g -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -${hyphen}no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe -g
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -${hyphen}no-as-needed
    echo smarteiffel_options: -no_strip

) > "C:\Users\%USERNAME%\liberty.cfg"
if not exist "%installation_path%\bin" (
    mkdir bin
)
@echo Starting T1...
:: Compile every source individually
:: poate este stripul de vina
cd resources\smarteiffel-germ
gcc -pipe -O2 -c -x c *.c 
gcc *.o -o compile_to_c
del *.o
strip compile_to_c.exe

mkdir T1
mkdir T2
move /y compile_to_c.exe T1 >nul
cd T1
start /wait compile_to_c.exe -verbose -boost -no_gc compile_to_c -o compile_to_c.new
cd ..
move /y T1\* T2 >nul
move /y T2\compile_to_c.exe T1 >nul
@echo Done

@echo Starting T2...
cd T2
gcc -pipe -O2 -c -x c *.c 
gcc *.o -o compile_to_c
del *.o
strip compile_to_c.exe
mkdir temp
move /y compile_to_c.exe temp >nul
del /F /Q  *.*  
move /y temp\* . >nul
rmdir temp

start /wait compile_to_c.exe -verbose -boost -no_gc compile_to_c -o compile_to_c.new
cd ..
mkdir T3
move /y T2\* T3 >nul
move /y T3\compile_to_c.exe T2 >nul
@echo Done

@echo Starting T3...
cd T3
gcc -pipe -O2 -c -x c *.c 
gcc *.o -o compile_to_c
del *.o
strip compile_to_c.exe
mkdir temp
move /y compile_to_c.exe temp >nul
del /F /Q  *.*  
move /y temp\* . >nul
rmdir temp
@echo Done

cd ..
fc /b T2\compile_to_c.exe T3\compile_to_c.exe > nul
if ERRORLEVEL 1 (
    @echo Please retry the installation process.
    EXIT /B
)
move /y T3\compile_to_c.exe ../../bin >nul
rd /s /q T1\
rd /s /q T2\
rd /s /q T3\


endlocal

pause
