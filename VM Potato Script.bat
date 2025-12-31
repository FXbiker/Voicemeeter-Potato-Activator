@echo off
setlocal enabledelayedexpansion

REM === CONFIG ===
set INTERVAL=32
set DATEFILE=data.txt

REM === READ LAST DATE ===
if not exist "%DATEFILE%" (
    echo %date:~10,4%-%date:~4,2%-%date:~7,2% > "%DATEFILE%"
    echo First run. Exiting.
    exit /b
)

set /p LASTDATE=<"%DATEFILE%"

REM === PARSE LAST DATE (YYYY-MM-DD) ===
for /f "tokens=1-3 delims=-" %%A in ("%LASTDATE%") do (
    set LY=%%A
    set LM=%%B
    set LD=%%C
)

REM === GET TODAY'S DATE (YYYY-MM-DD) ===
for /f "tokens=1-3 delims=/" %%A in ("%date%") do (
    REM This depends on locale; adjust if needed
)

REM Use WMIC to get ISO date (works on Win10/11)
for /f %%A in ('wmic os get LocalDateTime ^| find "."') do set NOW=%%A
set TY=!NOW:~0,4!
set TM=!NOW:~4,2!
set TD=!NOW:~6,2!

REM === CONVERT DATES TO DAYS SINCE EPOCH ===
call :ToDays !LY! !LM! !LD! LAST_DAYS
call :ToDays !TY! !TM! !TD! TODAY_DAYS

set /a DIFF = TODAY_DAYS - LAST_DAYS
set /a INTERVALS = DIFF / INTERVAL

echo Last date: %LASTDATE%
echo Days passed: %DIFF%
echo Intervals: %INTERVALS%

if %INTERVALS% LSS 1 (
    echo Not time yet. Exiting.
    exit /b
)

REM === READ CURRENT REGISTRY VALUE ===
for /f "tokens=3" %%A in ('reg query "HKCU\VB-Audio\VoiceMeeter" /v code 2^>nul') do set VAL=%%A

if "%VAL%"=="" (
    echo Registry value not found.
    exit /b
)

REM Convert hex to decimal
set /a DEC=0x%VAL%

REM === APPLY INCREMENT ===
set /a ADD = INTERVAL * INTERVALS
set /a NEWVAL = DEC + ADD

echo Updating registry by %ADD%
echo New value: %NEWVAL%

reg add "HKCU\VB-Audio\VoiceMeeter" /v code /t REG_DWORD /d %NEWVAL% /f >nul

REM === UPDATE LAST DATE ===
set /a NEW_LAST = LAST_DAYS + (INTERVAL * INTERVALS)
call :FromDays !NEW_LAST! NEWY NEWM NEWD

echo %NEWY%-%NEWM%-%NEWD% > "%DATEFILE%"

echo Done.
exit /b


REM === FUNCTIONS ===

:ToDays
REM Convert YYYY MM DD to days since epoch (1970-01-01)
setlocal
set Y=%1
set M=%2
set D=%3

REM Shift months so March = month 1
set /a A = (14 - M) / 12
set /a Y2 = Y - A
set /a M2 = M + 12*A - 2

set /a DAYS = (D + (153*M2+2)/5 + 365*Y2 + Y2/4 - Y2/100 + Y2/400 - 719469)

endlocal & set %4=%DAYS%
exit /b

:FromDays
REM Convert days since epoch back to YYYY MM DD
setlocal
set DAYS=%1

set /a Z = DAYS + 719469
set /a A = Z
set /a B = (4*A + 3) / 146097
set /a C = A - (146097*B)/4
set /a D = (4*C + 3) / 1461
set /a E = C - (1461*D)/4
set /a M = (5*E + 2) / 153

set /a DAY = E - (153*M + 2)/5 + 1
set /a MONTH = M + 3 - 12*(M/10)
set /a YEAR = 100*B + D - 4800 + (M/10)

endlocal & (
    set %2=%YEAR%
    set %3=%MONTH%
    set %4=%DAY%
)
exit /b
