#!/bin/bash

# Check if the input file is provided
if [ -z "$1" ]; then
  echo "Usage: $0 input_file.mapped.v"
  exit 1
fi

input_file=$1

# Extract NAME from "NAME.mapped.v"
if [[ $input_file =~ ^(.+)\.mapped\.v$ ]]; then
  name="${BASH_REMATCH[1]}"
  output_file="${name}.pg.mapped.v"
else
  echo "Error: Input file should follow the format NAME.mapped.v"
  exit 1
fi

# A flag to track if we're processing a multi-line module declaration
in_multiline_module=false

# Read the input file line by line
while IFS= read -r line || [[ -n "$line" ]]; do
  # Check if the line starts with "module" and ends with ");"
  if [[ $line =~ ^module.*\)\;$ ]]; then
    # Replace the ending and add VDD, VSS in the module declaration
    echo "${line%);} , VDD, VSS);"
    echo "inout VDD, VSS;"

  # Check if the line starts with "module" but does not end with ");"
  elif [[ $line =~ ^module.*\($ ]]; then
    # Start tracking a multi-line module declaration
    in_multiline_module=true
    echo "$line"

  # Check if we're in a multi-line module declaration and this line ends with ");"
  elif $in_multiline_module && [[ $line =~ \)\;$ ]]; then
    # Complete the module declaration with VDD, VSS
    in_multiline_module=false
    echo "${line%);} , VDD, VSS);"
    echo "inout VDD, VSS;"

  # Check if the line ends with ");" but not starting with "module"
  elif [[ $line =~ \)\;$ ]]; then
    # Replace the ending
    echo "${line%);} , .VDD(VDD), .VSS(VSS) );"

  else
    # Print the line as is
    echo "$line"
  fi
done < "$input_file" > "$output_file"

echo "Modified file created as $output_file"

