file=$1

count=$(wc -l < $file)

if [[ $count -eq 0 ]]; then echo The file $file has 0 lines; elif [[ $count -eq 1 ]]; then echo The file $file has 1 line; else echo The file $file has $count lines; fi
