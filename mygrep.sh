#!/bin/bash

showLineNum=false
invertMatch=false

in_red() {
    local wordInRed=$1
    printf '\033[31m%s\033[0m' "$wordInRed"
}

check_invalid_options() {
    for arg in "$@"; do
        if [[ $arg == -* ]]; then
            echo "Error: Invalid option '$arg' found after processing options."
            echo "Usage: ./mygrep.sh [OPTIONS] PATTERN [FILE...]"
            exit 1
        fi
    done
}

search_in_file() {
    local searchWord="$1"
    local fileName="$2"
    local lineNum=1

    while IFS= read -r line; do
        local foundMatch=false
        for word in $line; do
            if [[ ${word,,} == "${searchWord,,}" ]]; then
                foundMatch=true
                if [[ $invertMatch == true ]]; then
                    break
                fi

                if $showLineNum; then
                    echo "$lineNum: ${line//$word/$(in_red "$word")}"
                else
                    echo "${line//$word/$(in_red "$word")}"
                fi
                break
            fi
        done

        if [[ $invertMatch == true && $foundMatch == false ]]; then
            if $showLineNum; then
                echo "$lineNum: $line"
            else
                echo "$line"
            fi
        fi

        ((lineNum++))
    done < "$fileName"
}


while getopts ":nv" opt; do
  case ${opt} in
    n)
      showLineNum=true
      ;;
    v)
      invertMatch=true
      ;;
    ?)
      echo "Invalid options: -${OPTARG}."
      exit 1
      ;;
  esac
done

shift $((OPTIND - 1))
check_invalid_options "$@"

if [[ $# -gt 2 ]]; then
    echo "Too many arguments. Use the command as follows:
    ./mygrep.sh [OPTIONS] PATTERN [FILE...]"
    exit
elif [[ -z $1 ]]; then
    echo "You need to specify a search word"
    exit
elif [[ -z $2 ]]; then
    echo "File not specified. Do you want to search the whole directory? [y/N]"
    read -r response
    if [[ ${response,,} == "y" ]]; then
        for file in *; do
            if [[ $file == "mygrep.sh" ]]; then
                continue
            fi
            if [[ -f $file ]]; then
                echo "Searching in file: $file"
                search_in_file "$1" "$file"
            fi
        done
    else
        echo "Operation canceled."
        exit
    fi
elif [[ ! -e $2 ]]; then
    echo "File $2 does not exist."
    exit 

else
    search_in_file "$1" "$2"
fi


