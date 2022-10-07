#!/bin/bash
(clear)
#extrauppgift
#speed(t+1)=v(1)+(0.1F-1.5)=
#altitude(t+1)=h(1)+v(1)+(0.1F-1.5)/2
speed=-25
altitude=250
sec=0
fuel=500
echo -e "\n--------Lunar descent challenge--------\nYou will plot a lunar descent the last 250m.\nEach turn represents a 1-second decent time"
echo "Set the throttle for each turn (0-100)"
echo -e "\nTime \tAltitude \tVelocity \tFuel \tThrottle"
while true; do
        if (($(echo "$altitude" | awk '{print($1<0)}'))); then
                if (($(echo "$speed" | awk '{print($1<0)}'))); then
                        if (($(echo "$speed" | awk '{print($1>-2)}'))); then
                                echo "You did it!, You landed with a Velocity of $speed"
                                exit
                        else
                                echo "You crashed :("
                                exit
                        fi
                fi
        else
                read -r -p "$sec    $altitude                 $speed             $fuel       " F
                ((sec += +1))
                ((fuel -= F))
                altitude=$(echo "$altitude+$speed+(0.1*$F-1.5)/2" | bc)
                speed=$(echo "$speed+(0.1*$F-1.5)" | bc)
        fi
done
