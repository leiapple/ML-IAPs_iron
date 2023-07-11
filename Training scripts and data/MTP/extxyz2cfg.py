# -*- coding: utf-8 -*-
"""
The code is used to convert the training data format for EXTxyz to MTP *.cfg file.

Author: lei.zhang@rug.nl
"""

import numpy as np
import os
import random
                
out_training =  './training.cfg'
out_validation = './validation.cfg'
    
eV_to_Ry = 1/13.60569301
Ry_to_eV = 13.60569301

# Define variable initials
counter1 = 0
# energy of an isolated atom: reference energy
# e0 = -3455.6995339
# Input the total number of configurations in training DB
configurations = 14476
list_config = np.arange(0,configurations)

# Percentage of validation set
valid_per = 0.1
valid_num = int(np.round(configurations*valid_per))

# Select ramdom numbers from the list
valid_set = np.random.choice(list_config,valid_num)
print(valid_set)

# Database file name 
infile='../train.xyz'

def findstring(substring,fullstring):
    if substring in fullstring:
        return fullstring

with open(infile) as file_obj1:
    for i in range(0,configurations):
# Define the name of output file
        
        # the number of atoms
        counter=file_obj1.readline()
        counter=int(counter)
        line1=file_obj1.readline()
        positions=np.zeros((counter,6),dtype=float)
        for j in range(0,counter):
            linep=file_obj1.readline()
            linep=linep.split()
            for everynum in np.arange(0,6):
                positions[j,everynum]=float(linep[everynum+1])
# Extract the lattice       
        line1=line1.split()
        a1=line1[0].split('"')
        a1=float(a1[1])
        a2=float(line1[1])
        a3=float(line1[2])
        b1=float(line1[3])
        b2=float(line1[4])
        b3=float(line1[5])
        c1=float(line1[6])
        c2=float(line1[7])
        c3=line1[8].split('"')
        c3=float(c3[0])
# Find and extract the energy
        for eng in line1:
            energystr=findstring('energy',eng)
            if energystr:
                energystr=energystr.split('=')
                # rescale data 
                energy=float(energystr[1]) #- e0 * counter
# Extract virial stress if it is a primitive cell
        if counter==1:
            virial_xx=line1[-9].split('"')
            virial_xx=float(virial_xx[1])
            virial_xy=float(line1[-8])
            virial_xz=float(line1[-7])
            virial_yy=float(line1[-5])
            virial_yz=float(line1[-4])
            virial_zz=line1[-1].split('"')
            virial_zz=float(virial_zz[0])
# Write the data
        if i in valid_set:
            outfile = out_validation
        else:
            outfile = out_training
                
        with open(outfile,'a') as file_obj2:
            file_obj2.write('BEGIN_CFG\n')
            file_obj2.write(' Size\n')
            file_obj2.write(' %i\n' % counter)
            file_obj2.write(' Supercell\n')
            file_obj2.write('       %14.10f %14.10f %14.10f\n' % (a1,a2,a3))
            file_obj2.write('       %14.10f %14.10f %14.10f\n' % (b1,b2,b3))
            file_obj2.write('       %14.10f %14.10f %14.10f\n' % (c1,c2,c3))
            file_obj2.write(' AtomData:  id type       cartes_x      cartes_y      cartes_z      fx           fy           fz\n')
            for atom in range(0,counter):
                file_obj2.write('           %i  %i        %12.8f  %12.8f  %12.8f  %12.8f %12.8f %12.8f\n' % 
                (atom+1,0,positions[atom,0],positions[atom,1],positions[atom,2],
                positions[atom,3],positions[atom,4],positions[atom,5]))
            file_obj2.write(' Energy\n')
            file_obj2.write('    %.10f\n' % energy)
            if counter==1:
                file_obj2.write(' PlusStress:  xx          yy          zz          xy          xz          yz\n')
                file_obj2.write('         %10.8f %10.8f %10.8f %10.8f %10.8f %10.8f\n' % (virial_xx,virial_yy,virial_zz,virial_xy,virial_xz,virial_yz))
            file_obj2.write(' Feature   EFS_by       QUANTUMESPRESSO\n')
            file_obj2.write('END_CFG\n\n')
            
            print ('Converting data for %i config: success!' % i)
            

# A reference code: /data/p301616/DFT_benchrmark_2021_01_03/DFT_recalculate_Dragoni_2021_01_03/db2/db2/atom_position_data
