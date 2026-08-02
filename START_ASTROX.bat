@echo off
setlocal EnableExtensions DisableDelayedExpansion
chcp 65001 >nul
title DERO AstroX Miner 1.0.0

set "MINER=%~dp0dero-astrox-miner.exe"
if not exist "%MINER%" (
  echo.
  echo ERROR: No se encontro dero-astrox-miner.exe junto a este archivo.
  echo.
  pause
  exit /b 1
)

echo ========================================
echo   DERO ASTROX MINER 1.0.0
echo   DOMINATING THE COMPETITION
echo ========================================
echo   DEV FEE: 10%% - 10 min DEV / 90 min USER
echo.

set "ASTROX_URL="
set /p "ASTROX_URL=URL del nodo o pool principal: "
if not defined ASTROX_URL goto :missing

set "ASTROX_WALLET="
set /p "ASTROX_WALLET=Wallet DERO del usuario: "
if not defined ASTROX_WALLET goto :missing

set "ASTROX_PASSWORD="
set /p "ASTROX_PASSWORD=Password del pool [x]: "
if not defined ASTROX_PASSWORD set "ASTROX_PASSWORD=x"

set "ASTROX_DEFAULT_THREADS=%NUMBER_OF_PROCESSORS%"
if not defined ASTROX_DEFAULT_THREADS set "ASTROX_DEFAULT_THREADS=22"
if %ASTROX_DEFAULT_THREADS% GTR 22 set "ASTROX_DEFAULT_THREADS=22"
set "ASTROX_THREADS="
set /p "ASTROX_THREADS=Threads [%ASTROX_DEFAULT_THREADS%]: "
if not defined ASTROX_THREADS set "ASTROX_THREADS=%ASTROX_DEFAULT_THREADS%"

set "ASTROX_BACKUP="
set /p "ASTROX_BACKUP=URL de respaldo [opcional]: "

echo.
echo Configuracion:
echo   Principal: %ASTROX_URL%
if defined ASTROX_BACKUP echo   Respaldo:  %ASTROX_BACKUP%
echo   Wallet:    %ASTROX_WALLET%
echo   Threads:   %ASTROX_THREADS%
echo   Dev fee:   10%%
echo.
choice /C SN /N /M "Iniciar mineria? [S/N]: "
if errorlevel 2 exit /b 0

echo.
if defined ASTROX_BACKUP (
  "%MINER%" -o "%ASTROX_URL%" -B "%ASTROX_BACKUP%" -u "%ASTROX_WALLET%" -p "%ASTROX_PASSWORD%" -t "%ASTROX_THREADS%"
) else (
  "%MINER%" -o "%ASTROX_URL%" -u "%ASTROX_WALLET%" -p "%ASTROX_PASSWORD%" -t "%ASTROX_THREADS%"
)
set "ASTROX_EXIT=%ERRORLEVEL%"
echo.
echo El minero termino con codigo %ASTROX_EXIT%.
pause
exit /b %ASTROX_EXIT%

:missing
echo.
echo URL principal y wallet son obligatorias. No se inicio la mineria.
pause
exit /b 1
