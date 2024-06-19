
https://www.shengbte.org/

ShengBTE is a software package for solving the Boltzmann Transport Equation for phonons. Its main purpose is to compute the lattice contribution to the thermal conductivity of bulk crystalline solids, but nanowires can also be treated under a hypothesis of diffusive boundary conditions. In addition to the thermal conductivity itself, ShengBTE computes and outputs plenty of additional information about the system under study. See the Features page for a more complete description. Our method is fully parameter-
free, and within its limits of applicability it can yield excellent agreement with experiment. In contrast with parametric methods, it can also be used to predict the lattice thermal conductivity of uncharacterized or even as-yet-unsynthesized materials.

download the compressed file from:
  
  https://www.shengbte.org/downloads

Create a directory;  copy the present tcsh script (install.sh) with the downloaded files "ShengBTE-v????.tar.bz2" and "thirdorder-v???.tar.bz2" in this directory; then run:
      
        chmod +x install.sh
        ./install.sh
      
make sure that the spglib is installed;
  it can be found in: ~/.local/lib/python??/site-packages/spglib
