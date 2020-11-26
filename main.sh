# !/bin/bash
# SBATCH --exclusive
# SBATCH --account=desclaux 
# SBATCH --job-name=HRpose 
# SBATCH --nodes=1
# SBATCH --cpus-per-task=5
# #SBATCH --partition=multigpu #je sais pas comment ca marche sur CC
# SBATCH --gres=gpu:p100l:4	 # resource
# SBATCH --mem=128Gb
# SBATCH --time=2:00:00
# SBATCH --output=../SLP-outputs/HRpose.%j.out
# SBATCH --error=../SLP-outputs/HRpose.%j.err
echo python main.py 
source activate slp_env #activate conda environment

# Define temporary variables
DS_FD="/home/desclaux/projects/def-lseoud/desclaux" 
SLP_SET=simLab #on va tester sur simLab
OUTPUTDIR="../SLP-outputs"
MOD_SRC=depth
CONF=config/HRpose.conf
PRETRAINED=SLP_depth_u12_HRpose_exp

# Pretrained model info
# pretrained_model="SLP_IR_u12_HRpose_exp"
# IFS="_" arr=($pretrained_model)
# TRAINSET=${arr[0]}

# Execute code
python main.py \
--ds_fd $DS_FD \
--SLP_set $SLP_SET \
--mod_src $MOD_SRC \
--modelConf $CONF \
--if_test \
--display_id 1\
--if_pretrained $PRETRAINED
--output_dir $OUTPUTDIR \
--suffix_exp_train 'exp'



