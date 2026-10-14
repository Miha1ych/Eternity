@echo off
chcp 65001 >nul
title Eternity 1.0
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Eternity.ps1"
