from extxyz import read, iread, write, ExtXYZTrajectoryWriter
import numpy as np
frames = read("../train.xyz") 
configurations = len(frames) #- 14
list_config = np.arange(0,configurations)

# Percentage of validation set
valid_per = 0.1
valid_num = int(np.round(configurations*valid_per))

# Select ramdom numbers from the list
valid_set = np.random.choice(list_config,valid_num)

for i in np.arange(0,configurations):
    if i in valid_set:
        print('Write frame into validation set:', i)
        write("testing.xyz", frames[i], append=True)
    else:
        print('Write frame into training set:', i)
        write("training.xyz", frames[i], append=True)

for i in np.arange(configurations,configurations): #+14):
    write("training.xyz", frames[i], append=True)
    print('Write frame into training set:', i)
