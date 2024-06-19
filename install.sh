#!/bin/tcsh -f

cat <<EOF
        &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
             Install ShengBTE
               @gbenabdellah
                 version 3.0
        &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&       

EOF
#sleep 2
set path_log="`pwd`"
echo "">> $path_log/log.log

set spglib_path=`python3 -m pip show spglib | grep Location | cut -f2 -d: | sed -e 's/ //g'`

#sleep 2
if (! -e $spglib_path/spglib ) then
    echo ""
    echo "Please install spglib:   pip3 install spglib  " 
    echo "Please install spglib:   pip3 install spglib  ">> $path_log/log.log
    echo ""
    exit(0)
endif

set shengbte=`ls -d Sheng*.bz2`
if (-e $shengbte ) then
    tar -xf $shengbte
    cd ShengBTE/
    cd Src/

    
cat <<EOF > arch.make
export FFLAGS=-traceback -debug -O2 -static_intel -qopenmp
export LDFLAGS=-L$spglib_path/spglib/lib -lsymspg
export MPIFC=mpiifort
MKL=\${MKLROOT}/lib/intel64/libmkl_lapack95_lp64.a -Wl,--start-group \\
    \${MKLROOT}/lib/intel64/libmkl_intel_lp64.a \\
    \${MKLROOT}/lib/intel64/libmkl_sequential.a \\
    \${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group -lpthread -lm
export LAPACK=\$(MKL)
export LIBS=\$(LAPACK)
EOF

    make
    cd ..
    if (-e ShengBTE ) then
        mkdir -p bin
        cp ShengBTE bin/ShengBTE
        cp ShengBTE bin/shengbte
        cd bin/
        set tst=`grep SHENGBTE  ~/.bashrc`
        if ( "$#tst" != "0"  ) then
        sed -i '/SHENGBTE/,/ENDSHENGBTE/d'  ~/.bashrc
        endif
        echo ""
        echo "add link to .bashrc "
        echo ""
cat <<EOF>> ~/.bashrc

##SHENGBTE ####
export PATH=`pwd`:\$PATH
##ENDSHENGBTE####
EOF
    cd ..
    else
    echo " ShengBTE  not compiled cprrectely "
    echo " ShengBTE not compiled cprrectely  ">> $path_log/log.log
    
    endif
    cd ..
else
    echo " ShengBTE-v*****.tar.bz2  not found "
    echo " ShengBTE-v*****.tar.bz2  not found ">> $path_log/log.log
endif

set thirdorder=`ls -d thirdorder*.bz2`
if (-e $thirdorder ) then
    tar -xf $thirdorder
    cd thirdorder/
    set include="$spglib_path/spglib/include"
    set lib="$spglib_path/spglib/lib"

    # Use sed to replace the patterns in setup.py
    sed -i 's|INCLUDE_DIRS *= *\[\]|INCLUDE_DIRS = \["'${include}'"\]    \#|g' setup.py
    sed -i 's|LIBRARY_DIRS *= *\[\]|LIBRARY_DIRS = \["'${lib}'"\]    \#|g' setup.py
    sed -i 's/spglib\/spglib.h/spglib.h/' thirdorder_core.c
    python3 setup.py build --build-lib=. --build-platlib=.
    
	set thirdorder_core=`ls thirdorder_core.*so`
        if (! -e $thirdorder_core)  then
        	
            echo "" 
            echo "thirdorder_core note compiled correctly"  
            echo "thirdorder_core note compiled correctly" >>$path_log/log.log 
            echo ""
            cd ..
            exit
        else
        ln -s -f $thirdorder_core thirdorder_core
         set dtst=`grep SHENGBTE  ~/.bashrc`
        if ( "$#dtst" != "0"  ) then
        sed -i '/THIRDOEDER/,/THIRDOEDER/d'  ~/.bashrc
        endif
        echo ""
        echo "add link to .bashrc "
        echo ""
cat <<EOF>> ~/.bashrc

##THIRDOEDER ####
export PATH=`pwd`:\$PATH
##ENDTHIRDOEDER####
EOF
        
        
        
        endif
    cd ..

exit





