rem Place the TestNav and AZMerit msi installers in the same directory as the script.
rem You may need to change the file names of the installers as they are updated.
rem "%~dp0" refers to the directory where the script is currently executing from.

cd "%~dp0"
msiexec /passive /package "%~dp0testnav-1.8.2.msi"
msiexec /passive /package "%~dp0azmerit-10.4.msi"
