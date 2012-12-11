FOLDER=../robert-zaremba.github.com.deploy
echo "deploy temp folder: $FOLDER"

if [ -d "$FOLDER" ]; then
	{ echo "ERROR: directory  $FOLDER  exists"; exit 1; }
fi
mkdir $FOLDER || { echo "ERROR: can't create  $FOLDER  directory"; exit 1; }
cp -r blog/html/* $FOLDER/
git co master
mv .git*  $FOLDER/
mv CNAME  $FOLDER/
mv params.json  $FOLDER/
mv .nojekyll  $FOLDER/

rm -rf *
rm -rf .*
mv $FOLDER/* ./
mv $FOLDER/.* ./
rmdir $FOLDER

