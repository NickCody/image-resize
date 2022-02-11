#!/bin/bash

# set -euo pipefail

if [ ! -d backup ]; then
    mkdir backup
fi

alljpegs=`ls *.jpg`

# Remove spaces from filenames (replace with _)
#
#set +e
for file in *.jpg; do
    mv "$file" `echo "$file" | tr ' ' '_'` 2> /dev/null
done
#set -e

# new filenames
#
alljpegs=`ls *.jpg`
num_images=$(echo "$alljpegs" | wc -l)
count=1

for file in $alljpegs; do
    fileinfo=`identify "$file"`
    filedimensions=`echo "$fileinfo" | cut -d " " -f  3`
    x=`echo $filedimensions | cut -d "x" -f 1`
    y=`echo $filedimensions | cut -d "x" -f 2`

    if [[ $x -lt $y || $x -eq $y ]]; then
        # Portrait to landscape square to landscape
        #
        echo "Compositing portrait $file ($count / $num_images)"
        newx=`awk -v m=$y 'BEGIN {print int((16 / 9 * m)+1)}'` # stretch to a 16:9 image
        identitycommand="convert  -size "$newx"x"$y" canvas:none -fill black black.jpg"
        `$identitycommand`
        mv "${file}" "backup/${file}"
        composite -colorspace sRGB -gravity center "backup/${file}" black.jpg "${file}"
    else
        # Wide landscape to 16:9
        #
        echo "Compositing landscape $file ($count / $num_images)"
        newy=`awk -v m=$x 'BEGIN {print int((9 / 16 * m)+1)}'` # stretch to a 16:9 image
        identitycommand="convert  -size "$x"x"$newy" canvas:none -fill black black.jpg"
        `$identitycommand`
        mv "${file}" "backup/${file}"
        composite -colorspace sRGB -gravity center "backup/${file}" black.jpg "${file}"
    fi
    convert "${file}" -resize 3840x2160^ "${file}"
    ((count=count+1))
done

if [ -f black.jpg ]; then
    rm black.jpg
fi