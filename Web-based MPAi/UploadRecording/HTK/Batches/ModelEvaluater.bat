@Echo OFF
REM	****************************
REM	This batch file is used to evaluate the language model
REM     Author: Shaoqing Yu(Shawn)  14/01/2016
REM	****************************


echo step: 1  recordings2mfcs starts
REM	****************************
REM	There are 3 steps in preparation process, this is the 1 step "recordings2mfcs"
REM	****************************

REM	****************************
REM     if the folder "MFCs" does not exist, Create one
REM	****************************
IF NOT EXIST "%cd%\..\MFCs\" (mkdir "%cd%\..\MFCs\")

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
REM     create train code script (Script.scp) with a filter suffix "wav" in %MFCs%
REM	****************************
Perl "%Perls%ScriptGenerater.pl" "%recordingFolder%" wav "%MFCs%\"

REM	****************************
REM	assign character set to utf-8
REM	****************************
REM     chcp 65001 >NUL

REM	****************************
REM     Generate MFC files by train code script
REM	****************************
"%Tools%HCopy" -T 1 -C "%Params%MFCs.conf" -S "%MFCs%script.scp"

echo step: 1  recordings2mfcs ends









echo step: 2  grammar2wordnet starts
REM	****************************
REM	There are 3 steps in preparation process, this is the 2 step "grammar2wordnet"
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

REM	****************************
REM     create word network file WordNet.wdnet by WordNets/HParse
REM	****************************
"%Tools%HParse" "%Grammars%grammar.gram" "%Grammars%WordNet.wdnet"
echo step: 2  grammar2wordnet ends






echo step: 3  recordingstest starts
REM	****************************
REM	There are 3 steps in preparation process, this is the 3 step "recordingstest"
REM	****************************

REM	****************************
REM     if the folder "Evaluations" does not exist, Create one
REM	****************************
IF NOT EXIST "%cd%\..\Evaluations\" (mkdir "%cd%\..\Evaluations\")

REM	****************************
REM     if the folder "MLFs" does not exist, Create one
REM	****************************
IF NOT EXIST "%cd%\..\MLFs\" (mkdir "%cd%\..\MLFs\")

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

REM	****************************
REM     Generate evaluation script in %Evaluations% from %MFCs%
REM	****************************
Perl "%Perls%Script2Train.pl" "%MFCs%script.scp" "%Evaluations%evaluation.scp"

REM	****************************
REM	Recognize the recordings on evaluation.scp and then output the transcript "RecMLF.mlf"
REM	****************************
"%Tools%HVite" -o ST -H -C "%Params%HMMs.conf" "%HMMs%hmm15/macros" -H "%HMMs%hmm15/hmmdefs" -S "%Evaluations%evaluation.scp" -l * -T 4 -i "%MLFs%RecMLF.mlf" -w "%Grammars%WordNet.wdnet" -p 0.0 -s 5.0 "%Dictionaries%dictionary" "%Dictionaries%tiedlist"> HVite.log

("%Tools%HResults" -I "%MLFs%WordMLF.mlf" "%Dictionaries%tiedlist" "%MLFs%RecMLF.mlf")> "%Evaluations%result.txt"

echo step: 3  recordingstest ends
exit