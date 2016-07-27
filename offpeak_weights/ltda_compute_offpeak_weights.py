#! /usr/local/bin/python

import subprocess
import re

xsec = { '1237' : 525.0,
         '1235' : 525.0,
         '998' : 2090.0,
         '1005' : 1300.0,
         '3429' : 940.0 }
run = [ '1', '2', '3', '4', '5', '6' ]
mc_modes = [ '998', '1005', '3429', '1235', '1237' ]

onpeak_lumi = []
offpeak_lumi = []
onpeak_template = 'lumi --dataset AllEventsSkim-Run{0}-OnPeak-R24a1 --dbname=bbkr24'
offpeak_template = 'lumi --dataset AllEventsSkim-Run{0}-OffPeak-R24a1 --dbname=bbkr24'
onpeak_lumi_patt = re.compile('^ Lumi +Processed +([1-9\.][0-9\.]*)')
offpeak_lumi_patt = re.compile('^ Lumi +Processed +([0-9\.]+) +([1-9\.][0-9\.]*)')

for i in run:
    onpeak_cmd  = onpeak_template.format(i)
    offpeak_cmd  = offpeak_template.format(i)
    #print onpeak_cmd
    #print offpeak_cmd

    onpeak_output = subprocess.check_output(onpeak_cmd.split())
    for line in onpeak_output.strip().split('\n'):
        match = onpeak_lumi_patt.search(line)
        if match:
            onpeak_lumi.append(float(match.group(1)))

    offpeak_output = subprocess.check_output(offpeak_cmd.split())
    for line in offpeak_output.strip().split('\n'):
        match = offpeak_lumi_patt.search(line)
        if match:
            offpeak_lumi.append(float(match.group(2)))

offpeak_weight = []
for on, off in zip(onpeak_lumi, offpeak_lumi):
    weight = on*1./off
    offpeak_weight.append(weight)

print '{:<20}{:<20}'.format('run', 'weight')
for i, w in enumerate(offpeak_weight):
    print '{:<20}{:<20}'.format(i, w)
