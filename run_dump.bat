@echo off
rem Il2CppDumper (updated fork) - quick launcher
set GAME=E:\Nintendo\Eden\user\sdmc\atmosphere\contents\0100771025398000\romfs\Data2\Managed\Metadata
set OUT=D:\Project\Il2CppDumper\output

if "%~1"=="" (
    set "MAIN=%GAME%\main"
    set "META=%GAME%\global-metadata.dat"
) else (
    set "MAIN=%~1"
    set "META=%~2"
    if "%~3"=="" (set "OUT=%OUT%") else (set "OUT=%~3")
)

if not exist "%OUT%" mkdir "%OUT%"
"D:\Project\Il2CppDumper\publish\Il2CppDumper.exe" "%MAIN%" "%META%" "%OUT%\"
echo.
echo Result in: %OUT%
pause
