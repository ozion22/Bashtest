#!/bin/bash
echo "ready to do nothing?!"
read yn
echo "Well, I dont care!"
while true; do
    echo "File created!"
    touch donothing$num.txt
    let "num=num+1"
    echo "Does nothing" >> donothing$num.txt
    sleep 1
done