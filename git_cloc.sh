#!/usr/bin/env bash

printf "('temp-linecount-repo' will be deleted automatically)\n\n\n"

git clone --depth 1 "$1" temp-linecount-repo

cd temp-linecount-repo

echo "Git-Repo $1" > ../cloc_out.txt

docker run -v "$PWD":/data mribeiro/cloc . >> ../cloc_out.txt

cd ..

rm -rf temp-linecount-repo

python3 << END
import json

dollars_per_line_of_code = 18

with open("cloc_out.txt", "r") as ifh:
    lines = ifh.readlines()
lines = [a.strip() for a in lines]
_state = -1
source = {}
for line in lines:
    if len(line) == 0:
        continue
    if _state == -1 and "Git-Repo" in line:
        _state = 0
        key, value = line.split()
        source[key] = value
    if _state == 0 and "Language" in line:
        _state = 1
    elif _state == 1 and "------------" in line:
        _state = 2
    elif _state == 2 and not "------------" in line:
        # Gather
        # Go                             1566          38431          13656         233664
        lang_str = line[0:30].strip()
        stats_str = line[30:].strip()
        tmp_list = stats_str.split()
        files, blank, comment, code = [int(a) for a in tmp_list]
        source[lang_str] = {'files': files, 'blank': blank, 'comment': comment, 'code': code, 'cost': code * dollars_per_line_of_code}
        #print(lang_str, files, blank, comment, code)
    elif _state == 2 and "------------" in line:
        _state = 3
    elif _state == 3 and "SUM:" in line:
        # Get sum
        stats_str = line[30:].strip()
        tmp_list = stats_str.split()
        files, blank, comment, code = [int(a) for a in tmp_list]
        source['sum'] = {'files': files, 'blank': blank, 'comment': comment, 'code': code, 'cost': code * dollars_per_line_of_code}

with open("cloc_out.json", "w") as ofh:
    json.dump(source, ofh, indent=4)

END