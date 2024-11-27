#! 

# The default folder X is current folder 
if [[ $1 -d ]]; then X=.; else X=$1; fi

# The default number of lines N is 0
if [[ -z $2 ]]; then N=0; else N=$2; fi

# Number of fasta/fa files in folder X
FA=$(find . -name "*.fasta" -or -name "*.fa" | wc -l)
echo There are $FA files in $1 

# Number of unique fasta ID in total 
awk '/>/{print $1}' $FA | sort | uniq | wc -l


