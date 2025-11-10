@echo off
:: =========================================================
:: FBS-Terminal - Version corrigée sans horloge
:: =========================================================
setlocal enabledelayedexpansion
set "AUTH_PASSWORD=fsb2025"
set "LOGFILE=%~dp0FBS-Terminal-Log.txt"
set "WINDOW_TITLE=FBS-Console"
set "NET_IFACE=Ethernet"
mode con: cols=100 lines=38
title %WINDOW_TITLE%
color 0B
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Relancement en mode administrateur requis...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)
cls
echo =============================================================
echo              FBS-Console - Acces securise
echo =============================================================
echo.

for /f "usebackq delims=" %%P in (`powershell -NoProfile -Command ^
  "$p = Read-Host -AsSecureString -Prompt 'Mot de passe d''acces';" ^
  "[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($p)).Trim()"`) do set "USERPASS=%%P"

if /i not "%USERPASS%"=="%AUTH_PASSWORD%" (
    echo.
    echo [ERREUR] Mauvais mot de passe.
    echo [%date% %time%] Acces echoue >> "%LOGFILE%"
    pause
    exit /b
)

echo.
echo [OK] Authentification reussie.
echo [%date% %time%] Connexion autorisee >> "%LOGFILE%"
timeout /t 1 >nul

:: ---------- MENU PRINCIPAL ----------
:MENU
cls
echo =============================================================
echo                  FBS-Console - Menu Principal
echo =============================================================
echo [1] Informations systeme
echo [2] IP locale
echo [3] IP publique
echo [4] Ping d'un hote
echo [5] Nettoyer fichiers temporaires
echo [6] Vider cache Windows Update
echo [7] Flush DNS
echo [8] SFC /scannow
echo [9] DISM /RestoreHealth
echo [10] Defragmenter lecteur C:
echo [11] Nettoyage disque (cleanmgr)
echo [12] Optimisation rapide
echo [13] Optimisation reseau (Ethernet)
echo [14] Creer un point de restauration
echo [15] Afficher le log
echo [0] Quitter
echo =============================================================
set /p choix="Choix > "

if "%choix%"=="1" goto SYSINFO
if "%choix%"=="2" goto IPLOCAL
if "%choix%"=="3" goto IPPUB
if "%choix%"=="4" goto PING
if "%choix%"=="5" goto CLEAN_TEMP
if "%choix%"=="6" goto CLEAN_WU
if "%choix%"=="7" goto FLUSH_DNS
if "%choix%"=="8" goto SFC
if "%choix%"=="9" goto DISM
if "%choix%"=="10" goto DEFRAG
if "%choix%"=="11" goto CLEANMGR
if "%choix%"=="12" goto QUICK_OPT
if "%choix%"=="13" goto NET_OPTIM_ETH
if "%choix%"=="14" goto CREATE_RP
if "%choix%"=="15" goto SHOWLOG
if "%choix%"=="0" goto QUIT
goto MENU
:SYSINFO
cls
systeminfo | findstr /B /C:"Nom de l'hote" /C:"OS Name" /C:"Version" /C:"Type du systeme"
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors,LoadPercentage
wmic os get TotalVisibleMemorySize,FreePhysicalMemory
wmic logicaldisk get DeviceID,Size,FreeSpace,FileSystem
pause
goto MENU

:IPLOCAL
cls
ipconfig | findstr /i "IPv4"
pause
goto MENU

:IPPUB
cls
for /f "delims=" %%A in ('powershell -NoProfile -Command "(Invoke-RestMethod -Uri 'https://ipinfo.io/ip' -UseBasicParsing).Trim()"') do set "PUBIP=%%A"
echo Adresse IP publique : %PUBIP%
pause
goto MENU

:PING
cls
set /p host="Adresse a tester > "
if "%host%"=="" goto MENU
ping -n 5 %host%
pause
goto MENU

:CLEAN_TEMP
cls
echo Nettoyage fichiers temporaires...
rd /s /q "%temp%" 2>nul
md "%temp%"
rd /s /q "C:\Windows\Temp" 2>nul
md "C:\Windows\Temp"
echo Terminé.
pause
goto MENU

:CLEAN_WU
cls
echo Vidage du cache Windows Update...
net stop wuauserv
net stop bits
rd /s /q "C:\Windows\SoftwareDistribution\Download"
md "C:\Windows\SoftwareDistribution\Download"
net start bits
net start wuauserv
echo OK.
pause
goto MENU

:FLUSH_DNS
cls
ipconfig /flushdns
pause
goto MENU

:SFC
cls
sfc /scannow
pause
goto MENU

:DISM
cls
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto MENU

:DEFRAG
cls
defrag C: /O
pause
goto MENU

:CLEANMGR
cls
cleanmgr
pause
goto MENU

:QUICK_OPT
cls
ipconfig /flushdns
rd /s /q "%temp%"
md "%temp%"
net stop wuauserv
net stop bits
rd /s /q "C:\Windows\SoftwareDistribution\Download"
md "C:\Windows\SoftwareDistribution\Download"
net start bits
net start wuauserv
DISM /Online /Cleanup-Image /RestoreHealth
echo Optimisation rapide terminee.
pause
goto MENU

:NET_OPTIM_ETH
cls
echo Optimisation reseau Ethernet...
ipconfig /flushdns
netsh int ip reset
netsh winsock reset
netsh interface ip delete arpcache
netsh interface ip set dns name="%NET_IFACE%" static 1.1.1.1 primary
netsh interface ip add dns name="%NET_IFACE%" 1.0.0.1 index=2
echo Optimisation terminee (redemarrage recommande).
pause
goto MENU

:CREATE_RP
cls
powershell -NoProfile -Command "Checkpoint-Computer -Description 'FBS-Terminal Backup' -RestorePointType 'MODIFY_SETTINGS'"
pause
goto MENU

:SHOWLOG
cls
type "%LOGFILE%" 2>nul || echo Aucun log.
pause
goto MENU

:QUIT
cls
echo Fermeture...
timeout /t 1 >nul
exit /b

