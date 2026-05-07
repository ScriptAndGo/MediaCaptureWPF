@echo off
setlocal enableextensions

set VERSION=2.0.0-beta

REM Clean
call .\clean.cmd

REM Build
msbuild -restore -v:m .\pack.sln /maxcpucount /target:build /nologo /p:Configuration=Release /p:Platform=x86
if %ERRORLEVEL% NEQ 0 goto eof
msbuild -restore -v:m .\pack.sln /maxcpucount /target:build /nologo /p:Configuration=Release /p:Platform=x64
if %ERRORLEVEL% NEQ 0 goto eof

REM Pack
nuget.exe pack MMaitre.MediaCaptureWPF.nuspec -OutputDirectory Packages -Prop NuGetVersion=%VERSION% -NoPackageAnalysis
if %ERRORLEVEL% NEQ 0 goto eof
nuget.exe pack MMaitre.MediaCaptureWPF.Symbols.nuspec -OutputDirectory Symbols -Prop NuGetVersion=%VERSION% -NoPackageAnalysis
if %ERRORLEVEL% NEQ 0 goto eof