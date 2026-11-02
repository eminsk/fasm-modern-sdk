@echo off
setlocal
echo ==============================================================================
echo [FASM Modern SDK] Full System Self-Build & Verification
echo ==============================================================================

set "ROOT_DIR=%~dp0"
set "FASM_BIN=%ROOT_DIR%bin\fasm.exe"
set "INCLUDE=%ROOT_DIR%include\core"

if not exist "%FASM_BIN%" (
    echo [ERROR] Compiler not found at: %FASM_BIN%
    exit /b 1
)

echo [1/3] Self-compiling FASM Windows binary from source...
pushd "%ROOT_DIR%src\fasm1\WIN32"
"%FASM_BIN%" FASM.ASM "%ROOT_DIR%bin\fasm_verified.exe"
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Self-compilation failed!
    popd
    exit /b 1
)
move /y "%ROOT_DIR%bin\fasm_verified.exe" "%ROOT_DIR%bin\fasm.exe" >nul
popd
echo [OK] Self-compilation verified.

echo [2/3] Building MinimalFluentApp example...
pushd "%ROOT_DIR%examples\MinimalFluentApp"
call build.bat
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] MinimalFluentApp build failed!
    popd
    exit /b 1
)
del MinimalFluentApp.exe >nul 2>&1
popd
echo [OK] MinimalFluentApp passed.

echo [3/3] Building StackOverflowSearchPro flagship example...
pushd "%ROOT_DIR%examples\StackOverflowSearchPro"
call build.bat
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] StackOverflowSearchPro build failed!
    popd
    exit /b 1
)
del StackOverflowSearch.exe >nul 2>&1
popd
echo [OK] StackOverflowSearchPro passed.

echo ==============================================================================
echo [SUCCESS] FASM Modern SDK built and verified successfully!
echo ==============================================================================
