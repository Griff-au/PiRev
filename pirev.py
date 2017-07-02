#!/usr/bin/python3

import os
import sys
import subprocess
import collections

numParms = len(sys.argv)
parmVals = (sys.argv)

lncmd = subprocess.Popen(["cat", "/proc/cpuinfo"], stdout=subprocess.PIPE)
(cpuInfo, err) = lncmd.communicate()

rpCpu = ( 
        ('0002'),    ('Model B Rev 1', '256'),
        ('0003'),    ('Model B Rev 1', '256'),
        ('0004'),    ('Model B Rev 2', '256'),
        ('0005'),    ('Model B Rev 2', '256'),
        ('0006'),    ('Model B Rev 2', '256'),
        ('0007'),    ('Model A', '256'),
        ('0008'),    ('Model A', '256'),
        ('0009'),    ('Model A', '256'),
        ('000d'),    ('Model B Rev 2', '512'),
        ('000e'),    ('Model B Rev 2', '512'),
        ('000f'),    ('Model B Rev 2', '512'),
        ('0010'),    ('Model B+', '512'),
        ('0013'),    ('Model B+', '512'),
        ('0012'),    ('Model A+', '256'),
        ('0015'),    ('Model A+', '256/512'),
        ('a01041'),  ('Pi 2 Model B v1.1', '1Gb'),
        ('a21041'),  ('Pi 2 Model B v1.1', '1Gb'),
        ('a22042'),  ('Pi 2 Model B v1.2', '1Gb'),
        ('a02082'),  ('Pi 3 Model B', '1Gb'),
        ('a22082'),  ('Pi 3 Model B', '1Gb'),
        ('900092'),  ('PiZero v1.2', '512'),
        ('900093'),  ('PiZero v1.3', '512'),
        ('9000c1'),  ('PiZero W', '512')
        )

def CPU_This_Pi(): 
    for line in cpuInfo.splitlines():
        line = line.decode()
        if 'Revision' in line:
            revSplit = line.split()
            Print_Head()
            Print_Details(revSplit[2])

    if len(revSplit) == 0:
        print("Hmmm, are you sure this is a Raspberry Pi?")

def All_Pi_Rev():
    Print_Head()

    for revVal in rpCpu[::2]:
        Print_Details(revVal)

def Print_Head():
    print('{:=<32}'.format(''))
    print("%8s %10s %12s" % ("Revision", "Model", "Memory"))
    print('{:=<32}'.format(''))

def Print_Details(revVal):
    piModel  = rpCpu[rpCpu.index(revVal) + 1][0] 
    piMemory = rpCpu[rpCpu.index(revVal) + 1][1]
    print("%-8s %-18s %-8s" % (revVal, piModel, piMemory))
    
def PiRev_Help():
    print("Help - The Beatles")
    print("Lennon/Mccartney - Parlophone, Capitol Records")
    print("Released 1965, B Side - 'I'm Down'")

if numParms == 1: 
    CPU_This_Pi()
elif parmVals[1].lower() == '-all':
    All_Pi_Rev()
elif parmVals[1].lower() == '-help':
    PiRev_Help()
else:
    print("Parameter unrecognised try 'pirev -help'")
