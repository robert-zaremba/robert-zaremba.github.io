syntax="Wrong arguments. Syntax: '[-amend] ['commit message']"

amend=false
if [[ $1 == *"-amend"* ]]; then
	echo "AMENDING"
	amend=true
fi

if $amend; then echo "yes - amending"; fi

if $amend; then
	case $# in
		1) ;;
		2) msg="${@: -1}";;
		*) echo $syntax; exit 10;;
	esac;
else
	case $# in
		0) ;;
		1) msg="${@: -1}";;
		*) echo $syntax; exit 10;;
	esac;
fi

echo "num of args: $#, msg=$msg; amend=$amend"
