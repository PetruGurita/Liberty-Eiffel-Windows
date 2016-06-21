@echo off
setlocal enabledelayedexpansion
set CHECK_LEVEL=-require_check
set DIR=require
set DEBUG=false
set SEDB=false
set NOGC=false
set BDWGC=false
set OPTIONS=''
set TOOL=compile_to_c
set BUILD=true
set GDB=false

set SE_BIN=%~dp0
for %%I in (%*) DO 	(
	if "%%I" == "-no_check" (
		set CHECK_LEVEL=%%I
		set DIR=no
	)
	if "%%I" == "-require_check" (
		set CHECK_LEVEL=%%I
		set DIR=require
	)
	if "%%I" == "-ensure_check" (
		set CHECK_LEVEL=%%I
		set DIR=ensure
	)
	if "%%I" == "-no_check" (
		set CHECK_LEVEL=%%I
		set DIR=no
	)
    if "%%I" == "-invariant_check" (
		set CHECK_LEVEL=%%I
		set DIR=invariant
	)
    if "%%I" == "-loop_check" (
		set CHECK_LEVEL=%%I
		set DIR=loop
	)
    if "%%I" == "-all_check" (
		set CHECK_LEVEL=%%I
		set DIR=all
	)
	if "%%I" == "-boost" (
		set CHECK_LEVEL=%%I
		set DIR=boost
	)
	if "%%I" == "-debug" (
		set CHECK_LEVEL=%%I
		set DEBUG=true
	)
)
endlocal
