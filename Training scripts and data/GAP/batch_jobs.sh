# Job script to do a grid search on parameters of GAP
# 

for Lmax in $(seq 1 1 12)
do

for Nmax in $(seq 1 1 2)
do

jobfolder=L${Lmax}_N${Nmax}

mkdir ${jobfolder}
cd ${jobfolder}

# create submit file name
submitfile="submit"

# Create the file for submitting jobs by using batch
#--------------------------------------------
cat >${submitfile} <<EOF
#!/bin/bash
#SBATCH --job-name=GAP
#SBATCH --partition=thin
#SBATCH --nodes=1   # number of nodes
#SBATCH --time=10:00:00
#SBATCH --exclusive
#SBATCH --error=slurm-%j.stderr
#SBATCH --output=slurm-%j.stdout
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lei.zhang@rug.nl

# lei.zhang, 12 Dec 2021, lei.zhang@rug.nl

module restore set-gap

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

echo $SLURM_CPUS_ON_NODE
# Spliting the data
python ../split.py
# Training the potential
#----------------------------------
/home/zhanglei1/software/QUIP_OPENMPI/build/linux_x86_64_gfortran_openmp/gap_fit at_file=training.xyz \
gap={ distance_Nb order=2 cutoff=6.5 n_sparse=25 covariance_type=ard_se  \
delta=1.0 theta_uniform=2.5 sparse_method=uniform compact_clusters=True \
:soap_turbo l_max=${Lmax} alpha_max={{${Nmax}}} \
atom_sigma_r={{0.25}} atom_sigma_t={{0.25}} \
atom_sigma_r_scaling={{ 0.0}} atom_sigma_t_scaling={{0.0}} \
zeta=4 rcut_hard=3.0 rcut_soft=2.5 \
delta=1.0 basis="poly3" \
scaling_mode="polynomial"  amplitude_scaling={{1.0}}  \
n_species=1 species_Z={26} add_species=F \
compress_mode="trivial" \
radial_enhancement=1 central_weight={{1.0}}  covariance_type=dot_product \
config_type_n_sparse={slice_sample_high:200:phonons_54_high:200:phonons_128_high:200:prim_random:100:default:1500} \
sparse_method=cur_points \
:soap_turbo l_max=${Lmax} alpha_max={{${Nmax}}} \
atom_sigma_r={{0.5}} atom_sigma_t={{0.5}} \
atom_sigma_r_scaling={{ 0.0}} atom_sigma_t_scaling={{0.0}} \
zeta=4 rcut_hard=6.5 rcut_soft=5.5 \
delta=1.0 basis="poly3" \
scaling_mode="polynomial"  amplitude_scaling={{1.0}}  \
n_species=1 species_Z={26} add_species=F compress_mode="trivial" \
radial_enhancement=1 central_weight={{1.0}}  covariance_type=dot_product \
config_type_n_sparse={slice_sample_high:400:phonons_54_high:400:phonons_128_high:400:prim_random:200:default:2400} \
sparse_method=cur_points} \
sparse_jitter=1e-12 \
default_sigma={0.005 0.2 1.0 0.0}  \
config_type_sigma={slice_sample_high:0.0001:0.01:0.01:0.0:phonons_54_high:0.001:0.05:1.0:0.0:phonons_128_high:0.001:0.05:1.0:0.0:prim_random:0.0001:0.01:0.01:0.0} \
energy_parameter_name=energy force_parameter_name=force virial_parameter_name=virial  \
do_copy_at_file=F  \
sparse_separate_file=T  \
gp_file=gap_Fe_test.xml \
openmp_chunk_size=1000 \
e0={Fe:-3455.6995339}  

#----------------------------

/home/zhanglei1/software/QUIP_OPENMPI/build/linux_x86_64_gfortran_openmp/quip E=T F=T atoms_filename=training.xyz param_filename=gap_Fe_test.xml  | grep AT | sed 's/AT//' > quip_train.xyz

/home/zhanglei1/software/QUIP_OPENMPI/build/linux_x86_64_gfortran_openmp/quip E=T F=T atoms_filename=testing.xyz param_filename=gap_Fe_test.xml  | grep AT | sed 's/AT//' > quip_test.xyz

EOF
#--------------------------------------------


# submit the job
sbatch ${submitfile}
cd ..

done
done
