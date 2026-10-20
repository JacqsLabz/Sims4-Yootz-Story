@echo off
setlocal enabledelayedexpansion

:: Configuration
set "OutputFile=z-Merged-Plan.md"

:: Ensure we are working in the script's directory
cd /d "%~dp0"

:: Delete existing output file to start fresh
if exist "%OutputFile%" del "%OutputFile%"

echo Merging .md and .canvas files from all subfolders into %OutputFile%...

:: Loop through .md and .canvas files recursively
:: /s = subfolders, /b = bare format (full path), /a:-d = files only (no directories)
for /f "delims=" %%f in ('dir /s /b /a:-d *.md *.canvas 2^>nul') do (
    rem Skip the batch file itself and the output file
    rem Using %%~nxf extracts just the filename for comparison
    if not "%%~nxf"=="%~nx0" if not "%%~nxf"=="%OutputFile%" (
        echo Processing: %%f
        
        rem Write the header: 2 breaks, # filename, 2 breaks
        echo. >> "%OutputFile%"
        echo. >> "%OutputFile%"
        echo # %%f >> "%OutputFile%"
        echo. >> "%OutputFile%"
        echo. >> "%OutputFile%"
        
        rem Append the file content using the full path
        type "%%f" >> "%OutputFile%"
    )
)

echo.
echo Merge complete! Output saved to %OutputFile%
pause   