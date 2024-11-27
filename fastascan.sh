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

