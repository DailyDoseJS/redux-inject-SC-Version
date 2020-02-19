@echo off

:: BatchAdminRechte
:-------------------------------------
REM  --> Check for adminrights
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error is set, we have no admin rights.
if '%errorlevel%' NEQ '0' (
    echo Fordere Adminrechte an...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------    

Start C:\PATH\TO\altv.exe 
REM --> Path to your AltV.exe

timeout /t 20 
REM --> Time the social club launcher needs for the patching process (different from Computer to Computer)

xcopy /y /E "C:\PATH\TO\REDUX" "C:\PATH\TO\Grand Theft Auto V" 
REM --> First path: folder where the Redux files are located, second path: where he should copy it.
exit
