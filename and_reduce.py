#!/usr/bin/env python2

import re
import sys

docs = []
i = 0
what = sys.argv[1].split()
while True:
    try:
        a = raw_input()
    except EOFError:
        break
    if a[0] == "!":
        print(a)
        sys.exit(0)
    b = re.sub(r"\d+\)", r"", a)
    c = re.sub(r"\((\d+)", r"\1", b)
    d = map(int, c.split()[1:-1])
    docs.append(d)
    i += 1

if len(docs) != len(what):
    sys.exit(0)

index = [0] * i
while True:
    eq = True
    min = 0
    for j in range(1, i):
        if docs[j][index[j]] != docs[j - 1][index[j - 1]]:
            eq = False
            if docs[j][index[j]] < docs[min][index[min]]:
                min = j
    if eq:
        print(str(docs[0][index[0]]) + " " + str(docs[0][index[0]]))
    if index[min] < len(docs[min]) - 1:
        index[min] += 1
    else:
        break
