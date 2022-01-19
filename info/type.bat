@echo off

set VERSION=4.0
set FILETYPE=.bat

@REM Adds colours (very pretty)
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

@REM Some stuff brought over from chat.bat
if "%1" NEQ "1" goto :FAIL

set NAME=%2
set NAME=%NAME:-= %
set %h_NAME%=%4
set h_ADMIN=%5

set /a NICKED=0
set /a CHATASED=0

if %3==TRUE (
    set ADMIN=TRUE
) ELSE (
    set ADMIN=FALSE
)

goto :CHATJOIN

pause

@REM If user did not run chat.bat
:FAIL
cls
title NOT AUTHORIZED
color 4
echo %_fRed%%_bRed%//////////////////////
echo /%_bBlack%   NOT AUTHORIZED   %_bRed%/
echo /%_bBlack%   RUN "chat%FILETYPE%"   %_bRed%/
echo //////////////////////%_RESET%
echo 
echo %DATE% %TIME% ^>^> %USERNAME% Has tried to access type%FILETYPE% without running chat%FILETYPE% >>logs.log
timeout /t 5 /nobreak >nul
exit



@REM Announces that you joined the chat
:CHATJOIN
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Joined the chat >> logs.log
echo %_fblue%%DATE% %TIME% %_fRed%^>^> %_fBGreen%%NAME%%_RESET% Joined the chat >> chat.log

@REM Main chat
:CHAT

@REM Checks if you are banned
if exist "users\%h_NAME%.ban" goto :BANNED
if exist "users\%USERNAME%.ban" goto :BANNED

cls

@REM Adds title
if "%ADMIN%" NEQ "TRUE" (
    title TYPE HERE %NAME%   -   Type /help to see a list of commands
)
if "%ADMIN%"=="TRUE" (
    title TYPE HERE %NAME%   -   Type /help to see a list of commands - ADMIN MODE -
)

color 7

set /p TEXT=^>^>

@REM Another ban check
if exist "users\%h_NAME%.ban" goto :BANNED
if exist "users\%USERNAME%.ban" goto :BANNED

if "%TEXT%"=="" goto :CHAT

@REM Bad words
set "text=%text:nigger=******%"
set "text=%text:faggot=******%"
set "text=%text:bitch=*****%"
set "text=%text:whore=*****%"
set "text=%text:homo=****%"
set "text=%text:fag=***%"
set "text=%text:cunt=****%"



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
@REM if "%TEXT%"=="/debug" goto :debug
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



@REM Sends message
echo ^<%_fbGreen%%NAME%%_RESET%^> %TEXT% >> chat.log
set TEXT=
echo %_fBGreen%%_fBGreen%Message sent%_RESET%%_RESET%
timeout /t 2 /nobreak >nul
goto :CHAT
if %CHATASED%==1 goto :CHATASLOOP



@REM List of commands
:help
cls
title /help
echo %_fBGreen%Commands:%_RESET%
echo %_fBBlue%/help %_fRed%- %_RESET%Brings up this menu
echo %_fBBlue%/info %_fRed%- %_RESET%Gives you some info
echo %_fBBlue%/logout %_fRed%- %_RESET%Go's back the login page
echo %_fBBlue%/nick (NCIKNAME) %_fRed%- %_RESET%Set a nickname
echo %_fBBlue%/changepassword %_fRed%- %_RESET%Menu to change your password
echo %_fBBlue%/deleteaccount %_fRed%- %_RESET%Deletes your account
if %NICKED%==1 echo /back %_fRed%- %_RESET%Removes your nickname
if "%ADMIN%"=="TRUE" echo.
if "%ADMIN%"=="TRUE" echo %_fBGreen%ADMIN COMMANDS:%_RESET%
if "%ADMIN%"=="TRUE" echo %_fBBlue%/logs %_fRed%- %_RESET%This will show you the every command a user uses, every time someone logs in or our and more.
if "%ADMIN%"=="TRUE" echo %_fBBlue%/chatfile %_fRed%- %_RESET%This will open the file where the chat is stored ^(chat.log^).
if "%ADMIN%"=="TRUE" echo %_fBBlue%/chatas (NAME) %_fRed%- %_RESET%Chat with a set username.
if "%ADMIN%"=="TRUE" echo %_fBBlue%/ad (TEXT) %_fRed%- %_RESET%Advertise something in chat.
if "%ADMIN%"=="TRUE" echo %_fBBlue%/clearchat %_fRed%- %_RESET%This will clear the chat.
if "%ADMIN%"=="TRUE" echo %_fBBlue%/clearlogs %_fRed%- %_RESET%This will clear the logs.
if "%ADMIN%"=="TRUE" echo %_fBBlue%/slogout %_fRed%- %_RESET%Same as /logout but it does not say it in chat.
if "%ADMIN%"=="TRUE" echo %_fBBlue%/ban %_fRed%- %_RESET%Bans user account.
if "%ADMIN%"=="TRUE" echo %_fBBlue%/unban %_fRed%- %_RESET%Unbans user account.
if "%ADMIN%"=="TRUE" echo %_fBBlue%/pcban %_fRed%- %_RESET%Bans person with matching PC username.
if "%ADMIN%"=="TRUE" echo %_fBBlue%/unpcban %_fRed%- %_RESET%unbans person with matching PC username.
if "%ADMIN%"=="TRUE" echo %_fBBlue%/bans %_fRed%- %_RESET%Shows a list off all banned accounts
if "%ADMIN%"=="TRUE" echo %_fBBlue%/terminate %_fRed%- %_RESET%Deletes an account.
@REM if "%ADMIN%"=="TRUE" echo %_fBBlue%/debug %_fRed%- %_RESET%Creates or removes debug.bat which when run will log you into an account called test instantly.
if "%ADMIN%"=="TRUE" echo %_fBBlue%/promote (NAME) %_fRed%- %_RESET%Gives the user admin permissions
if "%ADMIN%"=="TRUE" echo %_fBBlue%/demote (NAME) %_fRed%- %_RESET%revokes the users admin permissions
if "%ADMIN%"=="TRUE" echo.
if "%ADMIN%"=="TRUE" echo In the logs, any name with an * before it means it is the account name, not the computer name.
echo.
echo %_fBGreen%Press any key to go back%_RESET%
pause>nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Info on the program
:info
title /info
echo %_fGreen%VERSION: %_fRed%%VERSION%
echo %_fblue%Made by Immortal Terror
echo.
echo %_fbgreen%How do I use this?%_RESET%
echo Just make an account, login, and start talking!
echo.
echo %_fbgreen%What commands are there?%_RESET%
echo Type "/help" to see a list of commands.
echo.
echo %_fbgreen%Can someone get my accounts password?%_RESET%
echo It is practically impossible for someone to get your password as they are hashed with sha256. Only way they could get it is with brute force.
echo.
echo %_fbgreen%I have found a bug or an issue, what do I do?%_RESET%
echo If you find any sort of bug, please open an issue on the github page. I will fix it as fast as I can.
echo.
echo %_fbgreen%Where can i suggest a feature?%_RESET%
echo Anywhere really. But either on Github or Discord would be the best.
echo.
echo %_fGreen%Press any key to go back%_RESET%
pause>nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM quits the type window and says it in chat
:quit
cls
title /logout
echo %_fRed%are you sure you want to logout?%_RESET%
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
echo %_fblue%%DATE% %TIME% %_fRed%^>^> %_fbGreen%%NAME%%_RESET% Logged out >> chat.log
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Logged out >> logs.log
echo. >%TEMP%\CHATLOGOUT.tmp
exit



@REM Silent logout. it's called "squit" because its a repurposed old command
:squit
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> /slogout >> chat.log
    cls
    echo ^>^>/slogout
    echo %_fBGreen%Message sent%_RESET%
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title /logout (SILENT)
echo %_fRed%are you sure you want to logout?%_RESET%
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
    echo ^<%_fbgreen%%NAME%%_RESET%^> /logs >> chat.log
    cls
    echo ^>^>/logs
    echo %_fBGreen%Message sent%_RESET%
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title LOGS
:LOGSLOOP
cls
echo %_fblue%Logs:%_RESET%
echo.
if exist logs.log type logs.log
echo.
echo.
echo %_fbGreen%Press any key to go back
echo Press %_bBWhite%%_fBlack%"r"%_RESET%%_fbGreen% to refresh%_RESET%
choice /c r1234567890qwetyuiopasdfghjklzxcvbnm >nul
if %ERRORLEVEL%==1 goto :LOGSLOOP
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT
    


@REM Opens the chat file (chat.log), admin only
:chatfile
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> /chatfile >> chat.log
    cls
    echo ^>^>/chatfile
    echo %_fBGreen%Message sent%_RESET%
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
echo Opened %_fblue%chat.log%_RESET%
echo %_fGreen%Close %_fblue%chat.log%_fGreen% to go back%_RESET%
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) opened chat file >>logs.log
call chat.log
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Clears chat.log
:clear
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> /clearchat >> chat.log
    cls
    echo ^>^>/clearchat
    echo %_fBGreen%Message sent%_RESET%
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title CHAT CLEAR MENU
echo %_fRed%%_bRed%//////////////////////////////////////////
echo /%_bBlack%   ARE YOU SURE YOU WANT TO CONTINUE?   %_bRed%/
echo //////////////////////////////////////////%_RESET%
echo 
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
echo %_fblue%Clearing chat.log...%_RESET%
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) cleared the chat >> logs.log
timeout /t 3 /nobreak >nul
del /q chat.log
color 7
cls
echo %_fGreen%Cleared chat.log%_RESET%
echo.
TIMEOUT /t 3 >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Clears logs.log, admin only
:clearl
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> /clearlogs >> chat.log
    cls
    echo ^>^>/clearlogs
    echo %_fBGreen%Message sent%_RESET%
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title LOGS CLEAR MENU
color 4
echo %_fRed%%_bRed%//////////////////////////////////////////
echo /%_bBlack%   ARE YOU SURE YOU WANT TO CONTINUE?   %_bRed%/
echo //////////////////////////////////////////%_RESET%
echo 
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
echo %_fblue%Clearing logs.log...%_RESET%
timeout /t 3 /nobreak >nul
del /q logs.log
color 7
cls
echo %_fGreen%Cleared logs.log%_RESET%
echo.
TIMEOUT /t 3 >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM chat with a chosen username, admin only
:chatas
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> %TEXT%% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo %_fBGreen%Message sent%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
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
if exist "users\%h_NAME%.ban" goto :BANNED
if exist "users\%USERNAME%.ban" goto :BANNED
cls
title Chatting as %CHATASN% - Type /back to go back - Type /help to see a list of commands
color 7
set /p TEXT=^>^>
if exist "users\%h_NAME%.ban" goto :BANNED
if exist "users\%USERNAME%.ban" goto :BANNED

if "%TEXT%"=="" goto :CHATASLOOP

@REM Bad words
set "text=%text:nigger=******%"
set "text=%text:faggot=******%"
set "text=%text:bitch=*****%"
set "text=%text:whore=*****%"
set "text=%text:homo=****%"
set "text=%text:fag=***%"
set "text=%text:cunt=****%"



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
@REM if "%TEXT%"=="/debug" goto :debug
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

echo ^<%_fbgreen%%CHATASN%%_RESET%^> %TEXT% >> chat.log
echo %_fBGreen%Message sent%_RESET%
timeout /t 2 /nobreak >nul
goto :CHATASLOOP



@REM Removes chatas name
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
    echo ^<%_fbgreen%%NAME%%_RESET%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo %_fBGreen%Message sent%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
echo %_fRed%^>^> %_fbgreen%%ADVERT% %_fRed%^<^<%_RESET%>>chat.log
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) advertised "%ADVERT%">>logs.log
cls
echo %_fGreen%Advert sent%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
    echo 
    timeout /t 3 >nul
    set /a NICKED=0
    goto :CHAT
)
set NICK=%NICK:/nick =%
if "%NICK%"=="" (
    cls
    color 4
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
    echo 
    timeout /t 3 >nul
    set /a NICKED=0
    goto :CHAT
)
set /a NICKED=1
echo %_fblue%%DATE% %TIME% %_fRed%^>^> %_fbgreen%%NAME%%_RESET% has set there nickname to "%_fGreen%%NICK%%_RESET%" >> chat.log
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) has set there nickname to "%NICK%" >> logs.log
cls
echo Nickname is now %_fGreen%%NICK%%_RESET%
timeout /t 2 /nobreak >nul
cls

@REM clone of main chat but for nicked users
:NCHAT
if exist "users\%h_NAME%.ban" goto :BANNED
if exist "users\%USERNAME%.ban" goto :BANNED
cls
if "%ADMIN%" NEQ "TRUE" title TYPE HERE %NAME% - Nickname: %NICK% - Type /back to go back - Type /help to see a list of commands
if "%ADMIN%"=="TRUE" title TYPE HERE %NAME% - Nickname: %NICK% - Type /back to go back - Type /help to see a list of commands - ADMIN MODE -
color 7
set /p TEXT=^>^>

if "%TEXT%"=="" goto :NCHAT

@REM Bad words
set "text=%text:nigger=******%"
set "text=%text:faggot=******%"
set "text=%text:bitch=*****%"
set "text=%text:whore=*****%"
set "text=%text:homo=****%"
set "text=%text:fag=***%"
set "text=%text:cunt=****%"


if exist "users\%h_NAME%.ban" goto :BANNED
if exist "users\%USERNAME%.ban" goto :BANNED


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
@REM if "%TEXT%"=="/debug" goto :debug
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
echo ^<%_fGreen%%NICK%%_RESET%^> %TEXT% >> chat.log
set TEXT=
echo %_fBGreen%Message sent%_RESET%
timeout /t 2 /nobreak >nul
goto :NCHAT

@REM removes nickname
:unnick
cls
title unnick
echo %_fRed%Nickname removed%_RESET%
echo %_fblue%%DATE% %TIME% %_fRed%^>^> %_fGreen%%NICK%%_RESET% (%_fbgreen%%NAME%%_RESET%) Removed there nickname >>chat.log
echo %DATE% %TIME% ^>^> %NICK% (*%NAME% (%USERNAME%)) Removed there nickname >>logs.log
set NICK=%NAME%
set /a NICKED=0
timeout /t 2 /nobreak >nul
goto :CHAT



@REM Bans user
:ban
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo %_fBGreen%Message sent%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls

echo %BAN%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_BAN=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

if NOT EXIST "users\%h_BAN%.dll" goto :ACCNOTEXIST
if EXIST "users\%h_BAN%.ban" goto :ALREADYBANNED
color 4
title %BAN% has been banned
echo %_bRed%%_fRed%///////////////////
echo /%_bBlack%   USER BANNED   %_bRed%/
echo ///////////////////%_RESET%
echo 
echo %DATE% %TIME% ^>^> *%BAN:-= % was banned by *%NAME% (%USERNAME%) >> logs.log
echo %_fblue%%DATE% %TIME% %_fRed%^>^> %_fbgreen%%BAN:-= %%_RESET% was banned by %_fbgreen%%NAME%%_RESET% >> chat.log
set BAN=%BAN%
echo %DATE% %TIME% ^>^> %BAN:-= % was banned by *%NAME% (%USERNAME%) >users\%h_BAN%.ban
echo %BAN% - Banned by *%NAME% (%USERNAME%) on %DATE% at %TIME%>>users\bans.log
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Unbans user
:unban
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo %_fBGreen%Message sent%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls

echo %UNBAN%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_UNBAN=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

if NOT EXIST "users\%h_UNBAN%.dll" goto :ACCNOTEXIST
if NOT EXIST "users\%h_UNBAN%.ban" goto :BANNOTEXIST
title %UNBAN% has been unbanned
echo %_bRed%%_fRed%/////////////////////
echo /%_bBlack%   USER UNBANNED   %_bRed%/
echo /////////////////////%_RESET%
echo 
echo %DATE% %TIME% ^>^> *%UNBAN:-= % was unbanned by *%NAME% (%USERNAME%) >> logs.log
echo %_fblue%%DATE% %TIME% %_fRed%^>^> %_fbgreen%%UNBAN:-= %%_RESET% was unbanned by %_fbgreen%%NAME%%_RESET% >> chat.log
del /q "users\%h_UNBAN%.ban"
findstr /V /I /R /C:"^%UNBAN%\>" "users\bans.log" > "users\new_bans.log"
move /Y "users\new_bans.log" "users\bans.log">nul
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Pc bans user (bans windows account)
:PCBAN
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo %_fBGreen%Message sent%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
if EXIST "users\%PCBAN%.ban" goto :ALREADYBANNED
title %PCBAN% has been pc banned
echo %_bRed%%_fRed%/////////////////////
echo /%_bBlack%   USER PCBANNED   %_bRed%/
echo /////////////////////%_RESET%
echo 
echo %DATE% %TIME% ^>^> %PCBAN% was pc banned by *%NAME% (%USERNAME%) >> logs.log
echo %_fblue%%DATE% %TIME% %_fRed%^>^> %_fbgreen%%PCBAN%%_RESET% was pc banned by %_fbgreen%%NAME%%_RESET% >> chat.log
set PCBAN=%PCBAN: =-%
echo %DATE% %TIME% ^>^> %PCBAN% was pc banned by *%NAME% (%USERNAME%) >users\%PCBAN%.ban
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Un pc ban's
:UNPCBAN
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo %_fBGreen%Message sent%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
    echo 
    timeout /t 3 >nul
    @REM Among us?!?
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
if NOT EXIST "users\%UNPCBAN%.ban" goto :BANNOTEXIST
cls
title %UNPCBAN% Has been unpcbanned
echo %_bRed%%_fRed%///////////////////////
echo /%_bBlack%   USER UNPCBANNED   %_bRed%/
echo ///////////////////////%_RESET%
echo 
echo %DATE% %TIME% ^>^> %UNPCBAN% was pc unbanned by *%NAME% (%USERNAME%) >> logs.log
echo %_fblue%%DATE% %TIME% %_fRed%^>^> %_fbgreen%%UNPCBAN%%_RESET% was pc unbanned by %_fbgreen%%NAME%%_RESET% >> chat.log
set UNPCBAN=%UNPCBAN: =-%
del /q "users\%UNPCBAN%.ban"
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT


@REM If the account of the user you are trying to (un)ban does not exist
:ACCNOTEXIST
cls
title Account does not exist
color 4
echo %_bRed%%_fRed%////////////////////////
echo /%_bBlack%   ACCOUNT DOES NOT   %_bRed%/
echo /%_bBlack%        EXIST         %_bRed%/
echo ////////////////////////%_RESET%
echo 
echo %_fGreen%Please enter an account name that exists.%_RESET%
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) tried to ban or unban an account that does not exist>>logs.log
timeout /t 3 /nobreak >nul
if %NICKED%==1 goto :NCHAT
goto :CHAT
if %CHATASED%==1 goto :CHATASLOOP



@REM If the user you are trying to unban is not banned
:BANNOTEXIST
cls
title User is not banned
color 4
echo %_bRed%%_fRed%///////////////////
echo /%_bBlack%   USER IS NOT   %_bRed%/
echo /%_bBlack%      BANNED     %_bRed%/
echo ///////////////////%_RESET%
echo 
echo %_fGreen%Please enter the name of someone who is banned.%_RESET%
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) tried to unban an account that is not banned>>logs.log
timeout /t 3 /nobreak >nul
if %NICKED%==1 goto :NCHAT
goto :CHAT
if %CHATASED%==1 goto :CHATASLOOP



@REM If the user you are trying to ban is already banned
:ALREADYBANNED
cls
title User is already banned
color 4
echo %_bRed%%_fRed%///////////////////////
echo /%_bBlack%   USER IS ALREADY   %_bRed%/
echo /%_bBlack%       BANNED        %_bRed%/
echo ///////////////////////%_RESET%
echo 
echo %_fGreen%Please enter the name of someone who is not already banned.%_RESET%
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) tried to ban an account that is already banned>>logs.log
timeout /t 3 /nobreak >nul
if %NICKED%==1 goto :NCHAT
goto :CHAT
if %CHATASED%==1 goto :CHATASLOOP



@REM Message when you are banned
:BANNED
cls
color 4
title BANNED
echo %_bRed%%_fRed%////////////////////////////
echo /%_bBlack%   YOU HAVE BEEN BANNED   %_bRed%/
echo ////////////////////////////%_RESET%
echo.
echo go away
echo 
timeout /t 3 /nobreak >nul
exit



@REM Command to delete other users accounts
:TERMINATE
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo %_fBGreen%Message sent%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls

echo %TERMINATEACC%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_TERMINATEACC=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

title /terminate
color 4
if NOT EXIST "users\%h_TERMINATEACC%.dll" (

    cls
    title %TERMINATEACC%.dll NOT FOUND
    echo %_bRed%%_fRed%//////////////////////////////
    echo /%_bBlack%   ACCOUNT DOES NOT EXIST   %_bRed%/
    echo //////////////////////////////%_RESET%
    echo 
    echo %DATE% %TIME% ^>^> *%NAME% ^(%USERNAME%^) tried to delete an account that does not exist >> logs.log
    TIMEOUT /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)

cls
title DELETING %TERMINATEACC%.dll
echo %_bRed%%_fRed%////////////////////////
echo /%_bBlack%   DELETING ACCOUNT   %_bRed%/
echo ////////////////////////%_RESET%
echo 
TIMEOUT /t 2 /nobreak >nul

del /q users\%h_TERMINATEACC%.dll
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Terminated account "*%TERMINATEACC%" >> logs.log
title %TERMINATEACC%'s account has been Successfully deleted
echo %_fbgreen%%TERMINATEACC%%_RESET% (%_fblue%%h_TERMINATEACC%.dll%_RESET%) has been %_fRed%deleted%_RESET%.
TIMEOUT /t 3 >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Command to change your password
:CHANGEPASSWORD
cls
color 4
title /changepassword
echo %_bRed%%_fRed%/////////////////////////////////////
echo /%_bBlack%        ARE YOU SURE YOU           %_bRed%/
echo /%_bBlack%   WANT TO CHANGE YOUR PASSWORD?   %_bRed%/
echo /////////////////////////////////////%_RESET%
echo 
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
color 7
echo %_bbGreen%%_fbgreen%/////////////////////////////////////
echo /%_RESET%   PLEASE ENTER CURRENT PASSWORD   %_bbGreen%%_fbgreen%/
echo /////////////////////////////////////%_RESET%
echo.
set "psCommand=powershell -Command "$pword = read-host 'Password' -AsSecureString ; ^
     $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
           [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set C_PASSWORD=%%p

echo %C_PASSWORD%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p C_PASSWORD=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

set /p password_file=<\users%h_NAME%.dll
if %C_PASSWORD%==%password_file% goto :CORRECT_PASSWORD

:WRONG_PASSWORD
cls
color 4
title Incorrect password
echo %_bRed%%_fRed%//////////////////////
echo /%_bBlack%   WRONG PASSWORD   %_bRed%/
echo //////////////////////%_RESET%
echo 
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) entered the current password wrong when trying to change it >>logs.log
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT

:CORRECT_PASSWORD
cls
title Enter new password
echo %_bBGreen%%_fbgreen%//////////////////////////
echo /%_RESET%   ENTER NEW PASSWORD   %_bbGreen%%_fbgreen%/
echo //////////////////////////%_RESET%
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
    echo %_bRed%%_fRed%/////////////////////////////
    echo /%_bBlack%   PASSWORDS DON'T MATCH   %_bRed%/
    echo /////////////////////////////%_RESET%
    echo 
    timeout /t 3 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)

echo %NEW_PASSWORD%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_NEW_PASSWORD=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp


del %h_NAME%.dll
echo %h_NEW_PASSWORD%>users\%h_NAME%.dll
echo %h_ADMIN%>>users\%h_NAME%.dll

cls
title password changed successfully
color 2
echo %_fbgreen%%_bBGreen%////////////////////////
echo /%_RESET%   PASSWORD CHANGED   %_bbGreen%%_fbgreen%/
echo ////////////////////////%_RESET%
echo.
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Changed there password >>logs.log
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Command to delete your account
:deleteaccount
cls
color 4
title /deleteaccount
echo %_bRed%%_fRed%///////////////////////////////
echo /%_bBlack%    ARE YOU SURE YOU WANT    %_bRed%/
echo /%_bBlack%   TO DELETE YOUR ACCOUNT?   %_bRed%/
echo ///////////////////////////////%_RESET%
echo 
choice
if %ERRORLEVEL%==2 (
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
    if %CHATASED%==1 goto :CHATASLOOP
)
cls
echo %_bbGreen%%_fbgreen%//////////////////////////////////////////
echo /%_RESET%   PLEASE ENTER YOUR CURRENT PASSWORD   %_bbGreen%%_fbgreen%/
echo //////////////////////////////////////////%_RESET%
echo.
set "psCommand=powershell -Command "$pword = read-host 'Password' -AsSecureString ; ^
     $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pword); ^
           [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set DELCURRENTPASSWORD=%%p

set /p DELPASSWORD=<users\%h_NAME%.dll

echo %DELCURRENTPASSWORD%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p DELCURRENTPASSWORD=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

if NOT %DELCURRENTPASSWORD%==%DELPASSWORD% (
    cls
    title Incorrect password
    echo %_bRed%%_fRed%/////////////////////
    echo /%_bBlack%   WRONG PASWORD   %_bRed%/
    echo /////////////////////%_RESET%
    echo 
    timeout /t 3 /nobreak >nul
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
    if %CHATASED%==1 goto :CHATASLOOP
)
cls
title deleting account...
echo %_bRed%%_fRed%////////////////////////
echo /%_bBlack%   DELETING ACCOUNT   %_bRed%/
echo ////////////////////////%_RESET%
echo.
timeout /t 3 /nobreak >nul
del /q users\%h_NAME%.dll
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) deleted there account>>logs.log
echo %_fGreen%Account delete.
echo %_fblue%It was nice having you around :)%_RESET%
title Account deleted
timeout /t 2 /nobreak >nul
echo. >%TEMP%\CHATLOGOUT.tmp
exit



@REM Shows banned users
:BANLIST
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo %_fBGreen%Message sent%_RESET%
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title banlist
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Checked the ban list>>logs.log
:BANLISTLOOP
cls
echo %_fGreen%Currently banned accounts:%_RESET%
echo.
type users\bans.log
echo.
echo.
echo %_fgreen%Press any key to go back
echo Press %_bBWhite%%_fBlack%"r"%_RESET%%_fgreen% to refresh
choice /c r1234567890qwetyuiopasdfghjklzxcvbnm >nul
if %ERRORLEVEL%==1 goto :BANLISTLOOP
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Debug mode (Probablt broken so i disabled it)
@REM :debug
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> %TEXT% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo %_fBGreen%Message sent%_RESET%
    timeout /t 2 /nobreak >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
cd ..
if EXIST debug.bat (
    color 4
    echo %_bbGreen%%_fbgreen%//////////////////////
    echo /%_RESET%   DEBUG MODE OFF   %_bbGreen%%_fbgreen%/
    echo //////////////////////%_RESET%
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
echo %_bbGreen%%_fbgreen%/////////////////////
echo /%_RESET%   DEBUG MODE ON   %_bbGreen%%_fbgreen%/
echo /////////////////////%_RESET%
echo.
echo @echo off>>debug.bat
echo echo. ^>debug>>debug.bat
echo call Chat%FILETYPE%>>debug.bat
cd info
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) turned ON debug mode>>logs.log
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Very secret easter egg
:easter_ehg
start dino.bat
exit



@REM Promote an account to admin
:PROMOTE
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> %TEXT%% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo %_fBGreen%Message sent%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)

echo %PROMOTE%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_PROMOTE=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

if NOT EXIST "users\%h_PROMOTE%.dll" (

    cls
    color 4
    title %PROMOTE%.dll NOT FOUND
    echo %_bRed%%_fRed%//////////////////////////////
    echo /%_bBlack%   ACCOUNT DOES NOT EXIST   %_bRed%/
    echo //////////////////////////////%_RESET%
    echo 
    echo %DATE% %TIME% ^>^> *%NAME% ^(%USERNAME%^) tried to promote an account that does not exist >> logs.log
    TIMEOUT /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)

FOR /F "skip=1" %%c IN (users\%h_PROMOTE%.dll) DO set f_ADMINCH=%%c

set h_ADMINCH=8Fas3%h_PROMOTE%onRG621

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

if "%ADMINCH%"=="TRUE" (
    cls
    color 4
    title %PROMOTE% ALREADY IS AN ADMIN
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   USER ALREADY IS AN ADMIN   %_bRed%/
    echo ////////////////////////////////%_RESET%
    echo 
    echo %DATE% %TIME% ^>^> *%NAME% ^(%USERNAME%^) Tried to promote %PROMOTE% but they where alreday an admin >>logs.log
    TIMEOUT /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title /promote %PROMOTE%
echo %_bRed%%_fRed%/////////////////////////////
echo /%_bBlack%   ARE YOU SURE YOU WANT   %_bRed%/
echo /%_bBlack%   TO PROMOTE THIS USER?   %_bRed%/
echo /////////////////////////////%_RESET%
echo.
echo If you promote %_fbgreen%%PROMOTE%%_RESET% they will have %_fRed%full%_RESET% access to %_fRed%all admin commands%_RESET%.
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set /p new_admin_password=<users\%h_PROMOTE%.dll
echo %new_admin_password%>users\%h_PROMOTE%.dll.tmp
move /Y "users\%h_PROMOTE%.dll.tmp" "users\%h_PROMOTE%.dll">nul

set NEW_ADMIN_STATUS=8Fas3%h_PROMOTE%onRG621
echo %NEW_ADMIN_STATUS%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_NEW_ADMIN_STATUS=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

echo %h_NEW_ADMIN_STATUS%>>users\%h_PROMOTE%.dll
color 2
cls
echo %_bbGreen%%_fbgreen%////////////////////////
echo /%_RESET%   ACCOUNT PROMOTED   %_bbGreen%%_fbgreen%/
echo ////////////////////////%_RESET%
echo.
echo The account "%_fbgreen%%PROMOTE:-= %%_RESET%" has been granted %_fRed%admin%_RESET% permissions!
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Promoted %PROMOTE%>>logs.log
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT



@REM Removes an accounts admin permissions 
:DEMOTE
if "%ADMIN%" NEQ "TRUE" (
    echo ^<%_fbgreen%%NAME%%_RESET%^> %TEXT%% >> chat.log
    cls
    echo ^>^>%TEXT%
    echo %_fBGreen%Message sent%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
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
    echo %_bRed%%_fRed%////////////////////////////////
    echo /%_bBlack%   YOU MUST ENTER SOMETHING   %_bRed%/
    echo ////////////////////////////////%_RESET%
    echo 
    timeout /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)

echo %DEMOTE%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_DEMOTE=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

if NOT EXIST "users\%h_DEMOTE%.dll" (

    cls
    color 4
    title %DEMOTE%.dll NOT FOUND
    echo %_bRed%%_fRed%//////////////////////////////
    echo /%_bBlack%   ACCOUNT DOES NOT EXIST   %_bRed%/
    echo //////////////////////////////%_RESET%
    echo 
    echo %DATE% %TIME% ^>^> *%NAME% ^(%USERNAME%^) tried to demote an account that does not exist >> logs.log
    TIMEOUT /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)

FOR /F "skip=1" %%c IN (users\%h_DEMOTE%.dll) DO set f_ADMINCH=%%c

set h_ADMINCH=8Fas3%h_DEMOTE%onRG621

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

if "%ADMINCH%"=="FALSE" (
    cls
    color 4
    title %DEMOTE% ALREADY IS NOT AN ADMIN
    echo %_bRed%%_fRed%////////////////////////////
    echo /%_bBlack%   USER IS NOT AN ADMIN   %_bRed%/
    echo ////////////////////////////%_RESET%
    echo 
    echo %DATE% %TIME% ^>^> *%NAME% ^(%USERNAME%^) Tried to demote %DEMOTE% but they where not an admin >>logs.log
    TIMEOUT /t 3 >nul
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
cls
title /demote %DEMOTE%
echo %_bRed%%_fRed%/////////////////////////////
echo /%_bBlack%   ARE YOU SURE YOU WANT   %_bRed%/
echo /%_bBlack%   TO DEMOTE THIS USER?    %_bRed%/
echo /////////////////////////////%_RESET%
echo.
echo If you demote %_fbgreen%%DEMOTE%%_RESET% they loose access to %_fRed%all admin commands%_RESET%.
choice
if %ERRORLEVEL%==2 (
    if %CHATASED%==1 goto :CHATASLOOP
    if %NICKED%==1 goto :NCHAT
    goto :CHAT
)
set /p new_admin_password=<users\%h_DEMOTE%.dll
echo %new_admin_password%>users\%h_DEMOTE%.dll.tmp
move /Y "users\%h_DEMOTE%.dll.tmp" "users\%h_DEMOTE%.dll">nul

set NEW_ADMIN_STATUS=73Hs%h_DEMOTE%gGG83A
echo %NEW_ADMIN_STATUS%>%temp%\hashinput.tmp
CertUtil -hashfile %temp%\hashinput.tmp sha256 | findstr /v "hash">%temp%\hashoutput.tmp
set /p h_NEW_ADMIN_STATUS=<%temp%\hashoutput.tmp

del %temp%\hashinput.tmp
del %temp%\hashoutput.tmp

echo %h_NEW_ADMIN_STATUS%>>users\%h_DEMOTE%.dll
color 4
cls
echo %_bbGreen%%_fbgreen%////////////////////////
echo /%_RESET%   ACCOUNT DEMOTED    %_bbGreen%%_fbgreen%/
echo ////////////////////////%_RESET%
echo.
echo The account "%_fbgreen%%DEMOTE%%_RESET%" has had their admin permissions %_fRed%revoked%_RESET%!
echo %DATE% %TIME% ^>^> *%NAME% (%USERNAME%) Demoted %DEMOTE%>>logs.log
timeout /t 3 /nobreak >nul
if %CHATASED%==1 goto :CHATASLOOP
if %NICKED%==1 goto :NCHAT
goto :CHAT