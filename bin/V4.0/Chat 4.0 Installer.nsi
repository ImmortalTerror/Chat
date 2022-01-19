!include "MUI2.nsh"

Name "Chat V4.0"
OutFile "Chat V4.0 Installer.exe"
Unicode True
InstallDir "$EXEDIR\Chat"
RequestExecutionLevel user

!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_ICON "..\Icons\chat icon V4.0.ico"
!define MUI_WELCOMEPAGE_TITLE "Chat V4.0 Setup"
!define MUI_WELCOMEPAGE_TEXT "This is the instillation menu for Chat V4.0$\n$\nMade by ImmortalTerror$\nGithub: https://github.com/immortalterror/chat$\nDiscord: https://discord.gg/pqAFVCKZhz$\n$\n$\nPress $\"next$\" to continue"
!define MUI_DIRECTORYPAGE_TEXT_TOP "Please select a shared directory to install Chat V4.0.$\nFor the chat program to work with multiple users, ALL USERS MUST HAVE ACCESS TO THE DIRECTORY.$\nOnce installed, please run $\"Chat.exe$\""
!define MUI_FINISHPAGE_RUN "$INSTDIR\chat.exe"
!define MUI_FINISHPAGE_LINK "Star on Github!"
!define MUI_FINISHPAGE_LINK_LOCATION "https://github.com/immortalterror/chat"
!define MUI_FINISHPAGE_TEXT "Chat V4.0 has successfully been installed.$\nRun $\"Chat.exe$\" to make your account!"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "LICENSE"
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "English"


Section ""

  SetOutPath "$INSTDIR"
  file "Chat.exe"
  file "LICENSE"
  file "README.md"
  SetOutPath "$INSTDIR\info"
  file "info\type.exe"
  file "info\dino.bat"
  file "info\cmdmenusel.exe"
  SetOutPath "$INSTDIR\info\users"
  file "info\users\bans.log"
  SetOutPath "$INSTDIR"

SectionEnd