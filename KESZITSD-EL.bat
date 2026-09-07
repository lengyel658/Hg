@echo off
chcp 65001 >nul
title Futballmenedzser - EXE keszites
color 0E
cd /d "%~dp0"

echo.
echo  ================================================
echo    FUTBALLMENEDZSER - EXE KESZITESE
echo  ================================================
echo.

where node >nul 2>nul
if errorlevel 1 (
  color 0C
  echo  [HIBA] Nincs telepitve a Node.js.
  echo.
  echo  1^) Nyisd meg: https://nodejs.org
  echo  2^) Toltsd le az LTS valtozatot es telepitsd.
  echo  3^) Utana futtasd ujra ezt a fajlt.
  echo.
  start https://nodejs.org
  pause
  exit /b 1
)

for /f "tokens=*" %%v in (\x27node -v\x27) do set NODEV=%%v
echo  Node.js megtalalva: %NODEV%
echo.

if not exist node_modules (
  echo  [1/2] Szukseges reszek letoltese... ez 3-6 percig tarthat.
  echo        Kb. 250 MB-ot tolt le. Ne zard be az ablakot!
  echo.
  call npm install --no-audit --no-fund
  if errorlevel 1 (
    color 0C
    echo.
    echo  [HIBA] A letoltes nem sikerult. Ellenorizd az internetkapcsolatot.
    pause
    exit /b 1
  )
) else (
  echo  [1/2] A szukseges reszek mar megvannak, kihagyva.
)

echo.
echo  [2/2] EXE keszitese... ez 1-3 percig tart.
echo.
call npm run exe
if errorlevel 1 (
  color 0C
  echo.
  echo  [HIBA] A forditas nem sikerult.
  pause
  exit /b 1
)

color 0A
echo.
echo  ================================================
echo    KESZ!
echo  ================================================
echo.
echo  Az EXE fajl itt talalhato:
echo  %cd%\kesz
echo.
if exist kesz start "" "kesz"
pause
