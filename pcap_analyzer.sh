#This script uses tshark, the command-line version of Wireshark, to automate the extraction of key information from a .pcap file. 

#!/bin/bash

# A script to automate the analysis of a .pcap file using tshark.

# Check if a pcap file is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <path_to_pcap_file>"
    exit 1
fi

PCAP_FILE=$1
echo "--- Analyzing PCAP File: $PCAP_FILE ---"

# --- Analysis 1: Extract DNS Queries ---
echo ""
echo " Extracting DNS Queries..."
tshark -r "$PCAP_FILE" -Y "dns.flags.query == 1" -T fields -e frame.number -e ip.src -e ip.dst -e dns.qry.name
echo ""

# --- Analysis 2: Extract DNS Responses with IPv4 Answers ---
echo " Extracting DNS IPv4 Responses..."
tshark -r "$PCAP_FILE" -Y "dns.flags.response == 1 && dns.a" -T fields -e frame.number -e ip.src -e dns.qry.name -e dns.a
echo ""

# --- Analysis 3: List TCP Conversations (HTTP) ---
echo " Listing TCP Conversations on Port 80 (HTTP)..."
tshark -r "$PCAP_FILE" -Y "tcp.port == 80" -q -z conv,tcp
echo ""

echo "--- Analysis Complete ---"
