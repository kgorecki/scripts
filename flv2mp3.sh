#!/usr/bin/env bash
for FILE in *.flv
do
    echo -ne "Converting $FILE... "
    avconv -i "$FILE" -acodec libmp3lame "${FILE%.*}.mp3" -loglevel error
    echo done
done

