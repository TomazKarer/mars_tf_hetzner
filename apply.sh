source ./scripts/secrets.sh

terraform apply
(
  cd ./ansible

  ansible-playbook playbook.yml -i ./inventory/hosts.cfg -u root --p ../../secrets/id_rsa.mars.hetzner

  cd ..
)
