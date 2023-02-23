#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

import os
import shutil
import argparse
import json
import hashlib
import sys

def getfiles(dirpath):
    f =  []
    for root, dirs, files in os.walk(dirpath):
        for file in files:
            if os.path.isfile(os.path.join(root, file)):
                f.append(os.path.join(root, file))
    f.sort(key=str.lower)
    return f

def hashdir(path):
    hashstr = ""
    files = getfiles(path)
    for file in files:
        thash = hashlib.sha256()
        with open(file, "rb") as f:
            for line in iter(lambda: f.read(65536), b''):
                thash.update(line)
        hashstr += thash.hexdigest()
    return hashlib.sha256().update(bytes(hashstr, "ascii")).hexdigest()
    
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
moddir = os.path.abspath("../")
builddir = os.path.abspath("Real Weapon Names")
metafile = os.path.join(moddir, "meta.json")
metaident = "RealWeaponNames"
locdir = os.path.join(builddir, "lua/loc")

#setup argparse
parser = argparse.ArgumentParser(description="buildscript for Real Weapon Names")
parser.add_argument("-v", action="store", help="Version to bump to")
args = parser.parse_args()

#create clean builddir
if os.path.exists(builddir):
    shutil.rmtree(builddir)
os.mkdir(builddir)

#version bump
if args.v != None:
    with open(os.path.join(moddir, "mod.txt"), "r", encoding="utf8") as f:
        modtxt =  json.loads(f.read())
    modtxt["version"] = str(args.v)
    with open(os.path.join(moddir, "mod.txt"), "w", encoding="utf8") as f:
        f.write(json.dumps(modtxt, sort_keys=False, indent=4))

#copy files
shutil.copy2(os.path.join(moddir, "mod.txt"), os.path.join(builddir, "mod.txt"))
shutil.copy2(os.path.join(moddir, "LICENSE.txt"), os.path.join(builddir, "LICENSE.txt"))
shutil.copy2(os.path.join(moddir, "RWN.png"), os.path.join(builddir, "RWN.png"))
shutil.copytree(os.path.join(moddir, "lua"), os.path.join(builddir, "lua"))

#minify and validate loc files
cwd = os.getcwd()
os.chdir(locdir)
for file in os.listdir(locdir): 
    if file.endswith(".json"):
        with open(file, "r", encoding="utf8") as f:
            data = validateJson(f.read(), os.path.basename(file))
        with open(file, "w", encoding="utf8") as f:
            f.write(json.dumps(data, sort_keys=True, ensure_ascii=False))
os.chdir(cwd)

#compute sha256 hash and write new meta file
hash = hashdir(builddir)
with open(os.path.join(moddir, "meta.json"), "w", encoding="utf8") as f:
    f.write(json.dumps([{"ident": metaident, "hash": hash}], sort_keys=True, indent=4))

#build zip
shutil.make_archive("RWN", "zip", os.path.join(moddir, "script"), builddir)
os.remove(os.path.join(moddir, "RWN.zip"))
shutil.move(os.path.join(os.getcwd(), "RWN.zip"), os.path.join(moddir, "RWN.zip"))

#cleanup
if os.path.exists(builddir):
    shutil.rmtree(builddir)