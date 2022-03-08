# ClusteringAERPtoAcousticTT
Clustering Approach based on Psychometrics and Auditory Event-related Potentials to evaluate Acoustic Therapy Effects

Background – Tinnitus is an auditory condition with no effective treatments. Seven of the 25 most widely used treatment are sound based therapies, but no methods to select an appropriate one have been established. New Method – Therefore, this investigation aimed to establish a method to select an appropriate acoustic therapy by finding comparable psycho-neurological effects. For that purpose, 71 Mexican volunteers (60 tinnitus sufferers and 11 controls) followed one of five two-month treatments that aimed to (1) diminution the level of attention towards tinnitus via neuro-modulation, (2) habituation to tinnitus by retraining or (3) distress relieve (binaural beats and music). From the treatment outcomes, six features were defined: (1) hearing loss, (2) anxiety level, (3) stress level, (4) overall amount of neural electrical response to acoustic therapy, (5) EEG channel wherefrom the maximum neural response was obtained, and (6) assigned group. Then, a cluster analysis based on the k-means method was undertaken. Results – As a result, a strong structure (silhouette measure = 0.798) of six clusters showed that tinnitus sufferers who reported diminution of stress and anxiety, and no side effects, mainly proceeded from neuro-modulation treatments. Furthermore, most of tinnitus sufferers who reported increase of anxiety mainly proceeded from tinnitus retraining and binaural beats. Finally, tinnitus sufferers who only reported anxiety diminution mainly proceeded from tinnitus retraining and music therapy. Comparison & Conclusion – Taken together, these findings are a guideline to select an appropriate therapy according to clinical history and psycho-neurological effects, what has not been proposed until now.   


This repository contain all the needed fuctions to develop step-by-step procedure to estimate the AUC feature for the cluster analysis. AUC refers to the area under the curve of the difference between AERPs of the initial an final sessions of the experimental procedure.

![image](https://user-images.githubusercontent.com/78170948/157155966-29aab5a2-5307-4905-aa04-7746dd4c25f7.png)


## Software Requirements:
### MATLAB R2021b
    -Signal Processing toolbox
    -Statistics toolbox
    -Optimization toolbox
    -Image processing toolbox
    -EEGLAB toolbox 2021 https://sccn.ucsd.edu/eeglab/download.php
        -Biosig extension
        -FastICA extension
