import os
import sys
import re
import shutil
from filecmp import dircmp

ZKPATH = "/home/user/.local/share/Steam/steamapps/common/Zero-K"
ZKMAPPATH = ZKPATH + "/maps"
CURRDIR = os.path.dirname(os.path.realpath('__file__'))

mapName = "Map.sdd"
mapVersion = ""
src = ""
dst = ""

def main():
    global mapName
    global src
    global mapVersion
    global dst

    mapName = getMapName()
    src = CURRDIR + "/%s.sdd" % mapName
    mapVersion = getMapVersion()
    dst = ZKMAPPATH + "/%s_%s.sdd" % (mapName, mapVersion)
    

    command = "merge" if len(sys.argv) <= 1 else sys.argv[1]
    processCommand(command)
    print("Command %s processed." % command)


def processCommand(cmd):
    if cmd == "merge":
        mergeCommand()
    elif cmd == "zip":
        zipCommand()
    elif cmd == "clean":
        cleanCommand()
    else:
        print("Unknown Command: %s, try merge, zip or clean" % arg)


def mergeCommand():
    if not os.path.exists(dst) or not isDirEqual(src, dst):
        cleanCommand()
        print("New Files Added or Removed")
        
    mergeDir(src, dst)


def zipCommand():
    os.system("7z a -ms=off %s_%s.sd7 %s/*" % (mapName, mapVersion, src))


def cleanCommand():
    if os.path.exists(dst):
        shutil.rmtree(dst)


def getMapName():
    for item in os.listdir(CURRDIR):
        if ".sdd" in item:
            return item.replace(".sdd", "")


def getMapVersion():
    with open("%s/mapinfo.lua" % src, "r") as search:
        for line in search:
            line = line.rstrip()  # remove '\n' at end of line
            if "version" in line:
                return re.search('"(.+?)"', line).group(1)
    return "1.0"


def isDirEqual(a, b):
    dcmp = dircmp(a, b)
    return len(dcmp.left_only) == 0 and len(dcmp.right_only) == 0


def mergeDir(root_src_dir, root_dst_dir):
    for src_dir, dirs, files in os.walk(root_src_dir):
        dst_dir = src_dir.replace(root_src_dir, root_dst_dir, 1)
        if not os.path.exists(dst_dir):
            os.makedirs(dst_dir)
        for file_ in files:
            src_file = os.path.join(src_dir, file_)
            dst_file = os.path.join(dst_dir, file_)
            if os.path.exists(dst_file):
                os.remove(dst_file)
            shutil.copy(src_file, dst_dir)


if __name__ == '__main__':
    main()

    

    
