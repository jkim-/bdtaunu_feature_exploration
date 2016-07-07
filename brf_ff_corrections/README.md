MC branching fraction and form factor corrections
===

Branching fraction correction:
---
+ Determine the most frequent B decay modes in generic MC (SP-1235/1237) that encompasses 50% of all B decays.
+ Compare DECAY.DEC branching fraction values to those in the PDG and make the correction.

Form factor correction:
---
+ CLN only.

D\*\* branching fraction correction:
---
+ Apply 0.6 correction to the event weight each time you come across a decay involving D\*\* or a non-resonant decay (see `brf_others.dat`). 

Data for plots:
---
+ `brf_others.dat` and `offpeak_weights.csv` already exist in this directory.
+ Data files such as `mc.csv`, `onpeak_data.csv`, and `offpeak_data.csv` are not uploaded and must be downloaded using `download_events.sql`.
