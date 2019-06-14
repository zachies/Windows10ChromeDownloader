rem NOTE: use "rem" to add comments.

echo Installing the latest version of Chrome.

rem Tests for whether the system is 32-bit or 64-bit.
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
if %OS%==32BIT echo This is a 32bit operating system
if %OS%==64BIT echo This is a 64bit operating system

rem Change directories to a temporary location for cleanup.
cd "c:\tmp"
if%OS%==32BIT curl.exe -L -o googlechromestandaloneenterprise.msi "https://dl.google.com/tag/s/appguid={8A69D345-D564-463C-AFF1-A69D9E530F96}&iid={ED613D4D-C32B-7048-EA8E-A21DF33935C1}&lang=en&browser=3&usagestats=0&appname=Google%20Chrome&needsadmin=true&ap=stable-arch_x86-statsdef_0&brand=GCEA/dl/chrome/install/googlechromestandaloneenterprise.msi"
if%OS%==64BIT curl.exe -L -o googlechromestandaloneenterprise64.msi "https://dl.google.com/tag/s/appguid={8A69D345-D564-463C-AFF1-A69D9E530F96}&iid={ED613D4D-C32B-7048-EA8E-A21DF33935C1}&lang=en&browser=3&usagestats=0&appname=Google%20Chrome&needsadmin=true&ap=x64-stable-statsdef_0&brand=GCEA/dl/chrome/install/googlechromestandaloneenterprise64.msi"

rem Run the Chrome installer.
if%OS%==32BIT msiexec /qn /norestart /i "%~dp0googlechromestandaloneenterprise.msi"
if%OS%==64BIT msiexec /qn /norestart /i "%~dp0googlechromestandaloneenterprise64.msi"
if exist "c:\Program Files\Google\Chrome\Application\" copy /y "%~dp0master_preferences" "C:\Program Files\Google\Chrome\Application\"
if exist "c:\Program Files (x86)\Google\Chrome\Application\" copy /y "%~dp0master_preferences" "C:\Program Files (x86)\Google\Chrome\"
rem reg add HKLM\Software\Policies\Google\Update /f /v AutoUpdateCheckPeriodMinutes /d 0
