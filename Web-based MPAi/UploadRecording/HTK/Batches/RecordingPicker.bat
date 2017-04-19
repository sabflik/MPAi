@echo off 

set inputFolder=D:\Projects\MPAid\Deployment\MPAi\sounds\
set outputFolder=D:\Projects\MPAid\MPAid\bin\x86\Debug\Audio\

for /f %%n in ('forfiles /p %inputFolder% /s /m *.wav /c "cmd /c echo @fname"') do (
  for /f "tokens=1,2 delims=_" %%a in ("%%~n") do (
    for %%i in (03 04 05 06 07 09 10 12 15 17 18 22 23 24 25 26 27 28 30) do (
      if %%b==%%i  xcopy /s "%inputFolder%%%n.wav" "%outputFolder%%%n.wav*"
    )
  )
)

pause&exit