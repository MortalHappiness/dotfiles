#!/usr/bin/env bash

script_path="$(dirname "$(readlink -f "$BASH_SOURCE[0]")")"
input_file="${1}"
extension="${input_file##*.}"
output_file="${input_file%.*}.mp4"

ffmpeg -y -i "${input_file}" -c:v libx264 -preset slow -crf 23 -c:a aac -b:a 128k "${output_file}"

if [ $? -eq 0 ]; then
    notify-send "Transform to MP4" "Successfully converted to MP4"
else
    notify-send "Transform to MP4" "Failed to convert video ${input_file} to MP4."
    exit 1
fi
