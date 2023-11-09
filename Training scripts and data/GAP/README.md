# GAP training materials

## DFT database 
The DFT database is given in `train.xyz` in  ExtendedXYZ format. 
This database was originally developed to simulate thermomechanics and defects in bcc ferromagnetic iron (see [Dragoni et al.](https://journals.aps.org/prmaterials/abstract/10.1103/PhysRevMaterials.2.013808)), and has been extended to study fracture properties (see [zhang et al.](https://arxiv.org/abs/2208.05912)).

## Training command line
- submit.sh: A Bash script includes QUIP commands line to train GAP models
- batch_jobs.sh: A Bash script for conducting a grid search of some (hyper)parameter in GAP model training. Currently, it is made for a grid search on $l_{\rm max}$ and $n_{\rm max}$.
- split.py: A python script for randomly splitting the entire DFT database into training and testing sets with a ratio of 9:1.

GAP is trained using _[QUIP](https://github.com/libAtoms/QUIP.git)_ package. 
The key parameters are listed in this [page](https://libatoms.github.io/GAP/gap_fit.html#command-line-example).

## Example

Folder `L8_N8` is an exmaple training script using $l_{\rm max}=8$, $n_{\rm max}=8$, and $R_{\rm cut}=6.5\AA$. 

## RMSE analysis

The evaluation of RMSE is not provided by _QUIP_ explicitly.
Therefore, the RMSE is computed using jupyter notebook `gap_error_analysis.ipynb`.