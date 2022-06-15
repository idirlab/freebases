#!/bin/bash
# A Bash script to parse, process, clean the Freebase data dumps.

########## ########## ########## ########## ##########
## Z Commands Overview
########## ########## ########## ########## ##########

# Scan through the compressed data
# zmore freebase-rdf-latest.gz

# Grep for specific terms, limit set at 5
# zgrep 'term' -m 5 freebase-rdf-latest.gz

# Pipe the data to another file
# zgrep 'term' freebase-rdf-latest.gz > freebase-triples.txt


########## ########## ########## ########## ##########
## Stages and Changes
########## ########## ########## ########## ##########

## s1-c0 Setting File Names
INPUT_FILE=$1
OUTPUT_FILE_S01_C01=${INPUT_FILE:0:${#INPUT_FILE}-11}"-s01-c01.nt"
OUTPUT_FILE_S01_C02=${INPUT_FILE:0:${#INPUT_FILE}-11}"-s01-c02.nt"
OUTPUT_FILE_S01_C03=$INPUT_FILE"_formatted"


## s1-c1 Remove rows with Objects  longer than 255 characaters

#awk 'length($3) < 255  { print }' $INPUT_FILE > $OUTPUT_FILE_S01_C01

## s1-c2 Substring replacement: URLs

FB_URI='http:\/\/rdf.freebase.com'
FB_NS_URI='http:\/\/rdf.freebase.com\/ns'
W3_URI='http:\/\/www.w3.org\/[0-9]*\/[0-9]*\/[0-9]*-*'

sed "s/$FB_NS_URI//g; s/$W3_URI//g; s/$FB_URI//g" $INPUT_FILE > $OUTPUT_FILE_S01_C01
#rm -f $INPUT_FILE

## s1-c3 Substring replacement: <,> Signs

# [DEPRECATED] single sed substitute operation
# [DEPRECATED] sed "s/<//g; s/>//g" $INPUT_FILE | pv -pterbl >$OUTPUT_FILE

# Running with GNU sed ($ gsed) since OS X sed doesn't handle '\t' tab chars
# - 1st sub: targets the leading "<" char on each line
# - 2nd sub: targets leading "<", with a leading tab
# - 3rd sub: targets trailing ">" char, accurately found as its tab separated
sed "s/^<//g; s/\t</\t/g; s/>\t/\t/g" $OUTPUT_FILE_S01_C01  > $OUTPUT_FILE_S01_C02
rm -f $OUTPUT_FILE_S01_C01

## s1-c4 Substring replacement: Schema IDs /.. to ///
awk  -F "\t"  -v OFS="\t"  'function GSUB(F) {gsub(/\./,"/",$F)} {GSUB(1);GSUB(2)}1' $OUTPUT_FILE_S01_C02 > $OUTPUT_FILE_S01_C03
#sed "s/\./\//g" $OUTPUT_FILE_S01_C02  > $OUTPUT_FILE_S01_C03 # TODO: better regex with gsed
rm -f $OUTPUT_FILE_S01_C02
