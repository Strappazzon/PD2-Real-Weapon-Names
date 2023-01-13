import os
import json
#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

import sys
import argparse

def validateJson(jsondata, filename):
    try:
        data = json.loads(jsondata)
    except ValueError as err:
        print("\n\nJSON syntax error in \""+filename+"\"")
        print(err)
        input("Press any key to exit.")
        sys.exit(0)
    return data

#constants
path_to_loc = os.path.abspath("../lua/loc")

os.chdir(path_to_loc)

print("Sorting and validating all JSON files")
for file in os.listdir(): 
    if file.endswith(".json"):
        name = os.path.basename(file)
        print("formatting file \""+name+"\"")
        with open(file, "r", encoding="utf8") as f:
            data = validateJson(f.read(), name)
        with open(file, "w", encoding="utf8") as f:
            f.write(json.dumps(data, sort_keys=True, indent=4, ensure_ascii=False))

input("Press enter to exit.")
