#! /usr/bin/env python

#######################################################################################
# Author: Jitendra Gehlot
# Filename: mongo_export_transformation.py
# Date: 10/10/2016
# Description: This script is use to transform CSV data generated from Mongo_Export
#######################################################################################

import sys
import re
#s = "i2013-12-31T05:00:00.000Z"
#replaced = re.sub('T(\d\d:\d\d:\d\d.\d\d\d)Z', ' 00:00:00.000', s)
#print replaced


def main():
    lines = sys.stdin.read().splitlines()
    for line in lines:
        processLine(line)

def processLine(line):
    line = line.replace("2014-01-01T05:00:00.000Z", "2014-01-01 00:00:00.000")
    line = line.replace("\"","")
    line = re.sub('T(\d\d:\d\d:\d\d.\d\d\d)Z', ' 00:00:00.000', line)
 #   line = line.replace(",'f'", ",'0'")
    in_string = False
    newLine = ''
    for c in line:
        if not in_string:
            if c == "'":
                in_string = True
            elif c == '"':
 #               newLine = newLine + '`'
                continue
        elif c == "'":
            in_string = False
        newLine = newLine + c
    print newLine

if __name__ == "__main__":
    main()