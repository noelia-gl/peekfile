#!/usr/bin/env bash

# Check if the folder $1 exists, is executable and readable. The default folder is the current folder (.)
if [[ -d $1 && -r $1 && -x $1 ]]; then
    X=$1
else
    X=.
fi

# The default number of lines N is 0
if [[ -z $2 ]]; then
    N=0
else
    N=$2
fi

# Number of fasta/fa files in folder X
FA_N=$(find "$X" -type f \( -name "*.fasta" -o -name "*.fa" \) | wc -l)
if [[ $FA_N -eq 0 ]]; then 
    echo "No fasta files in folder $X"
    exit 1
else 
    echo "There are $FA_N fasta files in folder $X"
fi

# Number of unique fasta IDs in total
FA=$(find "$X" -type f \( -name "*.fasta" -o -name "*.fa" \))
ID_uniq=$(awk '/^>/{print $1}' $FA | sort | uniq | wc -l)
if [[ $ID_uniq -eq 0 ]]; then 
    echo "No unique fasta IDs found"
else 
    echo "There are $ID_uniq unique IDs in folder $X"
fi

# Report of fasta/fa files
for i in $FA; do 
    echo "==== Report of file: $i ===="
    
    # Check if the file is a symbolic link
    if [[ -h $i ]]; then
        echo "The file is a symbolic link"
    else 
        echo "The file is NOT a symbolic link"
    fi
    
    # Check if the file is not empty
    if [[ -s $i ]]; then
        # Number of sequences inside each file
        SEQ=$(grep -c "^>" "$i")
        if [[ $SEQ -eq 1 ]]; then
            echo "There is 1 sequence inside"
        else 
            echo "There are $SEQ sequences inside"
        fi
        
        # Total sequence length
        TOTAL_LENGTH=$(awk '!/^>/{gsub(/[^A-Za-z]/, ""); total += length($0)} END{print total}' "$i")
        echo "Total sequence length: $TOTAL_LENGTH"
        
        # Sequence type depending on content
        if grep -v "^>" "$i" | grep -q "[^ACTGNactgn]"; then
            seq_type="Amino acid sequence"
        else 
            seq_type="Nucleotide sequence"
        fi
        echo "Sequence type: $seq_type"
    else 
        echo "File is empty: NO sequences inside"
    fi
    
    # Display full content or summarized content
    if [[ $N -eq 0 ]]; then
        echo "Skip display content because number of lines is 0"
    elif [[ $(wc -l < "$i") -le $((2 * $N)) ]]; then
        echo "Full file content:"
        cat "$i"
    else 
        echo "File content (first $N and last $N lines):"
        head -n $N "$i"
        echo "..."
        tail -n $N "$i"
    fi
    
done

