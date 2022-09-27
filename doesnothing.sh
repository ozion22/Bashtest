#!/bin/bash
echo "ready to do nothing?!"
echo "Well, I dont care!"
while true; do
    echo "File created!"
    touch donothing"$num".txt
    echo "Does nothing" >> donothing"$num".txt
    ((num=num+1))
    sleep 2s
done
