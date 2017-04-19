@Echo OFF
REM	****************************
REM	This batch file is used to perpare the data (audio recordings) for language model training
REM     Author: Shaoqing Yu(Shawn)  14/01/2016
REM	****************************


echo step: 1  recordings2prompts starts
REM	****************************
REM	There are 6 steps in preparation process, this is the 1 step "recordings2prompts"
REM	****************************

REM	****************************
REM     if the folder "Dictionaries" does not exist, Create one
REM	****************************
IF NOT EXIST "%cd%\..\Dictionaries\" (mkdir "%cd%\..\Dictionaries\")

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
chcp 28605>NUL

REM	****************************
REM	list all the recordings 
REM	****************************
Perl "%Perls%Recordings2Prompts.pl" "%recordingFolder%" .wav "%Dictionaries%\"

echo step: 1  recordings2prompts ends








echo step: 2  recordings2mfcs starts
REM	****************************
REM	There are 6 steps in preparation process, this is the 2 step "recordings2mfcs"
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

echo step: 2  recordings2mfcs ends








echo step: 3  prompts2wordlist starts
REM	****************************
REM	There are 6 steps in preparation process, this is the 3 step "prompts2wordlist"
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
REM	Generate word list file by Prompts.pmpt
REM	****************************
Perl "%Perls%prompts2wlist.pl" "%Dictionaries%Prompts.pmpt" "%Dictionaries%WordList.wlist"

echo step: 3  prompts2wordlist ends








echo step: 4  wordlist2dictionary starts
REM	****************************
REM	There are 6 steps in preparation process, this is the 4 step "wordlist2dictionary"
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
REM	Generate a monophone list file with sp named "monophones1"
REM	****************************
"%Tools%HDMan" -m -w "%Dictionaries%WordList.wlist" -g "%Params%global.ded" -n "%Dictionaries%monophones1" -i -l HDMan.Log "%Dictionaries%dictionary" "%Dictionaries%lexicon.txt"
REM perl -pe "s/$/sp/ unless /^$|sil $|sp $/;" "%Dictionaries%lexicon.txt" > "%Dictionaries%dictionary"

REM	****************************
REM	Generate a monophone list file without sp named "monophones0"
REM	****************************
(type "%Dictionaries%monophones1" | findstr /v sp)>"%Dictionaries%monophones0"

echo step: 4  wordlist2dictionary ends








echo step: 5  prompts2Wordmlf starts
REM	****************************
REM	There are 6 steps in preparation process, this is the 5 step "prompts2Wordmlf"
REM	****************************

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
REM	Generate word level MLF file by Prompts.pmpt
REM	****************************
Perl "%Perls%prompts2mlf.pl" "%MLFs%WordMLF.mlf" "%Dictionaries%Prompts.pmpt"

echo step: 5  prompts2Wordmlf ends









echo step: 6  wordmlf2phonemlf starts
REM	****************************
REM	There are 6 steps in preparation process, this is the 6 step "wordmlf2phonemlf"
REM	****************************

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
REM	assign character set to utf-8
REM	****************************
REM     chcp 65001 >NUL

REM	****************************
REM     create the phone level MLF file named PhoneMLF0.mlf PhoneMLF1.mlf
REM	****************************

"%Tools%HLEd" -l * -d "%Dictionaries%dictionary" -i "%MLFs%PhoneMLF0.mlf" "%Params%mkphones0.led" "%MLFs%WordMLF.mlf"
"%Tools%HLEd" -l * -d "%Dictionaries%dictionary" -i "%MLFs%PhoneMLF1.mlf" "%Params%mkphones1.led" "%MLFs%WordMLF.mlf"

echo step: 6  wordmlf2phonemlf ends

pause & exit
