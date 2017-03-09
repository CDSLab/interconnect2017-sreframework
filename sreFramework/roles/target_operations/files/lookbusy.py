#!/usr/bin/python

import time
import subprocess
import sys

arg1 = sys.argv[1]
arg2 = sys.argv[2]

def cpuLoad(cpuPCT, seconds):
    cpuPCT_str = str(cpuPCT)
    print "Starting CPU load generator"
    p = subprocess.Popen(['lookbusy', '--cpu-util', cpuPCT_str])
    time.sleep(int(seconds))
    p.terminate()
    result = "Terminating CPU load generator"
    return result

cpuLoad(arg1, arg2)

# def cputMemLoad(cpuPCT, memoryPCT, seconds):
#     cpuPCT_str = str(cpuPCT)
#     memoryPCT_str = str(memoryPCT)
#     p = subprocess.Popen(['lookbusy', '--mem-util', memoryPCT_str, '--cpu-util', cpuPCT_str])
#     time.sleep(seconds)
#     p.terminate()
#     result = "terminating cpu and memory load generator"
#     return result
