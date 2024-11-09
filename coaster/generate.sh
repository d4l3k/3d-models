#!/bin/bash

set -ex

PEOPLE=(
    tristanr
    cpio
    clr
)

for person in "${PEOPLE[@]}";
do
	openscad -o "coaster-$person-black.stl" -D "person=\"$person\"" -D "black=true" coaster.scad 
	openscad -o "coaster-$person-orange.stl" -D "person=\"$person\"" -D "black=false" coaster.scad 

done

