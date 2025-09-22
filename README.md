# Network Forensics with Wireshark: A Packet-Level Investigation

This project replicates a core Security Operations Center (SOC) workflow: performing a full packet capture investigation to dissect network traffic and identify user activity. Using Wireshark, I analyzed a `.pcap` file to trace a web browsing session from the initial DNS request to the final TCP data transfer, demonstrating foundational skills in network forensics and protocol analysis.

---
## The Investigation: From Domain Name to Data Stream

The analysis followed the logical flow of a standard web request. By applying specific display filters in Wireshark, I was able to isolate each stage of the communication.

### Step 1: The DNS Query (The "Question")
The first step in any web browsing session is resolving a domain name to an IP address. By applying the display filter `udp.port == 53`, I isolated all DNS traffic. The packet below captures the initial request from the client.

**Analysis:** By dissecting the packet details, we can see the client (`172.21.224.2`) sending a standard query to the DNS server (`169.254.169.254`), asking for the IP address of `opensource.google.com`.

<img src="./assets/DNS query to opensource.jpg" width="800" alt="Wireshark screenshot showing a DNS query packet">
*<p align="center">Figure 1: The initial DNS query for opensource.google.com.</p>*

### Step 2: The DNS Response (The "Answer")
The DNS server responds to the query with the IP address(es) associated with the requested domain. This response packet provides the client with the necessary information to initiate a direct connection.

**Analysis:** The "Answers" section within the packet details is the most critical part. It clearly shows that `opensource.google.com` resolves to multiple IP addresses, including `142.250.1.139`. The client can now proceed to establish a TCP connection with this server.

<img src="./assets/UDP Resolution.jpg" width="800" alt="Wireshark screenshot showing a DNS response packet with answers">
*<p align="center">Figure 2: The DNS response providing the IP addresses for the requested domain.</p>*

### Step 3: The TCP Connection (The "Conversation")
With the server's IP address known, the client initiates a TCP connection on port 80 (HTTP) to begin the process of requesting and receiving web page data. Filtering for `tcp.port == 80` reveals this traffic.

**Analysis:** This TCP packet, identified by its `[PSH, ACK]` flags, represents part of the active data transfer between the client and the web server. Examining the IPv4 and TCP headers allows for a deep-dive analysis of source/destination IPs and ports, sequence numbers, and other protocol-specific details, confirming the successful connection established after the DNS lookup.

<img src="./assets/TCP Result.jpg" width="800" alt="Wireshark screenshot showing a TCP packet for an HTTP session">
*<p align="center">Figure 3: A TCP packet from the subsequent HTTP session on port 80.</p>*

---
## 🚀 Skills & Technologies Demonstrated

* **Network Forensics:** Analyzing packet captures (`.pcap`) to reconstruct network events and investigate activity.
* **Wireshark Proficiency:** Advanced usage of display filters, protocol hierarchy statistics, and packet dissection techniques.
* **Protocol Analysis:** In-depth understanding of the TCP/IP suite, including the relationship and function of DNS (UDP), TCP, and IPv4.
* **Packet Dissection:** Extracting key data points from packet layers, including IPs, MAC addresses, ports, flags, and TTL values.
* **SOC & Incident Response:** Applying foundational skills used by SOC analysts for network monitoring and incident investigation.
