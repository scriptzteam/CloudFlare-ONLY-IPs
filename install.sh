sudo apt-get install ipset
ipset create cf hash:net
#Now populate the set with CloudFlare IP ranges:
for x in $(curl https://www.cloudflare.com/ips-v4); do ipset add cf $x; done
#You can use the 'cf' set now in a iptables rule like so:
iptables -A INPUT -m set --match-set cf src -p tcp -m multiport --dports http,https -j ACCEPT
