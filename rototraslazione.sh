#!/bin/bash/

#script che rototralsa la proteina 3 volte in modo da avere LOP_i nella posizione di LOP1
vmd="/Applications/VMD\ 1.9.3.app/Contents/MacOs/"
file_top="pdb.pdb"
trajectory="tj_lop1.trr"


/Applications/VMD\ 1.9.3.app/Contents/MacOs/startup.command -dispdev none -f $file_top tj_lop1.trr > LOG_ROTOTRAS <<EOF
	animate delete beg 0 end 0 skip 0 top
	animate write trr "traj_lop1.trr" waitfor all 
	quit
EOF

/Applications/VMD\ 1.9.3.app/Contents/MacOs/startup.command -dispdev none -f $file_top tj_lop2.trr >> LOG_ROTOTRAS <<EOF
	animate delete beg 0 end 0 skip 0 top
	
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
	animate write trr "traj_lop2.trr" waitfor all 
	quit
EOF

/Applications/VMD\ 1.9.3.app/Contents/MacOs/startup.command -dispdev none -f $file_top tj_lop3.trr >> LOG_ROTOTRAS <<EOF
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

	animate write trr "traj_lop3.trr" waitfor all 
	quit
EOF

/Applications/VMD\ 1.9.3.app/Contents/MacOs/startup.command -dispdev none -f $file_top tj_lop4.trr >> LOG_ROTOTRAS <<EOF
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

	animate write trr "traj_lop4.trr" waitfor all 
	quit
EOF
