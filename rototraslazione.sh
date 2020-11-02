#!/bin/bash/

#script che rototralsa la proteina 3 volte in modo da avere LOP_i nella posizione di LOP1
vmd="/Applications/VMD\ 1.9.3.app/Contents/MacOs/"
file_top="initial.pdb"
trajectory="full_traj_PL_0_216_every_200ps.trr"
rm traj_lop1.dcd traj_lop2.dcd traj_lop3.dcd traj_lop4.dcd

/Applications/VMD\ 1.9.3.app/Contents/MacOs/startup.command -dispdev none -f $file_top $trajectory > LOG_ROTOTRAS <<EOF
	animate delete beg 0 end 0 skip 0 top 
	set p_LP [atomselect top "protein or (resname LOP and segname HETA)"]

	animate write dcd "traj_lop1.dcd" waitfor all  sel \${p_LP} top
    
	set all [atomselect top "all"]
	set target [atomselect top "index 668 to 4576"]
	set Plop2 [atomselect top "index 9820 to 13728"]
	set num_steps [molinfo top get numframes]

	for {set frame 0} {\$frame < \$num_steps} {incr frame} {
		\$Plop2 frame \$frame
		\$all frame \$frame
                        # compute the transformation
 	       set trans_mat [measure fit \$Plop2 \$target ]
                        # do the alignment
 	       \${all} move \${trans_mat}
	}
	set p_LP [atomselect top "protein or (resname LOP and segname HETB)"]

	animate write dcd "traj_lop2.dcd" waitfor all sel \${p_LP} top
	quit
EOF

/Applications/VMD\ 1.9.3.app/Contents/MacOs/startup.command -dispdev none -f $file_top $trajectory >> LOG_ROTOTRAS <<EOF
	animate delete beg 0 end 0 skip 0 top 
	set all [atomselect top "all"]
	set target [atomselect top "index 668 to 4576"]
	set Plop3 [atomselect top "index 5244 to 9152"]
	set num_steps [molinfo top get numframes]
	for {set frame 0} {\$frame < \$num_steps} {incr frame} {			
		\$Plop3 frame \$frame
		\$all frame \$frame
                        # compute the transformation
        set trans_mat [measure fit \$Plop3 \$target ]
                        # do the alignment
        \${all} move \${trans_mat}
	}
	set p_LP [atomselect top "protein or (resname LOP and segname HETC) "]
	animate write dcd "traj_lop3.dcd" waitfor all sel \${p_LP} top
	quit
EOF


/Applications/VMD\ 1.9.3.app/Contents/MacOs/startup.command -dispdev none -f $file_top $trajectory >> LOG_ROTOTRAS <<EOF
	animate delete beg 0 end 0 skip 0 top 
	set all [atomselect top "all"]
	set target [atomselect top "index 668 to 4576"]
	set Plop4 [atomselect top "index 14396 to 18304"]
	set num_steps [molinfo top get numframes]
	for {set frame 0} {\$frame < \$num_steps} {incr frame} {
		\$Plop4 frame \$frame
		\$all frame \$frame
                        # compute the transformation
        set trans_mat [measure fit \$Plop4 \$target ]
                        # do the alignment
        \${all} move \${trans_mat}
	}
	set p_LP [atomselect top "protein or (resname LOP and segname HETD)"]
	animate write dcd "traj_lop4.dcd" waitfor all sel \${p_LP} top
	quit
EOF