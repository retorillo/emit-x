@echo off
setlocal ENABLEDELAYEDEXPANSION

rem Requirements for Development Computer
rem - Visual Studio 2017 or 2015 (Tested on Community Edition)
rem   - Windows Universal CRT SDK
rem   - Windows SDK 8.1

SET _TARGET_PLATFORM=8.1

set VS2017x64=HKLM\SOFTWARE\WOW6432Node\Microsoft\VisualStudio\SxS\VS7
set VS2017x86=HKLM\SOFTWARE\Microsoft\VisualStudio\SxS\VS7
set VS2015=HKLM\SOFTWARE\Microsoft\MSBuild\ToolsVersions\14.0

reg query %VS2017x64% /v 15.0 2> NUL > NUL
if "%ERRORLEVEL%"=="0" set VS2017=%VS2017x64% && goto use_vs2017
reg query %VS2017x86% /v 15.0 2> NUL > NUL
if "%ERRORLEVEL%"=="0" set VS2017=%VS2017x86% && goto use_vs2017
goto use_vs2015

:use_vs2017
  set _PLATFORM_TOOLSET=v141
  for /f "usebackq skip=2 tokens=2,*" %%a in (`reg query "!VS2017!" /v 15.0`) do (
    set MSBUILD=%%bMSBuild\15.0\Bin\msbuild
    goto build
  )
  goto error

:use_vs2015
  echo Visual Studio 2017 is not found, Trying to use Visual Studio 2015...
  set _PLATFORM_TOOLSET=v140
  for /f "usebackq skip=2 tokens=2,*" %%a in (`reg query "!VS2015!" /v MSBuildToolsPath`) do (
    set MSBUILD=%%bmsbuild
    goto build
  )
  goto error

:error
  echo Cannot detect MSBuild on this machine. >&2
  exit /b 1

:build
  echo MSBuild: !MSBUILD!
  "!MSBUILD!" build.xml /p:Configuration=%1 /p:Platform=x86 /t:%2
  "!MSBUILD!" build.xml /p:Configuration=%1 /p:Platform=x64 /t:%2
:end
  endlocal
