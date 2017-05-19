# Copy template to specified folder

FOLDER_NAME=$1

if [[ $FOLDER_NAME == '' ]]; then
	echo "Need to specify a folder name where to copy template files"
else
	cp Makefile $FOLDER_NAME/
	cp citations.bib $FOLDER_NAME/
fi