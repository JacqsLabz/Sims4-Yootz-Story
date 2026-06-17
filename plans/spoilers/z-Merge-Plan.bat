@echo off
setlocal enabledelayedexpansion

:: Configuration
set "OutputFile=z-Merged-Plan.md"

:: Ensure we are working in the script's directory
cd /d "%~dp0"

:: Delete existing output file to start fresh
if exist "%OutputFile%" del "%OutputFile%"

echo Merging .md and .canvas files into %OutputFile%...

:: Loop through .md files
for /f "delims=" %%f in ('dir /b /a:-d *.md *.canvas 2^>nul') do (
    :: Skip the batch file itself and the output file
    if not "%%f"=="%~nx0" if not "%%f"=="%OutputFile%" (
        echo Processing: %%f
        
        :: Write the header: 2 breaks, # filename, 2 breaks
        echo. >> "%OutputFile%"
        echo. >> "%OutputFile%"
        echo # %%f >> "%OutputFile%"
        echo. >> "%OutputFile%"
        echo. >> "%OutputFile%"
        
        :: Append the file content
        type "%%f" >> "%OutputFile%"
    )
)

echo.
echo Merge complete! Output saved to %OutputFile%
pause   