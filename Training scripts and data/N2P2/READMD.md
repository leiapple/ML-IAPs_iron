# NNP training materials

NNPs are trained using _[N2P2](https://compphysvienna.github.io/n2p2/)_ package. 

## DFT database
_N2P2_ requires an interal format, as given in `input.data`.
The detail of the data format is described in [page](https://compphysvienna.github.io/n2p2/topics/cfg_file.html).

## Training script

The training script is provided in `input.nn`.
The symmetry function, cutoff radius, and architecture of the neural network are specified in `input.nn`.

## Training command line

The training command line is given in `submit.sh`.

## RMSE analysis

The RMSE is extracted from the log file and plotted against the training epochs.
The results is presented in jupyter notebook `n2p2_convergence.ipynb`. 