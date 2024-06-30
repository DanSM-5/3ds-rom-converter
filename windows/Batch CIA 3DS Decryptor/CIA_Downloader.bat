@echo off
mode con cols=52 lines=26
title CIA Downloader
SetLocal EnableDelayedExpansion

:menu
cls
set INPUT=0
echo.
set /p INPUT=Enter the Title ID of the Game:
call :STRLEN %INPUT%, LEN
if %LEN%==16 goto CETK
echo.
echo Please Enter a Valid ID, eg. 0004000000030800 or 0004000000040a00, Enter to Continue.
pause >nul
goto menu

:STRLEN string len
REM https://www.dostips.com/forum/viewtopic.php?t=1485
set "token=#%~1" & set "len=0"
for /L %%a in (12,-1,0) do (
	set/a "len|=1<<%%a"
	for %%i in (!len!) do if "!token:~%%i,1!"=="" set/A "len&=~1<<%%a"
)
set %~2=%len%
exit/B

:ERROR
cls
echo.
echo Download failed, please press any key to finish.
goto Finished

:CETK
cls
echo.
echo Checking...
aria2c http://nus.cdn.c.shop.nintendowifi.net/ccs/download/%INPUT%/cetk --dir=./%INPUT% --allow-overwrite=true --conf-path=aria2.conf >nul
if %errorlevel%==0 goto TMD
aria2c http://ccs.cdn.c.shop.nintendowifi.net/ccs/download/%INPUT%/cetk --dir=./%INPUT% --allow-overwrite=true --conf-path=aria2.conf >nul
if %errorlevel%==0 goto TMD
aria2c http://3DS.titlekeys.gq/ticket/%INPUT% --dir=./%INPUT% --out=cetk --allow-overwrite=true --conf-path=aria2.conf >nul
if not %errorlevel%==0 goto ERROR

:TMD
aria2c http://nus.cdn.c.shop.nintendowifi.net/ccs/download/%INPUT%/tmd --dir=./%INPUT% --allow-overwrite=true --conf-path=aria2.conf >nul
if %errorlevel%==0 goto DownloadCIA
aria2c http://ccs.cdn.c.shop.nintendowifi.net/ccs/download/%INPUT%/tmd --dir=./%INPUT% --allow-overwrite=true --conf-path=aria2.conf >nul
if not %errorlevel%==0 goto ERROR

:DownloadCIA
ctrtool -t tmd ./%INPUT%/tmd >content.txt
set TEXT="Content id"
set FILE="content.txt"
set /a i=0
for /f "delims=" %%d in ('findstr /c:%TEXT% %FILE%') do (
	set CONLINE=%%d
	set /a i+=1
	cls
	echo.
	echo Downloding...
	echo Close the window to cancel for next time resume.
	echo.
	echo #!i! data
	aria2c http://nus.cdn.c.shop.nintendowifi.net/ccs/download/%INPUT%/!CONLINE:~24,8! --dir=./%INPUT% --conf-path=aria2.conf --console-log-level=error
	if %errorlevel%==0 goto MAKE
	cls
	echo.
	echo Downloding...
	echo Close the window to cancel for next time resume.
	echo.
	echo #!i! data
	aria2c http://ccs.cdn.c.shop.nintendowifi.net/ccs/download/%INPUT%/!CONLINE:~24,8! --dir=./%INPUT% --conf-path=aria2.conf --console-log-level=error
	if not %errorlevel%==0 goto ERROR
)

EndLocal
:MAKE
cls
echo.
echo Do not insert \/:^?"<>|
set GNAME=
set /p GNAME=Enter the Name of the Game:
cls
echo.
echo Packing...
make_cdn_cia %INPUT% "%GNAME%.cia" 2>ERROR
for /f %%i in ("ERROR") do set EMPTY=%%~zi
if %EMPTY% gtr 0 (
	del "%GNAME%.cia" >nul 2>&1
	goto ERROR
)
cls
echo.
echo Finished, please press any key to exit.

:Finished
del ERROR >nul 2>&1
del content.txt >nul 2>&1
rmdir /S /Q .\%INPUT%\ >nul 2>&1
pause >nul
REM matif

