#!/bin/bash

# Convert SVG to PNG.
find -name "*.svg" -o -name "*.SVG" | while read i;
do
    echo "File named $i will be converted."
    fname=$( basename "$i")
    inkscape -f "$i" -e "${i%.*}.png"
done  
