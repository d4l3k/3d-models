#!/bin/bash

set -ex

PEOPLE=(
    ""
    tristanr
    cpio
    chienchin
    gnadathur
    irisz
    fduwjj
    kw2501
    lpasqualin
    sqzhang
    whc
    xilunwu
    andgu
    howardhuang
    lty
    wanchaol
    weif
    yifanmao
    yifu
    gchanan
    clr
)

for person in "${PEOPLE[@]}";
do
	openscad -o "coaster-$person-black.stl" -D "person=\"$person\"" -D "black=true" coaster2.scad 
	openscad -o "coaster-$person-orange.stl" -D "person=\"$person\"" -D "black=false" coaster2.scad 

done

