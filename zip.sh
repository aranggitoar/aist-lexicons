#!/bin/bash


dir="lexicons"


# -------
echo $'\n> Compressing '$dir' directory into '$dir$'.tar.gz\n'

# Create tar archive
tar -cf $dir'.tar' $dir'/'

# Compress the tar archive
gzip -4 -c $dir'.tar' > $dir'.tar.gz'

# Remove the tar archive
rm $dir'.tar'
