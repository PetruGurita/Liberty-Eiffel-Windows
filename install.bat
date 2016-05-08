@echo off
setlocal enabledelayedexpansion

:: Compile every source individually
for %%i in ( *.c ) do (
    gcc -pipe -O2 -c -x c "%%i"
)

:: Get the number of .o files from the dir listing
for /f "tokens=1" %%A in ('dir *.o^|find "File(s)"') do set o_files=%%A

:: Build a string with all of the .o files (up to 512 due to string length limitations)
for /L %%A in (1,1,!o_files!) do set "o_string=!o_string! compile_to_c%%A.o"

gcc -Xlinker -no-as-needed !o_string! -x none -o compile_to_c

:: Clean the directory
del *.o

strip compile_to_c.exe