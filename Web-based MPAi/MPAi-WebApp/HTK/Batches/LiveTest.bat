@Echo OFF
REM	****************************
REM	This batch file is used to do a live recognition test by htk
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

pause
"%Tools%HVite" -H "%HMMs%hmm15/macros" -H "%HMMs%hmm15/hmmdefs"  -C "%Params%test.conf" -w "%Grammars%WordNet.wdnet"   -e -i output -g -p 0.0 -s 5.0 "%Dictionaries%dictionary" "%Dictionaries%tiedList"

pause & exit
