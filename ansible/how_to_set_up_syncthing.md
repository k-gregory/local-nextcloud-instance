## Set up remote Syncthing blackbox.

A **blackbox** is a server running Syncthing on an untrusted OS.
Trusted devices use end-to-end encryption(E2EE) before uploading syncthing into a blackbox.

Then, blackbox acts as a relay and allows to transfer and synchronize files between trusted machines that share an E2EE key.
Even if machine is a 

ansible-playbook -i inventory/local-vm setup-syncthing-blackbox.yml