import os
import json

path_to_loc = "../lua/loc"
os.chdir(path_to_loc)

for file in os.listdir(): 
    if file.endswith(".json"):
        name = os.path.basename(file)
        print("formatting file \""+name+"\"")
        with open(file, "r", encoding="utf8") as f:
            data = json.loads(f.read())
        with open(file, "w", encoding="utf8") as f:
            f.write(json.dumps(data, sort_keys=True, indent=4, ensure_ascii=False))