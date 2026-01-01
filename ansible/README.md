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

## TODO

1. Move away from www-data running nextcloud
2. Switch to PHP-FPM
3. Switch to PostgreSQL
4. Configgure forgejo
5. Configure automatic Let's Encrypt Certbot renewal
6. Fix NextCloud warning from Admin page
7. I want a wiki
8. I want a debian repo
9. I want a CCTV control
10. I doubt certbot will properly replace certificate when I add more domains.