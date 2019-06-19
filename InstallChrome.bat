@echo off

rem NOTE: use "rem" to add comments.

echo Installing the latest version of Chrome.

rem Tests for whether the system is 32-bit or 64-bit.
echo Testing for bitness.
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT echo This is a 32-bit operating system.
if %OS%==64BIT echo This is a 64-bit operating system.

echo Changing directories to a temporary location for cleanup.
cd "%~dp0"
echo Downloading Chrome, this may take a while...
if %OS%==32BIT powershell -Command "(New-Object Net.WebClient).DownloadFile('https://dl.google.com/tag/s/appguid={8A69D345-D564-463C-AFF1-A69D9E530F96}&iid={ED613D4D-C32B-7048-EA8E-A21DF33935C1}&lang=en&browser=3&usagestats=0&appname=Google%20Chrome&needsadmin=true&ap=stable-arch_x86-statsdef_0&brand=GCEA/dl/chrome/install/googlechromestandaloneenterprise.msi', '%~dp0googlechrome.msi')"
if %OS%==64BIT powershell -Command "(New-Object Net.WebClient).DownloadFile('https://dl.google.com/tag/s/appguid={8A69D345-D564-463C-AFF1-A69D9E530F96}&iid={ED613D4D-C32B-7048-EA8E-A21DF33935C1}&lang=en&browser=3&usagestats=0&appname=Google%20Chrome&needsadmin=true&ap=x64-stable-statsdef_0&brand=GCEA/dl/chrome/install/googlechromestandaloneenterprise64.msi', '%~dp0googlechrome64.msi')"
echo Done!

rem Download the config file.
echo Downloading the master preferences file...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/zachies/Windows10ChromeDownloader/master/master_preferences', '%~dp0master_preferences')"
echo Done!

rem Run the Chrome installer.
echo Installing Chrome...
if %OS%==32BIT msiexec /norestart /i /qn "%~dp0googlechrome.msi"
if %OS%==64BIT msiexec /norestart /i /qn "%~dp0googlechrome64.msi"
echo Done!

echo Installing preferences.
if exist "c:\Program Files\Google\Chrome\Application\" copy /y "%~dp0master_preferences" "C:\Program Files\Google\Chrome\Application\"
echo Completed 32-bit Chrome check.
if exist "c:\Program Files (x86)\Google\Chrome\Application\" copy /y "%~dp0master_preferences" "C:\Program Files (x86)\Google\Chrome\Application\"
echo Completed 64-bit Chrome check.
echo Setting Chrome to never automatically check for updates in the registry...
reg add HKLM\Software\Policies\Google\Update /f /v AutoUpdateCheckPeriodMinutes /d 0
echo Done! If access was denied, be sure to run this script as administrator.

echo Deleting installation files...
if exist "%~dp0googlechrome.msi" del "%~dp0googlechrome.msi"
if exist "%~dp0googlechrome64.msi" del "%~dp0googlechrome64.msi"
if exist "%~dp0master_preferences" del "%~dp0master_preferences"
echo Done!
PAUSE
