@echo off

set VERSION=4.0
set FILETYPE=.bat


@REM Chat made by Immortal Terror (Discord: Immortal Terror#6969 | Github: https://github.com/ImmortalTerror | Youtube: https://www.youtube.com/channel/UCMwG-Wmm3RnzPT5bzyjzpeA | Instagram: https://www.instagram.com/immortalterror07/ )
@REM I would like to thank one of my best friends, A KFC RatChicken for suggesting features and finding ways to implement them.
@REM He may have not written a single line of code here, but many features wouldn't be possible without him.

Set _fBlack=[30m
Set _bBlack=[40m
Set _fRed=[31m
Set _bRed=[41m
Set _fGreen=[32m
Set _bGreen=[42m
Set _fYellow=[33m
Set _bYellow=[43m
Set _fBlue=[34m
Set _bBlue=[44m
Set _fMag=[35m
Set _bMag=[45m
Set _fCyan=[36m
Set _bCyan=[46m
Set _fLGray=[37m
Set _bLGray=[47m
Set _fDGray=[90m
Set _bDGray=[100m
Set _fBRed=[91m
Set _bBRed=[101m
Set _fBGreen=[92m
Set _bBGreen=[102m
Set _fBYellow=[93m
Set _bBYellow=[103m
Set _fBBlue=[94m
Set _bBBlue=[104m
Set _fBMag=[95m
Set _bBMag=[105m
Set _fBCyan=[96m
Set _bBCyan=[106m
Set _fBWhite=[97m
Set _bBWhite=[107m
Set _RESET=[0m


@REM Checks if info folder exists
if NOT EXIST info (
    echo info folder %_fRed%not found%_RESET%
    echo please download the latest release from %_bBWhite%%_fBlack%https://github.com/ImmortalTerror/Chat/releases/tag/chat%_RESET%
    pause>nul
    exit
)




@REM Makes info folder hidden if its not
attrib info>%temp%\attrib.tmp
set /p attrib=<%temp%\attrib.tmp
del /q %temp%\attrib.tmp
set correct=   SH                %cd%\info
if "%attrib%" NEQ "%correct%" (
    attrib +S +H info
)


@REM Checks if debug mode is on (DISABLED)
@REM if EXIST debug (
@REM     set /a DEBUG=1
@REM     set NAME=test
@REM     set ADMINCH=FALSE
@REM     del /q debug
@REM     goto :CHATSTART
@REM )
set /a DEBUG=0



@REM Checks if any users exists and if it should go to first time setup
if NOT EXIST info\users\*.dll echo First time setup>info\ftsu.tmp



cd info
set /a FTSU=0
if EXIST ftsu.tmp goto :FIRSTTIMESETUP



@REM dashboard
echo %DATE% %TIME% ^>^> %USERNAME% has made it to the dashboard. >>logs.log
:START



@REM Fix the size once im done making v4

mode CON: COLS=68 LINES=45
cls
title WELCOME - %VERSION%
color 7
echo %_fGreen%%_bGreen%/////////////////////////////
echo /%_RESET%         %_fBlack%%_bRed%WELCOME%_RESET%           %_fGreen%%_bGreen%/
echo /%_RESET%   %_fBlack%%_bBWhite%PRESS ANY KEY TO LOGIN%_RESET%  %_fGreen%%_bGreen%/
echo /////////////////////////////%_RESET%
echo.
echo.
echo This program is still being worked on. %_fBGreen%There will be more soon%_RESET%
echo.
echo.
echo %_bGreen%%_fGreen%///////////////////
echo /%_RESET%  %_fRed%ANNOUNCEMENTS  %_bGreen%%_fGreen%/
echo /%_RESET%   AND %_fBGreen%UPDATES   %_bGreen%%_fGreen%/
echo ///////////////////%_RESET%
echo.
echo %_bRed%%_fBlack%ANNOUNCEMENTS:%_RESET%

@REM VVVV CHANGE THIS VVVV

echo V4.0 is here!
echo And V5.0 will come one day...
echo.
echo.
echo %_bGreen%%_fBlack%UPDATES:%_RESET%
echo %_fBBlue%V4.0%_RESET%
echo -colours in chat.bat
echo -colours in type.bat
echo -removing junk code
echo -checks for info folder
echo -makes info folder hidden and system
echo -swap encrypting for hashing
echo -add username hashing
echo -comments to make code more readable
echo -fix up more junk code
echo -Disabled /debug as it probably won't work anymore
echo.
echo %_fBBlue%V3.9.2%_RESET%
echo -Fixed some logging errors
echo -Added First time setup
echo -Reworked admin system
echo -Added /promote command (ADMIN COMMAND)
echo -Added /demote command (ADMIN COMMAND)
echo.
echo %_fBBlue%V3.9.1%_RESET%
echo -When typing passwords, all characters will now be viewed as "*"
echo -/chatas now supports commands
echo -Added an easter egg :)
echo.
pause>nul



@REM Asks if you already have an account
:ACCOUNTEXIST
cls
mode CON: COLS=48 LINES=11
color 7
title LOGIN
echo do you already have an account?
echo.
cmdmenusel.exe 0770 "YES" "NO"
if %ERRORLEVEL%==1 (
    echo %DATE% %TIME% ^>^> %USERNAME% Has gone to the login page >>logs.log
    cd users
    goto :LOGIN
)
if %ERRORLEVEL%==2 (
    echo %DATE% %TIME% ^>^> %USERNAME% Has gone to make a new account >>logs.log
    cd users
    goto :ACCOUNTMAKE
)
cls
echo ERROR
Pause
exit



@REM Page to login
:LOGIN
cls
title LOGIN - /back to go back to dashboard
color 2
echo %_bBGreen%%_fBGreen%////////////////////
echo /%_RESET%   PLEASE LOGIN   %_bBGreen%%_fBGreen%/
echo ////////////////////%_RESET%
echo.
echo.
echo.
set /p NAME=Username: 
if "%NAME%"=="/back" (
    set NAME=
    cd ..
    goto :START
)
echo %NAME%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_NAME=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

@REM Checks if user is banned
if exist "%h_NAME%.ban" goto :BAN
if exist "%USERNAME%.ban" goto :BAN
if exist "%h_NAME%.dll" goto :PASSWORD

@REM If the username is not found
cls
color 4
echo %_fRed%%_bRed%//////////////////////////
echo /%_RESET%   %_fRed%USERNAME NOT FOUND   %_fRed%%_bRed%/
echo //////////////////////////%_RESET%
echo 
cd ..
echo %DATE% %TIME% ^>^> %USERNAME% Has attempted to log into an account that does not exist >>logs.log
cd users
timeout /t 3 >nul
goto :LOGIN

@REM Prompt for password if account exists
:PASSWORD
set "psCommand=powershell -Command "$pword = read-host 'Password' -AsSecureString ; ^
     $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
           [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set password=%%p
if "%password%"=="/back" (
    set NAME=
    cd ..
    goto :START
)



@REM Gets password from account file
set /p password_file=<%h_NAME%.dll



@REM Hashes inputed password
echo %password%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_password=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp



@REM Gets admin status
FOR /F "skip=1" %%c IN (%h_NAME%.dll) DO set f_ADMINCH=%%c

set h_ADMINCH=8Fas3%h_NAME%onRG621

echo %h_ADMINCH%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_ADMINCH=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

if %f_ADMINCH%==%h_ADMINCH% (
    set ADMINCH=TRUE
) ELSE (
    set ADMINCH=FALSE
)



@REM If password is correct
if %password_file%==%h_password% goto correct_credentials



@REM If password is incorrect
:incorrect_credentials
cls
color 4
echo %_bRed%%_fRed%//////////////////////
echo /%_RESET%   %_fRed%WRONG PASSWORD   %_fRed%%_bRed%/
echo //////////////////////%_RESET%
echo 
cd ..
echo %DATE% %TIME% ^>^> %USERNAME% Has entered the password for *%NAME% wrong >>logs.log
cd users
timeout /t 3 >nul
goto login

@REM Correct password
:correct_credentials
cd ..
echo %DATE% %TIME% ^>^> %USERNAME% Has logged into *%NAME% >>logs.log
cd users
goto :RULES



@REM Page to make an account
:ACCOUNTMAKE
cls
title LOGIN - /back to go back to dashboard
color 7
echo %_fBGreen%%_bBGreen%/////////////////////////////
echo /%_RESET%    ENTER NEW USERNAME     %_fBGreen%%_bBGreen%/
echo /////////////////////////////%_RESET%
echo.
echo.
echo.
set /p new_NAME=Username: 
if "%new_NAME%"=="/back" (
    set NAME=
    cd ..
    goto :START
)

@REM Hashes name
echo %new_NAME%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_new_NAME=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

if exist "%h_new_NAME%.dll" goto :ALREADYEXIST

@REM Enter new password
:NEWPASSWORD
cls
color 7
echo %_bBGreen%%_fBGreen%//////////////////////
echo /%_RESET%   ENTER PASSWORD   %_bBGreen%%_fBGreen%/
echo //////////////////////%_RESET%
echo.
echo.
echo.

set "psCommand=powershell -Command "$pword = read-host 'New Password' -AsSecureString ; ^
     $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
           [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set new_password=%%p

if "%new_password%"=="/back" (
    set NAME=
    cd ..
    goto :START
)

set "psCommand=powershell -Command "$pword = read-host 'Confirm New Password' -AsSecureString ; ^
     $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
           [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set confirm_new_password=%%p

if "%new_password%"=="%confirm_new_password%" goto :PASSWORDSMATCH

@REM If passwordds don't match
cls
color 4
echo %_bRed%%_fRed%//////////////////////////////
echo /%_RESET%   %_fRed%PASSWORD'S DON'T MATCH   %_fRed%%_bRed%/
echo //////////////////////////////%_RESET%
echo 
timeout /t 3 /nobreak>nul
set new_password=
set confirm_new_password=
goto :NEWPASSWORD

@REM If passwords match
:PASSWORDSMATCH

@REM Hashes password
echo %new_password%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p new_password=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp



@REM Gets username and adds salt to make hashed admin status
set n_ADMIN_STATUS=73Hs%new_NAME%gGG83A

echo %n_ADMIN_STATUS%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_n_ADMIN_STATUS=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp



@REM Makes account file
echo %new_password%>"%h_new_NAME%".dll
echo %h_n_ADMIN_STATUS%>>"%h_new_NAME%".dll

@REM Tells user account has been made
echo.
echo %_fGreen%Account Successfully Created!%_RESET%
cd ..
echo %DATE% %TIME% ^>^> %username% created account ^"*%new_NAME%^" >>logs.log
cd users
timeout /t 2 >nul
if %FTSU%==1 goto :FTSU2
goto :LOGIN



@REM If account already exists
:ALREADYEXIST
cls
color 4
echo %_fRed%%_bRed%////////////////////////////////////////
echo /%_RESET%   %_fRed%THIS ACCOUNT NAME ALREADY EXISTS   %_fRed%%_bRed%/
echo /%_RESET%     %_fGreen%PLEASE TRY ANOTHER USERNAME      %_bRed%%_fRed%/
echo ////////////////////////////////////////%_RESET%
echo 
timeout /t 3 >nul
goto :ACCOUNTMAKE



@REM Rules
:RULES
mode CON: COLS=100 LINES=15
cls
echo %_bBBlue%%_fBBlue%///////////////////
echo /%_RESET%      %_fBGreen%RULES      %_bBBlue%%_fBBlue%/
echo /%_RESET%   %_fRed%PLEASE READ   %_bBBlue%%_fBBlue%/
echo ///////////////////%_RESET%
echo.
echo 1. %_fblue%Spam will not be tolerated.%_RESET%
echo 3. %_fblue%DO NOT delete any files%_RESET%
echo 4. %_fblue%Discrimination is not allowed, this includes racism, homophobic/transphobic slurs and more.%_RESET%
echo 5. %_fblue%Use common sense, if you feel like you shouldn't do something, then don't.%_RESET%
echo.
echo If you break these rules, %_fRed%i can ban you.%_RESET%
echo.
echo Rule breakers will be punished
Pause>nul


@REM starts the chat window
:CHATSTART
cls
color 7
if %DEBUG%==0 cd ..
if %DEBUG%==1 cd info
start type%FILETYPE% 1 %NAME: =-% %ADMINCH% %h_NAME% %h_ADMINCH%
title Chat
:CHAT
if EXIST "%TEMP%\CHATLOGOUT.tmp" (
    del "%TEMP%\CHATLOGOUT.tmp"
    if %DEBUG%==1 set DEBUG=0
    goto :START
)
mode CON: COLS=75 LINES=50
cls
echo                              ^>^> WELCOME ^<^<
if EXIST "chat.log" type chat.log
timeout /t 1 /nobreak >nul
goto :CHAT



@REM Banned page
:BAN
cls
color 4
title BANNED
echo %_bRed%%_fRed%////////////////////////////
echo /   %_bBWhite%%_fRed%YOU HAVE BEEN BANNED%_bRed%%_fRed%   /
echo ////////////////////////////%_RESET%
echo.
echo go away
echo 
if exist "%USERNAME%.ban" goto :BANALT
cd ..
echo %DATE% %TIME% ^>^> %USERNAME% Tried to log into *%NAME% but is banned. >>logs.log
timeout /t 3 /nobreak >nul
exit


@REM Pc banned page
:BANALT
cd ..
echo %DATE% %TIME% ^>^> %USERNAME% Tried to login but is pc banned. >>logs.log
timeout /t 3 /nobreak >nul
exit



@REM First time setup
:FIRSTTIMESETUP
cls
color 7
title First Time Setup
set /a FTSU=1
echo %_fBGreen%%_bBGreen%//////////////////
echo /%_RESET%   FIRST TIME   %_fBGreen%%_bBGreen%/
echo /%_RESET%     SETUP      %_fBGreen%%_bBGreen%/
echo //////////////////%_RESET%
echo.
echo %_fBlue%Welcome to the first time set up page for this chat program.
echo To begin, you will need to make an account with %_fGreen%admin permissions%_RESET%.%_bBGreen%%_fBlack%
echo.
echo Press any key to begin.%_RESET%
del ftsu.tmp
pause>nul
cd users
mode CON: COLS=48 LINES=11
goto :ACCOUNTMAKE

@REM First time setup completed
:FTSU2
mode CON: COLS=125 LINES=30
color 7
cls
title Admin account made!
color 2
set /p new_admin_password=<%h_new_Name%.dll
echo %new_admin_password%>%h_new_Name%.dll.tmp
move /Y "%h_new_Name%.dll.tmp" "%h_new_Name%.dll">nul

set NEW_ADMIN_STATUS=8Fas3%h_new_NAME%onRG621
echo %NEW_ADMIN_STATUS%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_NEW_ADMIN_STATUS=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

echo %h_NEW_ADMIN_STATUS%>>%h_new_Name%.dll
echo The account %_bBWhite%%_fBlack%"%new_Name:-= %"%_RESET% has been granted admin permissions!
echo you may continue...
set /a FTSU=0
timeout /t 5 >nul
mode CON: COLS=48 LINES=11
goto :LOGIN
