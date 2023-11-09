# PACE training materials

## DFT database 
_PACEMAKER_ requires the data format `pckl.gzip`.
Example is given in this [page](https://pacemaker.readthedocs.io/en/latest/pacemaker/quickstart/).
The training and testing data are `train_pred.pckl.gzip` and `test_pred.pckl.gzip`, respectively.
The energy and force distribution of training and testing data are visualized `train_ef-distributions.png` and `test_ef-distributions.png`, respectively.
The fitting data information is stored in `fitting_data_info.pckl.gzip`.

## Training script
The training script is provided in `input.yaml`.
The body order, expansion level, cutoff radius, and fitting details are specified in the training script.
The training command line is in `submit.sh`.
The training output is in the log file `log.txt`.