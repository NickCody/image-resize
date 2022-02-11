from calendar import TUESDAY
import os
import hashlib
import pathlib


def noex(filename):
    return pathlib.Path(filename).name[:-len(''.join(pathlib.Path(filename).suffixes))]

def md5checksum(fname):

    md5 = hashlib.md5()

    # handle content in binary form
    f = open(fname, "rb")

    while chunk := f.read(4096):
        md5.update(chunk)

    return md5.hexdigest()

def match(f, fa):
    if f in fa:
        return True
    for a in fa:
        if a in f:
            return True
    return False

def remove_duplicates(dir):
    count=0
    unique = set()
    filenames = set()
    for filename in os.listdir(dir):
        if os.path.isfile(filename):
            nx = noex(filename)
            if True or match(nx, filenames):            
                filehash = md5checksum(filename)
                if filehash not in unique: 
                    unique.add(filehash)
                else:
                    print(filename + " is a duplicate") 
                    #os.remove(filename)
            filenames.add(nx)
            count = count + 1
            if (count % 100 == 0):
                print("Processing " + str(count))

if __name__ == '__main__':
    remove_duplicates(os.getcwd())
