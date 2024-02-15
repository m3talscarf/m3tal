#!/bin/bash

# Writes to text file ipout all ips connect to the device

arp -a | awk '{print $2}' | sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 | cat > ipout.txt

# For Testing
#echo "(192.168.1.2)" | cat > ipout.txt 

# Define the list of good IP addresses
good_ips=("(192.168.1.1)" "(192.168.1.2)" "(192.168.1.3)" "(192.168.1.4)" "(192.168.1.5)" "(192.168.1.6)" "(192.168.1.7)")

# Define a function to check if an IP address is in the list of good IPs
is_good_ip() {
    local ip=$1
    for good_ip in "${good_ips[@]}"; do
        if [ "$ip" = "$good_ip" ]; then
            return 0  # IP address is in the list of good IPs
        fi
    done
    return 1  # IP address is not in the list of good IPs
}

# Read each IP address from the list of random IPs and check if it's a good IP

while read -r ip; do
    if is_good_ip "$ip"; then
        echo "$ip"
    else
        echo "$ip x"
        echo "$ip" | cat > unknownips.txt
    fi
done < "ipout.txt"

ip_file="unknownips.txt"
