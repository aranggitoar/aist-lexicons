# run.sh is a MySword extended Strong's lexicon SQLite extractor.
# Copyright (C) 2022  Aranggi J. Toar
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; only version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA. 

#!/bin/bash


# -------
echo $'\n> Preparing the environment.\n'

# Prepare the directory name, downloaded file name and suffix
# sfn = source file name; ofn = output file name
dir="lexicons"
sfn="strong.dct.mybible"
ofn=("details" "dictionary")

# Clean previous directory and create a new one
rm -rf $dir
mkdir $dir
cd $dir


# -------
echo $'\n> Downloading and extracting the latest MySword Strong\'s,
  BDB Hebrew Thayer Greek Lexicon module.\n'

# Download the latest extended Strong's from MySword
wget -O "$sfn.gz" "https://mysword-bible.info:4443/download/getfile.php?file=strong.dct.mybible.gz"

# "Ungunzip" the gunzip
gzip -d "$sfn.gz"


# -------
echo $'\n> Extracting the contents of the module into CSV format and
  change the text file format from DOS/Windows to Unix.\n'

# Extract the lexicon details
sqlite3 -header -csv $sfn "select * from ${ofn[0]};" > \
  "${ofn[0]}.csv"

# Extract the lexicon
sqlite3 -header -csv $sfn "select * from ${ofn[1]};" > \
  "${ofn[1]}.csv"

# Change from dos to unix format as to remove ^M (Carriage Return)
# It is a control character from dos/Windows that signifies the end
# of line, ref. in VIM help digraph-table
dos2unix "${ofn[0]}.csv"
dos2unix "${ofn[1]}.csv"

# Remove the source file
rm $sfn


# -------
echo $'\n> Converting the CSV of the lexicon into separate JSONs of
  Greek and Hebrew.\n'

# Prepare the source CSV file names and JSON file names
# sfn = source file name; ofn = output file name
sfn=("${ofn[0]}.csv" "${ofn[1]}.csv")
ofn=('lexicon-hebrew.json' 'lexicon-greek.json' 'README.md')

# Prepare the line counter
total_line=$(grep -c "" ${sfn[1]})
current_line_index=0

# Prepare the output files
touch ${ofn[*]}

# Read every line of the lexicon file >> ${sfn[1]} and append the
# converted data into a variable "contents"
contents=''
while read line; do

  # If there is only a double quote present, skip the iteration
  if [[ "$line" =~ ^\"$ ]]; then continue; fi

  # If it is the column name line (first line),
  # 1. Append an opening bracket into the content variable, and
  # 2. Skip the iteration
  if [[ "$line" =~ relativeorder,word,data ]]; then
    echo $'\n> Converting the Hebrew lexicon.\n'
    contents='{'
    continue
  fi

  # If it is the last line of the Greek lexicon (the first line of
  # Hebrew prefixes),
  # 1. Write the whole content variable into the output file, and
  # 2. Break out of the loop
  if [[ $line =~ .*,Hb,.* ]]; then
    contents+='}'
    echo $contents >> ${ofn[1]}
    break
  fi

  # Extract contents of the "word" and "data" column,
  # which are the Strong's numbers and lexicon entry
  word="$(echo $line | awk -F ',' '{print $2}')"
  # Capture every character after the first comma and double quote until
  # the end of line,
  data="$(echo $line | sed 's/.*,"\(.*\)$/\1/' |
    # then escape all backward slashes and forward slashes,
    sed 's/\\/\\\\/g' | sed 's/\//\\\//g' | 
    # then escape all double quotes except for the last one, as
    # it will be the closing quote for the JSON object value.
    sed 's/"/\\"/g' | sed 's/\\"$/"/g')"

  # If it is the first line of the Greek lexicon data,
  # 1. Write the whole content variable into the Hebrew lexicon
  #    output file, and
  # 2. Overwrite the content variable with the Strong's numbers as a
  #    JSON object key with a preceding opening bracket
  # Else if it is the first line of the Hebrew lexicon data, append
  # the Strong's numbers as a JSON object key
  # Else, append the Strong's numbers as a JSON object key with a
  # preceding comma into the content variable
  if [[ "$line" =~ .*,G1,.* ]]; then
    contents+='}'
    echo $contents >> ${ofn[0]}
    echo $'\n> Converting the Greek lexicon.\n'
    contents='{"'$word'":"'
  elif [[ "$line" =~ .*,H1,.* ]]; then
    contents+='"'$word'":"'
  else
    contents+=',"'$word'":"'
  fi

  # If the lexicon entry ends with a double quote, append it as it is
  # Else, append a double quote to the end of it first
  if [[ $data =~ .*\"$ ]]; then
    contents+=$data
  else
    contents+=$data'"'
  fi

done < ${sfn[1]}


# -------
echo $'\n> Converting the CSV of the lexicon details into a README
  file.\n'

# Read every line of the lexicon details file >> ${sfn[0]} and append
# the converted data into a variable "contents"
contents=""
while read line; do

  # If it is an empty line, skip the iteration
  [ -z "$line" ] && continue

  # If it is the column name line (first line), skip the iteration
  if [[ "$line" =~ title,abbreviation.* ]]; then continue; fi

  # If it is the second line, append the relevant contents into the
  # README output file then skip the iteration
  if [[ "$line" =~ Strong,Strong,.* ]]; then
    echo $(echo $line | sed 's/.*","\(.*\)$/\1/') >> ${ofn[2]}
    continue
  fi

  # If it ends with a double quote (which means its the last line,
  # remove the double quote first before appending into the README
  # output file
  if [[ "$line" =~ .*\"$ ]]; then
    echo $(echo $line | sed 's/\(.*\)"$/\1/') >> ${ofn[2]}
    continue
  fi

  # Append whole lines into the README output file
  echo $line >> ${ofn[2]}

done < ${sfn[0]}


# -------
echo $'\n> Cleaning source tree, check the contents of ./'$dir$'/.\n'

# Remove the source files
rm -rf ${sfn[*]}
