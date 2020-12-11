#!/bin/bash
#SBATCH --exclusive
#SBATCH --account=def-lseoud #desclaux
#SBATCH --job-name=HRpose 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=5
##SBATCH --partition=multigpu #je sais pas comment ca marche sur CC
#SBATCH --gres=gpu:p100l:4	 # resource
#SBATCH --mem=128G
#SBATCH --time=2:00:00
#SBATCH --output=../SLP-outputs/HRpose.%j.out
#SBATCH --error=../SLP-outputs/HRpose.%j.err
echo python main.py 
source ~/.bashrc
source activate slp_env #activate conda environment

# Define temporary variables
DS_FD=/home/desclaux/projects/def-lseoud/desclaux/
SLP_SET=simLab #on va tester sur simLab
OUTPUTDIR=../SLP-outputs
MOD_SRC=RGB
CONF=config/HRpose.conf
PRETRAINED=SLP_RGB_u12_HRpose_exp
#cov_li=cover2
#EXP_TEST=cover2


#Pretrained model info
# pretrained_model="SLP_IR_u12_HRpose_exp"
# IFS="_" arr=($pretrained_model)
# TRAINSET=${arr[0]}
# Execute code

COV_LI=('uncover' 'cover1' 'cover2')

for cov_li in "${COV_LI[@]}"
do 
	#EXP_TEST="${MOD_SRC}_${cov_li}"
	#--mod_src ${MOD_SRC[*]} \
	EXP_TEST="${cov_li}"
	python main.py \
		--ds_fd $DS_FD \
       		--SLP_set $SLP_SET \
		--mod_src $MOD_SRC \
		--if_test \
		--if_pretrained $PRETRAINED \
		--output_dir $OUTPUTDIR \
		--cov_li $cov_li \
		--suffix_exp_test $EXP_TEST
done
