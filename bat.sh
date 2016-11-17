#!/bin/sh
while true; do
    battery1=$(upower -i $(upower -e | grep BAT0) | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//)
    battery2=$(upower -i $(upower -e | grep BAT1) | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//)

    battery1CurrentEnergy=$(upower -i $(upower -e | grep BAT1) | grep --color=never -E energy|xargs|cut -d' ' -f2|sed s/%//)
    battery2CurrentEnergy=$(upower -i $(upower -e | grep BAT0) | grep --color=never -E energy|xargs|cut -d' ' -f2|sed s/%//)

    battery1FullEnergy=$(upower -i $(upower -e | grep BAT1) | grep --color=never -E energy-full|xargs|cut -d' ' -f2|sed s/%//)
    battery2FullEnergy=$(upower -i $(upower -e | grep BAT0) | grep --color=never -E energy-full|xargs|cut -d' ' -f2|sed s/%//)
    state1=$(upower -i $(upower -e | grep BAT0) | grep --color=never -E state|xargs|cut -d' ' -f2)
    state2=$(upower -i $(upower -e | grep BAT1) | grep --color=never -E state|xargs|cut -d' ' -f2)


    fuck=$(echo "scale=2;100*($battery1CurrentEnergy+$battery2CurrentEnergy)/($battery1FullEnergy+$battery2FullEnergy)" | bc)
    threshold=10;

    flag=0
    state="charging"
    if [ "$state2" == "discharging" ]; then
        flag=1;
        state="discharging"
    fi

    if [ "$state1" == "discharging" ]; then
        flag=1;
        state="discharging"
    fi 
    comparison=$(echo "scale=2;$fuck>$threshold" | bc)
    echo $(date +"[%T | %Y/%m/%d] Battery Level : $fuck % | $state")
    if (((flag==1)&&(comparison==0)));then 
        echo $(date +"[%T | %Y/%m/%d] Battery Level : $fuck % | $state - Suspending Now")
        state="charging"
        state1="charging"
        state2="charging"
        comparison = 1
        systemctl suspend
    fi 
    sleep 10;
done
