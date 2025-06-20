@echo off
setlocal

:: Define the root of the MATLAB installation
set MATLAB_ROOT=C:\Program Files\MATLAB\R2024a

:: Define paths to specific MATLAB directories needed
set MATLAB_BIN_WIN64=%MATLAB_ROOT%\bin\win64
set MATLAB_RUNTIME_WIN64=%MATLAB_ROOT%\runtime\win64
set MATLAB_EXTERN_BIN_WIN64=%MATLAB_ROOT%\extern\bin\win64
set MATLAB_EXTERN_LIB_WIN64=%MATLAB_ROOT%\extern\lib\win64
:: Define the JAR path without internal quotes. Quotes will be added when used if necessary.
set MATLAB_ENGINE_JAR_PATH=%MATLAB_ROOT%\extern\engines\java\jar\engine.jar

:: Project specific paths
set SRC_DIR=java
set BIN_DIR=bin

:: Add all runtime paths (this is the key fix)
:: These paths should NOT be individually quoted when adding to the PATH variable itself.
:: The OS handles spaces in directory names within the PATH variable.
set PATH=%PATH%;%MATLAB_BIN_WIN64%;%MATLAB_RUNTIME_WIN64%;%MATLAB_EXTERN_BIN_WIN64%;%MATLAB_EXTERN_LIB_WIN64%

:: (Optional) For debugging, show the modified PATH and relevant variables
:: echo MATLAB_ROOT=%MATLAB_ROOT%
:: echo MATLAB_ENGINE_JAR_PATH=%MATLAB_ENGINE_JAR_PATH%
:: echo MATLAB_BIN_WIN64=%MATLAB_BIN_WIN64%
:: echo MATLAB_RUNTIME_WIN64=%MATLAB_RUNTIME_WIN64%
:: echo MATLAB_EXTERN_BIN_WIN64=%MATLAB_EXTERN_BIN_WIN64%
:: echo MATLAB_EXTERN_LIB_WIN64=%MATLAB_EXTERN_LIB_WIN64%
:: echo Updated PATH=%PATH%

:: Create bin folder if needed
if not exist %BIN_DIR% (
    echo Creating directory: %BIN_DIR%
    mkdir %BIN_DIR%
)

:: Compile Java
echo Compiling Java source files...
:: Ensure the classpath argument is quoted if it contains spaces.
javac -cp "%MATLAB_ENGINE_JAR_PATH%" -d %BIN_DIR% %SRC_DIR%\Main.java %SRC_DIR%\loader\*.java %SRC_DIR%\utils\*.java %SRC_DIR%\logic\*.java %SRC_DIR%\output\*.java %SRC_DIR%\simulink\*.java
if errorlevel 1 (
    echo ERROR: Compilation failed.
    goto end_script
)
echo Compilation successful.

:: Run Java with native access enabled
echo Running Java application...
:: The classpath entries %BIN_DIR% and %MATLAB_ENGINE_JAR_PATH% should be quoted if they contain spaces.
:: The entire classpath string "%BIN_DIR%;%MATLAB_ENGINE_JAR_PATH%" is quoted.
java --enable-native-access=ALL-UNNAMED -cp "%BIN_DIR%;%MATLAB_ENGINE_JAR_PATH%" Main
if errorlevel 1 (
    echo ERROR: Java application execution failed.
    goto end_script
)
echo Java application finished successfully.

:end_script
pause
endlocal
