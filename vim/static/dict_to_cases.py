#!/usr/bin/env python
inf = open("english_dict", "r")
ouf = open("dict_with_cases", "w")

for word in inf.readlines():
    ouf.write(word)
    if word[0].islower():
        ouf.write(word[0].upper() + word[1:])
