@echo off
setlocal enabledelayedexpansion
set ROOT=%~dp0%\..
cd /d %ROOT%

if not exist build-profile.backup.json5 (
  copy /Y build-profile.json5 build-profile.backup.json5 >nul
)

for %%p in (phone pad tablet 2in1) do (
  if exist build-profile.%%p.json5 (
    copy /Y build-profile.%%p.json5 build-profile.json5 >nul
    echo Switched to profile: %%p
    echo Attempting to run hvigor for %%p (if hvigor is in PATH)...
    hvigor || echo hvigor not found or returned error. Please run hvigor or use DevEco Studio.
  ) else (
    echo Profile file build-profile.%%p.json5 not found, skipping %%p
  )
)

if exist build-profile.backup.json5 (
  copy /Y build-profile.backup.json5 build-profile.json5 >nul
  echo Restored original build-profile.json5
)
