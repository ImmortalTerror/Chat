@echo off

if "%1" NEQ "1" goto :FAIL

set NAME=%2
set NAME=%NAME:-= %

set /a NICKED=0
set /a CHATASED=0

if %3==TRUE (
    set ADMIN=TRUE
) ELSE (
    set ADMIN=FALSE
)

goto :CHATJOIN



@REM If user did not run chat.bat
:FAIL
cls
title NOT AUTHORIZED
color 4
echo //////////////////////
echo /   NOT AUTHORIZED   /
echo /   RUN "chat.bat"   /
echo //////////////////////
echo 
echo %DATE% %TIME% ^>^> %USERNAME% Has tried to access type.bat without running chat.bat >>logs.log
timeout /t 5 /nobreak >nul
exit



:CHATJOIN
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Joined the chat >> logs.log
echo %DATE% %TIME% ^>^> %NAME% Joined the chat >> chat.log

@REM Main chat
:CHAT
cd users
if exist "%NAME%.ban" goto :BANNED
if exist "%USERNAME%.ban" goto :BANNED
cd ..
cls

if "%ADMIN%" NEQ "TRUE" (
    title TYPE HERE %NAME%   -   Type /help to see a list of commands
)
if "%ADMIN%"=="TRUE" (
    title TYPE HERE %NAME%   -   Type /help to see a list of commands - ADMIN MODE -
)
color 7

set /p TEXT=^>^>

cd users
if exist "%NAME%.ban" goto :BANNED
if exist "%USERNAME%.ban" goto :BANNED
cd ..



@REM Bad words
set "text=%text:nigger=******%"
set "text=%text:faggot=******%"
set "text=%text:bitch=*****%"
set "text=%text:whore=*****%"
set "text=%text:homo=****%"
set "text=%text:fag=***%"
set "text=%text:nig=***%"
set "text=%text:cunt=****%"
set "text=%text:coon=****%"



@REM Commands
if "%TEXT%"=="/help" goto :help
if "%TEXT%"=="/info" goto :info
if "%TEXT%"=="/logs" goto :logs
if "%TEXT%"=="/chatfile" goto :chatfile
if "%TEXT%"=="/clearchat" goto :clear
if "%TEXT%"=="/clearlogs" goto :clearl
if "%TEXT%"=="/logout" goto :quit
if "%TEXT%"=="/bans" goto :BANLIST
if "%TEXT%"=="/slogout" goto :squit
if "%TEXT%"=="/changepassword" goto :CHANGEPASSWORD
if "%TEXT%"=="/deleteaccount" goto :deleteaccount
if "%TEXT%"=="/debug" goto :debug
if NOT "%TEXT%"=="%TEXT:/chatas=%" goto :chatas
if NOT "%TEXT%"=="%TEXT:/ad=%" goto :ad
if NOT "%TEXT%"=="%TEXT:/nick=%" goto :nick 
if NOT "%TEXT%"=="%TEXT:/ban=%" goto :ban
if NOT "%TEXT%"=="%TEXT:/unban=%" goto :unban
if NOT "%TEXT%"=="%TEXT:/pcban=%" goto :pcban
if NOT "%TEXT%"=="%TEXT:/unpcban=%" goto :UNPCBAN
if NOT "%TEXT%"=="%TEXT:/terminate=%" goto :TERMINATE
if NOT "%TEXT%"=="%TEXT:/promote=%" goto :PROMOTE
if NOT "%TEXT%"=="%TEXT:/demote=%" goto :DEMOTE



echo ^<%NAME%^> %TEXT% >> chat.log
set TEXT=
echo Message sent
timeout /t 2 /nobreak >nul
goto :CHAT
if %CHATASED%==1 goto :CHATASLOOP



@REM List of commands
:help
cls
title /help
echo Commands:
echo /help - Brings up this menu
echo /info - Gives you some info
echo /logout - Go's back the login page
echo /nick (NCIKNAME) - Set a nickname
echo /changepassword - Menu to change your password
echo /deleteaccount - Deletes your account
if %NICKED%==1 echo /back - Removes your nickname
if "%ADMIN%"=="TRUE" echo.
if "%ADMIN%"=="TRUE" echo ADMIN COMMANDS:
if "%ADMIN%"=="TRUE" echo.
if "%ADMIN%"=="TRUE" echo /logs - This will show you when people joined the chat and what there names are ^(stoed in logs.log^).
if "%ADMIN%"=="TRUE" echo /chatfile - This will open the file where the chat is stored ^(chat.log^).
if "%ADMIN%"=="TRUE" echo /chatas (NAME) - Chat with a set username.
if "%ADMIN%"=="TRUE" echo /ad (TEXT) - Advertise something in chat.
if "%ADMIN%"=="TRUE" echo /clearchat - This will clear the chat.
if "%ADMIN%"=="TRUE" echo /clearlogs - This will clear the logs.
if "%ADMIN%"=="TRUE" echo /slogout - Same as /logout but it does not say it in chat.
if "%ADMIN%"=="TRUE" echo /ban - Bans user account.
if "%ADMIN%"=="TRUE" echo /unban - Unbans user account.
if "%ADMIN%"=="TRUE" echo /pcban - Bans person with matching PC username.
if "%ADMIN%"=="TRUE" echo /unpcban - unbans person with matching PC username.
if "%ADMIN%"=="TRUE" echo /bans - Shows a list off all banned accounts
if "%ADMIN%"=="TRUE" echo /terminate - Deletes an account.
if "%ADMIN%"=="TRUE" echo /debug - Creates or removes debug.bat which when run will log you into an account called test instantly.
if "%ADMIN%"=="TRUE" echo /promote (NAME) - Gives the user admin permissions
if "%ADMIN%"=="TRUE" echo /demote (NAME) - revokes the users admin permissions
if "%ADMIN%"=="TRUE" echo.
if "%ADMIN%"=="TRUE" echo In the logs, any name with an * before it means it is the account name, not the computer name.
echo.
echo Press any key to go back
pause>nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Info on the program
:info
title /info
echo VERSION: 3.9.2
echo Made by Immortal Terror  -   Encryption by some random guy I found on youtube
echo.
echo What is this?
echo This is a chat system for school networks. You can type messages and any other students using this can see it.
echo.
echo How do I use it?
echo There are 2 cmd (Command Prompt) windows open, DON'T CLOSE THEM. One of them shows the chat and the other is where you type.
echo.
echo Can people find out my password?
echo No. The passwords are encrypted.
echo.
echo Can i have admin perms?
echo No, fuck off. (Unless your cool and I give you admin)
echo.
echo What can admins do?
echo Ban and unban, look at logs, advertise, chat as other users, clear chat, logout silently and more.
echo.
echo Press any key to go back
pause>nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM quits the type window and says it in chat
:quit
cls
title /logout
echo are you sure you want to logout?
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
echo %DATE% %TIME% ^>^> %NAME% Logged out >> chat.log
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Logged out >> logs.log
echo. >%TEMP%\CHATLOGOUT.tmp
exit



@REM Just quits the window, admin only
:squit
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> /slogout >> chat.log
    cls
    echo ^>^>/slogout
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title /logout (SILENT)
echo are you sure you want to logout?
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Logged out silently >> logs.log
echo. >C:\Users\%USERNAME%\AppData\Local\Temp\CHATLOGOUT.tmp
exit



@REM Brings up the logs from logs.log, admin only
:logs
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> /logs >> chat.log
    cls
    echo ^>^>/logs
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Checked logs >> logs.log
title LOGS
:LOGSLOOP
cls
type logs.log
echo.
echo.
echo Press any key to go back
echo Press "r" to refresh
choice /c r1234567890qwetyuiopasdfghjklzxcvbnm >nul
if %ERRORLEVEL%==1 goto :LOGSLOOP
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT
    


@REM Opens the chat file (chat.log), admin only
:chatfile
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> /chatfile >> chat.log
    cls
    echo ^>^>/chatfile
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
echo Opened chat.log
echo Closes chat.log to go back
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) opened chat file >>logs.log
call chat.log
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Clears chat.log
:clear
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> /clearchat >> chat.log
    cls
    echo ^>^>/clearchat
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title CHAT CLEAR MENU
color 4
echo //////////////////////////////////////////
echo /   ARE YOU SURE YOU WANT TO CONTINUE?   /
echo //////////////////////////////////////////
echo 
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
echo Clearing chat.log...
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) cleared the chat >> logs.log
timeout /t 3 /nobreak >nul
del /q chat.log
color 7
cls
echo Cleared chat.log
echo.
TIMEOUT /t 3 >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Clears logs.log, admin only
:clearl
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> /clearlogs >> chat.log
    cls
    echo ^>^>/clearlogs
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title LOGS CLEAR MENU
color 4
echo //////////////////////////////////////////
echo /   ARE YOU SURE YOU WANT TO CONTINUE?   /
echo //////////////////////////////////////////
echo 
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
echo Clearing logs.log...
timeout /t 3 /nobreak >nul
del /q logs.log
color 7
cls
echo Cleared logs.log
echo.
TIMEOUT /t 3 >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM chat with a chosen username, admin only
:chatas
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> %TEXT%% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
    
)
cls
set CHATASN=%TEXT%
if "%CHATASN%"=="/chatas" (
    cls
    title /chatas
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set CHATASN=%CHATASN:/chatas =%
if "%CHATASN%"=="" (
    cls
    title /chatas
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) set CHATAS name to %CHATASN% >>logs.log
set /a CHATASED=1

@REM clone of the main chat, but with your CHATAS nickname
:CHATASLOOP
cd users
if exist "%NAME%.ban" goto :BANNED
if exist "%USERNAME%.ban" goto :BANNED
cd ..
cls
title Chatting as %CHATASN% - Type /back to go back - Type /help to see a list of commands
color 7
set /p TEXT=^>^>
cd users
if exist "%NAME%.ban" goto :BANNED
if exist "%USERNAME%.ban" goto :BANNED
cd ..
@REM Bad words
set "text=%text:nigger=******%"
set "text=%text:faggot=******%"
set "text=%text:bitch=*****%"
set "text=%text:whore=*****%"
set "text=%text:homo=****%"
set "text=%text:fag=***%"
set "text=%text:nig=***%"
set "text=%text:cunt=****%"
set "text=%text:coon=****%"



@REM Commands
if "%TEXT%"=="/help" goto :help
if "%TEXT%"=="/info" goto :info
if "%TEXT%"=="/logs" goto :logs
if "%TEXT%"=="/chatfile" goto :chatfile
if "%TEXT%"=="/clearchat" goto :clear
if "%TEXT%"=="/clearlogs" goto :clearl
if "%TEXT%"=="/logout" goto :quit
if "%TEXT%"=="/bans" goto :BANLIST
if "%TEXT%"=="/slogout" goto :squit
if "%TEXT%"=="/changepassword" goto :CHANGEPASSWORD
if "%TEXT%"=="/deleteaccount" goto :deleteaccount
if "%TEXT%"=="/debug" goto :debug
if NOT "%TEXT%"=="%TEXT:/chatas=%" goto :chatas
if NOT "%TEXT%"=="%TEXT:/ad=%" goto :ad
if NOT "%TEXT%"=="%TEXT:/nick=%" goto :nick 
if NOT "%TEXT%"=="%TEXT:/ban=%" goto :ban
if NOT "%TEXT%"=="%TEXT:/unban=%" goto :unban
if NOT "%TEXT%"=="%TEXT:/pcban=%" goto :pcban
if NOT "%TEXT%"=="%TEXT:/unpcban=%" goto :UNPCBAN
if NOT "%TEXT%"=="%TEXT:/terminate=%" goto :TERMINATE
if NOT "%TEXT%"=="%TEXT:/promote=%" goto :PROMOTE
if NOT "%TEXT%"=="%TEXT:/demote=%" goto :DEMOTE
if "%TEXT%"=="/back" goto :UNCHATAS

echo ^<%CHATASN%^> %TEXT% >> chat.log
echo Message sent
timeout /t 2 /nobreak >nul
goto :CHATASLOOP



:UNCHATAS
cls
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Stopped chatting as %CHATASN% >>logs.log
set CHATASN=""
set /a CHATASED=0
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Advertises something, >> looks like this <<, admin only
:ad
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title ADVERTISE
set ADVERT=%TEXT%
if "%ADVERT%"=="/ad" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set ADVERT=%ADVERT:/ad =%
if "%ADVERT%"=="" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
echo ^>^> %ADVERT% ^<^<>>chat.log
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) advertised "%ADVERT%">>logs.log
echo.
echo Advert sent
timeout /t 2 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Sets your nickname
:nick
cls
title /nick
set NICK=%TEXT%
if "%NICK%"=="/nick" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    set /a NICKED=0
    goto :CHAT
)
set NICK=%NICK:/nick =%
if "%NICK%"=="" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    set /a NICKED=0
    goto :CHAT
)
set /a NICKED=1
echo %DATE% %TIME% ^>^> %NAME% has set there nickname to "%NICK%" >> chat.log
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) has set there nickname to "%NICK%" >> logs.log
cls
echo Nickname is now %NICK%
timeout /t 2 /nobreak >nul
cls

@REM clone of main chat but for nicked users
:NCHAT
cd users
if exist "%NAME%.ban" goto :BANNED
if exist "%USERNAME%.ban" goto :BANNED
cd ..
cls
if "%ADMIN%" NEQ "TRUE" title TYPE HERE %NAME% - Nickname: %NICK% - Type /back to go back - Type /help to see a list of commands
if "%ADMIN%"=="TRUE" title TYPE HERE %NAME% - Nickname: %NICK% - Type /back to go back - Type /help to see a list of commands - ADMIN MODE -
color 7
set /p TEXT=^>^>
@REM Bad words
set "text=%text:nigger=******%"
set "text=%text:faggot=******%"
set "text=%text:bitch=*****%"
set "text=%text:whore=*****%"
set "text=%text:homo=****%"
set "text=%text:fag=***%"
set "text=%text:nig=***%"
set "text=%text:cunt=****%"
set "text=%text:coon=****%"
cd users
if exist "%NAME%.ban" goto :BANNED
if exist "%USERNAME%.ban" goto :BANNED
cd ..
@REM Commands
if "%TEXT%"=="/help" goto :help
if "%TEXT%"=="/info" goto :info
if "%TEXT%"=="/logs" goto :logs
if "%TEXT%"=="/chatfile" goto :chatfile
if "%TEXT%"=="/clearchat" goto :clear
if "%TEXT%"=="/clearlogs" goto :clearl
if "%TEXT%"=="/logout" goto :quit
if "%TEXT%"=="/bans" goto :BANLIST
if "%TEXT%"=="/slogout" goto :squit
if "%TEXT%"=="/changepassword" goto :CHANGEPASSWORD
if "%TEXT%"=="/deleteaccount" goto :deleteaccount
if "%TEXT%"=="/debug" goto :debug
if NOT "%TEXT%"=="%TEXT:/chatas=%" goto :chatas
if NOT "%TEXT%"=="%TEXT:/ad=%" goto :ad
if NOT "%TEXT%"=="%TEXT:/nick=%" goto :nick 
if NOT "%TEXT%"=="%TEXT:/ban=%" goto :ban
if NOT "%TEXT%"=="%TEXT:/unban=%" goto :unban
if NOT "%TEXT%"=="%TEXT:/pcban=%" goto :pcban
if NOT "%TEXT%"=="%TEXT:/unpcban=%" goto :UNPCBAN
if NOT "%TEXT%"=="%TEXT:/terminate=%" goto :TERMINATE
if NOT "%TEXT%"=="%TEXT:/promote=%" goto :PROMOTE
if NOT "%TEXT%"=="%TEXT:/demote=%" goto :DEMOTE
if "%TEXT%"=="/back" goto :UNNICK
if "%TEXT%"=="/dino" goto :easter_ehg
echo ^<%NICK%^> %TEXT% >> chat.log
set TEXT=
echo Message sent
timeout /t 2 /nobreak >nul
goto :NCHAT

@REM removes nickname
:unnick
cls
title unnick
echo Nickname removed
echo %DATE% %TIME% ^>^> %NICK% (%NAME%) Removed there nickname >>chat.log
echo %DATE% %TIME% ^>^> %NICK% (*%NAME% (%USERNAME%)) Removed there nickname >>logs.log
set NICK=%NAME%
set /a NICKED=0
timeout /t 2 /nobreak >nul
goto :CHAT



:ban
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
color 4
set BAN=%TEXT%
if "%BAN%"=="/ban" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set BAN=%BAN:/ban =%
if "%BAN%"=="" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
set BAN=%BAN: =-%
cd users
if NOT EXIST "%BAN%.dll" goto :ACCNOTEXIST
if EXIST "%BAN%.ban" goto :ALREADYBANNED
cd ..
color 4
title %BAN:-= % has been banned
echo ///////////////////
echo /   USER BANNED   /
echo ///////////////////
echo 
echo %DATE% %TIME% ^>^> *%BAN:-= % was banned by *%NAME% (%USERNAME%) >> logs.log
echo %DATE% %TIME% ^>^> *%BAN:-= % was banned by %NAME% >> chat.log
set BAN=%BAN: =-%
cd users
echo %DATE% %TIME% ^>^> %BAN:-= % was banned by *%NAME% (%USERNAME%) >%BAN%.ban
echo %BAN:-= % - Banned by *%NAME% (%USERNAME%) on %DATE% at %TIME%>>bans.log
cd .. 
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



:unban
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
color 4
set UNBAN=%TEXT%
if "%UNBAN%"=="/unban" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set UNBAN=%UNBAN:/unban =%
if "%UNBAN%"=="" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
set UNBAN=%UNBAN: =-%
cd users
if NOT EXIST "%UNBAN%.dll" goto :ACCNOTEXIST
if NOT EXIST "%UNBAN%.ban" goto :BANNOTEXIST
cd ..
title %UNBAN:-= % has been unbanned
echo /////////////////////
echo /   USER UNBANNED   /
echo /////////////////////
echo 
echo %DATE% %TIME% ^>^> *%UNBAN:-= % was unbanned by *%NAME% (%USERNAME%) >> logs.log
echo %DATE% %TIME% ^>^> *%UNBAN:-= % was unbanned by %NAME% >> chat.log
cd users
del /q "%UNBAN%.ban"
set UNBAN=%UNBAN:-= %
findstr /V /I /R /C:"^%UNBAN%\>" "bans.log" > "new_bans.log"
move /Y "new_bans.log" "bans.log">nul
cd ..
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



:PCBAN
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
color 4
set PCBAN=%TEXT%
if "%PCBAN%"=="/pcban" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set PCBAN=%PCBAN:/pcban =%
if "%PCBAN%"=="" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
cd users
if EXIST "%PCBAN%.ban" goto :ALREADYBANNED
cd ..
title %PCBAN% has been pc banned
echo /////////////////////
echo /   USER PCBANNED   /
echo /////////////////////
echo 
echo %DATE% %TIME% ^>^> %PCBAN% was pc banned by *%NAME% (%USERNAME%) >> logs.log
echo %DATE% %TIME% ^>^> %PCBAN% was pc banned by %NAME% >> chat.log
cd users
set PCBAN=%PCBAN: =-%
echo %DATE% %TIME% ^>^> %PCBAN% was pc banned by *%NAME% (%USERNAME%) >%PCBAN%.ban
cd ..
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



:UNPCBAN
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
color 4
set UNPCBAN=%TEXT%
if "%UNPCBAN%"=="/UNPCBAN" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set UNPCBAN=%UNPCBAN:/UNPCBAN =%
if "%UNPCBAN%"=="" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cd users
if NOT EXIST "%UNPCBAN%.ban" goto :BANNOTEXIST
cd ..
cls
title %UNPCBAN% Has been unpcbanned
echo ///////////////////////
echo /   USER UNPCBANNED   /
echo ///////////////////////
echo 
echo %DATE% %TIME% ^>^> %UNPCBAN% was pc unbanned by *%NAME% (%USERNAME%) >> logs.log
echo %DATE% %TIME% ^>^> %UNPCBAN% was pc unbanned by %NAME% >> chat.log
cd users
set UNPCBAN=%UNPCBAN: =-%
del /q "%UNPCBAN%.ban"
cd ..
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT


:ACCNOTEXIST
cd ..
cls
title Account does not exist
color 4
echo ////////////////////////
echo /   ACCOUNT DOES NOT   /
echo /        EXIST         /
echo ////////////////////////
echo 
echo Please enter an account name that exists.
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) tried to ban or unban an account that does not exist>>logs.log
timeout /t 3 /nobreak >nul
if %NICKED%==1 goto :NCHAT
goto :CHAT
if %CHATASED%==1 goto :CHATASLOOP


:BANNOTEXIST
cd ..
cls
title User is not banned
color 4
echo ///////////////////
echo /   USER IS NOT   /
echo /      BANNED     /
echo ///////////////////
echo 
echo Please enter the name of someone who is banned.
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) tried to unban an account that is not banned>>logs.log
timeout /t 3 /nobreak >nul
if %NICKED%==1 goto :NCHAT
goto :CHAT
if %CHATASED%==1 goto :CHATASLOOP


:ALREADYBANNED
cd ..
cls
title User is already banned
color 4
echo ///////////////////////
echo /   USER IS ALREADY   /
echo /       BANNED        /
echo ///////////////////////
echo 
echo Please enter the name of someone who is not already banned.
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) tried to ban an account that is already banned>>logs.log
timeout /t 3 /nobreak >nul
if %NICKED%==1 goto :NCHAT
goto :CHAT
if %CHATASED%==1 goto :CHATASLOOP


:BANNED
cls
color 4
title BANNED
echo ////////////////////////////
echo /   YOU HAVE BEEN BANNED   /
echo ////////////////////////////
echo.
echo go away
echo 
timeout /t 3 /nobreak >nul
exit



:TERMINATE
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
color 4
set TERMINATEACC=%TEXT%
if "%TERMINATEACC%"=="/terminate" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set TERMINATEACC=%TERMINATEACC:/terminate =%
if "%TERMINATEACC%"=="" (
    cls
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
set TERMINATEACC=%TERMINATEACC: =-%
title /terminate
color 4
cd users
if NOT EXIST "%TERMINATEACC%.dll" (

    cls
    title %TERMINATEACC%.dll NOT FOUND
    echo //////////////////////////////
    echo /   ACCOUNT DOES NOT EXIST   /
    echo //////////////////////////////
    echo 
    cd ..
    echo %DATE% %TIME% ^>^> *%NAME% ^(%USERNAME%^) tried to delete an account that does not exist >> logs.log
    TIMEOUT /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)

cls
title DELETING %TERMINATEACC%.dll
echo ////////////////////////
echo /   DELETING ACCOUNT   /
echo ////////////////////////
echo 
TIMEOUT /t 2 /nobreak >nul
del /q %TERMINATEACC%.dll
cd ..
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Terminated account "*%TERMINATEACC%" >> logs.log
title %TERMINATEACC%.dll Successfully deleted
echo %TERMINATEACC%.dll has been deleted.
TIMEOUT /t 3 >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



:CHANGEPASSWORD
cls
color 4
title /changepassword
echo /////////////////////////////////////
echo /        ARE YOU SURE YOU           /
echo /   WANT TO CHANGE YOUR PASSWORD?   /
echo /////////////////////////////////////
echo 
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
color 7
echo /////////////////////////////////////
echo /   PLEASE ENTER CURRENT PASSWORD   /
echo /////////////////////////////////////
echo.
set "psCommand=powershell -Command "$pword = read-host 'Password' -AsSecureString ; ^
     $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
           [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set C_PASSWORD=%%p

setlocal enabledelayedexpansion

set inputcode=9375 
set code=%C_PASSWORD%
set chars=0123456789abcdefghijklmnopqrstuvwxyz

for /L %%N in (10 1 36) do (
    for /F %%C in ("!chars:~%%N,1!") do (
        set /a MATH=%%N*%inputcode%
        for /f %%F in ("!MATH!") do (
            set "code=!code:%%C=-%%F!"
        )
    )
)

set C_PASSWORD=!code!
set "C_PASSWORD=%C_PASSWORD: =_%"

setlocal disabledelayedexpansion

cd users
findstr /I /R /C:"^p\>" "%NAME%.dll">%TEMP%\CHATCHANGEPW.tmp
set /p password_file=<%TEMP%\CHATCHANGEPW.tmp
del %TEMP%\CHATCHANGEPW.tmp
set password_file=%password_file:p!=%
if %C_PASSWORD%==%password_file% goto :CORRECT_PASSWORD
goto :WRONG_PASSWORD

:WRONG_PASSWORD
cls
color 4
title Incorrect password
echo //////////////////////
echo /   WRONG PASSWORD   /
echo //////////////////////
echo 
cd ..
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) entered the current password wrong when trying to change it >>logs.log
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT

:CORRECT_PASSWORD
cls
title Enter new password
echo //////////////////////////
echo /   ENTER NEW PASSWORD   /
echo //////////////////////////
echo.
set "psCommand=powershell -Command "$pword = read-host 'New Password' -AsSecureString ; ^
     $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
           [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set NEW_PASSWORD=%%p
set "psCommand=powershell -Command "$pword = read-host 'Confirm New Password' -AsSecureString ; ^
     $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
           [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set CONFIRM_PASS=%%p
if "%NEW_PASSWORD%" NEQ "%CONFIRM_PASS%" (
    cls
    title Passwords do not match
    color 4
    echo /////////////////////////////
    echo /   PASSWORDS DON'T MATCH   /
    echo /////////////////////////////
    echo 
    timeout /t 3 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)

setlocal enabledelayedexpansion

set inputcode=9375 
set code=%NEW_PASSWORD%
set chars=0123456789abcdefghijklmnopqrstuvwxyz

for /L %%N in (10 1 36) do (
    for /F %%C in ("!chars:~%%N,1!") do (
        set /a MATH=%%N*%inputcode%
        for /f %%F in ("!MATH!") do (
            set "code=!code:%%C=-%%F!"
        )
    )
)

set NEW_PASSWORD=!code!
set "NEW_PASSWORD=%NEW_PASSWORD: =_%"

setlocal disabledelayedexpansion

echo p!%NEW_PASSWORD%>%NAME%.dll
if "%ADMIN%"=="TRUE" echo a!TRUE>>%NAME%.dll
if "%ADMIN%"=="FALSE" echo a!FALSE>>%NAME%.dll
cd ..
cls
title password changed successfully
color 2
echo ////////////////////////
echo /   PASSWORD CHANGED   /
echo ////////////////////////
echo.
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Changed there password >>logs.log
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



:deleteaccount
cls
color 4
title /deleteaccount
echo ///////////////////////////////
echo /    ARE YOU SURE YOU WANT    /
echo /   TO DELETE YOUR ACCOUNT?   /
echo ///////////////////////////////
echo 
choice
if %ERRORLEVEL%==2 (
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
    if %CHATASED%==1 goto :CHATASLOOP
)
cls
echo //////////////////////////////////////////
echo /   PLEASE ENTER YOUR CURRENT PASSWORD   /
echo //////////////////////////////////////////
echo.
set "psCommand=powershell -Command "$pword = read-host 'Password' -AsSecureString ; ^
     $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
           [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set DELCURRENTPASSWORD=%%p
cd users
set DELNAME=%NAME: =-%
findstr /I /R /C:"^p\>" "%DELNAME%.dll">%TEMP%\CHATDELPW.tmp
set /p DELPASSWORD=<%TEMP%\CHATDELPW.tmp
del %TEMP%\CHATDELPW.tmp
set DELPASSWORD=%DELPASSWORD:p!=%

setlocal enabledelayedexpansion

set inputcode=9375 
set code=%DELCURRENTPASSWORD%
set chars=0123456789abcdefghijklmnopqrstuvwxyz

for /L %%N in (10 1 36) do (
    for /F %%C in ("!chars:~%%N,1!") do (
        set /a MATH=%%N*%inputcode%
        for /f %%F in ("!MATH!") do (
            set "code=!code:%%C=-%%F!"
        )
    )
)
set DELCURRENTPASSWORD=!code!
set "DELCURRENTPASSWORD=%DELCURRENTPASSWORD: =_%"

setlocal disabledelayedexpansion

if NOT %DELCURRENTPASSWORD%==%DELPASSWORD% (
    cls
    title Incorrect password
    echo /////////////////////
    echo /   WRONG PASWORD   /
    echo /////////////////////
    echo 
    timeout /t 3 /nobreak >nul
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
    if %CHATASED%==1 goto :CHATASLOOP
)
cls
title deleting account...
echo ////////////////////////
echo /   DELETING ACCOUNT   /
echo ////////////////////////
echo.
timeout /t 3 /nobreak >nul
del /q %DELNAME%.dll
cd ..
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) deleted there account>>logs.log
echo Account delete.
echo It was nice having you around :)
title Account deleted
timeout /t 2 /nobreak >nul
echo. >%TEMP%\CHATLOGOUT.tmp
exit



:BANLIST
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title banlist
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Checked the ban list>>logs.log
cd users
:BANLISTLOOP
cls
echo Currently banned accounts:
echo.
type bans.log
echo.
echo.
echo Press any key to go back
echo Press "r" to refresh
choice /c r1234567890qwetyuiopasdfghjklzxcvbnm >nul
if %ERRORLEVEL%==1 goto :BANLISTLOOP
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



:debug
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
cd ..
if EXIST debug.bat (
    color 4
    echo //////////////////////
    echo /   DEBUG MODE OFF   /
    echo //////////////////////
    echo.
    del debug.bat
    cd info
    echo %DATE% %TIME% ^>^> *%NAME% ^(%USERNAME%^) turned OFF debug mode>>logs.log
    timeout /t 3 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
color 2
echo /////////////////////
echo /   DEBUG MODE ON   /
echo /////////////////////
echo.
echo @echo off>>debug.bat
echo echo. ^>debug>>debug.bat
echo call Chat.bat>>debug.bat
cd info
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) turned ON debug mode>>logs.log
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT


:easter_ehg
start dino.bat
exit


:PROMOTE
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> %TEXT%% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
    
)
cls
set PROMOTE=%TEXT%
if "%PROMOTE%"=="/promote" (
    cls
    title /promote
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set PROMOTE=%PROMOTE:/promote =%
if "%PROMOTE%"=="" (
    cls
    title /promote
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cd users
if NOT EXIST "%PROMOTE: =-%.dll" (

    cls
    color 4
    title %PROMOTE: =-%.dll NOT FOUND
    echo //////////////////////////////
    echo /   ACCOUNT DOES NOT EXIST   /
    echo //////////////////////////////
    echo 
    cd ..
    echo %DATE% %TIME% ^>^> *%NAME% ^(%USERNAME%^) tried to promote an account that does not exist >> logs.log
    TIMEOUT /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
findstr /I /R /C:"^a\>" "%PROMOTE%.dll">%TEMP%\ADMINCH.tmp
set /p ADMINCH=<%TEMP%\ADMINCH.tmp
del %TEMP%\ADMINCH.tmp
set ADMINCH=%ADMINCH:a!=%
if "%ADMINCH%"=="TRUE" (
    cls
    color 4
    title %PROMOTE% ALREADY IS AN ADMIN
    echo ////////////////////////////////
    echo /   USER ALREADY IS AN ADMIN   /
    echo ////////////////////////////////
    echo 
    cd ..
    echo %DATE% %TIME% ^>^> *%NAME% ^(%USERNAME%^) Tried to promote %PROMOTE% but they where alreday an admin >>logs.log
    TIMEOUT /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title /promote %PROMOTE%
echo /////////////////////////////
echo /   ARE YOU SURE YOU WANT   /
echo /   TO PROMOTE THIS USER?   /
echo /////////////////////////////
echo.
echo If you promote %PROMOTE% they will have full access to all admin commands.
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set PROMOTE=%PROMOTE: =-%
findstr /V /I /R /C:"^a\>" "%PROMOTE%.dll" > "%PROMOTE%.dll.tmp"
move /Y "%PROMOTE%.dll.tmp" "%PROMOTE%.dll">nul
echo a!TRUE>>%PROMOTE%.dll
cd ..
color 2
cls
echo ////////////////////////
echo /   ACCOUNT PROMOTED   /
echo ////////////////////////
echo.
echo The account "%PROMOTE:-= %" has been granted admin permissions!
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Promoted %PROMOTE%>>logs.log
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT


:DEMOTE
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%NAME%^> %TEXT%% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo Message sent
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
    
)
cls
set DEMOTE=%TEXT%
if "%DEMOTE%"=="/demote" (
    cls
    title /demote
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set DEMOTE=%DEMOTE:/demote =%
if "%DEMOTE%"=="" (
    cls
    title /demote
    color 4
    echo ////////////////////////////////
    echo /   YOU MUST ENTER SOMETHING   /
    echo ////////////////////////////////
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cd users
if NOT EXIST "%DEMOTE: =-%.dll" (

    cls
    color 4
    title %DEMOTE: =-%.dll NOT FOUND
    echo //////////////////////////////
    echo /   ACCOUNT DOES NOT EXIST   /
    echo //////////////////////////////
    echo 
    cd ..
    echo %DATE% %TIME% ^>^> *%NAME% ^(%USERNAME%^) tried to demote an account that does not exist >> logs.log
    TIMEOUT /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
findstr /I /R /C:"^a\>" "%DEMOTE%.dll">%TEMP%\ADMINCH.tmp
set /p ADMINCH=<%TEMP%\ADMINCH.tmp
del %TEMP%\ADMINCH.tmp
set ADMINCH=%ADMINCH:a!=%
if "%ADMINCH%"=="FALSE" (
    cls
    color 4
    title %DEMOTE% ALREADY IS NOT AN ADMIN
    echo ////////////////////////////
    echo /   USER IS NOT AN ADMIN   /
    echo ////////////////////////////
    echo 
    cd ..
    echo %DATE% %TIME% ^>^> *%NAME% ^(%USERNAME%^) Tried to demote %DEMOTE% but they where not an admin >>logs.log
    TIMEOUT /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title /demote %DEMOTE%
echo /////////////////////////////
echo /   ARE YOU SURE YOU WANT   /
echo /   TO DEMOTE THIS USER?    /
echo /////////////////////////////
echo.
echo If you demote %DEMOTE% they loose access to all admin commands.
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set DEMOTE=%DEMOTE: =-%
findstr /V /I /R /C:"^a\>" "%DEMOTE%.dll" > "%DEMOTE%.dll.tmp"
move /Y "%DEMOTE%.dll.tmp" "%DEMOTE%.dll">nul
echo a!FALSE>>%DEMOTE%.dll
cd ..
color 4
cls
echo ////////////////////////
echo /   ACCOUNT DEMOTED    /
echo ////////////////////////
echo.
echo The account "%DEMOTE:-= %" has had their admin permissions revoked!
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Demoted %DEMOTE%>>logs.log
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT