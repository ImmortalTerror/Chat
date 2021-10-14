@echo off


@REM Chat made by Immortal Terror (Discord: Immortal Terror#6969 | Github: https://github.com/ImmortalTerror | Youtube: https://www.youtube.com/channel/UCMwG-Wmm3RnzPT5bzyjzpeA | Instagram: https://www.instagram.com/immortalterror07/ )
@REM Encryption by https://www.youtube.com/technologycrazy
@REM Huge thanks to the amazing people of stack overflow



if NOT EXIST info\users\*.dll echo First time setup>info\ftsu.tmp


if EXIST debug (
    set /a DEBUG=1
    set NAME=test
    del /q debug
    goto :CHATSTART
)
set /a DEBUG=0



cd info
set /a FTSU=0
if EXIST ftsu.tmp goto :FIRSTTIMESETUP
cd ..



cd info



@REM dashboard
echo %DATE% %TIME% ^>^> %USERNAME% has made it to the dashboard. >>logs.log
:START
mode CON: COLS=65 LINES=60
cls
title WELCOME - V3.9.2
color 2
echo /////////////////////////////
echo /         WELCOME           /
echo /   PRESS ANY KEY TO LOGIN  /
echo /////////////////////////////
echo.
echo.
echo This program is still being worked on. There will be more soon
echo.
echo.
echo ///////////////////
echo /  ANNOUNCEMENTS  /
echo /   AND UPDATES   /
echo ///////////////////
echo.
echo ANNOUNCEMENTS:
echo V4.0 coming soon!
echo.
echo.
echo UPDATES:
echo V3.9.2
echo -Fixed some logging errors
echo -Added First time setup
echo -Reworked admin system
echo -Added /promote command (ADMIN COMMAND)
echo -Added /demote command (ADMIN COMMAND)
echo.
echo V3.9.1
echo -When typing passwords, all characters will now be viewed as "*"
echo -/chatas now supports commands
echo -Added an easter egg :)
echo.
echo V3.9
echo -Reworked /nick
echo -Reworked /ad
echo -Reworked /chatas
echo -Added /changepassword
echo -Reworked all the ban commands
echo -Added /terminate (ADMIN COMMAND)
echo -Added refresh system to /logs (ADMIN COMMAND)
echo -/logout will now bring up the dashboard
echo -Fixed some bugs
echo -Now when chat is open, it says "Welcome" at the top
echo -Added /deleteaccount
echo -Added better ban logging.
echo -Added /bans (ADMIN COMMAND)
echo -Added /debug (ADMIN COMMAND)
echo.
echo V3.8
echo -Fixed bug with banning name with spaces
echo -Removed password for /clearchat and /clearlogs
echo -Other small fixes and changes
echo.
echo V3.7
echo - Passwords can now contain spaces
echo.
echo.
echo TO DO:
echo -Private DM's
pause>nul



cd users
:ACCOUNTEXIST
cls
mode CON: COLS=48 LINES=11
color 7
title LOGIN
echo do you already have an account?
choice
if %ERRORLEVEL%==1 (
    cd ..
    echo %DATE% %TIME% ^>^> %USERNAME% Has gone to the login page >>logs.log
    cd users
    goto :LOGIN
)
if %ERRORLEVEL%==2 (
    cd ..
    echo %DATE% %TIME% ^>^> %USERNAME% Has gone to make a new account >>logs.log
    cd users
    goto :ACCOUNTMAKE
)
cls
echo ERROR
Pause
exit



:LOGIN
cls
title LOGIN - /back to go back to dashboard
color 2
echo ////////////////////
echo /   PLEASE LOGIN   /
echo ////////////////////
echo.
echo.
echo.
set /p NAME=Username:
if "%NAME%"=="/back" (
    set NAME=
    cd ..
    goto :START
)
set "NAME=%NAME: =-%"
if exist "%NAME%.ban" goto :BAN
if exist "%USERNAME%.ban" goto :BAN
if exist "%NAME%.dll" goto :PASSWORD
cls
color 4
echo //////////////////////////
echo /   USERNAME NOT FOUND   /
echo //////////////////////////
echo 
cd ..
echo %DATE% %TIME% ^>^> %USERNAME% Has attempted to log into an account that does not exist >>logs.log
cd users
timeout /t 3 /nobreak >nul
goto :LOGIN

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



findstr /I /R /C:"^p\>" "%NAME%.dll">%TEMP%\CHATPW.tmp
set /p password_file=<%TEMP%\CHATPW.tmp
del %TEMP%\CHATPW.tmp
set password_file=%password_file:p!=%



setlocal enabledelayedexpansion

set inputcode=9375
set code=%password%
set chars=0123456789abcdefghijklmnopqrstuvwxyz

for /L %%N in (10 1 36) do (
    for /F %%C in ("!chars:~%%N,1!") do (
        set /a MATH=%%N*%inputcode%
        for /f %%F in ("!MATH!") do (
            set "code=!code:%%C=-%%F!"
        )
    )
)

set enpassword=!code!
set "enpassword=%enpassword: =_%"

setlocal disabledelayedexpansion



findstr /I /R /C:"^a\>" "%NAME%.dll">%TEMP%\ADMINCH.tmp
set /p ADMINCH=<%TEMP%\ADMINCH.tmp
del %TEMP%\ADMINCH.tmp
set ADMINCH=%ADMINCH:a!=%



if %password_file%==%enpassword% goto correct_credentials

goto incorrect_credentials



:incorrect_credentials
cls
color 4
echo //////////////////////
echo /   WRONG PASSWORD   /
echo //////////////////////
echo 
cd ..
echo %DATE% %TIME% ^>^> %USERNAME% Has entered the password for *%NAME% wrong >>logs.log
cd users
timeout /t 3 >nul
goto login

:correct_credentials
cd ..
echo %DATE% %TIME% ^>^> %USERNAME% Has logged into *%NAME% >>logs.log
cd users
goto :RULES



:ACCOUNTMAKE
cls
title LOGIN - /back to go back to dashboard
color 7
echo /////////////////////////////
echo /    ENTER NEW USERNAME     /
echo /////////////////////////////
echo.
echo.
echo.
set /p new_NAME=Username:
if "%new_NAME%"=="/back" (
    set NAME=
    cd ..
    goto :START
)
set "new_NAME=%new_NAME: =-%"
if exist "%new_NAME%.dll" goto :ALREADYEXIST

:NEWPASSWORD
cls
color 7
echo //////////////////////
echo /   ENTER PASSWORD   /
echo //////////////////////
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

cls
color 4
echo //////////////////////////////
echo /   PASSWORD'S DON'T MATCH   /
echo //////////////////////////////
echo 
timeout /t 3 /nobreak>nul
set new_password=
set confirm_new_password=
goto :NEWPASSWORD

:PASSWORDSMATCH

setlocal enabledelayedexpansion

set inputcode=9375
set code=%new_password%
set chars=0123456789abcdefghijklmnopqrstuvwxyz

for /L %%N in (10 1 36) do (
    for /F %%C in ("!chars:~%%N,1!") do (
        set /a MATH=%%N*%inputcode%
        for /f %%F in ("!MATH!") do (
            set "code=!code:%%C=-%%F!"
        )
    )
)
set new_password=!code!
set "new_password=%new_password: =_%"
setlocal disabledelayedexpansion

echo p!%new_password% >"%new_NAME%".dll
echo a!FALSE>>"%new_NAME%".dll

echo.
echo Account Successfully Created!
cd ..
echo %DATE% %TIME% ^>^> %username% created account ^"*%new_NAME%^" >>logs.log
cd users
timeout /t 2 >nul
if %FTSU%==1 goto :FTSU2
goto :LOGIN



:ALREADYEXIST
cls
color 4
echo ////////////////////////////////////////
echo /   THIS ACCOUNT NAME ALREADY EXISTS   /
echo /     PLEASE TRY ANOTHER USERNAME      /
echo ////////////////////////////////////////
echo 
timeout /t 3 >nul
goto :ACCOUNTMAKE



@REM rules
:RULES
mode CON: COLS=100 LINES=15
cls
echo ///////////////////
echo /      RULES      /
echo /   PLEASE READ   /
echo ///////////////////
echo.
echo 1. Spam will not be tolerated.
echo 3. DO NOT delete any files
echo 4. Discimination is not allowed, this includes racisim, homophobic/transphobic slurs and more.
echo 5. Use common sense, if you feel like you shouldn't do something, then don't.
echo.
echo If you break these rules, i can ban you.
echo.
echo Rule breakers will be punished
Pause>nul



@REM starts the chat window
:CHATSTART
cls
color 7
if %DEBUG%==0 cd ..
if %DEBUG%==1 cd info
start cmd /c "type.bat" 1 %NAME% %ADMINCH%
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
echo ////////////////////////////
echo /   YOU HAVE BEEN BANNED   /
echo ////////////////////////////
echo.
echo go away
echo 
if exist "%USERNAME%.ban" goto :BANALT
cd ..
echo %DATE% %TIME% ^>^> %USERNAME% Tried to log into *%NAME% but is banned. >>logs.log
timeout /t 3 /nobreak >nul
exit


:BANALT
cd ..
echo %DATE% %TIME% ^>^> %USERNAME% Tried to login but is pc banned. >>logs.log
timeout /t 3 /nobreak >nul
exit



:FIRSTTIMESETUP
cls
color 7
title First Time Setup
set /a FTSU=1
echo //////////////////
echo /   FIRST TIME   /
echo /     SETUP      /
echo //////////////////
echo.
echo Welcome to the first time set up page for this chat program.
echo To begin, you will need to make an account with admin permissions.
echo.
echo Press any key to begin.
del ftsu.tmp
pause>nul
cd users
mode CON: COLS=48 LINES=11
goto :ACCOUNTMAKE

:FTSU2
mode CON: COLS=125 LINES=30
color 7
cls
title Admin account made!
color 2
findstr /V /I /R /C:"^a\>" "%new_Name%.dll" > "%new_Name%.dll.tmp"
move /Y "%new_Name%.dll.tmp" "%new_Name%.dll">nul
echo a!TRUE>>%new_Name%.dll
echo The account "%new_Name:-= %" has been granted admin permissions!
echo you may continue...
set /a FTSU=0
timeout /t 5 >nul
mode CON: COLS=48 LINES=11
goto :LOGIN
