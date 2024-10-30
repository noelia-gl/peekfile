
if [[ -z $2 ]]; then X=3; else X=$2; fi

if [[ $(wc -l < $1) -le $((2 * $X)) ]]; then cat $1; else echo ===== Warning: The file $1 contains more than $((2 * $X)) lines; head -n $X $1; echo "..."; tail -n $X $1; fi

