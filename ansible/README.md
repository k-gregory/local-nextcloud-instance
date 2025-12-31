Add password to `./vault_pass`
If running from `ansible` dir(where this file is located) it should work. 

If you're running `ansible-playbook ...` from other directory, `.vault_pass` will not be found and you should expect weird error, 
e.g.:
```
[ERROR]: Error reading `vars_files` file '/home/gregory/Documents/System administration/local-nextcloud-instance/ansible/vars/secrets.yml': Attempting to decrypt but no vault secrets found.
```
You can make it work by launching playbook with explicit vault password location:
```
ANSIBLE_VAULT_PASSWORD_FILE=./ansible/.vault_pass ansible-playbook -i ansible/inventory/local-vm ansible/setup-webfronts.yml
```