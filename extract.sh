#!/bin/bash


# -------
echo $'\n> Prepare the environment.\n'

# Prepare the directory name, downloaded file name and suffix
dir="mysword-extended-strongs"
fn="strong.dct.mybible"
s=".gz"

# Clean previous directory and create a new one
rm -rf $dir
mkdir $dir
cd $dir


# -------
echo $'\n> Downloading and extracting the latest MySword Strong\'s, \
  BDB Hebrew Thayer Greek Lexicon module.\n'

# Download the latest extended Strong's from MySword
wget -O "$fn$s" "https://mysword-bible.info:4443/download/getfile.php?file=strong.dct.mybible.gz"

# "Ungunzip" the gunzip
gzip -d "$fn$s"


# -------
echo $'\n> Extracting the contents of the Lexicon into CSV format\n'

# Extract the lexicon details
sqlite3 -header -csv $fn "select * from details;" > details.csv

# Extract the lexicon
sqlite3 -header -csv $fn "select * from dictionary;" > dictionary.csv


# -------
echo $'\n> Cleaning source tree, check the contents of ./$dir/ ./\n'

# Clean the environment
rm -rf $fn
