#! 

# The default folder X is current folder 
if [[ -d $1 ]]; then X=$1; else X=.; fi

# The default number of lines N is 0
if [[ -z $2 ]]; then N=0; else N=$2; fi

# Number of fasta/fa files in folder X
FA_N=$(find $1 -name "*.fasta" -or -name "*.fa" | wc -l)
echo There are $FA_N fasta files in folder $1 

# Number of unique fasta ID in total 
FA=$(find $1 -type f -name "*.fasta" -or -name "*.fa")
ID_uniq=$(awk '/>/{print $1}' $FA | sort | uniq | wc -l)
echo There are $ID_uniq uniq ID in folder $1

# Report of fasta/fa files 
for i in $FA
	do echo ==== Report of file: $i ====
		# Check if the file is a symbolic link 
		if [[ -h $i ]]
			then echo The file is a symbolic link
		else echo The file is NOT a symbolic link
		fi 
	# Check if the files are not empty 
	if [[ -s $i ]]  
		# Number of sequences inside each file
		then SEQ=$(grep -c ">" $i)
		if [[ $SEQ -eq 1 ]]
			then echo There is 1 sequence inside
			else echo There are $SEQ sequences inside 
		fi
		# Total sequence length 
		awk '!/>/{gsub(/[^A-Za-z]/, "") ##only counts for the sequence itself
		total_length += length($0)}
		END{print "Total sequence length: " total_length}' $i
	else echo File is empty: NO sequences inside
	fi
	# Display full content 
	if [[ $N -eq 0 ]]; 
		# If $N is 0, skip this part
		then echo Skip display content because number of lines is 0	
	elif [[ $(wc -l < $i) -le $((2 * $N)) ]]
		# If file has 2*$N lines or less, display full content
		then echo Full file content: 
		cat $i
	else 
		# If file has more than 2*$N lines, only display first and last $N lines
		echo "File content (first $N and last $N lines)"
		head -n $N $i 
		echo "..."
		tail -n $N $i 
	fi
done


