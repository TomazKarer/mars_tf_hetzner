ip=$(terraform output -raw instance_ip_addr)
echo $ip
ssh root@$ip -i ../secrets/id_rsa.mars.hetzner
