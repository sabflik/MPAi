@Echo OFF
REM	****************************
REM	This batch file is used to train the language model
REM     Author: Shaoqing Yu(Shawn)  01/02/2016
REM	****************************

REM	****************************
REM     if the folder "HMMs" does not exist, Create one
REM	****************************

IF NOT EXIST "%cd%\..\HMMs\" (mkdir "%cd%\..\HMMs\")

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
Perl "%Perls%Script2Train.pl" "%MFCs%script.scp" "%HMMs%train.scp"

REM	****************************
REM	assign character set to utf-8
REM	****************************
REM     chcp 65001 >NUL

REM	****************************
REM	make "%HMMs%"%HMMs%hmm0""
REM	****************************
REM if not exist "%HMMs%"%HMMs%hmm0"" (mkdir "%HMMs%hmm0")
REM "%Tools%HCompV" -C "%Params%HMMs.conf" -f 0.01 -m -S "%HMMs%train.scp" -M "%HMMs%hmm0" prot

REM	****************************
REM	make "%HMMs%hmm1"-3 based on "%HMMs%hmm0"
REM	****************************
if not exist "%HMMs%hmm1" (mkdir "%HMMs%hmm1")
"%Tools%HERest" -C "%Params%HMMs.conf" -I "%MLFs%PhoneMLF0.mlf" -t 250.0 150.0 1000.0 -S "%HMMs%train.scp" -H "%HMMs%hmm0/macros" -H "%HMMs%hmm0/hmmdefs" -M "%HMMs%hmm1" "%Dictionaries%monophones0"

if not exist "%HMMs%hmm2" (mkdir "%HMMs%hmm2")
"%Tools%HERest" -C "%Params%HMMs.conf" -I "%MLFs%PhoneMLF0.mlf" -t 250.0 150.0 1000.0 -S "%HMMs%train.scp" -H "%HMMs%hmm1/macros" -H "%HMMs%hmm1/hmmdefs" -M "%HMMs%hmm2" "%Dictionaries%monophones0"

if not exist "%HMMs%hmm3" (mkdir "%HMMs%hmm3")
"%Tools%HERest" -C "%Params%HMMs.conf" -I "%MLFs%PhoneMLF0.mlf" -t 250.0 150.0 1000.0 -S "%HMMs%train.scp" -H "%HMMs%hmm2/macros" -H "%HMMs%hmm2/hmmdefs" -M "%HMMs%hmm3" "%Dictionaries%monophones0"

REM	****************************
REM	make "%HMMs%hmm5"-7 based on "%Params%sil.hed"
REM	****************************
if not exist "%HMMs%hmm5" (mkdir "%HMMs%hmm5")
"%Tools%HHEd" -H "%HMMs%hmm4/macros" -H "%HMMs%hmm4/hmmdefs" -M "%HMMs%hmm5" "%Params%sil.hed" "%Dictionaries%monophones1"

if not exist "%HMMs%hmm6" (mkdir "%HMMs%hmm6")
"%Tools%HERest" -C "%Params%HMMs.conf" -I "%MLFs%PhoneMLF1.mlf" -t 250.0 150.0 1000.0 -S "%HMMs%train.scp" -H "%HMMs%hmm5/macros" -H "%HMMs%hmm5/hmmdefs" -M "%HMMs%hmm6" "%Dictionaries%monophones1"

if not exist "%HMMs%hmm7" (mkdir "%HMMs%hmm7")
"%Tools%HERest" -C "%Params%HMMs.conf" -I "%MLFs%PhoneMLF1.mlf" -t 250.0 150.0 1000.0 -S "%HMMs%train.scp" -H "%HMMs%hmm6/macros" -H "%HMMs%hmm6/hmmdefs" -M "%HMMs%hmm7" "%Dictionaries%monophones1"

REM	****************************
REM	Re-aligning the training data 
REM	****************************
"%Tools%HVite" -l * -o SWT -b SENT-END -C "%Params%HMMs.conf" -a -H "%HMMs%hmm7/macros" -H "%HMMs%hmm7/hmmdefs" -i "%MLFs%AlignedMLF.mlf" -m -t 250.0 150.0 1000.0 -y lab -I "%MLFs%WordMLF.mlf" -S "%HMMs%train.scp" "%Dictionaries%dictionary" "%Dictionaries%monophones1"> HVite.log

REM	****************************
REM	make "%HMMs%hmm8"-9 based on a %MLFs%AlignedMLF.mlf
REM	****************************
if not exist "%HMMs%hmm8" (mkdir "%HMMs%hmm8")
"%Tools%HERest" -C "%Params%HMMs.conf" -I "%MLFs%AlignedMLF.mlf" -t 250.0 150.0 1000.0 -S "%HMMs%train.scp" -H "%HMMs%hmm7/macros" -H "%HMMs%hmm7/hmmdefs" -M "%HMMs%hmm8" "%Dictionaries%monophones1"

if not exist "%HMMs%hmm9" (mkdir "%HMMs%hmm9")
"%Tools%HERest" -C "%Params%HMMs.conf" -I "%MLFs%AlignedMLF.mlf" -t 250.0 150.0 1000.0 -S "%HMMs%train.scp" -H "%HMMs%hmm8/macros" -H "%HMMs%hmm8/hmmdefs" -M "%HMMs%hmm9" "%Dictionaries%monophones1"

REM	****************************
REM	make "%HMMs%hmm10"
REM	****************************
"%Tools%HLEd" -n "%Dictionaries%triphones1" -l * -i "%MLFs%TriphoneMLF.mlf" "%Params%mktri.led" "%MLFs%AlignedMLF.mlf"

Perl "%Perls%maketrihed.pl" "%Dictionaries%monophones1" "%Dictionaries%triphones1" "%Params%\"

if not exist "%HMMs%hmm10" (mkdir "%HMMs%hmm10")
"%Tools%HHEd" -H "%HMMs%hmm9/macros" -H "%HMMs%hmm9/hmmdefs" -M "%HMMs%hmm10" "%Params%mktri.hed" "%Dictionaries%monophones1"

REM	****************************
REM	make "%HMMs%hmm11"-12, as well as statistic file stats
REM	****************************
if not exist "%HMMs%hmm11" (mkdir "%HMMs%hmm11")
"%Tools%HERest" -C "%Params%HMMs.conf" -I "%MLFS%triphoneMLF.mlf" -t 250.0 150.0 1000.0 -S "%HMMs%train.scp" -H "%HMMs%hmm10/macros" -H "%HMMs%hmm10/hmmdefs" -M "%HMMs%hmm11" "%Dictionaries%triphones1" 

if not exist "%HMMs%hmm12" (mkdir "%HMMs%hmm12")
"%Tools%HERest" -C "%Params%HMMs.conf" -I "%MLFS%triphoneMLF.mlf" -t 250.0 150.0 1000.0 -s "%HMMs%stats" -S "%HMMs%train.scp" -H "%HMMs%hmm11/macros" -H "%HMMs%hmm11/hmmdefs" -M "%HMMs%hmm12" "%Dictionaries%triphones1"

"%Tools%HDMan" -b sp -n "%Dictionaries%FullPhoneList" -g "%Params%mktriphones.ded" -l HDMan.Log "%Dictionaries%tri-dictionary" "%Dictionaries%lexicon.txt"

type NUL > "%Dictionaries%FullPhoneListAdded"
type "%Dictionaries%monophones0" >> "%Dictionaries%FullPhoneListAdded"
type "%Dictionaries%FullPhoneList" >> "%Dictionaries%FullPhoneListAdded"
Perl "%Perls%MergeFullPhoneList.pl" "%Dictionaries%FullPhoneListAdded" "%Dictionaries%FullPhoneListMerged"
Perl "%Perls%EditTree.pl" "%Params%tree.hed" "%HMMs%stats" "%Dictionaries%FullPhoneListMerged" "%Dictionaries%tiedlist" "%HMMs%trees" 

REM	****************************
REM	make "%HMMs%hmm13"-15
REM	****************************
if not exist "%HMMs%hmm13" (mkdir "%HMMs%hmm13")
"%Tools%HHEd" -H "%HMMs%hmm12/macros" -H "%HMMs%hmm12/hmmdefs" -M "%HMMs%hmm13" "%Params%tree.hed" "%Dictionaries%triphones1"

if not exist "%HMMs%hmm14" (mkdir "%HMMs%hmm14")
"%Tools%HERest" -C "%Params%HMMs.conf" -I "%MLFS%triphoneMLF.mlf"  -t 250.0 150.0 3000.0 -S "%HMMs%train.scp" -H "%HMMs%hmm13/macros" -H "%HMMs%hmm13/hmmdefs" -M "%HMMs%hmm14" "%Dictionaries%tiedlist"

if not exist "%HMMs%hmm15" (mkdir "%HMMs%hmm15")
"%Tools%HERest" -C "%Params%HMMs.conf" -I "%MLFS%triphoneMLF.mlf"  -t 250.0 150.0 3000.0 -S "%HMMs%train.scp" -H "%HMMs%hmm14/macros" -H "%HMMs%hmm14/hmmdefs" -M "%HMMs%hmm15" "%Dictionaries%tiedlist"

pause&exit