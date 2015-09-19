#!/usr/bin/env python2

import re
import sys
import operator


docs = []
words = []
i = 0
what = sys.argv[1].split()
what_unique = list(set(what))
while True:
    try:
        a = raw_input()
    except EOFError:
        break
    if a[0] == "!":
        print(a)
        sys.exit(0)
    b = re.sub(r"(\d+)\)", r"\1", a)
    c = re.sub(r"\((\d+)", r"\1", b).split()
    d = map(int, c[1:-1])
    words.append(c[0])
    docs.append(d)
    i += 1

if len(docs) == 0:
    sys.exit(0)

score = {}
for i in what_unique:
    posting = []
    if i in words:
        posting = docs[words.index(i)]
        for k in range(0, len(posting), 2):
            if score.get(posting[k]) is None:
                score[posting[k]] = 0
            score[posting[k]] += posting[k + 1]


sorted_scores = reversed(sorted(score.items(), key=operator.itemgetter(1)))

for key, value in sorted_scores:
    print(str(key) + " " + str(key))
