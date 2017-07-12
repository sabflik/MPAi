@Echo OFF
REM	****************************
REM	This batch file is used to evaluate the model we have built by YM(youngmale) YF(youngfemale) OM(oldmale) OF(oldfemale) audio recordings respectively
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

echo step: 1  YM YF OM OF recordings feeding starts
REM	****************************
REM	There are 1 steps in preparation process, this is the 1 step "YM YF OM OF recordings feeding"
REM	****************************
set Cur=D:\experiment\YM\

for %%i in (YM YF OM OF) do (    
    IF NOT EXIST "%Cur%%%i" (mkdir "%Cur%%%i")

    ModelEvaluater

    xcopy /s /y "%Evaluations%result.txt" "%Cur%%%i\result.txt*"
    xcopy /s /y "%MLFs%RecMLF.mlf" "%Cur%%%i\RecMLF.mlf*"
)

echo step: 1  YM YF OM OF recordings feeding ends


pause & exit