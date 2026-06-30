@echo off
REM Windows batch script to compile and run simulation using Icarus Verilog (iverilog)
REM and automatically open GTKWave if installed.

echo =======================================================================
echo               Metastability CDC Simulation Runner (Windows)
echo =======================================================================

where iverilog >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] Icarus Verilog (iverilog) was not found in your PATH.
    echo Please install it from http://bleyer.org/icarus/ and add it to your environment variables.
    exit /b 1
)

echo.
echo [1/4] Compiling Unsafe Design (Unsynchronized CDC)...
iverilog -o sim_unsafe.vvp ..\rtl\metastability_unsafe.v ..\tb\tb_metastability_unsafe.v
if %errorlevel% neq 0 (
    echo [ERROR] Compilation of Unsafe design failed!
    exit /b 1
)

echo [2/4] Running Unsafe Simulation...
vvp sim_unsafe.vvp
if %errorlevel% neq 0 (
    echo [ERROR] Unsafe simulation execution failed!
    exit /b 1
)

echo.
echo [3/4] Compiling Safe Design (Synchronized CDC)...
iverilog -o sim_safe.vvp ..\rtl\metastability_safe.v ..\tb\tb_metastability_safe.v
if %errorlevel% neq 0 (
    echo [ERROR] Compilation of Safe design failed!
    exit /b 1
)

echo [4/4] Running Safe Simulation...
vvp sim_safe.vvp
if %errorlevel% neq 0 (
    echo [ERROR] Safe simulation execution failed!
    exit /b 1
)

echo.
echo =======================================================================
echo Simulations completed successfully!
echo Waveforms dumped:
echo  - metastability_unsafe.vcd
echo  - metastability_safe.vcd
echo =======================================================================
echo.

where gtkwave >nul 2>nul
if %errorlevel% eq 0 (
    echo [INFO] GTKWave found. Launching waveforms...
    echo Launching Unsafe design waveform...
    start gtkwave metastability_unsafe.vcd
    echo Launching Safe design waveform...
    start gtkwave metastability_safe.vcd
) else (
    echo [INFO] GTKWave not found in PATH. Please open the VCD files manually in GTKWave.
)

pause
