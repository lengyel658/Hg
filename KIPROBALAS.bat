@echo off
chcp 65001 >nul
title Futballmenedzser - Kiprobalas
cd /d "%~dp0"
where node >nul 2>nul
if errorlevel 1 ( echo Nincs Node.js telepitve. Nyisd meg: https://nodejs.org & pause & exit /b 1 )
if not exist node_modules ( echo Elso inditas, letoltes... & call npm install --no-audit --no-fund )
call npm start
