@echo on

if not defined OutDir echo error: OutDir is not defined >&2 && exit /b 1
if not defined ProjectName echo error: ProjectName is not defined >&2 && exit /b 1
if not defined PlatformTarget echo error: PlatformTarget is not defined >&2 && exit /b 1
if not defined BuildVersion echo warning: BuildVersion is not defined >&2

setlocal enabledelayedexpansion

set ZipName=%ProjectName%_
if defined BuildVersion set ZipName=!ZipName!v%BuildVersion%_
set ZipName=!ZipName!%PlatformTarget%.zip

cd /D %OutDir% 2>&1 > NUL
if errorlevel 1 (
  echo error: Failed change directory to "%OutDir%" >&2
  endlocal
  exit /b 1
)

if exist ZipName del /Q !ZipName! 2>&1 > NUL
if errorlevel 1 (
  echo error: Failed to remove existing file "!ZipName!" >&2
  endlocal
  exit /b 1
)

7z a "!ZipName!" "*.exe" && ^
7z l "!ZipName!" && ^
7z h -scrcSHA256 "*.exe" "!ZipName!"

if errorlevel 1 (
  echo error: Failed to create archieve "!ZipName!" >&2
  endlocal
  exit /b 1
)

endlocal
