#!/bin/bash
#SBATCH --exclusive
#SBATCH --account=def-lseoud #desclaux
#SBATCH --job-name=HRpose 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=5
##SBATCH --partition=multigpu #je sais pas comment ca marche sur CC
#SBATCH --gres=gpu:p100l:4	 # resource
#SBATCH --mem=128G
#SBATCH --time=12:00:00
#SBATCH --output=../SLP-outputs/HRpose.%j.out
#SBATCH --error=../SLP-outputs/HRpose.%j.err
echo python main.py 
source ~/.bashrc
source activate slp_env #activate conda environment

# Define temporary variables
DS_FD=/home/desclaux/projects/def-lseoud/desclaux/
SLP_SET=danaLab #on va entrainer sur simLab
OUTPUTDIR=../SLP-outputs
MOD_SRC=RGB
CONF=config/HRpose.conf
SUFFIX_EXP_TRAIN=exp
# PRETRAINED=SLP_IR-depth_u12_HRpose_exp
#cov_li=cover2
#EXP_TEST=cover2


#Pretrained model info
# pretrained_model="SLP_IR_u12_HRpose_exp"
# IFS="_" arr=($pretrained_model)
# TRAINSET=${arr[0]}
# Execute code

# COV_LI=('uncover' 'cover1' 'cover2')
 
	#EXP_TEST="${MOD_SRC}_${cov_li}"
# EXP_TEST="${cov_li}"


python main.py \
	--ds_fd $DS_FD \
    	--SLP_set $SLP_SET \
	--mod_src $MOD_SRC \
	--output_dir $OUTPUTDIR \
        --suffix_exp_train $SUFFIX_EXP_TRAIN
#python main.py --ds_fd /home/desclaux/projects/def-lseoud/desclaux/ --SLP_set simLab --mod_src depth --if_test --if_pretrained SLP_depth_u12_HRpose_exp --output_dir ../SLP-outputs
