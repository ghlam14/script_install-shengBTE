#!/bin/sh

mkdir -p bin

thirdorder=`ls -d thirdorder*.bz2`
if [ -f  "$thirdorder" ]; then
    tar -xf $thirdorder
    if [ -d "bin/spglib/lib" ] ; then
        cd thirdorder/
                echo
                echo
                echo "  build  thirdorder using python3 "

                #cython3 thirdorder_core.pyx
                sed -i 's/spglib\/spglib.h/spglib.h/' thirdorder_core.c
                python3 setup.py build --build-lib=. --build-platlib=.   
                
                thirdorder_core=`ls thirdorder_core.*so`
                if [ ! -f "$thirdorder_core" ]; then
                    echo ""
                    echo "thirdorder_core not compiled correctly" >>../ERROR.log
                    echo ""
                    exit
                fi
            
                echo " copy scripts and lib to root dir. ../bin "
                echo

                for file in   thirdorder_common.py    thirdorder_espresso.py   thirdorder_castep.py   thirdorder_vasp.py $thirdorder_core
                    do
                        cp $file  ../bin/ 
                        chmod +x  ../bin/$file
                    done
                 
                 cd ../bin/
                    ln -s -f $thirdorder_core thirdorder_core 

                echo " .... done ............"
                echo
                
                cd ..
    else
        echo ""
        echo " .... Ooops ............"
        echo "         spglib not installed in bin/spglib "
        echo "         spglib not installed in bin/spglib " >>../ERROR.log
        echo "     "
        echo "    https://spglib.github.io/spglib/install.html"
        echo ""
        exit
    fi
else
    echo " thirdorder-v*****.tar.bz2  not found "

fi

exit
