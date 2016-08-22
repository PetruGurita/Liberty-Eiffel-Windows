@echo off
setlocal enabledelayedexpansion

set installation_path=%~dp0
(
    echo [General]
    echo bin: !installation_path!bin
    echo sys: !installation_path!sys
    echo short: !installation_path!short
    echo flavor: Windows
    echo.
    echo [Environment]
    echo path_eiffel: !installation_path!
    echo path_eiffel_core: !installation_path!src\lib
    echo path_eiffel_extra: !installation_path!src\wrappers
    echo path_eiffel_staging: !installation_path!src\staging
    echo path_smarteiffel: !installation_path!src\smarteiffel
    echo path_tools: !installation_path!src\tools
    echo path_tutorial: !installation_path!tutorial
    echo path_work: !installation_path!work
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
    echo make: se_make.bat
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
    echo c_linker_options: -Xlinker -no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe -O2
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -no-as-needed
    echo.
    echo [no_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe -O1
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -no-as-needed
    echo.
    echo [require_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -no-as-needed
    echo.
    echo [ensure_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -no-as-needed
    echo.
    echo [invariant_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -no-as-needed
    echo.
    echo [loop_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -no-as-needed
    echo. 
    echo [all_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -no-as-needed
    echo. 
    echo [debug_check]
    echo c_compiler_type: gcc
    echo c_compiler_path: gcc
    echo c_compiler_options: -pipe -g -O1
    echo c_linker_path: gcc
    echo c_linker_options: -Xlinker -no-as-needed
    echo cpp_compiler_type: g++
    echo cpp_compiler_path: g++
    echo cpp_compiler_options: -pipe -g
    echo cpp_linker_path: g++
    echo cpp_linker_options: -Xlinker -no-as-needed
    echo smarteiffel_options: -no_strip

) > "%USERPROFILE%\liberty.cfg" &
    type "%USERPROFILE%\liberty.cfg" >> "%AllUsersProfile%\liberty.cfg"
endlocal