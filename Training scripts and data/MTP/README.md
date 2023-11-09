# MTP training materials

All MTPs are trained using _[MLIP-2](https://gitlab.com/ashapeev/mlip-2)_.
Extensive examples are given in [gitlab page](https://gitlab.com/ashapeev/mlip-2-tutorials).
The training of MTP requires an initial potential file that has a pre-defined expansion level. 
This is already provided in _MLIP-2_ package.

## DFT database 
The format of DFT database required for MTP is an internal `cfg` format.
`extxyz2cfg.py` is used to convert ExtendedXYZ format to cfg format, and is used to split the database into training and testing by 9:1. 

## Training command line
The training command line is given in `submit.sh`. 