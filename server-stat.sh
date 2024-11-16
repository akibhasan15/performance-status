#!/bin/bash
echo "#############################----------CPU USAGE---------################################"
CPU=`top -bn1 | grep "%Cpu(s):" | awk '{print  100-$8}'`
#USED_MEMORY=`free -m | grep "Mem:" | awk '{ print ($3/$2)*100 }'`
#FREE_MEMORY=`free -m | grep "Mem:" | awk '{print ($7/$2)*100}'`
echo -e "Total_CPU_Usage:\t$CPU%" | column -t
#echo -e "Used_Memory:$USED_MEMORY%\tFree_Memory:$FREE_MEMORY%" | column -t
echo "#############################----------MEMORY USAGE---------################################"
free -m | grep -w "Mem:"|awk '{print "Total_Memory:" ($2/1000)"G" "\n" "Used:" ($3/1000)"G" "("($3/$2)*100"%"")""\n" "Free:" ($7/1000)"G" "("($7/$2)*100"%"")" }'

echo "#############################----------DISK USAGE---------################################"
df -h | grep -w '/' | sed  "s\G\ \g" | awk '{print "Total Disk:" $2"G" "\n" "Used:" $3"G" "(" ($3/$2)*100"%" ")" "\n" "Free:" $4"G" "(" ($4/$2)*100"%"")"}'

echo "#############################----------TOP 5 PROECESSES BY CPU USAGE---------################################"
# ANSI escape codes for colors and formatting
#WHITE_BG="\e[47m"    # White background
#BLACK_FG="\e[30m"    # Black text
#RESET="\e[0m"        # Reset formatting

# Print header with white background
#printf "${WHITE_BG}${BLACK_FG}%-7s %-8s %-4s %-4s %-7s %-7s %-7s %-2s %-5s %-5s %-8s %s${RESET}\n" \
#"PID" "USER" "PR" "NI" "VIRT" "RES" "SHR" "S" "%CPU" "%MEM" "TIME+" "COMMAND"
ps -eo pid,%cpu,comm --sort=-%cpu | head -n 6

echo "#############################----------TOP 5 PROECESSES BY MEMORY USAGE---------################################"
ps -eo pid,%mem,comm,rss --sort=-%mem | head -n 6 | awk 'NR==1{printf "%-8s %-8s %-20s %s\n", "PID", "%MEM", "COMMAND", "RAM"} NR>1{printf "%-8s %-8s %-20s %.3fMB\n", $1, $2, $3, $4/1024}'
