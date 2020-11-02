#!/bin/bash/

rm trj_of_4LOP.dcd
echo "fine"

cat initial.pdb | grep -v "      HETD"| grep -v "      HETC"| grep -v "      HETB" >prova.pdb

/Applications/VMD\ 1.9.3.app/Contents/MacOs/startup.command -dispdev none -f prova.pdb traj_lop*dcd > LOG_ROTOTRAS_2 <<EOF
	animate delete beg 0 end 0 skip 0 top 
	animate write dcd "trj_of_4LOP.dcd" waitfor all
	quit
EOF
