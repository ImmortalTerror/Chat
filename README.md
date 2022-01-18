# Chat V4.0

**Welcome!** This is a chat program made in Windows Batchfile.
It works by being in a local network (like a school or something) and all the users having access to the one file.

I would like to thank one of my best friends, A KFC RatChicken for suggesting features and finding ways to implement them.
He may have not written a single line of code here, but many features wouldn't be possible without him.

## Q&A

### How do I use this?
Go to the releases page and download the latest installer. When installing, choose a directory that all the uses will have access too (like a shared drive or something) and
install the program there.

### What do I do once It's installed?
First thing you will want to do is run `chat.exe`. This will bring you to the first time setup where you can setup an account with admin permissions.
Once you have made the account, log into that chat and type /help to see a list of commands.

### Can someone get my accounts password?
It is practically impossible for someone to get your password as they are hashed with sha256. Only way they could get it is with brute force.

### I have found a bug or an issue, what do I do?
If you find any sort of bug, please open an issue on the github page. I will fix it as fast as I can.

### Where can i suggest a feature?
Anywhere really. But either on Github or Discord would be the best.

## Commands
**USER COMMANDS**
- /help - Brings up the help menu
- /info - Gives you some info on the program
- /logout - Go's back the login page
- /nick (NCIKNAME) - Set a nickname
- /changepassword - Menu to change your password
- /deleteaccount - Deletes your account
- /back - Removes your nickname if you have one

**ADMIN COMMANDS:**
- /logs - This will show you the every command a user uses, every time someone logs in or our and more.
- /chatfile - This will open the file where the chat is stored ^(chat.log^).
- /chatas (NAME) - Chat with a set username.
- /ad (TEXT) - Advertise something in chat.
- /clearchat - This will clear the chat.
- /clearlogs - This will clear the logs.
- /slogout - Same as /logout but it does not announce it in chat.
- /ban - Bans user account.
- /unban - Unbans user account.
- /pcban - Bans person with matching PC username.
- /unpcban - unbans person with matching PC username.
- /bans - Shows a list off all banned accounts
- /terminate - Deletes an account.
- /promote (NAME) - Gives the user admin permissions
- /demote (NAME) - revokes the users admin permissions

## Screenshots

# Join my Discord server!
All changes are posted there.
[Discord](https://discord.gg/pqAFVCKZhz)
