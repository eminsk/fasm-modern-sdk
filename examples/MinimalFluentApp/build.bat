@echo off
setlocal
set "FASM_BIN=%~dp0..\..\bin\fasm.exe"
if not exist "%FASM_BIN%" set "FASM_BIN=C:\asm\hdd\FASM.EXE"
set "INCLUDE=%~dp0..\..\include\core"
if not exist "%INCLUDE%" set "INCLUDE=C:\asm\hdd\INCLUDE"

echo Compiling MinimalFluentApp with FASM...
"%FASM_BIN%" "%~dp0main.asm" "%~dp0MinimalFluentApp.exe"
if %ERRORLEVEL% EQU 0 (
    echo [SUCCESS] Built: MinimalFluentApp.exe
) else (
    echo [ERROR] Build failed!
)
