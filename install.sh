#!/bin/sh

cat <<EOF
        &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
             Install ShengBTE
               @gbenabdellah
                 version 3.0
        &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&       

EOF
sleep 2

echo
echo

 chmod +x  compile_spg.sh 
 chmod +x  compile_third.sh
 chmod +x  compile_shen.sh

./compile_spg.sh  
 
./compile_third.sh    

./compile_shen.sh  
