#!/bin/bash
export LANG='en_US.UTF-8'
#export LANG='fi_FI.UTF-8'
echo "COMPILING $1 $2 $3 $4"
#rm /home/arisi/projects/mygit/arisi/ctex/bin/sol_STM32L_mg11.srec
if [ $1 = "build" ]; then
   rant -f Rantfile.rb CPU=STM32L APP=$2 HW=mg11 clean
fi
rant -f Rantfile.rb --err-commands  -v CPU=STM32L APP=$2 HW=mg11 2>&1 |tee build/rant.err
#echo "COMPILED" >>log
#cat build/*.err >build/$2_STM32L_mg11/compile.log
cat build/*.err
#curl 'http://20.20.20.21:8087/demo.json?act=flash'
