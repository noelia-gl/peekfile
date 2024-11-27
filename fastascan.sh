#! 

# The default folder X is current folder 
if [[ -d $1 ]]; then X=$1; else X=.; fi

# The default number of lines N is 0
if [[ -z $2 ]]; then N=0; else N=$2; fi

# Number of fasta/fa files in folder X
FA_N=$(find $1 -name "*.fasta" -or -name "*.fa" | wc -l)
echo There are $FA_N fasta files in folder $1 

# Number of unique fasta ID in total 
FA=$(find $1 -name "*.fasta" -or -name "*.fa")
ID_uniq=$(awk '/>/{print $1}' $FA | sort | uniq | wc -l)
echo There are $ID_uniq uniq ID in folder $1

# Report of fasta/fa files 
for i in $FA
	do echo ==== Report of file $i: ====
		# Check if the file is a symbolic link 
		if [[ -h $i ]]; then echo The file $i is a symbolic link
		else echo The file $i is NOT a symbolic link
		fi 	
	# Number of sequences inside each file
	SEQ=$(grep -c ">" $i)
		if [[ $SEQ -eq 0 ]]
		then echo There are NOT sequences inside
		elif [[ $SEQ -eq 1 ]]
		then echo There is 1 sequence inside
		else echo There are $SEQ sequences inside 
		fi
	done


