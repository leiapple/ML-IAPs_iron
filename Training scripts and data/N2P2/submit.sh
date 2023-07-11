#!/bin/bash
#SBATCH --job-name=n2p2_N10
#SBATCH --partition=fat
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=30:00:00
#SBATCH --error=slurm-%j.stderr
#SBATCH --output=slurm-%j.stdout
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lei.zhang@rug.nl

ncpus=$SLURM_CPUS_ON_NODE
module restore set-n2p2

mpirun -np 64 nnp-scaling 1000
mpirun -np 64 nnp-train 
