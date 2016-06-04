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

) > "C:\liberty.cfg"

::mkdir bin
@echo Starting T1...
cd /d %installation_path%resources\smarteiffel-germ
:: Compile every source individually
for %%i in ( *.c ) do (
    gcc -pipe -O2 -c -x c "%%i"
)
::Get the number of .o files from the dir listing
for /f "tokens=1" %%A in ('dir *.o^|find "File(s)"') do set o_files=%%A
:: Build a string with all of the .o files (up to 512 due to string length limitations)
for /L %%A in (1,1,!o_files!) do set "o_string=!o_string! compile_to_c%%A.o"

gcc -Xlinker -no-as-needed !o_string! -x none -o compile_to_c
:: Clean the directory
del *.o
strip compile_to_c.exe
mkdir T1
move /y compile_to_c.exe T1
cd T1
start compile_to_c.exe -verbose -boost -no_gc compile_to_c -o compile_to_c.new
cd ..
mkdir T2
move /y T1\* T2 >nul
move /y T2\compile_to_c.exe T1

@echo Starting T2...
cd T2
for %%i in ( *.c ) do (
    gcc -pipe -O2 -c -x c "%%i"
)
for /f "tokens=1" %%A in ('dir *.o^|find "File(s)"') do set o_files=%%A
for /L %%A in (1,1,!o_files!) do set "o_string=!o_string! compile_to_c%%A.o"
gcc -Xlinker -no-as-needed !o_string! -x none -o compile_to_c
strip compile_to_c.exe
mkdir temp
move /y compile_to_c.exe temp >nul
del /F /Q  *.*  
move /y temp\* . >nul
rmdir temp
start compile_to_c.exe -verbose -boost -no_gc compile_to_c -o compile_to_c.new
cd ..
mkdir T3
move /y T2\* T3 >nul
move /y T3\compile_to_c.exe T2 >nul

@echo Starting T3...
cd T3
for %%i in ( *.c ) do (
    gcc -pipe -O2 -c -x c "%%i"
)
for /f "tokens=1" %%A in ('dir *.o^|find "File(s)"') do set o_files=%%A
for /L %%A in (1,1,!o_files!) do set "o_string=!o_string! compile_to_c%%A.o"
gcc -Xlinker -no-as-needed !o_string! -x none -o compile_to_c
strip compile_to_c.exe
mkdir temp
move /y compile_to_c.exe temp >nul
del /F /Q  *.*  
move /y temp\* . >nul
rmdir temp
endlocal

pause
