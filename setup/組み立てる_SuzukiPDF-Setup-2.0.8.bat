@echo off
chcp 65001 > nul
cd /d "%~dp0"
echo SuzukiPDF-Setup-2.0.8.exe を組み立てています...
for %%F in (SuzukiPDF-Setup-2.0.8.exe.part01 SuzukiPDF-Setup-2.0.8.exe.part02 SuzukiPDF-Setup-2.0.8.exe.part03 SuzukiPDF-Setup-2.0.8.exe.part04 SuzukiPDF-Setup-2.0.8.exe.part05 SuzukiPDF-Setup-2.0.8.exe.part06 SuzukiPDF-Setup-2.0.8.exe.part07 SuzukiPDF-Setup-2.0.8.exe.part08 SuzukiPDF-Setup-2.0.8.exe.part09 SuzukiPDF-Setup-2.0.8.exe.part10) do if not exist "%%F" (
  echo 部品 %%F が見つかりません。すべての部品をこのバッチと同じフォルダに置いてください。
  pause
  exit /b 1
)
copy /b SuzukiPDF-Setup-2.0.8.exe.part01+SuzukiPDF-Setup-2.0.8.exe.part02+SuzukiPDF-Setup-2.0.8.exe.part03+SuzukiPDF-Setup-2.0.8.exe.part04+SuzukiPDF-Setup-2.0.8.exe.part05+SuzukiPDF-Setup-2.0.8.exe.part06+SuzukiPDF-Setup-2.0.8.exe.part07+SuzukiPDF-Setup-2.0.8.exe.part08+SuzukiPDF-Setup-2.0.8.exe.part09+SuzukiPDF-Setup-2.0.8.exe.part10 "SuzukiPDF-Setup-2.0.8.exe" > nul
if errorlevel 1 (
  echo 組み立てに失敗しました。
  pause
  exit /b 1
)
for /f "tokens=* delims=" %%H in ('certutil -hashfile "SuzukiPDF-Setup-2.0.8.exe" SHA256 ^| findstr /v ":"') do (
  set "HASH=%%H"
  goto :check
)
:check
set "HASH=%HASH: =%"
if /i "%HASH%"=="CAFC671CB1B80C2ABCFD81E918E64D7303487C66E8F872871A1AA8DB0DB179FC" (
  echo できました: SuzukiPDF-Setup-2.0.8.exe（中身の確認も OK）
  echo 部品のファイル（.part01 など）は削除してかまいません。
) else (
  echo 組み立てたファイルの中身が元と違います。部品をもう一度受け取り直してください。
  del "SuzukiPDF-Setup-2.0.8.exe"
  pause
  exit /b 1
)
pause
