#!/bin/bash

check_ffmpeg() {
    if ! command -v ffmpeg &> /dev/null
    then
        echo "ffmpeg could not be found."
        echo "To install ffmpeg, follow these instructions:"
        echo "For Debian/Ubuntu: sudo apt update && sudo apt install ffmpeg"
        echo "For Fedora: sudo dnf install ffmpeg"
        echo "For macOS with Homebrew: brew install ffmpeg"
        echo "Please install ffmpeg and run this script again."
        exit 1
    fi
}

check_ffmpeg

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <audio_file> <subdivisions_file>"
    exit 1
fi

source="$1"
subdivisions_file="$2"

if [ ! -e "$subdivisions_file" ]; then
    echo "The subdivisions file '$subdivisions_file' does not exist."
    exit 1
fi

start_times=()
end_times=()
titles=()

while IFS= read -r line
do
    if [ -z "$line" ]; then
        continue
    fi
    t0=$(echo "$line" | awk '{print $1}')
    t1=$(echo "$line" | awk '{print $2}')
    title=$(echo "$line" | cut -d ' ' -f 3-)
    start_times+=("$t0")
    end_times+=("$t1")
    titles+=("$title")
done < "$subdivisions_file"

for ((i = 0; i < ${#start_times[@]}; i++)); do
    title=${titles[i]}
    t0=${start_times[i]}
    t1=${end_times[i]}
    echo "-----------------------------------------"
    echo "Title: $title"
    echo "Start: $t0"
    echo "End: $t1"
    echo "-----------------------------------------"
    
    ffmpeg -i "$source" -acodec copy -ss "$t0" -to "$t1" "$title"
done
