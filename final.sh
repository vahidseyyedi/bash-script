#!/bin/bash

days=7
size=1000
log_file="scriptlog"
timestamp=""
backup_file=""
exist=0
function check_address() {
    if [ -e "$1" ]; then
        echo 1
    else
        echo 0
    fi
}

function print_line() {
    > "$1/$log_file"
    for file in "$1"/*; do
        if [ -f "$file" ] && [[ "$(basename "$file")" != "$log_file" ]] && [[ "$(basename "$file")" != "$log_file.bak_"* ]]; then
            line_count=$(wc -l < "$file")
            echo "File: $file - Lines: $line_count"
            echo "File: $file - Lines: $line_count" >> "$1/$log_file"
        fi
    done 

    for file in "$1"/*; do
        if [ -d "$file" ]; then
            print_line "$file"
        fi
    done 
}

function check_days() {
    echo "*********************************************"
    echo "Find files modified in the last $2 days in $1"

    find "$1" -maxdepth 1 -type f -mtime -$2 ! -name "$log_file" ! -name "$log_file.bak_*" | while IFS= read -r file; do
        echo "File: $file - Last Modified: $(stat -c %y "$file")"
        echo "File: $file - Last Modified: $(stat -c %y "$file")" >> "$1/$log_file"
    done

    for file in "$1"/*; do
        if [ -d "$file" ]; then
            check_days "$file" "$2"
        fi
    done 

}

function check_size() {
    echo "Find file larger than $2 bytes in $1"

    for file in "$1"/*; do
        if [ -f "$file" ] && [[ "$(basename "$file")" != "$log_file" ]] && [[ "$(basename "$file")" != "$log_file.bak_"* ]]; then
            si=$(stat -c %s "$file")
            if [ "$2" -lt "$si" ]; then
                echo "File: $file - Size: $si"
                echo "File: $file - Size: $si" >> "$1/$log_file"
            fi
        fi
    done 

    for file in "$1"/*; do
        if [ -d "$file" ]; then
            check_size "$file" "$2"
        fi
    done 
}

function backup_log() {
   
    if [ -e "$1/$log_file" ]; then
    sed -i '/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/,/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/d' "$1/$log_file"
    
    timestamp=$(date +"%Y%m%d%H%M%S")
    backup_file="$1/$log_file.bak_$timestamp"
    cp "$1/$log_file" "$backup_file"
    echo "Backup of the log file created: $backup_file"
    exist=1

     for dir in "$1"/*; do
        if [ -d "$dir" ]; then
            backup_log "$dir"
        fi
    done

fi
}

function check_change() {
    if [ -e "$1/$log_file" ]; then
        local backup_file_path="$1/$log_file.bak_$timestamp"
        if [ -e "$backup_file_path" ]; then
            if ! diff "$backup_file_path" "$1/$log_file" > /dev/null; then
                echo "******************************************" >> "$1/$log_file"
                diff "$backup_file_path" "$1/$log_file" >> "$1/$log_file"
                echo "******************************************" >> "$1/$log_file"
            fi
        else
            echo "No backup file found for comparison in $1"
        fi
    fi

    for dir in "$1"/*; do
        if [ -d "$dir" ]; then
            check_change "$dir"
        fi
    done
}



if [ $# -lt 1 ] || [ $# -gt 3 ]; then
    echo "Please enter between 1 and 3 parameters."
    exit 1
fi

x=$(check_address "$1")
backup_log "$1"
if [ $x -eq 1 ]; then
 
    print_line "$1"
else
    echo "Invalid address: $1"
    exit 1
fi

if [ -z "$2" ]; then
    check_size "$1" $size
else
    if [[ "$2" =~ ^[0-9]+$ ]]; then
        check_size "$1" "$2"
    else
        echo "Parameter number 2 is invalid"
        exit 1
    fi
fi

if [ -z "$3" ]; then
    check_days "$1" $days
    check_change "$1"
else
    if [[ "$3" =~ ^[0-9]+$ ]]; then
        check_days "$1" "$3"
        check_change "$1"
    else
        echo "Parameter number 3 is invalid"
        exit 1
    fi
fi
