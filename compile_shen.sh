#!/bin/sh

cat <<EOF
        &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
             Install ShengBTE
               @gbenabdellah
                 version 2.0
        &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&       

EOF
sleep 2

echo
echo

# chmod +x  compile_spg.sh 
# chmod +x  compile_third.sh

#./compile_spg.sh  
 
#./compile_third.sh    

mkdir -p bin

shengbte="`ls  Sheng*.bz2`"
echo "$shengbte"
if [ -f "$shengbte" ]; then
    tar -xf $shengbte
    cd ShengBTE/
    cd Src/

    
cat <<EOF > arch.make
export FFLAGS=-traceback -debug -O2 -static_intel -qopenmp
export LDFLAGS=-L../../bin/spglib/lib -lsymspg
export MPIFC=mpiifort
MKL=\${MKLROOT}/lib/intel64/libmkl_lapack95_lp64.a -Wl,--start-group \\
    \${MKLROOT}/lib/intel64/libmkl_intel_lp64.a \\
    \${MKLROOT}/lib/intel64/libmkl_sequential.a \\
    \${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group -lpthread -lm
export LAPACK=\$(MKL)
export LIBS=\$(LAPACK)
EOF
    echo "  Compile ShengBTE "
        make
        
        cd ..
        if [ -f "ShengBTE" ] ; then
            cp ShengBTE ../bin
            mv ShengBTE ../bin/shengbte
            cd ..
        else
            echo ""
            echo "ShengBTE not compiled correctely ...."
            echo ""
            exit
        fi
        

    cd bin/
    path="`pwd`"

    tst=`grep SHENGBTE  ~/.bashrc`

    if [ "$tst" ] ; then
    sed -i '/SHENGBTE/,/ENDSHENGBTE/d'  ~/.bashrc
    fi
    echo ""
    echo "add link to .bashrc "
    echo ""
cat <<EOF>> ~/.bashrc

##SHENGBTE ####
#LD_LIBRARY_PATH=\$LD_LIBRARY_PATH:$path/spglib/lib/
export LD_LIBRARY_PATH
export PATH=$path:\$PATH
##ENDSHENGBTE####
EOF

    echo " .... done ............"
    echo ""
else
echo " ShengBTE-v*****.tar.bz2  not found "

fi

exit
