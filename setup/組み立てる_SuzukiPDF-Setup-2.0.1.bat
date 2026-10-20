@echo off
chcp 65001 > nul
cd /d "%~dp0"
echo SuzukiPDF-Setup-2.0.1.exe を組み立てています...
for %%F in (SuzukiPDF-Setup-2.0.1.exe.part01 SuzukiPDF-Setup-2.0.1.exe.part02 SuzukiPDF-Setup-2.0.1.exe.part03 SuzukiPDF-Setup-2.0.1.exe.part04 SuzukiPDF-Setup-2.0.1.exe.part05 SuzukiPDF-Setup-2.0.1.exe.part06 SuzukiPDF-Setup-2.0.1.exe.part07 SuzukiPDF-Setup-2.0.1.exe.part08 SuzukiPDF-Setup-2.0.1.exe.part09 SuzukiPDF-Setup-2.0.1.exe.part10) do if not exist "%%F" (
  echo 部品 %%F が見つかりません。すべての部品をこのバッチと同じフォルダに置いてください。
  pause
  exit /b 1
)
copy /b SuzukiPDF-Setup-2.0.1.exe.part01+SuzukiPDF-Setup-2.0.1.exe.part02+SuzukiPDF-Setup-2.0.1.exe.part03+SuzukiPDF-Setup-2.0.1.exe.part04+SuzukiPDF-Setup-2.0.1.exe.part05+SuzukiPDF-Setup-2.0.1.exe.part06+SuzukiPDF-Setup-2.0.1.exe.part07+SuzukiPDF-Setup-2.0.1.exe.part08+SuzukiPDF-Setup-2.0.1.exe.part09+SuzukiPDF-Setup-2.0.1.exe.part10 "SuzukiPDF-Setup-2.0.1.exe" > nul
if errorlevel 1 (
  echo 組み立てに失敗しました。
  pause
  exit /b 1
)
for /f "tokens=* delims=" %%H in ('certutil -hashfile "SuzukiPDF-Setup-2.0.1.exe" SHA256 ^| findstr /v ":"') do (
  set "HASH=%%H"
  goto :check
)
:check
set "HASH=%HASH: =%"
if /i "%HASH%"=="1408FC21AAB74288695179B912BE1AF179079C448BA0A0E3E87B45727CB3B303" (
  echo できました: SuzukiPDF-Setup-2.0.1.exe（中身の確認も OK）
  echo 部品のファイル（.part01 など）は削除してかまいません。
) else (
  echo 組み立てたファイルの中身が元と違います。部品をもう一度受け取り直してください。
  del "SuzukiPDF-Setup-2.0.1.exe"
  pause
  exit /b 1
)
pause
