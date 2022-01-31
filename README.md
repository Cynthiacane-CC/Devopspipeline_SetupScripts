# Devopspipeline_SetupScripts
---> Jenkins and tomcat: 
Git clone the repo to your computer then scp the scripts to your linux servers:
scp <locationScriptslocally+name> <Name@IP:location_linux_server> then it'll prompt you to enter password for linux server
b) cd where the scripts is and run command scp <filename> <Name@IP:location_linux_server> then it'll prompt you to enter password for linux server

---> KOPS
make sure you go on the aws console and you create the IAM roles (step 5) and the hosted private zone DNS (step 7) before running the script

---> For ansible server to ssh to other server:
1) create a user name and passwdor (pw) in ansible and the other server
2) go to /etc/ansible/ansible.cfg and comment out host_key_checking = False aka remove the hastag in front of the line
3) go to ssh config located /etc/ssh/sshd_config and uncomment the line “password authentification yes” and comment “password authentification no” 
then restart daemon: systemctl restart sshd
4) go to /etc/ansible/hosts and create a test group:
[test]
ansible_host=IP_Server_toSSH  ansible_ssh_user=<username> ansible_ssh_pass=<password> 
test if ansible can ssh: run ansible testserver -m ping
6) run a playbook: vim playbook.sh in /etc/ansible then run those 2 commands
2) go to the server you wanted to ssh into and check if the playbook ran successfully
ansible-playbook <nameofPlaybook> --syntax-check
ansible-playbook <nameofPlaybook> <Name_ServerGroup_toSSH>