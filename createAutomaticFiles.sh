#!/bin/bash

# Define the main folder name
read -p "deme el nombre de archivo: " main_folder

# Define capital letter name 
namefile=${main_folder^}
cssname=${main_folder^}

# Define type of file
jsfile="${main_folder^}.js"
cssfile="${main_folder^}.css"

# Create the main folder
mkdir "$main_folder"

# Check if the main folder was created successfully
if [ -d "$main_folder" ]; then
  echo "Main folder '$main_folder' created successfully."

  # Create the two subfolders within the main folder
  touch "$main_folder/$jsfile"
  touch "$main_folder/$cssfile"

  # Check if the subfolders were created successfully
  if [ -d "$main_folder/$jsfile" ] && [ -d "$main_folder/$cssfile" ]; then
    echo "Subfolders '$jsfile' and '$cssfile' created successfully."
  else
    echo "Failed to create subfolders."
  fi
else
  echo "Failed to create the main folder."
fi

# Define the content we want to add at js file 
content=$(cat <<EOF
import React from "react"
import "./$namefile.css"

function $namefile(){
  return(
    <div id="$main_folder"></div>
  )
}

export default $namefile
EOF
)

# Guarda el contenido en el archivo
echo "$content" > "./$main_folder/$jsfile"

# Define the content we want to add at js file 
contentIndex=$(cat <<EOF
import $namefile from './$namefile'

export {
  $namefile
}
EOF
)

# Guarda el contenido en el archivo index.js
echo "$contentIndex" > "./$main_folder/index.js"

echo "$(npx prettier . --write)"
