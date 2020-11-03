
#3/11/2020

correzioni alla traiettoria
1. eliminiamo i LP1

 echo "21"| gmx trjconv -f full_traj_PL_0_216.trr -o FTPL0216_200psNOLP.trr -n clustering_2/index.ndx -s step5_charmm2namd.pdb -skip 10


-> questa traietoria, per cui ogni frame e' stampato ongi 10*20ps, ha solo LOP e PROTEIN e non ha i LP1

2. Uso il file ndx in cui ho LOP1/2/3/4 e no LP1  creato in precedenza cosi: 
cat ../step5_charmm2namd.pdb | grep -v "LP1" > noLP1.pdb
# 
# 
# # qui ho rinominato le LOP in 4 gruppi diversi
module load vmd; 
vmd -dispdev none noLP1.pdb << EOF 
[atomselect 0 "resname LOP and segname HETB"] set resid 2
[atomselect 0 "resname LOP and segname HETC"] set resid 3
[atomselect 0 "resname LOP and segname HETD"] set resid 4
animate write pdb noLP_renamedLOP.pdb  
quit
EOF
#gmx make_ndx -f noLP1_and_renamedLOP.pdb -o noLP1.ndx

echo "22" | gmx trjconv -f FTPL0216_200psNOLP.trr -n clustering_2/noLP1.ndx -s clustering_2/noLP_renamedLOP.pdb -o tj_lop1.trr
echo "23" | gmx trjconv -f FTPL0216_200psNOLP.trr -n clustering_2/noLP1.ndx -s clustering_2/noLP_renamedLOP.pdb -o tj_lop2.trr
echo "24" |gmx trjconv -f FTPL0216_200psNOLP.trr -n clustering_2/noLP1.ndx -s clustering_2/noLP_renamedLOP.pdb -o tj_lop3.trr
echo "25" |gmx trjconv -f FTPL0216_200psNOLP.trr -n clustering_2/noLP1.ndx -s clustering_2/noLP_renamedLOP.pdb -o tj_lop4.trr


-> queste traietorie, per cui ogni frame e' stampato ongi 10*20ps, ha solo LOPX e PROTEIN e non ha i LP1

gmx trjconv -f clustering_2/noLP_renamedLOP.pdb -n clustering_2/noLP1.ndx -s clustering_2/noLP_renamedLOP.pdb -o pdb.pdb

3. ROTOTRASLAZIONE


$.4
 gmx trjcat -f traj_lop1.trr traj_lop2.trr traj_lop3.trr traj_lop4.trr -settime -o catoflops.trr

#1/11/2020 - step per maneggiare la traiettoria

1.  SUL CLUSTER, 
usare lo script full_traj.sh, che apre tutti i dcd ne fa unwrap/centering/wrap stampando fuori una traiettoria solo per PROTEINA E LOPS (circa 4h) OUTPUT: FORMATO DI GROMACS

# STEP 1
#echo "#!/bin/bash
##PBS -l nodes=1:ppn=28
##PBS -l walltime=12:00:00
##PBS -N bk_cluster
##PBS -e out_1.err
##PBS -o out_1
#cd ${PBS_O_WORKDIR}/;
#bash full_traj.sh"  > job_fulT
#
#qsub job_fulT

SE SBAGLI OUTPUT: crea file iniziale di pdb e usalo per cambiare formato con VMD

cat step5_charmm2namd.pdb | grep -v "TIP" | grep -v "MEM" | grep -v "\*\*\*\*"  >only_protein_and_lop.pdb

vmd -dispdev none -f only_protein_and_lop.pdb full_traj_PL_0_216.dcd <<EOF
animate delete beg 0 end 0 skip 0 top
animate write trr "full_traj_PL_0_216.trr" waitfor all
EOF

2. Usare gmx trjconv per salvare il sistema con meno frame

echo "21" | gmx trjconv -f full_traj_PL_0_216.trr -s only_protein_and_lop.pdb -n clustering_2/index.ndx -o full_traj_PL_0_216_every_200ps.trr  -skip 10

#3. Usare VMD per creare 3 ulteriori traiettorie, ciascuna a partire dalla prima, rototraslando in ciascuna di essa un LOP, in modo da avere i ligandi LOP tutti nella stessa ppocket. 
#4. unire queste 4 traiettorie
# 5. clustering
#
#3. Usare VMD per creare 3 ulteriori traiettorie, ciascuna a partire dalla prima, rototraslando in ciascuna di essa un LOP, in modo da avere i ligandi LOP tutti nella stessa ppocket. 
#4. unire queste 4 traiettorie
# 5. clustering
#
# STEP 1
#echo "#!/bin/bash
##PBS -l nodes=1:ppn=28
##PBS -l walltime=12:00:00
##PBS -N bk_cluster
##PBS -e out_1.err
##PBS -o out_1
#cd ${PBS_O_WORKDIR}/;
#bash full_traj.sh"  > job_fulT
#
#qsub job_fulT
#STEP 2
module load gromacs;
gmx trjconv