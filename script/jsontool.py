import os
import json
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

#setup argparse
parser = argparse.ArgumentParser(description="jsontool for Real Weapon Names")
parser.add_argument("-l", action="store_true", help="check length of strings in all json files")
parser.add_argument("-s", action="store_true", help="validate Json and sort stringids in all json files")
args = parser.parse_args()

#constants
path_to_loc = os.path.abspath("../lua/loc")
max_string_length = 100
outfile_length_check = os.path.abspath("./lengthcheck.txt")

os.chdir(path_to_loc)

if args.s == True:
    print("Sorting and validating all JSON files")
    for file in os.listdir(): 
        if file.endswith(".json"):
            name = os.path.basename(file)
            print("formatting file \""+name+"\"")
            with open(file, "r", encoding="utf8") as f:
                data = validateJson(f.read(), name)
            with open(file, "w", encoding="utf8") as f:
                f.write(json.dumps(data, sort_keys=True, indent=4, ensure_ascii=False))

if args.l == True:
    print("Checking length of strings")
    with open(outfile_length_check, "w", encoding="utf8") as of:
        for file in os.listdir(): 
            if file.endswith(".json"):
                name = os.path.basename(file)
                s = "checking file \""+name+"\""
                print(s)
                of.write(s+"\n\n")
                with open(file, "r", encoding="utf8") as f:
                    data = validateJson(f.read(), name)
                for k, v in data.items():
                    if len(v) > max_string_length and k.endswith("_info") == False and k.endswith("_desc") == False and k.endswith("_objective") == False:
                        s = "\tStringID: \""+k+"\" String: \""+v+"\" Length: "+str(len(v))
                        print(s)
                        of.write(s+"\n")

input("Press any key to exit.")
