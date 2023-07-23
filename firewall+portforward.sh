#!/bin/bash
# If you use Oracle Cloud or stuff you might want to do this!
# Allow incoming traffic on ports 8081, 25565, and 25577 using ufw.
sudo ufw allow 8081/tcp
sudo ufw allow 25565/tcp
sudo ufw allow 25577/tcp

# Forward incoming traffic on port 8081 to port 80 on the local machine.
sudo iptables -t nat -A PREROUTING -p tcp --dport 8081 -j REDIRECT --to-port 80

# Forward incoming traffic on ports 25565 and 25577 to the Minecraft server on the local machine.
sudo iptables -t nat -A PREROUTING -p tcp --dport 25565 -j DNAT --to-destination <local-ip>:25565
sudo iptables -t nat -A PREROUTING -p tcp --dport 25577 -j DNAT --to-destination <local-ip>:25577

# Save the iptables rules.
sudo iptables-save > /etc/iptables/rules.v4
