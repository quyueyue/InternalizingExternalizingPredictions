# Single- & Multi-Kernel Regression Leave-p-Out Cross-Validation workflow in ABCD Study

Functions under "multiKRR" folder perform multi-kernel leave-p-sites-out cross-validation workflow used in the ABCD analyses. 

Functions under "KRR" folder perform single-kernel leave-p-sites-out cross-validation workflow used in the ABCD analyses. 

Suppose all the subjects are from N sites, in each cross-validation fold we choose subjects from p sites as test set and the remaining subjects in the training set. This is repeated N-choose-p times.

In our paper, there are 10 site (N=10) clusters in total. In each cross-validation fold we choose subjects from 3 (p=3) site clusters as test set. This is repeated 10C3=120 times.
