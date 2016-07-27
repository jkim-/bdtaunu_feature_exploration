Data Exploration
===

Notebooks to visualize data features. 

Sideband Proposal
---
+ eextra >= 3 GeV.
+ mmiss2prime <= -15 GeV.
+ sig\_hp3 >= 2.3 GeV.
+ r2all >= 0.7 (TBD)

Unblinded Data Sample
---
+ 1% of the data from each run
+ MC weighted accordingly (4% of generic MC weighted for 1% of data)

Offpeak Weights
---
+ In directory `offpeak_weights`, the python script can only be ran on the LTDA.  Its output is the `offpeak_weights.csv`
used throughout this repository, and we use this weight applied to the offpeak data to substitute SP-998 and SP-1005.
