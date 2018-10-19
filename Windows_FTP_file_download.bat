@echo off

echo open 192.168.106.22> ftpmgetscript.txt

echo ganeshp>> ftpmgetscript.txt

echo bajaj123>> ftpmgetscript.txt

echo bi>> ftpmgetscript.txt

echo ha>> ftpmgetscript.txt

echo cd /ganeshp/>> ftpmgetscript.txt

echo lcd >> ftpmgetscript.txt

echo mget *>> ftpmgetscript.txt

echo bye>> ftpmgetscript.txt

ftp -i -s:ftpmgetscript.txt

del /F ftpmgetscript.txt

exit