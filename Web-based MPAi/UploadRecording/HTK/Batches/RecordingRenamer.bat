@Echo OFF
REM	****************************
REM	This batch file is used to rename the recording file in given folder
REM     Author: Shaoqing Yu(Shawn)  14/01/2016
REM	****************************

REM	****************************
REM	set up the environment varibles 
REM	****************************
pushd "%cd%"
cd ..
for /f %%i in ('dir "%cd%" /a:d /b /d') do (
  IF NOT DEFINED %%i (
	set %%i=%cd%\%%i\
  )
)
popd

set /p recordingFolder=Please enter the recording folder address:

REM	****************************
REM	assign character set to utf-8
REM	****************************
REM chcp 65001 >NUL

REM	****************************
REM	list all the recordings 
REM	****************************
Perl "%Perls%RecordingRenamer.pl" "%recordingFolder%" wav

pause & exit
