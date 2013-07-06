#!/usr/bin/python
# $File: dict_to_cases.py
# $Date: Mon Dec 10 23:46:08 2012 +0800
# Author: Yuxin Wu <ppwwyyxxc@gmail.com>
inf = open("english_dict", "r")
ouf = open("dict_with_cases", "w")

for word in inf.readlines():
    ouf.write(word)
    if word[0].islower():
        ouf.write(word[0].upper() + word[1:])
