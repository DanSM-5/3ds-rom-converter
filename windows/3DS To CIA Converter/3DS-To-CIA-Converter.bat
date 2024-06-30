@echo off

set x64=""
set manual=""
set manual2=""
set amc=""
set alt=0
set md=0
set reg=true
set sspoof=false
set ver=v4.1
set drag=%~1
if not "%drag%" == "" set file=%~n1
if "%drag%" == "" set file=None
color 0F

:menu
cls
set M=""
echo ....................................................
echo     Noob Friendly 3DS, SCU To CIA Converter %ver%
echo               Please Install Python v2.7
echo ....................................................
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo  1 - Get 3DS Info
echo  2 - Create ncchinfo.bin
echo  3 - View Converters Menu
echo  4 - Check Stored Name
echo  5 - View Extras Menu
echo  6 - Check For Update
echo.
echo.
echo.
echo.
echo.
echo.
set /p M=Please Type 1-6 or Hit Enter To Exit:
IF %M%==1 goto info
IF %M%==2 goto ncchinfo
IF %M%==3 goto menu3
IF %M%==4 goto name
IF %M%==5 goto menu2
IF %M%==6 goto update
IF %M%=="" goto exit
goto menu

:name
cls
set M=""
echo ....................................................
echo     Noob Friendly 3DS, SCU To CIA Converter %ver%
echo               Please Install Python v2.7
echo ....................................................
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo Stored Name: %file%
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo Hit Enter To Go Back..
pause>nul
IF %M%=="" goto menu
goto menu

:menu2
cls
set M=""
echo ....................................................
echo     Noob Friendly 3DS, SCU To CIA Converter %ver%
echo               Please Install Python v2.7
echo ....................................................
echo.
echo.
echo.
echo.
echo.
echo.
echo  1 - Trim Your 3DS Rom (Card1)
echo  2 - Trim Your 3DS Rom (Card2)
echo  3 - Restore Trimmed 3DS Rom
echo  4 - Remove Update From 3DS Rom (Card1)
echo  5 - Start 3DS Rom Unpack/Repack For Editing (Decrypted 3DS Files)
rem echo  6 - Start 3DS Rom Unpack/Repack For Editing (Req. Xorpads)
echo  7 - x86-x64 EXE File Tester
rem echo  7 - Change Padxorer Version
echo  8 - Merge 3D0 And 3D1 Files
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p M=Please Type 1-7 or Hit Enter To Go Back:
IF %M%==1 goto trim
IF %M%==2 goto trimcard2
IF %M%==3 goto restore
IF %M%==4 goto update
IF %M%==5 goto 3dsfix
rem IF %M%==6 goto 3dsfixnew
IF %M%==6 goto tester
rem IF %M%==7 goto padver
IF %M%==7 goto merge
IF %M%=="" goto menu
goto menu2

:padver
cls
set M=""
set xor=""
if exist "files\padxorer4x.exe" set xor=Padxorer (4.xx)
if exist "files\padxorerhi.exe" set xor=Padxorer (Higher)
echo ....................................................
echo     Noob Friendly 3DS, SCU To CIA Converter %ver%
echo               Please Install Python v2.7
echo ....................................................
echo.
echo.
echo.
echo.
echo.
echo.
echo  1 - Padxorer (4.xx)
echo  2 - Padxorer (Higher)
echo.
echo.
echo.
echo.
echo.
echo  Using:
echo  %xor%
echo.
echo.
echo.
echo.
echo.
set /p M=Please Type 1-2 or Hit Enter To Go Back:
IF %M%==1 goto padver1
IF %M%==2 goto padver2
IF %M%=="" goto menu2
goto menu

:padver1
cls
if exist "files\padxorerhi.exe" del /F /Q "files\padxorerhi.exe"
xcopy /y "files\padxorer4x\padxorer4x.exe" "files"
cls
echo Padxorer Changed
echo.
pause
goto menu

:padver2
cls
if exist "files\padxorer4x.exe" del /F /Q "files\padxorer4x.exe"
xcopy /y "files\padxorerhi\padxorerhi.exe" "files"
cls
echo Padxorer Changed
echo.
pause
goto menu

:menu3
cls
set M=""
echo ....................................................
echo     Noob Friendly 3DS, SCU To CIA Converter %ver%
echo               Please Install Python v2.7
echo ....................................................
echo.
echo.
echo.
echo.
echo.
echo  1 - Start 3DS To CIA Converter (Req. Xorpads)
echo  2 - Start 3DS To CIA Converter (Decrypted 3DS Files, Req. Xorpads)
echo  3 - Start 3DS To CIA Converter (Decrypted 3DS Rom)
echo  4 - Start CSU To CIA Converter
echo  5 - Start CIA To CCI Converter
echo  6 - Start CIA To 3DS Converter
echo  7 - Start Nes VC To CIA Preparation (Req. Xorpads)
echo  8 - Start VC 3DS To CIA Converter
echo  9 - Start MD 3DS To CIA Converter (Req. Xorpads)
echo.
echo.
echo.
echo.
echo.
echo.
set /p M=Please Type 1-9 or Hit Enter To Go Back:
IF %M%==1 goto check
IF %M%==2 goto prep2
IF %M%==3 goto ciano
IF %M%==4 goto csu
IF %M%==5 goto cci
IF %M%==6 goto 3ds
IF %M%==7 goto prep
IF %M%==8 goto vc
IF %M%==9 goto md
IF %M%=="" goto menu
goto menu3

:prep2
cls
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto prep2_1) else set rom=%rom%.3ds& goto prep2_1
goto prep2

:prep2_1
cls
if "%rom%" == "" goto prep2
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto prep2
cls
goto prep2_2

:prep2_2
cls
if not exist *Main.exefs_norm.xorpad goto check3
if not exist *Main.exheader.xorpad goto check3
if not exist *Main.romfs.xorpad goto check3
cls
echo Please Wait..
echo.
mkdir tmp
files\ctrtool -x --exefsdir=. --romfs=romfs.bin --exheader=exheader.bin --exefs=exefs.bin --logo=logo.bin "%rom%"
cls
echo Please Wait..
echo.
if not exist *exefs_7x.xorpad xcopy /y *Main.exefs_norm.xorpad tmp
if exist tmp\*Main.exefs_norm.xorpad move tmp\*Main.exefs_norm.xorpad exefs.xorpad
cls
echo Please Wait..
echo.
if exist *exefs_7x.xorpad xcopy /y *Main.exefs_7x.xorpad tmp
if exist tmp\*Main.exefs_7x.xorpad move tmp\*Main.exefs_7x.xorpad exefs_7x.xorpad
cls
echo Please Wait..
echo.
if exist exefs_7x.xorpad xcopy /y *Main.exefs_norm.xorpad tmp
if exist tmp\*Main.exefs_norm.xorpad move tmp\*Main.exefs_norm.xorpad exefs_norm.xorpad
cls
echo Please Wait..
echo.
if exist *main.romfs.xorpad xcopy /y *main.romfs.xorpad tmp
if exist tmp\*main.romfs.xorpad move tmp\*main.romfs.xorpad romfs.xorpad
cls
echo Please Wait..
echo.
if exist *main.exheader.xorpad xcopy /y *main.exheader.xorpad tmp
if exist tmp\*main.exheader.xorpad move tmp\*main.exheader.xorpad exh.xorpad
RMDIR /S /Q "tmp"
cls
echo Please Wait..
echo.
if exist "exefsEncrypted.bin.out" ren "exefsEncrypted.bin.out" exefs.bin
if exist "romfsEncrypted.bin.out" ren "romfsEncrypted.bin.out" romfs.bin
if exist "exefsEncrypted.bin" del exefsEncrypted.bin
if exist "romfsEncrypted.bin" del romfsEncrypted.bin
mkdir xorpads
if exist exefs.xorpad move exefs.xorpad xorpads
if exist exh.xorpad move exh.xorpad xorpads
if exist romfs.xorpad move romfs.xorpad xorpads
cls
goto cianoxor_1

:cianoxor
cls
set /p rom=Enter 3DS Rom Name:
goto cianoxor_1

:cianoxor_1
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto cianoxor2) else set rom=%rom%.3ds& goto cianoxor2
goto cianoxor

:cianoxor2
cls
if "%rom%" == "" goto cianoxor
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto cianoxor
cls
goto cianoxor3

:cianoxor3
cls
set M=""
echo ....................................................
echo     Noob Friendly 3DS, SCU To CIA Converter %ver%
echo               Please Install Python v2.7
echo ....................................................
echo.
echo.
echo.
echo  Please Ensure You Have The Following
echo  Files In The Root Folder:
echo.
echo  *.Main.exefs_norm.xorpad
echo  *.Main.exheader.xorpad
echo  *.Main.romfs.xorpad
echo  romfs.bin
echo  exefs.bin
echo  exheader.bin
echo  banner.bin
echo  icon.bin
echo  code.bin
echo.
echo  Aswell As The 3DS Rom.
echo.
echo.
echo.
set /p M=Please Type 1 or Hit Enter To Go Back:
IF %M%==1 goto cianoxor3_0
IF %M%=="" goto menu3
goto menu

:cianoxor3_0
cls
if exist Results.txt del /F /Q Results.txt
> Results.txt echo %rom:~0,-4%
rem set /P yn=Do You Want To Remove Region Lock [Y/N]?
rem if /I "%yn%"=="y" >> Results.txt echo Region Lock: Yes&set reg=true
rem if /I "%yn%"=="n" >> Results.txt echo Region Lock: No&set reg=false
rem cls
rem >> Results.txt echo Region Lock: No&set reg=false
rem set /P yn=Would You Like To Include The Manual [Y/N]?
rem if "%yn%"=="y" set manual=ren CTR-P-CTAP_1_MANUAL.cfa manual.cfa&set manual1= -content manual.cfa:1:1& >> Results.txt echo Manual: Yes& goto cianoxor3_1
rem if "%yn%"=="n" set manual=del manual.cfa& set manual2= (No Manual)& >> Results.txt echo Manual: No& goto cianoxor3_1
cls
set /P yn=Would You Like To Spoof Firmware to 4.xx [Y/N]?
if "%yn%"=="y" >> Results.txt echo Firmware Spoof: Yes& goto rf
if "%yn%"=="n" >> Results.txt echo Firmware Spoof: No& goto rf2
goto cianoxor3_0

:rf
cls
set sspoof=true
set /P yn=Do You Want To Remove Region Lock [Y/N]?
if /I "%yn%"=="y" >> Results.txt echo Region Lock: Yes&set reg=true
if /I "%yn%"=="n" >> Results.txt echo Region Lock: No&set reg=false
set manual2=
set manual=del manual.cfa& >> Results.txt echo Manual: No& goto cianoxor3_1
goto rf

:rf2
cls
set sspoof=false
>> Results.txt echo Region Lock: No&set reg=false
set manual2=
set manual=del manual.cfa& >> Results.txt echo Manual: No& goto cianoxor3_1
goto rf2

:cianoxor3_1
cls
>> Results.txt echo SDK: 5
if exist rom.bat del rom.bat
if not exist "decrypted" mkdir "decrypted"
if not exist "exefs" mkdir "exefs"
cls
echo Please Wait..
echo.
if not exist "%rom% Files" mkdir "%rom% Files"
rem if not exist "%rom% Files\*.Main.exefs_7x.xorpad" xcopy /y "*.Main.exefs_7x.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_norm.xorpad" xcopy /y "*.Main.exefs_norm.xorpad" "%rom% Files"
cls
echo Please Wait..
echo.
if not exist "%rom% Files\*.Main.exheader.xorpad" xcopy /y "*.Main.exheader.xorpad" "%rom% Files"
cls
echo Please Wait..
echo.
if not exist "%rom% Files\*.Main.romfs.xorpad" xcopy /y "*.Main.romfs.xorpad" "%rom% Files"
rem if not exist "%rom% Files\*.Manual.romfs.xorpad" xcopy /y "*.Manual.romfs.xorpad" "%rom% Files"
rem if not exist "%rom% Files\*.UpdateData.romfs.xorpad" xcopy /y "*.UpdateData.romfs.xorpad" "%rom% Files"
rem if not exist "%rom% Files\*.DownloadPlay.romfs.xorpad" xcopy /y "*.DownloadPlay.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\ncchinfo.bin" xcopy /y "ncchinfo.bin" "%rom% Files"
cls
echo Please Wait..
echo.
rem if exist *UpdateData.romfs.xorpad del *UpdateData.romfs.xorpad
rem cls
rem echo Please Wait..
rem echo.
rem if exist "romfs.bin" xcopy /y "romfs.bin" "%rom% Files"
rem if exist "exefs.bin" xcopy /y "exefs.bin" "%rom% Files"
rem if exist "exheader.bin" xcopy /y "exheader.bin" "%rom% Files"
rem if exist "banner.bin" xcopy /y "banner.bin" "%rom% Files"
rem if exist "icon.bin" xcopy /y "icon.bin" "%rom% Files"
rem if exist "code.bin" xcopy /y "code.bin" "%rom% Files"
if exist "romfs.bin" xcopy /y "romfs.bin" "decrypted"
cls
echo Please Wait..
echo.
if exist "exefs.bin" xcopy /y "exefs.bin" "decrypted"
cls
echo Please Wait..
echo.
if exist "exheader.bin" xcopy /y "exheader.bin" "decrypted"
cls
echo Please Wait..
echo.
if exist "banner.bin" xcopy /y "banner.bin" "exefs"
cls
echo Please Wait..
echo.
if exist "icon.bin" xcopy /y "icon.bin" "exefs"
cls
echo Please Wait..
echo.
if exist "custom\icon.bin" del /F /Q "exefs\icon.bin"
if exist "custom\icon.bin" xcopy /y "custom\icon.bin" "exefs"
rem if exist "custom\exheader.bin" del /F /Q "exheader.bin"
rem if exist "custom\exheader.bin" xcopy /y "custom\exheader.bin" "."
rem if exist "custom\exheader.bin" xcopy /y "custom\exheader.bin" "decrypted"
if exist "code.bin" xcopy /y "code.bin" "exefs"
cls
echo Please Wait..
echo.
if not exist decrypted\exefs.bin goto check2
if not exist decrypted\exheader.bin goto check2
if not exist decrypted\romfs.bin goto check2
if not exist exefs\banner.bin goto check2
if not exist exefs\code.bin goto check2
if not exist exefs\icon.bin goto check2
cls
echo Please Wait..
echo.
if not exist decrypted\exefs.bin goto dfailed
if not exist decrypted\romfs.bin goto dfailed
if not exist decrypted\exheader.bin goto dfailed
if not exist exefs\banner.bin goto dfailed
if not exist exefs\code.bin goto dfailed
if not exist exefs\icon.bin goto dfailed
if exist RSF.rsf del RSF.rsf
copy files\auto.rsf RSF.rsf
cls
echo Please Wait..
echo.
files\rsfgen.py "%rom%" %reg%
cls
echo Please Wait..
echo.
if exist *.Manual.romfs.xorpad (files\rom_tool --extract=. "%rom%") else if exist *DownloadPlay.romfs.xorpad (files\rom_tool --extract=. "%rom%")
cls
echo Please Wait..
echo.
if exist "*.Manual.romfs.xorpad" move *.Manual.romfs.xorpad xorpads\Manual.romfs.xorpad
cls
echo Please Wait..
echo.
if exist *.DownloadPlay.romfs.xorpad copy xorpads\DownloadPlay.romfs.xorpad
cls
echo Please Wait..
echo.
if exist *.DownloadPlay.romfs.xorpad ren *DLP.cfa dlp.cfa
if exist *appdata.cxi del *appdata.cxi
if exist *updatedata.cfa del *updatedata.cfa
%manual%
cls
echo Please Wait..
echo.
goto cianoxor3_2

:cianoxor3_2
cls
echo Please Check The RSF.rsf File For A
echo Correct Title And Product Code.
echo.
pause
cls
echo Please Wait..
echo.
set x64=_
files\%x64%makerom -f cxi -o rom.cxi -rsf RSF.rsf -target t -desc ecapp:5 -exheader exheader.bin -exefslogo -code exefs\code.bin -romfs decrypted\romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin%manual1%
cls
echo Please Wait..
echo.
if sspoof==true goto exinj1
if sspoof==false goto exinj2

:exinj1
cls
files\exinjector -rom rom.cxi -exheader exheader.bin -sd -fwspoof
cls
taskkill /F /IM cscript.exe
goto exinj3

:exinj2
cls
files\exinjector -rom rom.cxi -exheader exheader.bin -sd
cls
taskkill /F /IM cscript.exe
goto exinj3

:exinj3
cls
echo Please Wait..
echo.
if exist "*.DownloadPlay.romfs.xorpad" del /F /Q "*.DownloadPlay.romfs.xorpad"
cls
echo Please Wait..
echo.
if not exist "manual.cfa" If not exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If exist "manual.cfa" If not exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If exist "manual.cfa" If exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If exist "dlp.cfa" If not exist "manual.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5_1
goto autofail

:ciano
cls
set /p rom=Enter 3DS Rom Name:
goto ciano_1

:ciano_1
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto ciano2) else set rom=%rom%.3ds& goto ciano2
goto ciano

:ciano2
cls
if "%rom%" == "" goto ciano
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto ciano
cls
goto ciano3

:ciano3
cls
if exist Results.txt del /F /Q Results.txt
> Results.txt echo %rom:~0,-4%
cls
files\ctrtool -x --exefsdir=. --romfs=romfs.bin --exheader=exheader.bin --exefs=exefs.bin --logo=logo.bin "%rom%"
cls
set /P yn=Would You Like To Spoof Firmware to 4.xx [Y/N]?
if "%yn%"=="y" >> Results.txt echo Firmware Spoof: Yes& goto rfnew
if "%yn%"=="n" >> Results.txt echo Firmware Spoof: No& goto rf2new
goto ciano3

:rfnew
cls
set sspoof=true
set /P yn=Do You Want To Remove Region Lock [Y/N]?
if /I "%yn%"=="y" >> Results.txt echo Region Lock: Yes&set reg=true
if /I "%yn%"=="n" >> Results.txt echo Region Lock: No&set reg=false
set manual2=
set manual=del manual.cfa& >> Results.txt echo Manual: No& goto ciano3_1
goto rfnew

:rf2new
cls
set sspoof=false
>> Results.txt echo Region Lock: No&set reg=false
set manual2=
set manual=del manual.cfa& >> Results.txt echo Manual: No& goto ciano3_1
goto rf2new

:ciano3_1
cls
>> Results.txt echo SDK: 5
if exist rom.bat del rom.bat
cls
echo Please Wait..
echo.
if not exist exefs.bin goto dfailed
if not exist romfs.bin goto dfailed
if not exist exheader.bin goto dfailed
if not exist banner.bin goto dfailed
if not exist code.bin goto dfailed
if not exist icon.bin goto dfailed
if exist RSF.rsf del RSF.rsf
copy files\auto.rsf RSF.rsf
cls
echo Please Wait..
echo.
files\rsfgen.py "%rom%" %reg%
cls
echo Please Wait..
echo.
goto ciano3_2

:ciano3_2
cls
echo Please Check The RSF.rsf File For A
echo Correct Title And Product Code.
echo.
pause
cls
echo Please Wait..
echo.
set x64=_
files\%x64%makerom -f cxi -o rom.cxi -rsf RSF.rsf -target t -desc ecapp:5 -exheader exheader.bin -exefslogo -code code.bin -romfs romfs.bin -icon icon.bin -banner banner.bin
cls
echo Please Wait..
echo.
if sspoof==true goto exinj1new
if sspoof==false goto exinj2new

:exinj1new
cls
files\exinjector -rom rom.cxi -exheader exheader.bin -sd -fwspoof
cls
taskkill /F /IM cscript.exe
goto exinj3new

:exinj2new
cls
files\exinjector -rom rom.cxi -exheader exheader.bin -sd
cls
taskkill /F /IM cscript.exe
goto exinj3new

:exinj3new
cls
echo Please Wait..
echo.
files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -o ciarom.cia & goto cia5_1
goto autofail

:update
cls
start "" https://mega.co.nz/#F!4cpXTTjJ!Svh80anrKcR0oLB5UDEknQ
goto menu

:merge
cls
set /p rom=Enter 3D0 Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3d0" (goto merge2) else set rom=%rom%.3d0& goto merge2
goto merge

:merge2
cls
if "%rom%" == "" goto merge
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto merge
goto merge3

:merge3
cls
echo Please Wait..
echo.
copy /b "%rom%" + "%rom:~0,-4%.3d1" "%rom:~0,-4%.3dz"
cls
set /P yn=Would You Like To Delete The Split Files [Y/N]?
if "%yn%"=="y" goto merge4
if "%yn%"=="n" goto merge5
goto menu

:merge4
cls
if exist "%rom%" DEL "%rom:~0,-4%.3d1"
if exist "%rom%" DEL "%rom%"
cls
echo Complete..
echo.
pause
goto menu

:merge5
cls
echo Complete..
echo.
pause
goto menu

:ncchinfo
cls
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto ncchinfo2) else set rom=%rom%.3ds& goto ncchinfo2
goto ncchinfo

:ncchinfo2
cls
if "%rom%" == "" goto ncchinfo
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto ncchinfo
echo.
cls
set M=""
echo ....................................................
echo     Noob Friendly 3DS, SCU To CIA Converter %ver%
echo               Please Install Python v2.7
echo ....................................................
echo.
echo.
echo.
echo.
echo.
echo.
echo  1 - ncchinfo (4.xx)
echo  2 - ncchinfo (Higher)
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p M=Please Type 1-2 or Hit Enter To Go Back:
IF %M%==1 goto ncch1
IF %M%==2 goto ncch2
IF %M%=="" goto menu
goto menu

:ncch1
cls
files\ctrKeyGen.py "%rom%"
if exist "ncchinfo.bin" del /F /Q "ncchinfo.bin"
move files\ncchinfo.bin ncchinfo.bin
cls
echo Created ncchinfo.bin
echo.
pause
goto menu

:ncch2
cls
files\ctrKeyGen2.py "%rom%"
if exist "ncchinfo.bin" del /F /Q "ncchinfo.bin"
move files\ncchinfo.bin ncchinfo.bin
cls
echo Created ncchinfo.bin
echo.
pause
goto menu

:tester
cls
set /p file=Enter the EXE filename:
for /f "delims=" %%a  in ("%file%") do set "Extension=%%~xa"
if /i "%Extension%"==".exe" (goto tester2) else set file=%file%.exe& goto tester2
goto tester

:tester2
cls
if "%file%" == "" goto tester
if not exist "%file%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%file%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%file%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%file%" WSCRIPT.EXE usermessage.vbs
if not exist "%file%" DEL usermessage.vbs
if not exist "%file%" goto tester
files\PESnoop "%file%" /pe_dh
echo.
pause
goto menu

:trim
cls
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto trim2) else set rom=%rom%.3ds& goto trim2
goto trim

:trim2
cls
if "%rom%" == "" goto trim
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto trim
echo.
cls
files\rom_tool -t "%rom%"
cls
echo Congratulations You're Done
echo.
pause
goto menu

:trimcard2
cls
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto trimcard2_1) else set rom=%rom%.3ds& goto trimcard2_1
goto trimcard2

:trimcard2_1
cls
if "%rom%" == "" goto trimcard2
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto trimcard2
echo.
cls
files\Card2RomTrimTool "%rom%"
cls
echo Congratulations You're Done
echo.
pause
goto menu

:restore
cls
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto restore2) else set rom=%rom%.3ds& goto restore2
goto restore

:restore2
cls
if "%rom%" == "" goto restore
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto restore
echo.
cls
files\rom_tool -r "%rom%"
cls
echo Congratulations You're Done
echo.
pause
goto menu

:update
cls
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto update2) else set rom=%rom%.3ds& goto update2
goto update

:update2
cls
if "%rom%" == "" goto update
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto update
echo.
cls
files\rom_tool -u "%rom%"
cls
echo Congratulations You're Done
echo.
pause
goto menu

:info
cls
set /p rom=Enter Rom Name:
if "%rom%" == "" set rom=%file%
if "%rom%" == "" goto info
if exist "%rom%".3ds set rom=%file%.3ds
if exist "%rom%".csu set rom=%file%.csu
if exist "%rom%".cci set rom=%file%.cci
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto info
echo.
cls
set M=""
echo ....................................................
echo     Noob Friendly 3DS, SCU To CIA Converter %ver%
echo               Please Install Python v2.7
echo ....................................................
echo.
echo.
echo.
echo.
echo.
echo.
echo  1 - Rom Info (x86)
echo  2 - Rom Info (x64)
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p M=Please Type 1-2 or Hit Enter To Go Back:
IF %M%==1 goto info1
IF %M%==2 goto info2
IF %M%=="" goto menu
goto menu

:info1
cls
files\rom_tool -i "%rom%"
pause
goto menu

:info2
cls
files\rom_toolx64 -i "%rom%"
pause
goto menu

:csu
cls
set /p csu=Enter CSU Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%csu%") do set "Extension=%%~xa"
if /i "%Extension%"==".csu" (goto csu2) else set csu=%csu%.csu& goto csu2
goto csu

:csu2
cls
if "%csu%" == "" goto csu
if not exist "%csu%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%csu%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%csu%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%csu%" WSCRIPT.EXE usermessage.vbs
if not exist "%csu%" DEL usermessage.vbs
if not exist "%csu%" goto csu
echo.
cls
if exist "%csu%" copy "%csu%" "%csu%".3ds
if not exist RSF2.rsf copy files\auto2.rsf RSF2.rsf
files\ctrtool --exheader=exheader.bin --romfs=romfs.bin --exefs=exefs.bin --logo=logo.bin "%csu%".3ds
files\ctrtool -t exefs --exefsdir=. exefs.bin --decompresscode
goto csu3

:csu3
cls
set /P yn=Do You Want To Remove Region Lock [Y/N]?
if /I "%yn%"=="y" goto csu3yes
if /I "%yn%"=="n" goto csu3no
goto csu3

:csu3yes
cls
files\rsfgen2.py "%csu%" true
goto csunext

:csu3no
cls
files\rsfgen2.py "%csu%" false
goto csunext

:csunext
set csufile="romfs.bin"
set badsize=1
FOR /F "usebackq" %%A IN ('%csufile%') DO set size=%%~zA
goto csucheck

:csucheck
cls
echo Check RSF File..
echo.
pause
goto csumake

:csumake
cls
if %size% LSS %badsize% (
    files\_makerom -f cci -o "%csu%".cci -rsf RSF2.rsf -target t -exheader exheader.bin -exefslogo -code code.bin -icon icon.bin -banner banner.bin
) ELSE (
    files\_makerom -f cci -o "%csu%".cci -rsf RSF2.rsf -target t -exheader exheader.bin -exefslogo -code code.bin -romfs romfs.bin -icon icon.bin -banner banner.bin
)
files\exinjector -rom "%csu%".cci -exheader exheader.bin -sd
files\rom_tool -x . "%csu%".cci
ren *APPDATA.cxi appdata.cxi
taskkill /F /IM cscript.exe
files\_makerom -f cia -content appdata.cxi:0:0 -o "%csu:~0,-4%".cia
cls
echo Congratulations You're Done
echo.
set /P yn=Would You Like To Cleanup [Y/N]?
if "%yn%"=="y" goto csucleanup
if "%yn%"=="n" goto menu
goto menu

:csucleanup
cls
echo Cleaning Up Files..
if exist "%csu%".3ds del /F /Q "%csu%".3ds
if exist "%csu%".cci del /F /Q "%csu%".cci
if exist "RSF2.rsf" del /F /Q "RSF2.rsf"
if exist "appdata.cxi" del /F /Q "appdata.cxi"
if exist "banner.bin" del /F /Q "banner.bin"
if exist "code.bin" del /F /Q "code.bin"
if exist "exefs.bin" del /F /Q "exefs.bin"
if exist "exheader.bin" del /F /Q "exheader.bin"
if exist "icon.bin" del /F /Q "icon.bin"
if exist "logo.bin" del /F /Q "logo.bin"
if exist "romfs.bin" del /F /Q "romfs.bin"
cls
echo Files Cleaned Up..
echo.
pause
goto menu

:cci
cls
echo CIA Must Not Be Encryped..
echo.
set /p rom=Enter CIA Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".cia" (goto cci2) else set rom=%rom%.cia& goto cci2
goto cci

:cci2
cls
if "%rom%" == "" goto cci
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto cci
cls
echo Please Wait..
echo.
files\makerom -ciatocci "%rom%"
cls
echo Congratulations You're Done
echo.
pause
goto menu

:3ds
cls
echo CIA Must Not Be Encryped..
echo.
set /p rom=Enter CIA Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".cia" (goto 3ds_1) else set rom=%rom%.cia& goto 3ds_1
goto 3ds

:3ds_1
cls
if "%rom%" == "" goto 3ds
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto 3ds
cls
echo Please Wait..
echo.
files\_makerom -ciatocci "%rom%"
cls
echo Please Wait..
echo.
rename "%rom:~0,-4%.cci" "%rom:~0,-4%-tmp.3ds"
copy "%rom:~0,-4%-tmp.3ds" "%rom:~0,-4%-alt.3ds"
cls
echo Please Wait..
echo.
files\ctrtool -x --exefsdir=exefs --romfs=romfs.bin --exheader=exheader.bin "%rom:~0,-4%-tmp.3ds"
cls
echo Please Wait..
echo.
files\ctrtool -x --romfsdir=romfs romfs.bin
cls
echo Please Wait..
echo.
del romfs.bin
cls
echo Please Wait..
echo.
files\3dstool -c -t romfs --romfs-dir romfs -f romfs.bin
cls
echo Please Wait..
echo.
RMDIR /S /Q "romfs"
cls
echo Please Wait..
echo.
files\exinjector -rom "%rom:~0,-4%-tmp.3ds" -exheader exheader.bin -sd
cls
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
if exist RSF.rsf del RSF.rsf
copy files\auto5.rsf RSF.rsf
cls
echo Please Wait..
echo.
rem files\_makerom -ciatocci "%rom%"
files\rsfgen5.py "%rom:~0,-4%-tmp.3ds" false
mkdir decrypted
copy exheader.bin decrypted\exheader.bin
cls
echo Please Wait..
echo.
files\ctrtool -t exheader "exheader.bin" > "exheader.txt"
cls
echo Please Wait..
echo.
files\_makerom -f cci -target d -rsf RSF.rsf -romfs "romfs.bin" -exheader "decrypted\exheader.bin" -logo "exefs\logo.bin" -exefslogo -code "exefs\code.bin" -icon "exefs\icon.bin" -banner "exefs\banner.bin" -alignwr -o "%rom:~0,-4%.3ds"
rem files\_makerom -f cci -target d -rsf RSF.rsf -o "%rom:~0,-4%.3ds" -exheader exheader.bin -code exefs\code.bin -romfs romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin -alignwr
del "%rom:~0,-4%-tmp.3ds"
del "%rom:~0,-4%.cci"
cls
echo Please Wait..
echo.
cls
del RSF.rsf
del romfs.bin
cls
echo Please Wait..
echo.
del exheader.txt
del exheader.bin
RMDIR /S /Q "exefs"
RMDIR /S /Q "decrypted"
cls
echo Congratulations You're Done
echo.
pause
goto menu

:3dsfix
cls
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto 3dsfix_1) else set rom=%rom%.3ds& goto 3dsfix_1
goto 3dsfix

:3dsfix_1
cls
if "%rom%" == "" goto 3dsfix
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto 3dsfix
cls
goto 3dsfix_2

:3dsfix_2
cls
echo Please Wait..
echo.
files\ctrtool -x --exefsdir=exefs --romfs=romfs.bin --exheader=exheader.bin "%rom%"
cls
echo Please Wait..
echo.
files\ctrtool -x --romfsdir=romfs romfs.bin
cls
echo Please Wait..
echo.
if exist "romfs.bin" del /F /Q "romfs.bin"
if exist RSF.rsf delete RSF.rsf
copy files\auto5.rsf RSF.rsf
cls
echo Please Wait..
echo.
files\rsfgen5.py "%rom%" false
cls
echo Nows The Time To Alter Any Romfs or Exefs Files..
echo.
pause
cls
echo Please Wait..
echo.
files\3dstool -c -t romfs --romfs-dir romfs -f romfs.bin
cls
RMDIR /S /Q "romfs"
cls
echo Please Wait..
echo.
files\_makerom -f cci -target d -rsf RSF.rsf -o "%rom:~0,-4%-new.3ds" -exheader exheader.bin -code exefs\code.bin -romfs romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin -alignwr
cls
if exist "romfs.bin" del /F /Q "romfs.bin"
if exist "exheader.bin" del /F /Q "exheader.bin"
if exist "RSF.rsf" del /F /Q "RSF.rsf"
RMDIR /S /Q "exefs"
cls
echo Congratulations You're Done
echo.
pause
goto menu

:3dsfixnew
cls
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto 3dsfixnew_1) else set rom=%rom%.3ds& goto 3dsfixnew_1
goto 3dsfixnew

:3dsfixnew_1
cls
if "%rom%" == "" goto 3dsfixnew
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto 3dsfixnew
cls
goto 3dsfixnew_2

:3dsfixnew_2
cls
if not exist "%rom% Files" mkdir "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_7x.xorpad" xcopy /y "*.Main.exefs_7x.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_norm.xorpad" xcopy /y "*.Main.exefs_norm.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exheader.xorpad" xcopy /y "*.Main.exheader.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.romfs.xorpad" xcopy /y "*.Main.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Manual.romfs.xorpad" xcopy /y "*.Manual.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.UpdateData.romfs.xorpad" xcopy /y "*.UpdateData.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.DownloadPlay.romfs.xorpad" xcopy /y "*.DownloadPlay.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\ncchinfo.bin" xcopy /y "ncchinfo.bin" "%rom% Files"
if exist *UpdateData.romfs.xorpad del *UpdateData.romfs.xorpad
cls
echo Please Wait..
echo.
files\ctrtool1 -p --exheader=exheaderEncrypted.bin --romfs=romfsEncrypted.bin --exefs=exefsEncrypted.bin --logo=logo.bin "%rom%"
cls
echo Please Wait..
echo.
if not exist *exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs.xorpad
if exist *exefs_7x.xorpad ren *Main.exefs_7x.xorpad exefs_7x.xorpad
if exist exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs_norm.xorpad
if exist exefs_7x.xorpad files\MEX.py exefsEncrypted.bin exefs_norm.xorpad exefs_7x.xorpad exefs.xorpad
ren *main.romfs.xorpad romfs.xorpad
ren *main.exheader.xorpad exheader.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe romfsEncrypted.bin romfs.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exheaderEncrypted.bin exheader.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exefsEncrypted.bin exefs.xorpad
cls
echo Please Wait..
echo.
ren romfsEncrypted.bin.out romfs.bin
ren exefsEncrypted.bin.out exefs.bin
ren exheaderEncrypted.bin.out exheader.bin
cls
echo Please Wait..
echo.
files\ctrtool -t exefs --exefsdir=exefs exefs.bin --decompresscode
cls
echo Please Wait..
echo.
mkdir decrypted
mkdir xorpads
if exist *Manual.romfs.xorpad (files\rom_tool --extract=. "%rom%") else if exist *DownloadPlay.romfs.xorpad (files\rom_tool --extract=. "%rom%")
if exist *Manual.romfs.xorpad ren *manual*.cfa manual.cfa
if exist *DownloadPlay.romfs.xorpad ren *DLP.cfa dlp.cfa
%manual%
del *appdata.cxi
del *updatedata.cfa
move exefs.bin decrypted\exefs.bin
move romfs.bin decrypted\romfs.bin
move exefs.xorpad xorpads\exefs.xorpad
move romfs.xorpad xorpads\romfs.xorpad
move exheader.xorpad xorpads\exheader.xorpad
cls
echo Please Wait..
echo.
if exist "romfs.bin" del /F /Q "romfs.bin"
files\ctrtool -x --romfsdir=romfs decrypted\romfs.bin
if exist RSF.rsf delete RSF.rsf
copy files\auto5.rsf RSF.rsf
cls
echo Please Wait..
echo.
files\rsfgen5.py "%rom%" false
cls
echo Nows The Time To Alter Any Romfs or Exefs Files..
echo.
pause
cls
echo Please Wait..
echo.
files\3dstool -c -t romfs --romfs-dir romfs -f romfs.bin
cls
RMDIR /S /Q "romfs"
if exist decrypted\romfs.bin del decrypted\romfs.bin
if exist "romfs.bin" xcopy /y "romfs.bin" "decrypted"
cls
echo Please Wait..
echo.
if exist manual.cfa set manual1= -content manual.cfa:1:1
files\_makerom -f cci -target d -rsf RSF.rsf -o "%rom:~0,-4%-new.3ds" -exheader exheader.bin -code exefs\code.bin -romfs romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin%manual1% -alignwr
cls
if exist "romfs.bin" del /F /Q "romfs.bin"
if exist "exheader.bin" del /F /Q "exheader.bin"
if exist "RSF.rsf" del /F /Q "RSF.rsf"
if exist "*.Manual.romfs.xorpad" del /F /Q "*.Manual.romfs.xorpad"
if exist "exefs.bin" del /F /Q "exefs.bin"
if exist "exefs.xorpad" del /F /Q "exefs.xorpad"
if exist "exefsEncrypted.bin" del /F /Q "exefsEncrypted.bin"
if exist "exheader.xorpad" del /F /Q "exheader.xorpad"
if exist "exheaderEncrypted.bin" del /F /Q "exheaderEncrypted.bin"
if exist "logo.bin" del /F /Q "logo.bin"
if exist "romfs.xorpad" del /F /Q "romfs.xorpad"
if exist "romfsEncrypted.bin" del /F /Q "romfsEncrypted.bin"
RMDIR /S /Q "exefs"
cls
echo Congratulations You're Done
echo.
pause
goto menu

:vc
cls
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto vc_1) else set rom=%rom%.3ds& goto vc_1
goto vc

:vc_1
cls
if exist "RSF3.rsf" del /F /Q "RSF3.rsf"
cls
if "%rom%" == "" goto vc
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto vc
cls
set /P yn=Try Alternative Method If Previous Failed [Y/N]?
if /I "%yn%"=="y" goto vc_5
if /I "%yn%"=="n" goto vc_4

:vc_5
cls
files\rom_tool -i "%rom%" > exheaderinfo.txt
cls
if not exist "decrypted" mkdir "decrypted"
if exist "%rom% Files\decrypted" copy "%rom% Files\decrypted" decrypted
if not exist "exefs" mkdir "exefs"
if exist "%rom% Files\exefs" copy "%rom% Files\exefs" exefs
cls
files\ctrtool-a -x --exefsdir=exefs --romfs=romfs.bin --exheader=exheader.bin "%rom%"
files\ctrtool-a -x --romfsdir=romfs romfs.bin
cls
set /P yn=Would You Like To Replace The NES/GB/GBC/GBA Rom [Y/N]?
if "%yn%"=="y" goto vc_3
if "%yn%"=="n" goto vc_2
goto vc

:vc_4
cls
files\rom_tool -i "%rom%" > exheaderinfo.txt
cls
files\ctrtool -x --exefsdir=exefs --romfs=romfs.bin --exheader=exheader.bin "%rom%"
cls
if not exist "decrypted" mkdir "decrypted"
if exist "%rom% Files\decrypted" copy "%rom% Files\decrypted" decrypted
if not exist "exefs" mkdir "exefs"
if exist "%rom% Files\exefs" copy "%rom% Files\exefs" exefs
cls
files\ctrtool -x --romfsdir=romfs romfs.bin
cls
set /P yn=Would You Like To Replace The NES/GB/GBC/GBA Rom [Y/N]?
if "%yn%"=="y" goto vc_3
if "%yn%"=="n" goto vc_2
goto vc

:vc_2
cls
if not exist RSF3.rsf copy files\auto3.rsf RSF3.rsf
cls
files\rsfgen3.py "%rom%" false
cls
set x64=""
cls
echo Please Wait..
echo.
files\makerom2 -f cxi -o rom.cxi -rsf RSF3.rsf -target t -desc ecapp:5 -exheader exheader.bin -exefslogo -code exefs\code.bin -icon exefs\icon.bin -banner exefs\banner.bin -alignwr
cls
files\exinjector -rom rom.cxi -exheader exheader.bin -sd
cls
taskkill /F /IM cscript.exe
cls
files\makerom2 -f cia -target t -content rom.cxi:0:0 -o ciarom.cia
cls
rename ciarom.cia "%rom:~0,-4%.cia"
cls
if exist "exheader.bin" del /F /Q "exheader.bin"
if exist "exheaderinfo.txt" del /F /Q "exheaderinfo.txt"
if exist "info.txt" del /F /Q "info.txt"
if exist "romfs.bin" del /F /Q "romfs.bin"
if exist "rom.cxi" del /F /Q "rom.cxi"
if exist "RSF3.rsf" del /F /Q "RSF3.rsf"
if exist exefs.bin del /F /Q exefs.bin
RMDIR /S /Q "romfs"
RMDIR /S /Q "exefs"
cls
echo CIA File Created Now Copy To 3DS Large SD Card And Install Through DevMenu
echo.
pause
goto menu

:vc_3
cls
if not exist RSF3.rsf copy files\auto4.rsf RSF3.rsf
cls
files\rsfgen4.py "%rom%" false
cls
set /p rom2=Enter NES/GB/GBC/GBA Rom Name (including extension):
if "%rom2%" == "" goto vc_3
cls
if exist "RSF3.rsf" del /F /Q "RSF3.rsf"
cls
if not exist RSF3.rsf copy files\auto3.rsf RSF3.rsf
cls
set /P title=Enter Game Title:
cls
set /P product=Enter Custom Product Code (XXX-X-XXXX):
cls
set /P uniqueid=Enter Custom Unique ID (Last 5 Digits):
cls
set "one=  Title                   : "00000000""
set "two=  Title                   : "%title%""
set "three=  ProductCode             : "000-0-0000""
set "four=  ProductCode             : "%product%""
set "five=  UniqueId                : 0x00000000
set "six=  UniqueId                : 0x000%uniqueid%
cls
set "source=files\auto3.rsf"
set "target=RSF3.rsf"
cls
setlocal enableDelayedExpansion
(
   for /F "tokens=1* delims=:" %%a in ('findstr /N "^" %source%') do (
      set "line=%%b"
      if defined line set "line=!line:%one%=%two%!"
      if defined line set "line=!line:%three%=%four%!"
	  if defined line set "line=!line:%five%=%six%!"
      echo(!line!
   )
) > %target%
cls
if not exist "%rom2%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom2%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom2%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom2%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom2%" DEL usermessage.vbs
if not exist "%rom2%" goto vc_3
cls
if exist romfs\rom\vc_rom.bin del romfs\rom\vc_rom.bin& copy "%rom2%" romfs\rom\vc_rom.bin>NUL
for %%F in ("romfs\rom\*.*") do set name=%%~nxF
if exist romfs\rom\%name% del romfs\rom\%name%& copy "%rom2%" romfs\rom\%name%>NUL
cls
echo Please Wait..
echo.
files\3dstool -c -t romfs --romfs-dir romfs -f romfs.bin
cls
echo Please Wait..
echo.
files\makerom2 -f cxi -o rom.cxi -rsf RSF3.rsf -target t -desc ecapp:5 -exheader exheader.bin -exefslogo -code exefs\code.bin -icon exefs\icon.bin -banner exefs\banner.bin -alignwr
cls
echo Please Wait..
echo.
files\exinjector -rom rom.cxi -exheader exheader.bin -sd
cls
echo Please Wait..
echo.
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
files\makerom2 -f cia -target t -content rom.cxi:0:0 -o ciarom.cia
cls
echo Please Wait..
echo.
set /p rom2=Enter New CIA Name:
cls
rename ciarom.cia "%rom2%.cia"
cls
if exist "exheader.bin" del /F /Q "exheader.bin"
if exist "exheaderinfo.txt" del /F /Q "exheaderinfo.txt"
if exist "info.txt" del /F /Q "info.txt"
if exist "romfs.bin" del /F /Q "romfs.bin"
if exist "rom.cxi" del /F /Q "rom.cxi"
if exist "RSF3.rsf" del /F /Q "RSF3.rsf"
if exist exefs.bin del /F /Q exefs.bin
RMDIR /S /Q "romfs"
RMDIR /S /Q "exefs"
cls
echo CIA File Created Now Copy To 3DS Large SD Card And Install Through DevMenu
echo.
pause
goto menu

:md
cls
set md=1
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto cia2) else set rom=%rom%.3ds& goto md_1
goto md

:md_1
goto prep2

:md_1a
cls
if exist Results.txt del /F /Q Results.txt
> Results.txt echo %rom:~0,-4%
>> Results.txt echo Region Lock: Yes
goto md_2

:md_2
cls
>> Results.txt echo SDK: 5
if exist rom.bat del rom.bat
cls
echo Please Wait..
echo.
if exist "%rom% Files\*.Main.exefs_7x.xorpad" xcopy /y "*.Main.exefs_7x.xorpad"
if exist "%rom% Files\*.Main.exefs_norm.xorpad" xcopy /y "*.Main.exefs_norm.xorpad"
if exist "%rom% Files\*.Main.exheader.xorpad" xcopy /y "*.Main.exheader.xorpad"
if exist "%rom% Files\*.Main.romfs.xorpad" xcopy /y "*.Main.romfs.xorpad"
if exist "%rom% Files\*.Manual.romfs.xorpad" xcopy /y "*.Manual.romfs.xorpad"
if exist "%rom% Files\*.UpdateData.romfs.xorpad" xcopy /y "*.UpdateData.romfs.xorpad"
if exist "%rom% Files\*.DownloadPlay.romfs.xorpad" xcopy /y "*.DownloadPlay.romfs.xorpad"
if exist "%rom% Files\ncchinfo.bin" xcopy /y "ncchinfo.bin"
cls
echo Please Wait..
echo.
if not exist "decrypted" mkdir "decrypted"
if exist "%rom% Files\decrypted" copy "%rom% Files\decrypted" decrypted
if not exist "exefs" mkdir "exefs"
if exist "%rom% Files\exefs" copy "%rom% Files\exefs" exefs
if exist "exefs.bin" del "exefs.bin"
cls
echo Please Wait..
echo.
if not exist decrypted\exefs.bin goto dfailed
if not exist decrypted\romfs.bin goto dfailed
if not exist decrypted\exheader.bin goto dfailed
if not exist exefs\banner.bin goto dfailed
if not exist exefs\code.bin goto dfailed
if exist RSF.rsf del RSF.rsf
copy files\auto.rsf RSF.rsf
copy decrypted\exheader.bin exheader.bin
cls
if exist "decrypted\romfs.bin" xcopy /y "decrypted\romfs.bin"
cls
set /P yn=Would You Like To Replace The MD Rom [Y/N]?
if "%yn%"=="y" goto md_2a
if "%yn%"=="n" goto md_2b

:md_2a
cls
echo Please Wait..
echo.
files\ctrtool-a -x --romfsdir=romfs romfs.bin
cls
set /p rom2=Enter MD Rom Name (including extension):
if "%rom2%" == "" goto md_2a
cls
set /P title=Enter Game Title:
cls
set /P product=Enter Custom Product Code (XXX-X-XXXX):
cls
set /P uniqueid=Enter Custom Unique ID (Last 5 Digits):
cls
set "one=  Title                   : "00000000""
set "two=  Title                   : "%title%""
set "three=  ProductCode             : "000-0-0000""
set "four=  ProductCode             : "%product%""
set "five=  UniqueId                : 0x00000000
set "six=  UniqueId                : 0x000%uniqueid%
set "seven=  StackSize: 0x00000000"
set "eight=  StackSize: 0x00040000"
cls
set "source=files\auto.rsf"
set "target=RSF.rsf"
cls
setlocal enableDelayedExpansion
(
   for /F "tokens=1* delims=:" %%a in ('findstr /N "^" %source%') do (
      set "line=%%b"
      if defined line set "line=!line:%one%=%two%!"
      if defined line set "line=!line:%three%=%four%!"
	  if defined line set "line=!line:%five%=%six%!"
	  if defined line set "line=!line:%seven%=%eight%!"
      echo(!line!
   )
) > %target%
cls
for %%F in ("romfs\system\roms\*.*") do set name=%%~nxF
if exist romfs\system\roms\%name% del romfs\system\roms\%name%& copy "%rom2%" romfs\system\roms\%name%>NUL
if exist "romfs.bin" del "romfs.bin"
files\3dstool -c -t romfs --romfs-dir romfs -f romfs.bin
cls
echo Please Wait..
echo.
del *appdata.cxi
del *updatedata.cfa
cls
echo Please Wait..
echo.
files\ctrtool -t exheader decrypted\exheader.bin > exheaderinfo.txt
cls
echo Please Wait..
echo.
cls
echo Please Wait..
echo.
set md=0
set x64=_
files\%x64%makerom -f cxi -o rom.cxi -rsf RSF.rsf -target t -desc ecapp:5 -exheader decrypted\exheader.bin -exefslogo -code exefs\code.bin -romfs romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin
cls
echo Please Wait..
echo.
files\exinjector -rom rom.cxi -exheader decrypted\exheader.bin -sd
cls
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
if exist "*.DownloadPlay.romfs.xorpad" del /F /Q "*.DownloadPlay.romfs.xorpad"
cls
echo Please Wait..
echo.
files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -o ciarom.cia & goto md_5
goto autofail

:md_5
cls
set md=0
echo Please Wait..
echo.
cls
set /p rom3=Enter New CIA Name:
cls
if exist "%rom3%.cia" del /F /Q "%rom3%.cia"
rename ciarom.cia "%rom3%.cia"
if exist "%rom3% Results.txt" del /F /Q "%rom3% Results.txt"
rename Results.txt "%rom3% Results.txt"
if exist "rom.cxi" del /F /Q "rom.cxi"
if exist "romfs.bin" del /F /Q "romfs.bin"
if exist "*.Manual.romfs.xorpad" del /F /Q "*.Manual.romfs.xorpad"
if exist "*.DownloadPlay.romfs.xorpad" del /F /Q "*.DownloadPlay.romfs.xorpad"
RMDIR /S /Q "romfs"
set x64=""
set manual=""
set manual2=""
cls
echo CIA File Created Now Copy To 3DS Large SD Card And Install Through DevMenu
echo.
timeout 30
goto cleanup1

:md_2b
cls
echo Please Wait..
echo.
files\rsfgen.py "%rom%" true
goto md_2c

:md_2c
cls
echo Please Wait..
echo.
del *appdata.cxi
del *updatedata.cfa
cls
echo Please Wait..
echo.
files\ctrtool -t exheader decrypted\exheader.bin > exheaderinfo.txt
cls
echo Please Wait..
echo.
goto md_3

:md_3
cls
set md=0
echo Please Wait..
echo.
set x64=_
files\%x64%makerom -f cxi -o rom.cxi -rsf RSF.rsf -target t -desc ecapp:5 -exheader decrypted\exheader.bin -exefslogo -code exefs\code.bin -romfs decrypted\romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin
cls
echo Please Wait..
echo.
files\exinjector -rom rom.cxi -exheader decrypted\exheader.bin -sd
cls
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
if exist "*.DownloadPlay.romfs.xorpad" del /F /Q "*.DownloadPlay.romfs.xorpad"
cls
echo Please Wait..
echo.
files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -o ciarom.cia & goto md_4
goto autofail

:md_4
cls
echo Please Wait..
echo.
if exist "%rom:~0,-4% (SDK5) (MD).cia" del /F /Q "%rom:~0,-4% (SDK5) (MD).cia"
rename ciarom.cia "%rom:~0,-4% (SDK5) (MD).cia"
if exist "%rom:~0,-4% Results.txt" del /F /Q "%rom:~0,-4% Results.txt"
if exist "%rom:~0,-4% (SDK5) (MD) Results.txt" del /F /Q "%rom:~0,-4% (SDK5) (MD) Results.txt"
rename Results.txt "%rom:~0,-4% (SDK5) (MD) Results.txt"
if exist "rom.cxi" del /F /Q "rom.cxi"
if exist "romfs.bin" del /F /Q "romfs.bin"
if exist "*.Manual.romfs.xorpad" del /F /Q "*.Manual.romfs.xorpad"
if exist "*.DownloadPlay.romfs.xorpad" del /F /Q "*.DownloadPlay.romfs.xorpad"
RMDIR /S /Q "romfs"
set x64=""
set manual=""
set manual2=""
cls
echo CIA File Created Now Copy To 3DS Large SD Card And Install Through DevMenu
echo.
timeout 30
goto cleanup1

:cia
cls
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto cia2) else set rom=%rom%.3ds& goto cia2
goto cia

:cia2
cls
if "%rom%" == "" goto cia
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto cia
cls
echo Would You Like To Do The Rest Automatically..
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo Will Be Patched For The Following:
echo.
echo.
echo Removed Region Lock: No
echo Include The Manual: Choice
echo SDK Version: 5
echo Spoof Firmware: No
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /P yn=Do The Rest Automatically [Y/N]?
if "%yn%"=="y" goto cia4
if "%yn%"=="n" goto cia3
goto cia2

:cia3
cls
rem echo Try New Alternative Method
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo  1 - Continue
rem echo  2 - Alternative
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem echo.
rem set /p M2=Please Type 1 or 2:
rem IF %M2%==1 goto cia33
rem IF %M2%==2 goto newalt
rem IF %M2%=="" goto cia3
goto newalt

:cia33
if exist rom.bat del rom.bat
echo @echo off >> rom.bat
echo files\rom_tool.exe -i "%%rom%%" >> rom.bat
echo pause >> rom.bat
cls
start "New Window" cmd /c rom.bat
cls
if not exist "%rom% Files" mkdir "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_7x.xorpad" xcopy /y "*.Main.exefs_7x.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_norm.xorpad" xcopy /y "*.Main.exefs_norm.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exheader.xorpad" xcopy /y "*.Main.exheader.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.romfs.xorpad" xcopy /y "*.Main.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Manual.romfs.xorpad" xcopy /y "*.Manual.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.UpdateData.romfs.xorpad" xcopy /y "*.UpdateData.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.DownloadPlay.romfs.xorpad" xcopy /y "*.DownloadPlay.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\ncchinfo.bin" xcopy /y "ncchinfo.bin" "%rom% Files"
cls
rename *.exheader.xorpad exh.xorpad
rename *main.romfs.xorpad romfs.xorpad
if exist *UpdateData.romfs.xorpad del *UpdateData.romfs.xorpad
if not exist *exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs.xorpad
if exist *exefs_7x.xorpad ren *Main.exefs_7x.xorpad exefs_7x.xorpad
if exist exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs_norm.xorpad
cls
echo Please Wait..
echo.
files\ctrtool -p --exefs=exefs.bin "%rom%"
cls
echo Please Wait..
echo.
files\ctrtool -p --romfs=romfs.bin "%rom%"
cls
echo Please Wait..
echo.
files\ctrtool -p --exheader=exheader.bin "%rom%"
cls
echo Please Wait..
echo.
if exist exefs_7x.xorpad files\MEX.py exefs.bin exefs_norm.xorpad exefs_7x.xorpad exefs.xorpad
mkdir xorpads
mkdir encrypted_bin
mkdir decrypted
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exefs.bin exefs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exefs.bin -x exefs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exefs.bin -7 exefs_7x.xorpad
if exist files\padxorer4x.exe files\padxorer4x.exe exheader.bin exh.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exheader.bin -e exh.xorpad
if exist files\padxorer4x.exe files\padxorer4x.exe romfs.bin romfs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe romfs.bin -r romfs.xorpad
if exist exefs_7x.xorpad move exefs_7x.xorpad xorpads\exefs_7x.xorpad
if exist exefs_norm.xorpad move exefs_norm.xorpad xorpads\exefs_norm.xorpad
move exefs.xorpad xorpads\exefs.xorpad
move exh.xorpad xorpads\exh.xorpad
move romfs.xorpad xorpads\romfs.xorpad
move exheader.bin encrypted_bin\exheader.bin
move decrypted_exheader.bin decrypted\exheader.bin
cls
echo Please Wait..
echo.
files\ctrtool --exefsdir=exefs --decompresscode -t exefs decrypted_exefs.bin
goto nounpack

:cia4
cls
echo Did Your Previous Attempt Fail?
echo If So Try An Alternative Method
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo  1 - Continue Normally
echo  2 - Alternative 1
echo  3 - Alternative 2
echo  4 - Alternative 3
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p M1=Please Type 1, 2, 3 or 4:
IF %M1%==1 goto cia6
IF %M1%==2 goto cia7
IF %M1%==3 set alt=1& goto cia6
IF %M1%==4 goto cianew
IF %M1%=="" goto cia4
goto cia4

:cia6
cls
if exist Results.txt del /F /Q Results.txt
> Results.txt echo %rom:~0,-4%
>> Results.txt echo Region Lock: No
set /P yn=Would You Like To Include The Manual [Y/N]?
if "%yn%"=="y" set manual=ren CTR-P-CTAP_1_MANUAL.cfa manual.cfa&set manual1= -content manual.cfa:1:1& >> Results.txt echo Manual: Yes& goto cia6_1
if "%yn%"=="n" set manual=del manual.cfa& set manual2= (No Manual)& >> Results.txt echo Manual: No& goto cia6_1
goto cia6

:cia6_1
cls
>> Results.txt echo SDK: 5
if exist rom.bat del rom.bat
if not exist "%rom% Files" mkdir "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_7x.xorpad" xcopy /y "*.Main.exefs_7x.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_norm.xorpad" xcopy /y "*.Main.exefs_norm.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exheader.xorpad" xcopy /y "*.Main.exheader.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.romfs.xorpad" xcopy /y "*.Main.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Manual.romfs.xorpad" xcopy /y "*.Manual.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.UpdateData.romfs.xorpad" xcopy /y "*.UpdateData.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.DownloadPlay.romfs.xorpad" xcopy /y "*.DownloadPlay.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\ncchinfo.bin" xcopy /y "ncchinfo.bin" "%rom% Files"
rename *.exheader.xorpad exh.xorpad
rename *main.romfs.xorpad romfs.xorpad
if exist *UpdateData.romfs.xorpad del *UpdateData.romfs.xorpad
if not exist *exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs.xorpad
if exist *exefs_7x.xorpad ren *Main.exefs_7x.xorpad exefs_7x.xorpad
if exist exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs_norm.xorpad
cls
echo Please Wait..
echo.
files\ctrtool -p --exefs=exefs.bin "%rom%"
cls
echo Please Wait..
echo.
files\ctrtool -p --romfs=romfs.bin "%rom%"
cls
echo Please Wait..
echo.
files\ctrtool -p --exheader=exheader.bin "%rom%"
cls
echo Please Wait..
echo.
if exist exefs_7x.xorpad files\MEX.py exefs.bin exefs_norm.xorpad exefs_7x.xorpad exefs.xorpad
mkdir xorpads
mkdir encrypted_bin
mkdir decrypted
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exefs.bin exefs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exefs.bin -x exefs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exefs.bin -7 exefs_7x.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exheader.bin exh.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exheader.bin -e exh.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe romfs.bin romfs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe romfs.bin -r romfs.xorpad
cls
echo Please Wait..
echo.
if exist exefs_7x.xorpad move exefs_7x.xorpad xorpads\exefs_7x.xorpad
if exist exefs_norm.xorpad move exefs_norm.xorpad xorpads\exefs_norm.xorpad
move exefs.xorpad xorpads\exefs.xorpad
move exh.xorpad xorpads\exh.xorpad
move romfs.xorpad xorpads\romfs.xorpad
move exheader.bin encrypted_bin\exheader.bin
move decrypted_exheader.bin decrypted\exheader.bin
cls
echo Please Wait..
echo.
files\ctrtool --exefsdir=exefs --decompresscode -t exefs decrypted_exefs.bin
cls
echo Please Wait..
echo.
move exefs.bin encrypted_bin\exefs.bin
move romfs.bin encrypted_bin\romfs.bin
move decrypted_exefs.bin decrypted\exefs.bin
move decrypted_romfs.bin decrypted\romfs.bin
cls
echo Please Wait..
echo.
if not exist decrypted\exefs.bin goto dfailed
if not exist decrypted\romfs.bin goto dfailed
if not exist decrypted\exheader.bin goto dfailed
if not exist exefs\banner.bin goto dfailed
if not exist exefs\code.bin goto dfailed
if exist RSF.rsf rename RSF.rsf RSF3.rsf
copy files\auto.rsf RSF.rsf
copy decrypted\exheader.bin exheader.bin
cls
echo Please Wait..
echo.
files\rsfgen.py "%rom%" false
cls
echo Please Wait..
echo.
if exist *.Manual.romfs.xorpad (files\rom_tool --extract=. "%rom%") else if exist *DownloadPlay.romfs.xorpad (files\rom_tool --extract=. "%rom%")
cls
echo Please Wait..
echo.
if exist "*.Manual.romfs.xorpad" move *.Manual.romfs.xorpad xorpads\Manual.romfs.xorpad
cls
echo Please Wait..
echo.
if exist *.DownloadPlay.romfs.xorpad copy xorpads\DownloadPlay.romfs.xorpad
cls
echo Please Wait..
echo.
if exist *.DownloadPlay.romfs.xorpad ren *DLP.cfa dlp.cfa
del *appdata.cxi
del *updatedata.cfa
%manual%
cls
echo Please Wait..
echo.
files\ctrtool -t exheader decrypted\exheader.bin > exheaderinfo.txt
cls
echo Please Wait..
echo.
if %alt% equ 1 goto alt1
goto cia6_2

:cianew
cls
if exist Results.txt del /F /Q Results.txt
> Results.txt echo %rom:~0,-4%
>> Results.txt echo Region Lock: No
set /P yn=Would You Like To Include The Manual [Y/N]?
if "%yn%"=="y" set manual=ren CTR-P-CTAP_1_MANUAL.cfa manual.cfa& >> Results.txt echo Manual: Yes& goto cianew_1
if "%yn%"=="n" set manual=del manual.cfa& set manual2= (No Manual)& >> Results.txt echo Manual: No& goto cianew_1
goto cianew

:cianew_1
cls
>> Results.txt echo SDK: 5
>> Results.txt echo AMC: 3
if exist rom.bat del rom.bat
if not exist "%rom% Files" mkdir "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_7x.xorpad" xcopy /y "*.Main.exefs_7x.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_norm.xorpad" xcopy /y "*.Main.exefs_norm.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exheader.xorpad" xcopy /y "*.Main.exheader.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.romfs.xorpad" xcopy /y "*.Main.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Manual.romfs.xorpad" xcopy /y "*.Manual.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.UpdateData.romfs.xorpad" xcopy /y "*.UpdateData.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.DownloadPlay.romfs.xorpad" xcopy /y "*.DownloadPlay.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\ncchinfo.bin" xcopy /y "ncchinfo.bin" "%rom% Files"
if exist *UpdateData.romfs.xorpad del *UpdateData.romfs.xorpad
cls
echo Please Wait..
echo.
files\ctrtool1 -p --exheader=exheaderEncrypted.bin --romfs=romfsEncrypted.bin --exefs=exefsEncrypted.bin --logo=logo.bin "%rom%"
cls
echo Please Wait..
echo.
if not exist *exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs.xorpad
if exist *exefs_7x.xorpad ren *Main.exefs_7x.xorpad exefs_7x.xorpad
if exist exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs_norm.xorpad
if exist exefs_7x.xorpad files\MEX.py exefsEncrypted.bin exefs_norm.xorpad exefs_7x.xorpad exefs.xorpad
ren *main.romfs.xorpad romfs.xorpad
ren *main.exheader.xorpad exheader.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe romfsEncrypted.bin romfs.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exheaderEncrypted.bin exheader.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exefsEncrypted.bin exefs.xorpad
cls
echo Please Wait..
echo.
ren romfsEncrypted.bin.out romfs.bin
ren exefsEncrypted.bin.out exefs.bin
ren exheaderEncrypted.bin.out exheader.bin
cls
echo Please Wait..
echo.
files\ctrtool1 -t exefs --exefsdir=exefs exefs.bin --decompresscode
cls
echo Please Wait..
echo.
mkdir decrypted
mkdir xorpads
if exist *Manual.romfs.xorpad (files\rom_tool --extract=. "%rom%") else if exist *DownloadPlay.romfs.xorpad (files\rom_tool --extract=. "%rom%")
if exist *Manual.romfs.xorpad ren *manual*.cfa manual.cfa
if exist *DownloadPlay.romfs.xorpad ren *DLP.cfa dlp.cfa
%manual%
del *appdata.cxi
del *updatedata.cfa
move exefs.bin decrypted\exefs.bin
move romfs.bin decrypted\romfs.bin
move exefs.xorpad xorpads\exefs.xorpad
move romfs.xorpad xorpads\romfs.xorpad
move exheader.xorpad xorpads\exheader.xorpad
copy files\auto6.rsf RSF.rsf
cls
echo Please Wait..
echo.
files\rsfgen.py "%rom%" false
cls
echo Please Wait..
echo.
set /P yn=Would You Like To Alter The Romfs Files [Y/N]?
if "%yn%"=="y" goto cianew_2
if "%yn%"=="n" goto cianew_3

:cianew_2
cls
echo Please Wait..
echo.
if exist "romfs.bin" del /F /Q "romfs.bin"
files\ctrtool -x --romfsdir=romfs decrypted\romfs.bin
cls
echo Nows The Time To Alter Any Romfs or Exefs Files..
echo.
pause
cls
echo Please Wait..
echo.
files\3dstool -c -t romfs --romfs-dir romfs -f romfs.bin
cls
RMDIR /S /Q "romfs"
if exist decrypted\romfs.bin del decrypted\romfs.bin
if exist "romfs.bin" xcopy /y "romfs.bin" "decrypted"
goto cianew_3

:cianew_3
cls
echo Please Wait..
echo.
files\ctrtool -t exheader exheader.bin > exheaderinfo.txt
cls
echo Please Wait..
echo.
files\makerom3 -f cxi -o rom.cxi -rsf RSF.rsf -target t -desc ecapp:5 -exheader exheader.bin -exefslogo -code exefs\code.bin -romfs decrypted\romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin%manual1%
cls
echo Please Wait..
echo.
files\exinjector -rom rom.cxi -exheader exheader.bin -sd
cls
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
if exist dlp.cfa goto cianew_dlp
cls
echo Please Wait..
echo.
files\makerom3 -f cci -target d -content rom.cxi:0:0 -o new.3ds
pause
If exist "manual.cfa" If not exist "dlp.cfa" files\makerom3 -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If not exist "manual.cfa" If not exist "dlp.cfa" files\makerom3 -f cia -target t -content rom.cxi:0:0 -o ciarom.cia & goto cia5_1
goto cianew_1

:cianew_dlp
cls
echo Please Wait..
echo.
If exist "manual.cfa" If exist "dlp.cfa" files\makerom3 -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If not exist "manual.cfa" If exist "dlp.cfa" files\makerom3 -f cia -target t -content rom.cxi:0:0 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5_1
goto cianew_dlp

:alt1
cls
echo Please Wait..
echo.
>> Results.txt echo AMC: 2
>> Results.txt echo Spoof Firmware: No
echo Please Wait A While..
echo.
set x64=_
set amc= (AMC2)
files\%x64%makerom -f cia -o ciarom.cia -rsf RSF.rsf -target t -desc app:5 -exheader decrypted\exheader.bin -exefslogo -code exefs\code.bin -romfs decrypted\romfs.bin  -icon exefs\icon.bin -banner exefs\banner.bin%manual1%
cls
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
rename ciarom.cia "%rom:~0,-4% (SDK5)%amc%%manual2%.cia"
if exist "%rom:~0,-4% Results.txt" del /F /Q "%rom:~0,-4% Results.txt"
rename Results.txt "%rom:~0,-4% Results.txt"
if exist "rom.cxi" del /F /Q "rom.cxi"
set x64=""
set amc=""
set manual=""
set manual1=""
set manual2=""
cls
echo CIA File Created Now Copy To 3DS Large SD Card And Install Through DevMenu
echo.
timeout 30
goto cleanup1

:cia6_2
cls
set x64=_
files\%x64%makerom -f cxi -o rom.cxi -rsf RSF.rsf -target t -desc ecapp:5 -exheader decrypted\exheader.bin -exefslogo -code exefs\code.bin -romfs decrypted\romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin
cls
echo Please Wait..
echo.
files\exinjector -rom rom.cxi -exheader decrypted\exheader.bin -sd
cls
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
if exist "*.DownloadPlay.romfs.xorpad" del /F /Q "*.DownloadPlay.romfs.xorpad"
cls
echo Please Wait..
echo.
if not exist "manual.cfa" If not exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If exist "manual.cfa" If not exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If exist "manual.cfa" If exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If exist "dlp.cfa" If not exist "manual.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5_1
goto autofail

:cia7
cls
if exist Results.txt del /F /Q Results.txt
> Results.txt echo %rom:~0,-4%
>> Results.txt echo Region Lock: No
set /P yn=Would You Like To Include The Manual [Y/N]?
if "%yn%"=="y" set manual=ren CTR-P-CTAP_1_MANUAL.cfa manual.cfa& >> Results.txt echo Manual: Yes& goto cia7_1
if "%yn%"=="n" set manual=del manual.cfa& set manual2= (No Manual)& >> Results.txt echo Manual: No& goto cia7_1

:cia7_1
>> Results.txt echo Firmware Spoof: No
cls
echo Please Wait..
echo.
if exist rom.bat del rom.bat
if not exist "%rom% Files" mkdir "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_7x.xorpad" xcopy /y "*.Main.exefs_7x.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_norm.xorpad" xcopy /y "*.Main.exefs_norm.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exheader.xorpad" xcopy /y "*.Main.exheader.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.romfs.xorpad" xcopy /y "*.Main.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Manual.romfs.xorpad" xcopy /y "*.Manual.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.UpdateData.romfs.xorpad" xcopy /y "*.UpdateData.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.DownloadPlay.romfs.xorpad" xcopy /y "*.DownloadPlay.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\ncchinfo.bin" xcopy /y "ncchinfo.bin" "%rom% Files"
rename *.exheader.xorpad exh.xorpad
rename *main.romfs.xorpad romfs.xorpad
if exist *UpdateData.romfs.xorpad del *UpdateData.romfs.xorpad
if not exist *exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs.xorpad
if exist *exefs_7x.xorpad ren *Main.exefs_7x.xorpad exefs_7x.xorpad
if exist exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs_norm.xorpad
cls
echo Please Wait..
echo.
files\ctrtool -p --exefs=exefs.bin "%rom%"
cls
echo Please Wait..
echo.
files\ctrtool -p --romfs=romfs.bin "%rom%"
cls
echo Please Wait..
echo.
files\ctrtool -p --exheader=exheader.bin "%rom%"
cls
echo Please Wait..
echo.
if exist exefs_7x.xorpad files\MEX.py exefs.bin exefs_norm.xorpad exefs_7x.xorpad exefs.xorpad
mkdir xorpads
mkdir encrypted_bin
mkdir decrypted
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exefs.bin exefs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exefs.bin -x exefs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exefs.bin -7 exefs_7x.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exheader.bin exh.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exheader.bin -e exh.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe romfs.bin romfs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe romfs.bin -r romfs.xorpad
cls
echo Please Wait..
echo.
if exist exefs_7x.xorpad move exefs_7x.xorpad xorpads\exefs_7x.xorpad
if exist exefs_norm.xorpad move exefs_norm.xorpad xorpads\exefs_norm.xorpad
move exefs.xorpad xorpads\exefs.xorpad
move exh.xorpad xorpads\exh.xorpad
move romfs.xorpad xorpads\romfs.xorpad
move exheader.bin encrypted_bin\exheader.bin
move decrypted_exheader.bin decrypted\exheader.bin
cls
echo Please Wait..
echo.
files\ctrtool --exefsdir=exefs --decompresscode -t exefs decrypted_exefs.bin
cls
echo Please Wait..
echo.
move exefs.bin encrypted_bin\exefs.bin
move romfs.bin encrypted_bin\romfs.bin
move decrypted_exefs.bin decrypted\exefs.bin
move decrypted_romfs.bin decrypted\romfs.bin
cls
echo Please Wait..
echo.
if not exist decrypted\exefs.bin goto dfailed
if not exist decrypted\romfs.bin goto dfailed
if not exist decrypted\exheader.bin goto dfailed
if not exist exefs\banner.bin goto dfailed
if not exist exefs\code.bin goto dfailed
if exist RSF.rsf rename RSF.rsf RSF3.rsf
copy files\auto.rsf RSF.rsf
copy decrypted\exheader.bin exheader.bin
cls
echo Please Wait..
echo.
files\rsfgen.py "%rom%" false
cls
echo Please Wait..
echo.
if exist *.Manual.romfs.xorpad (files\rom_tool --extract=. "%rom%") else if exist *DownloadPlay.romfs.xorpad (files\rom_tool --extract=. "%rom%")
cls
echo Please Wait..
echo.
if exist "*.Manual.romfs.xorpad" move *.Manual.romfs.xorpad xorpads\Manual.romfs.xorpad
cls
echo Please Wait..
echo.
if exist *.DownloadPlay.romfs.xorpad copy xorpads\DownloadPlay.romfs.xorpad
cls
echo Please Wait..
echo.
if exist *.DownloadPlay.romfs.xorpad ren *DLP.cfa dlp.cfa
del *appdata.cxi
del *updatedata.cfa
%manual%
cls
echo Please Wait..
echo.
files\ctrtool -t exheader decrypted\exheader.bin > exheaderinfo.txt
cls
echo Please Wait..
echo.
set x64=_
files\%x64%makerom-a -f cxi -o rom.cxi -target g -desc app:5 -rsf RSF.rsf -icon exefs\icon.bin -banner exefs\banner.bin -exefslogo -code exefs\code.bin -exheader decrypted\exheader.bin -romfs decrypted\romfs.bin
cls
echo Please Wait..
echo.
files\exinjector -rom rom.cxi -exheader decrypted\exheader.bin -sd
cls
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
if exist "*.DownloadPlay.romfs.xorpad" del /F /Q "*.DownloadPlay.romfs.xorpad"
cls
echo Please Wait..
echo.
if not exist "manual.cfa" If not exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -o ciarom.cia & goto cia5
cls
echo Please Wait..
echo.
If exist "manual.cfa" If not exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -o ciarom.cia & goto cia5
cls
echo Please Wait..
echo.
If exist "manual.cfa" If exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5
cls
echo Please Wait..
echo.
If exist "dlp.cfa" If not exist "manual.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5
goto autofail

:autofail
cls
echo Something Must Have Gone Wrong
echo Continue To The Cleanup And Try Again..
echo.
pause
goto cleanup1

:cia5
cls
echo Please Wait..
echo.
set amc= (AMC1)
>> Results.txt echo AMC: 1
rename ciarom.cia "%rom:~0,-4% (SDK5)%amc%%manual2%.cia"
if exist "%rom:~0,-4% Results.txt" del /F /Q "%rom:~0,-4% Results.txt"
rename Results.txt "%rom:~0,-4% Results.txt"
if exist "rom.cxi" del /F /Q "rom.cxi"
set x64=""
set amc=""
set manual=""
set manual2=""
cls
echo CIA File Created Now Copy To 3DS Large SD Card And Install Through DevMenu
echo.
timeout 30
goto cleanup1

:cia5_1
cls
echo Please Wait..
echo.
if exist ciarom.cia rename ciarom.cia "%rom:~0,-4% (SDK5)%manual2%.cia"
if exist "%rom:~0,-4% Results.txt" del /F /Q "%rom:~0,-4% Results.txt"
if exist Results.txt rename Results.txt "%rom:~0,-4% Results.txt"
if exist "rom.cxi" del /F /Q "rom.cxi"
cls
echo Please Wait..
echo.
if exist "romfsEncrypted.bin" del /F /Q "romfsEncrypted.bin"
if exist "logo.bin" del /F /Q "logo.bin"
if exist "exheaderEncrypted.bin" del /F /Q "exheaderEncrypted.bin"
if exist "exheader.xorpad" del /F /Q "exheader.xorpad"
if exist "exefsEncrypted.bin" del /F /Q "exefsEncrypted.bin"
set x64=""
set manual=""
set manual2=""
cls
echo CIA File Created Now Copy To 3DS Large SD Card And Install Through DevMenu
echo.
timeout 30
goto cleanup1

:unpack
cls
set /P yn=Do You Want To Unpack romfs.bin [Y/N]?
if /I "%yn%"=="y" goto yesunpack
if /I "%yn%"=="n" goto nounpack
goto unpack

:yesunpack
cls
files\ctrtool --romfsdir=romfs decrypted_romfs.bin
move romfs decrypted\romfs
goto nounpack

:nounpack
cls
move exefs.bin encrypted_bin\exefs.bin
move romfs.bin encrypted_bin\romfs.bin
move decrypted_exefs.bin decrypted\exefs.bin
move decrypted_romfs.bin decrypted\romfs.bin
goto check4

:rsffile
cls
if exist RSF.rsf rename RSF.rsf RSF3.rsf
copy files\auto.rsf RSF.rsf
goto rsffile2

:rsffile2
cls
set /P yn=Do You Want To Remove Region Lock [Y/N]?
if /I "%yn%"=="y" goto yesregionlock
if /I "%yn%"=="n" goto noregionlock
goto rsffile2

:yesregionlock
cls
if exist Results.txt del /F /Q Results.txt
> Results.txt echo %rom:~0,-4%
>> Results.txt echo Region Lock: Yes
copy exheader.bin.out exheader.bin
copy decrypted\exheader.bin exheader.bin
files\rsfgen.py "%rom%" true
goto doneregionlock

:noregionlock
cls
> Results.txt echo %rom:~0,-4%
>> Results.txt echo Region Lock: No
copy exheader.bin.out exheader.bin
copy decrypted\exheader.bin exheader.bin
files\rsfgen.py "%rom%" false
goto doneregionlock

:doneregionlock
cls
echo Please Wait..
echo.
if exist *.Manual.romfs.xorpad (files\rom_tool --extract=. "%rom%") else if exist *DownloadPlay.romfs.xorpad (files\rom_tool --extract=. "%rom%")
if exist "*.Manual.romfs.xorpad" move *.Manual.romfs.xorpad xorpads\Manual.romfs.xorpad
if exist *.DownloadPlay.romfs.xorpad copy xorpads\DownloadPlay.romfs.xorpad
if exist *.DownloadPlay.romfs.xorpad ren *DLP.cfa dlp.cfa
del *appdata.cxi
del *updatedata.cfa
goto doneregionlock2

:doneregionlock2
cls
set /P yn=Would You Like The CIA TO Include The Manual [Y/N]?
if "%yn%"=="y" set manual1= -content manual.cfa:1:1& goto yesmanual
if "%yn%"=="n" set manual2= (No Manual)& goto nomanual
goto doneregionlock2

:yesmanual
cls
>> Results.txt echo Manual: Yes
ren CTR-P-CTAP_1_MANUAL.cfa manual.cfa
goto exheaderinfo

:nomanual
cls
>> Results.txt echo Manual: No
del manual.cfa
goto exheaderinfo

:exheaderinfo
cls
files\ctrtool -t exheader decrypted\exheader.bin > exheaderinfo.txt
cls
echo Did Your Previous Attempt Fail?
echo If So Try An Alternative Method
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo  1 - Continue Normally
echo  2 - Alternative 1
echo  3 - Alternative 2
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
set /p M1=Please Type 1, 2 or 3:
IF %M1%==1 goto continue
IF %M1%==2 goto continue9
IF %M1%==3 set alt=1& goto continue
IF %M1%=="" goto exheaderinfo
goto exheaderinfo

:continue
cls
echo Dont Go Any Higher Than 5 Or It Wont Work..
echo.
set /p sdk=Please Enter SDK Version (eg 1-5):
if "%sdk%" == "" goto continue
echo.
>> Results.txt echo SDK: %sdk%
cls
set /P yn=Do You Want To Use makerom x64 [Y/N]?
if /I "%yn%"=="y" goto continue5
if /I "%yn%"=="n" goto continue6
goto continue

:continue9
cls
echo Dont Go Any Higher Than 5 Or It Wont Work..
echo.
set /p sdk=Please Enter SDK Version (eg 1-5):
if "%sdk%" == "" goto continue9
echo.
>> Results.txt echo SDK: %sdk%
cls
set /P yn=Do You Want To Use makerom x64 [Y/N]?
if /I "%yn%"=="y" goto continue7
if /I "%yn%"=="n" goto continue8
goto continue9

:continue5
cls
echo Please Wait..
echo.
if %alt% equ 1 goto alt2
goto continue5_1

:alt2
cls
echo Please Wait..
echo.
>> Results.txt echo Makerom: x64
>> Results.txt echo AMC: 2
>> Results.txt echo Spoof Firmware: No
echo Please Wait A While..
echo.
set x64=_
set amc= (AMC2)
files\%x64%makerom -f cia -o ciarom.cia -rsf RSF.rsf -target t -desc app:"%sdk%" -exheader decrypted\exheader.bin -exefslogo -code exefs\code.bin -romfs decrypted\romfs.bin  -icon exefs\icon.bin -banner exefs\banner.bin%manual1%
cls
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
rename ciarom.cia "%rom:~0,-4% (SDK5%sdk%)%amc%%manual2%.cia"
if exist "%rom:~0,-4% Results.txt" del /F /Q "%rom:~0,-4% Results.txt"
rename Results.txt "%rom:~0,-4% Results.txt"
if exist "rom.cxi" del /F /Q "rom.cxi"
set x64=""
set amc=""
set manual=""
set manual1=""
set manual2=""
cls
echo CIA File Created Now Copy To 3DS Large SD Card And Install Through DevMenu
echo.
timeout 30
goto cleanup1

:alt3
cls
echo Please Wait..
echo.
>> Results.txt echo Makerom: x86
>> Results.txt echo AMC: 2
>> Results.txt echo Spoof Firmware: No
echo Please Wait A While..
echo.
set x64=""
set amc= (AMC2)
files\%x64%makerom -f cia -o ciarom.cia -rsf RSF.rsf -target t -desc app:"%sdk%" -exheader decrypted\exheader.bin -exefslogo -code exefs\code.bin -romfs decrypted\romfs.bin  -icon exefs\icon.bin -banner exefs\banner.bin%manual1%
cls
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
rename ciarom.cia "%rom:~0,-4% (SDK%sdk%)%amc%%manual2%.cia"
if exist "%rom:~0,-4% Results.txt" del /F /Q "%rom:~0,-4% Results.txt"
rename Results.txt "%rom:~0,-4% Results.txt"
if exist "rom.cxi" del /F /Q "rom.cxi"
set amc=""
set manual=""
set manual1=""
set manual2=""
cls
echo CIA File Created Now Copy To 3DS Large SD Card And Install Through DevMenu
echo.
timeout 30
goto cleanup1

:continue5_1
cls
echo Please Wait..
echo.
mkdir "exefs"
copy exefs.bin.out exefs.bin "decrypted"
copy exheader.bin exheader.bin "decrypted"
copy romfs.bin.out romfs.bin "decrypted"
>> Results.txt echo Makerom: x86
set x64=_
files\%x64%makerom -f cxi -o rom.cxi -rsf RSF.rsf -target t -desc ecapp:"%sdk%" -exheader decrypted\exheader.bin -exefslogo -code exefs\code.bin -romfs decrypted\romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin
goto continue0

:continue6
cls
echo Please Wait..
echo.
if %alt% equ 1 goto alt3
goto continue6_1

:continue6_1
cls
>> Results.txt echo Makerom: x86
echo Please Wait..
echo.
files\%x64%makerom -f cxi -o rom.cxi -rsf RSF.rsf -target t -desc ecapp:"%sdk%" -exheader decrypted\exheader.bin -exefslogo -code exefs\code.bin -romfs decrypted\romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin
goto continue0

:continue7
cls
>> Results.txt echo Makerom: x64
>> Results.txt echo AMC: 1
echo Please Wait..
echo.
set x64=_
set amc= (AMC1)
files\%x64%makerom-a -f cxi -o rom.cxi -target g -desc app:"%sdk%" -rsf RSF.rsf -icon exefs\icon.bin -banner exefs\banner.bin -exefslogo -code exefs\code.bin -exheader decrypted\exheader.bin -romfs decrypted\romfs.bin
goto continue0

:continue8
cls
>> Results.txt echo Makerom: x86
>> Results.txt echo AMC: 1
echo Please Wait..
echo.
set amc= (AMC1)
files\%x64%makerom-a -f cxi -o rom.cxi -target g -desc app:"%sdk%" -rsf RSF.rsf -icon exefs\icon.bin -banner exefs\banner.bin -exefslogo -code exefs\code.bin -exheader decrypted\exheader.bin -romfs decrypted\romfs.bin
goto continue0

:continue0
cls
set /P yn=Do You Want To Spoof Firmware [Y/N]?
if /I "%yn%"=="y" goto continue1
if /I "%yn%"=="n" goto continue2
goto continue9

:continue1
cls
echo Please Wait..
echo.
>> Results.txt echo Spoof Firmware: Yes
files\exinjector -rom rom.cxi -exheader decrypted\exheader.bin -sd -fwspoof
goto continue3

:continue2
cls
echo Please Wait..
echo.
>> Results.txt echo Spoof Firmware: No
files\exinjector -rom rom.cxi -exheader decrypted\exheader.bin -sd
goto continue3

:continue3
cls
echo Please Wait..
echo.
if exist "*.DownloadPlay.romfs.xorpad" del /F /Q "*.DownloadPlay.romfs.xorpad"
cls
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
if not exist "manual.cfa" If not exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -o ciarom.cia & goto continue4
If exist "manual.cfa" If not exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -o ciarom.cia & goto continue4
If exist "manual.cfa" If exist "dlp.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -content dlp.cfa:2:2 -o ciarom.cia & goto continue4
If exist "dlp.cfa" If not exist "manual.cfa" files\%x64%makerom -f cia -target t -content rom.cxi:0:0 -content dlp.cfa:2:2 -o ciarom.cia & goto continue4
goto error

:continue4
cls
echo Please Wait..
echo.
rename ciarom.cia "%rom:~0,-4% (SDK%sdk%)%amc%%manual2%.cia"
if exist "%rom:~0,-4% Results.txt" del /F /Q "%rom:~0,-4% Results.txt"
rename Results.txt "%rom:~0,-4% Results.txt"
set amc=""
if exist "rom.cxi" del /F /Q "rom.cxi"
set x64=""
echo CIA File Created Now Copy To 3DS Large SD Card And Install Through DevMenu
echo.
pause
goto cleanup

:newalt
cls
echo Dont Go Any Higher Than 5 Or It Wont Work..
echo.
set /p sdk=Please Enter SDK Version (eg 1-5):
if "%sdk%" == "" goto newalt
echo.
>> Results.txt echo SDK: %sdk%
cls
set /P yn=Do You Want To Use makerom x64 [Y/N]?
if /I "%yn%"=="y" goto newalt_1
if /I "%yn%"=="n" goto newalt_4
goto newalt

:newalt_1
cls
echo Please Wait..
echo.
if exist Results.txt del /F /Q Results.txt
> Results.txt echo %rom:~0,-4%
cls
set /P yn=Do You Want To Remove Region Lock [Y/N]?
if /I "%yn%"=="y" >> Results.txt echo Region Lock: Yes&set reg=true
if /I "%yn%"=="n" >> Results.txt echo Region Lock: No&set reg=false
cls
>> Results.txt echo Makerom: x64
cls
set /P yn=Would You Like To Include The Manual [Y/N]?
if "%yn%"=="y" set manual=ren CTR-P-CTAP_1_MANUAL.cfa manual.cfa& >> Results.txt echo Manual: Yes& goto newalt_2
if "%yn%"=="n" set manual=del manual.cfa& set manual2= (No Manual)& >> Results.txt echo Manual: No& goto newalt_2
goto newalt_1

:newalt_2
cls
echo Please Wait..
echo.
>> Results.txt echo SDK: %sdk%
>> Results.txt echo AMC: 3
if exist rom.bat del rom.bat
if not exist "%rom% Files" mkdir "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_7x.xorpad" xcopy /y "*.Main.exefs_7x.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_norm.xorpad" xcopy /y "*.Main.exefs_norm.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exheader.xorpad" xcopy /y "*.Main.exheader.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.romfs.xorpad" xcopy /y "*.Main.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Manual.romfs.xorpad" xcopy /y "*.Manual.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.UpdateData.romfs.xorpad" xcopy /y "*.UpdateData.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.DownloadPlay.romfs.xorpad" xcopy /y "*.DownloadPlay.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\ncchinfo.bin" xcopy /y "ncchinfo.bin" "%rom% Files"
if exist *UpdateData.romfs.xorpad del *UpdateData.romfs.xorpad
if exist "encrypted_bin\exheader.bin" xcopy /y "encrypted_bin\exheader.bin"
cls
echo Please Wait..
echo.
files\ctrtool1 -p --exheader=exheaderEncrypted.bin --romfs=romfsEncrypted.bin --exefs=exefsEncrypted.bin --logo=logo.bin "%rom%"
cls
echo Please Wait..
echo.
if not exist *exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs.xorpad
if exist *exefs_7x.xorpad ren *Main.exefs_7x.xorpad exefs_7x.xorpad
if exist exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs_norm.xorpad
if exist exefs_7x.xorpad files\MEX.py exefsEncrypted.bin exefs_norm.xorpad exefs_7x.xorpad exefs.xorpad
ren *main.romfs.xorpad romfs.xorpad
ren *main.exheader.xorpad exheader.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe romfsEncrypted.bin romfs.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exheaderEncrypted.bin exheader.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exefsEncrypted.bin exefs.xorpad
cls
echo Please Wait..
echo.
ren romfsEncrypted.bin.out romfs.bin
ren exefsEncrypted.bin.out exefs.bin
ren exheaderEncrypted.bin.out exheader.bin
cls
echo Please Wait..
echo.
files\ctrtool1 -t exefs --exefsdir=exefs exefs.bin --decompresscode
cls
echo Please Wait..
echo.
mkdir decrypted
mkdir xorpads
if exist *Manual.romfs.xorpad (files\rom_tool --extract=. "%rom%") else if exist *DownloadPlay.romfs.xorpad (files\rom_tool --extract=. "%rom%")
if exist *Manual.romfs.xorpad ren *manual*.cfa manual.cfa
if exist *DownloadPlay.romfs.xorpad ren *DLP.cfa dlp.cfa
%manual%
cls
echo Please Wait..
echo.
rem files\ctrtool1 --romfsdir=romfs romfs.bin
rem move romfs decrypted\romfs
rem pause
rem cls
rem echo Please Wait..
rem echo.
del *appdata.cxi
del *updatedata.cfa
move exefs.bin decrypted\exefs.bin
move romfs.bin decrypted\romfs.bin
move exefs.xorpad xorpads\exefs.xorpad
move romfs.xorpad xorpads\romfs.xorpad
copy files\auto6.rsf RSF.rsf
cls
echo Please Wait..
echo.
files\rsfgen.py "%rom%" %reg%
cls
echo Please Wait..
echo.
files\ctrtool -t exheader exheader.bin > exheaderinfo.txt
cls
echo Please Wait..
echo.
files\makerom3 -f cxi -o rom.cxi -rsf RSF.rsf -target t -desc ecapp:%sdk% -exheader exheader.bin -exefslogo -code exefs\code.bin -romfs decrypted\romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin
cls
echo Please Wait..
echo.
goto spoof

:spoof
cls
set /P yn=Would You Like To Spoof Firmware to 4.xx [Y/N]?
if "%yn%"=="y" >> Results.txt echo Firmware Spoof: Yes& goto spoof1
if "%yn%"=="n" >> Results.txt echo Firmware Spoof: No& goto spoof2
goto spoof

:spoof1
cls
files\exinjector -rom rom.cxi -exheader exheader.bin -sd -fwspoof
cls
taskkill /F /IM cscript.exe
cls
goto spoof2_1

:spoof2
cls
files\exinjector -rom rom.cxi -exheader exheader.bin -sd
cls
taskkill /F /IM cscript.exe
goto spoof2_1

:spoof2_1
cls
echo Please Wait..
echo.
if exist dlp.cfa goto newalt_3
cls
echo Please Wait..
echo.
If exist "manual.cfa" If not exist "dlp.cfa" files\makerom3 -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If not exist "manual.cfa" If not exist "dlp.cfa" files\makerom3 -f cia -target t -content rom.cxi:0:0 -o ciarom.cia & goto cia5_1
goto newalt

:newalt_3
cls
echo Please Wait..
echo.
If exist "manual.cfa" If exist "dlp.cfa" files\makerom3 -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If not exist "manual.cfa" If exist "dlp.cfa" files\makerom3 -f cia -target t -content rom.cxi:0:0 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5_1
goto newalt_3

:newalt_4
cls
echo Please Wait..
echo.
if exist Results.txt del /F /Q Results.txt
> Results.txt echo %rom:~0,-4%
cls
set /P yn=Do You Want To Remove Region Lock [Y/N]?
if /I "%yn%"=="y" >> Results.txt echo Region Lock: Yes&set reg=true
if /I "%yn%"=="n" >> Results.txt echo Region Lock: No&set reg=false
cls
>> Results.txt echo Makerom: x86
cls
set /P yn=Would You Like To Include The Manual [Y/N]?
if "%yn%"=="y" set manual=ren CTR-P-CTAP_1_MANUAL.cfa manual.cfa& >> Results.txt echo Manual: Yes& goto newalt_5
if "%yn%"=="n" set manual=del manual.cfa& set manual2= (No Manual)& >> Results.txt echo Manual: No& goto newalt_5
goto newalt_4

:newalt_5
cls
echo Please Wait..
echo.
>> Results.txt echo SDK: %sdk%
if exist rom.bat del rom.bat
if not exist "%rom% Files" mkdir "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_7x.xorpad" xcopy /y "*.Main.exefs_7x.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_norm.xorpad" xcopy /y "*.Main.exefs_norm.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exheader.xorpad" xcopy /y "*.Main.exheader.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.romfs.xorpad" xcopy /y "*.Main.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Manual.romfs.xorpad" xcopy /y "*.Manual.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.UpdateData.romfs.xorpad" xcopy /y "*.UpdateData.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.DownloadPlay.romfs.xorpad" xcopy /y "*.DownloadPlay.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\ncchinfo.bin" xcopy /y "ncchinfo.bin" "%rom% Files"
if exist *UpdateData.romfs.xorpad del *UpdateData.romfs.xorpad
if exist "encrypted_bin\exheader.bin" xcopy /y "encrypted_bin\exheader.bin"
cls
echo Please Wait..
echo.
files\ctrtool1 -p --exheader=exheaderEncrypted.bin --romfs=romfsEncrypted.bin --exefs=exefsEncrypted.bin --logo=logo.bin "%rom%"
cls
echo Please Wait..
echo.
if not exist *exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs.xorpad
if exist *exefs_7x.xorpad ren *Main.exefs_7x.xorpad exefs_7x.xorpad
if exist exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs_norm.xorpad
if exist exefs_7x.xorpad files\MEX.py exefsEncrypted.bin exefs_norm.xorpad exefs_7x.xorpad exefs.xorpad
ren *main.romfs.xorpad romfs.xorpad
ren *main.exheader.xorpad exheader.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe romfsEncrypted.bin romfs.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exheaderEncrypted.bin exheader.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exefsEncrypted.bin exefs.xorpad
cls
echo Please Wait..
echo.
ren romfsEncrypted.bin.out romfs.bin
ren exefsEncrypted.bin.out exefs.bin
ren exheaderEncrypted.bin.out exheader.bin
cls
echo Please Wait..
echo.
files\ctrtool1 -t exefs --exefsdir=exefs exefs.bin --decompresscode
cls
echo Please Wait..
echo.
mkdir decrypted
mkdir xorpads
if exist *Manual.romfs.xorpad (files\rom_tool --extract=. "%rom%") else if exist *DownloadPlay.romfs.xorpad (files\rom_tool --extract=. "%rom%")
if exist *Manual.romfs.xorpad ren *manual*.cfa manual.cfa
if exist *DownloadPlay.romfs.xorpad ren *DLP.cfa dlp.cfa
%manual%
del *appdata.cxi
del *updatedata.cfa
move exefs.bin decrypted\exefs.bin
move romfs.bin decrypted\romfs.bin
move exefs.xorpad xorpads\exefs.xorpad
move romfs.xorpad xorpads\romfs.xorpad
copy files\auto6.rsf RSF.rsf
cls
echo Please Wait..
echo.
files\rsfgen.py "%rom%" %reg%
cls
echo Please Wait..
echo.
files\ctrtool -t exheader exheader.bin > exheaderinfo.txt
cls
echo Please Wait..
echo.
files\makerom -f cxi -o rom.cxi -rsf RSF.rsf -target t -desc ecapp:%sdk% -exheader exheader.bin -exefslogo -code exefs\code.bin -romfs decrypted\romfs.bin -icon exefs\icon.bin -banner exefs\banner.bin
cls
echo Please Wait..
echo.
files\exinjector -rom rom.cxi -exheader exheader.bin -sd
cls
taskkill /F /IM cscript.exe
cls
echo Please Wait..
echo.
if exist dlp.cfa goto newalt_5
cls
echo Please Wait..
echo.
If exist "manual.cfa" If not exist "dlp.cfa" files\makerom -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If not exist "manual.cfa" If not exist "dlp.cfa" files\makerom -f cia -target t -content rom.cxi:0:0 -o ciarom.cia & goto cia5_1
goto newalt

:newalt_6
cls
echo Please Wait..
echo.
If exist "manual.cfa" If exist "dlp.cfa" files\makerom -f cia -target t -content rom.cxi:0:0 -content manual.cfa:1:1 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5_1
cls
echo Please Wait..
echo.
If not exist "manual.cfa" If exist "dlp.cfa" files\makerom -f cia -target t -content rom.cxi:0:0 -content dlp.cfa:2:2 -o ciarom.cia & goto cia5_1
goto newalt_6

:prep
cls
set /p rom=Enter 3DS Rom Name:
if "%rom%" == "" set rom=%file%
for /f "delims=" %%a  in ("%rom%") do set "Extension=%%~xa"
if /i "%Extension%"==".3ds" (goto prep2) else set rom=%rom%.3ds& goto prep2
goto prep

:prep2
cls
echo Please Wait..
echo.
if "%rom%" == "" goto prep
if not exist "%rom%" > usermessage.vbs ECHO Set wshShell = CreateObject( "WScript.Shell" )
if not exist "%rom%" >>usermessage.vbs ECHO wshShell.Popup "File Doesn't Exist!!", 64, _
if not exist "%rom%" >>usermessage.vbs ECHO "Warning", 64
if not exist "%rom%" WSCRIPT.EXE usermessage.vbs
if not exist "%rom%" DEL usermessage.vbs
if not exist "%rom%" goto prep
cls
goto prep_1

:prep_1
cls
echo Please Wait..
echo.
if exist rom.bat del rom.bat
if not exist "%rom% Files" mkdir "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_7x.xorpad" xcopy /y "*.Main.exefs_7x.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exefs_norm.xorpad" xcopy /y "*.Main.exefs_norm.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.exheader.xorpad" xcopy /y "*.Main.exheader.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Main.romfs.xorpad" xcopy /y "*.Main.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.Manual.romfs.xorpad" xcopy /y "*.Manual.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.UpdateData.romfs.xorpad" xcopy /y "*.UpdateData.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\*.DownloadPlay.romfs.xorpad" xcopy /y "*.DownloadPlay.romfs.xorpad" "%rom% Files"
if not exist "%rom% Files\ncchinfo.bin" xcopy /y "ncchinfo.bin" "%rom% Files"
rename *.exheader.xorpad exh.xorpad
rename *main.romfs.xorpad romfs.xorpad
if exist *UpdateData.romfs.xorpad del *UpdateData.romfs.xorpad
if not exist *exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs.xorpad
if exist *exefs_7x.xorpad ren *Main.exefs_7x.xorpad exefs_7x.xorpad
if exist exefs_7x.xorpad ren *Main.exefs_norm.xorpad exefs_norm.xorpad
cls
set /P yn=Try Alternative Method If Previous Failed [Y/N]?
if /I "%yn%"=="y" goto prep_4
if /I "%yn%"=="n" goto prep_3

:prep_3
cls
echo Please Wait..
echo.
files\ctrtool -p --exefs=exefs.bin "%rom%"
cls
echo Please Wait..
echo.
files\ctrtool -p --romfs=romfs.bin "%rom%"
cls
echo Please Wait..
echo.
files\ctrtool -p --exheader=exheader.bin "%rom%"
goto prep_5

:prep_4
cls
echo Please Wait..
echo.
files\ctrtool-a -x --exefsdir=exefs --romfs=romfs.bin --exheader=exheader.bin "%rom%"
files\ctrtool-a -x --romfsdir=romfs romfs.bin
del romfs.bin
cls
echo Please Wait..
echo.
files\ctrtool -p --exefs=exefs.bin "%rom%"
cls
echo Please Wait..
echo.
files\ctrtool -p --romfs=romfs.bin "%rom%"
cls
echo Please Wait..
echo.
files\ctrtool -p --exheader=exheader.bin "%rom%"
cls
goto prep_5

:prep_5
cls
echo Please Wait..
echo.
if exist exefs_7x.xorpad files\MEX.py exefs.bin exefs_norm.xorpad exefs_7x.xorpad exefs.xorpad
mkdir xorpads
mkdir encrypted_bin
mkdir decrypted
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exefs.bin exefs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exefs.bin -x exefs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exefs.bin -7 exefs_7x.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe exheader.bin exh.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe exheader.bin -e exh.xorpad
cls
echo Please Wait..
echo.
if exist files\padxorer4x.exe files\padxorer4x.exe romfs.bin romfs.xorpad
rem if exist files\padxorerhi.exe files\padxorerhi.exe romfs.bin -r romfs.xorpad
cls
echo Please Wait..
echo.
if exist exefs_7x.xorpad move exefs_7x.xorpad xorpads\exefs_7x.xorpad
if exist exefs_norm.xorpad move exefs_norm.xorpad xorpads\exefs_norm.xorpad
move exefs.xorpad xorpads\exefs.xorpad
move exh.xorpad xorpads\exh.xorpad
move romfs.xorpad xorpads\romfs.xorpad
move exheader.bin encrypted_bin\exheader.bin
move decrypted_exheader.bin decrypted\exheader.bin
cls
echo Please Wait..
echo.
files\ctrtool --exefsdir=exefs --decompresscode -t exefs decrypted_exefs.bin
cls
echo Please Wait..
echo.
move exefs.bin encrypted_bin\exefs.bin
move romfs.bin encrypted_bin\romfs.bin
move decrypted_exefs.bin decrypted\exefs.bin
move decrypted_romfs.bin decrypted\romfs.bin
cls
echo Please Wait..
echo.
if not exist decrypted\exefs.bin goto dfailed
if not exist decrypted\romfs.bin goto dfailed
if not exist decrypted\exheader.bin goto dfailed
if not exist exefs\banner.bin goto dfailed
if not exist exefs\code.bin goto dfailed
if exist RSF.rsf rename RSF.rsf RSF3.rsf
copy files\auto4.rsf RSF.rsf
copy decrypted\exheader.bin exheader.bin
cls
echo Please Wait..
echo.
files\rsfgen.py "%rom%" true
cls
echo Please Wait..
echo.
if exist "*.Manual.romfs.xorpad" move *.Manual.romfs.xorpad xorpads\Manual.romfs.xorpad
cls
echo Please Wait..
echo.
if exist *.DownloadPlay.romfs.xorpad copy xorpads\DownloadPlay.romfs.xorpad
cls
echo Please Wait..
echo.
if exist *.DownloadPlay.romfs.xorpad ren *DLP.cfa dlp.cfa
del *appdata.cxi
del *updatedata.cfa
cls
echo Please Wait..
echo.
files\ctrtool -t exheader decrypted\exheader.bin > exheaderinfo.txt
goto prep_2

:prep_2
cls
set x64=""
cls
echo Please Wait..
echo.
cls
if exist "*.DownloadPlay.romfs.xorpad" del /F /Q "*.DownloadPlay.romfs.xorpad"
cls
echo Please Wait..
echo.
if not exist "%rom% Files\decrypted" mkdir "%rom% Files\decrypted"
if not exist "%rom% Files\exefs" mkdir "%rom% Files\exefs"
if exist "decrypted" copy decrypted "%rom% Files\decrypted"
if exist "exefs" copy exefs "%rom% Files\exefs"
if exist "exheaderinfo.txt" del /F /Q "exheaderinfo.txt"
if exist "exheader.bin" del /F /Q "exheader.bin"
if exist "ncchinfo.bin" del /F /Q "ncchinfo.bin"
if exist "RSF.rsf" del /F /Q "RSF.rsf"
RMDIR /S /Q "decrypted"
RMDIR /S /Q "encrypted_bin"
RMDIR /S /Q "exefs"
RMDIR /S /Q "xorpads"
set x64=""
set manual=""
set manual2=""
cls
if %md% equ 1 goto md_1a
goto menu3

:cleanup
cls
set /P yn=Would You Like To Cleanup [Y/N]?
if "%yn%"=="y" goto cleanup1
if "%yn%"=="n" goto menu
goto cleanup

:cleanup1
cls
echo Please Wait..
echo.
if exist "CTR-P-CTAP_1_MANUAL.cfa" del /F /Q "CTR-P-CTAP_1_MANUAL.cfa"
if exist "*.UpdateData.romfs.xorpad" del /F /Q "*.UpdateData.romfs.xorpad"
if exist "*.DownloadPlay.romfs.xorpad" del /F /Q "*.DownloadPlay.romfs.xorpad"
if exist "*.Main.exefs_7x.xorpad" del /F /Q "*.Main.exefs_7x.xorpad"
if exist "*.Main.exefs_norm.xorpad" del /F /Q "*.Main.exefs_norm.xorpad"
if exist "*.Main.exheader.xorpad" del /F /Q "*.Main.exheader.xorpad"
if exist "*.Main.romfs.xorpad" del /F /Q "*.Main.romfs.xorpad"
if exist "*.Manual.romfs.xorpad" del /F /Q "*.Manual.romfs.xorpad"
if exist "rom.bat" del /F /Q "rom.bat"
if exist "ncchinfo.bin" del /F /Q "ncchinfo.bin"
if exist "RSF.rsf" del /F /Q "RSF.rsf"
if exist "RSF3.rsf" rename "RSF3.rsf" "RSF.rsf"
if exist "appdata.cxi" del /F /Q "appdata.cxi"
if exist "manual.cfa" del /F /Q "manual.cfa"
if exist "rom.cci" del /F /Q "rom.cci"
if exist "exheaderinfo.txt" del /F /Q "exheaderinfo.txt"
if exist "exheader.bin" del /F /Q "exheader.bin"
if exist "dlp.cfa" del /F /Q "dlp.cfa"
if exist "romfs.bin" del /F /Q "romfs.bin"
if exist "exefs.bin" del /F /Q "exefs.bin"
if exist "exheader.bin" del /F /Q "exheader.bin"
if exist "banner.bin" del /F /Q "banner.bin"
if exist "icon.bin" del /F /Q "icon.bin"
if exist "code.bin" del /F /Q "code.bin"
if exist "*.Manual.romfs.xorpad" del /F /Q "*.Manual.romfs.xorpad"
if exist "exefs_7x.xorpad" del /F /Q "exefs_7x.xorpad"
if exist "exefs_norm.xorpad" del /F /Q "exefs_norm.xorpad"
if exist "exefs.bin.out" del /F /Q "exefs.bin.out"
if exist "exheader.bin.out" del /F /Q "exheader.bin.out"
if exist "romfs.bin.out" del /F /Q "romfs.bin.out"
if exist "decrypted" RMDIR /S /Q "decrypted"
if exist "encrypted_bin" RMDIR /S /Q "encrypted_bin"
if exist "exefs" RMDIR /S /Q "exefs"
if exist "xorpads" RMDIR /S /Q "xorpads"
goto menu

:error
cls
echo Something Went Wrong With The makerom Process..
echo.
pause
goto menu

:check
cls
if not exist decrypted\exefs.bin goto check2
if not exist decrypted\exheader.bin goto check2
if not exist decrypted\romfs.bin goto check2
if not exist exefs\banner.bin goto check2
if not exist exefs\code.bin goto check2
if not exist exefs\icon.bin goto check2
goto cia

:check2
cls
if not exist *exefs_norm.xorpad goto check3
if not exist *exheader.xorpad goto check3
if not exist *main.romfs.xorpad goto check3
goto cia

:check3
cls
echo Cant Find Xorpads..
echo.
pause
goto menu

:check4
cls
rem if not exist decrypted\exefs.bin goto dfailed
rem if not exist decrypted\romfs.bin goto dfailed
rem if not exist decrypted\exheader.bin goto dfailed
rem if not exist exefs\banner.bin goto dfailed
rem if not exist exefs\code.bin goto dfailed
goto rsffile

:dfailed
cls
echo Decryption Failed..
echo.
pause
goto cleanup

:exit
exit