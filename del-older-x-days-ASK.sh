#!/bin/bash

# Note: Before deleting a file or directory, it needs to confirm the deletion. If no days inputed, will use 7 days as default.
# Using: bash del-older-x-days-ASK.sh /home/destination 7
# (It keeps the files and directories of the last 7 days and deletes the others.)

if [ $# -eq 0 ]; then
echo "`basename $0` "
echo "Script will delete file folders older than inside "
echo "If no days inputed, will use 7 days as default"
fi

DIR=$1
#check if user input days
if [ x"$2" = "x" ]; then
#if user didn't input days, we will use default value
DAYS="7"
else
DAYS="$2"
fi

#this will create list of folders older that X days. We use command find to find them, and set maxdepth
# to 1, we don't need recursively find all folders
dirlist=`find $DIR -maxdepth 1 -type d -mtime +$DAYS`
#now we will process each folder
for dir in ${dirlist}
do
#this will check if user have read and write permissions
if [ ! -r ${dir} -o ! -w ${dir} ]; then
#if no permissions just warn, without try to delete
echo "Access denied to folder ${dir}"
else
#if we have permissions – we ask user if really delete
read -p "Delete folder ${dir} and all subfolders? [y/n]" confirm
#check if user confirm deleting
if [ "$confirm" = "y" ]; then
#if user confirm – rm command to delete
rm -rf ${dir}
fi
fi
done
#same as with directories we do with files
#we get list
filelist=`find $DIR -maxdepth 1 -type f -mtime +$DAYS`
#proceed with every file
for file in ${filelist}
do
#we check permissions
if [ ! -r "${file}" -o ! -w "${file}" ]; then
echo "Access denied to file ${file}"
else
#if we have permissions we ask about confirmation
read -p "Delete file ${file}? [y/n]" confirm
if [ "$confirm" = "y" ]; then
#if confirmed – we delete file.
rm -rf ${file}
fi
fi
done
