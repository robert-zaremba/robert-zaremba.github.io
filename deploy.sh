echo -e "REMEMBER to run tinkerer -b before\npress to continue..."
read

usage="Usage: '[-amend] ['commit message']"

if [[ $1 == *"-h"* ]]; then
	echo $usage; exit 100
fi

# if [ $(git diff | wc -l) -ne  0 ] ; then
#     echo "ERROR: commit changes first"; exit 1;
# fi

usage="Wrong arguments. $usage"
amend=false
if [[ $1 == *"-amend"* ]]; then
	echo "AMENDING"
	amend=true
fi
if $amend; then
	case $# in
		1) ;;
		2) msg="${@: -1}";;
		*) echo $usage; exit 10;;
	esac;
else
	case $# in
		0) ;;
		1) msg="${@: -1}";;
		*) echo $usage; exit 10;;
	esac;
fi



git add -A
if $amend; then
	if [[ -z $msg ]]; then git ci -a --amend || exit 1
	else git ci -a --amend -m "$msg" || exit 1
	fi
else
	if [[ -z $msg ]]; then git ci -a || exit 1
	else git ci -a -m "$msg" || exit 1
	fi
fi

FOLDER=../robert-zaremba.github.com.deploy
echo "deploy temp folder: $FOLDER"

if [ -d "$FOLDER" ]; then
	echo "ERROR: directory  $FOLDER  exists"; exit 1;
fi
mv blog/html $FOLDER || { echo "can't move blog to $FOLDER"; exit 2; }
rm -rf blog
git co master  || { echo "can't checkout to master"; exit 3; }
mv .git*  $FOLDER/
mv CNAME  $FOLDER/
mv params.json  $FOLDER/
mv .nojekyll  $FOLDER/

rm -rf *
rm -rf .*
mv $FOLDER/* ./
mv $FOLDER/.* ./
rmdir $FOLDER
git add -A
git add -A
if $amend; then
	if [[ -z $msg ]]; then git ci -a --amend || exit 1
	else git ci -a --amend -m "$msg" || exit 1
	fi
else
	if [[ -z $msg ]]; then git ci -a || exit 1
	else git ci -a -m "$msg" || exit 1
	fi
fi

if $amend; then
	git push -f
else
	git push
fi
git co source
