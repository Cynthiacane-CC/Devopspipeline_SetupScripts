# For script start by creating the IAM role (step 5) and the hosted DNS (step 7) using amazon console
# Step 1: create EC2 ubuntu instance: username is ubuntu and not ec2-user

#Step 2: install awscli2
apt install awscli -y

#Step 3: Install kubectl on ubuntu instance
 curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
 chmod +x ./kubectl
 sudo mv ./kubectl /usr/local/bin/kubectl

 # Step 4: Install kops on ubuntu instance
  curl -LO https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
 chmod +x kops-linux-amd64
 sudo mv kops-linux-amd64 /usr/local/bin/kops

 # Step 5: Create an IAM user/role with Route53, EC2, IAM and S3 full access
 #go to aws console and create a role

 #Step 6: Attach IAM role to ubuntu instance
 # apt install awscli: do this if awscli2 didn't install properly
aws configure
# enter us-east-1 for Default region name [None] and for everything else press enter

 # Step 7: Create a Route53 private hosted zone (you can create Public hosted zone if you have a domain)
 #go to console and look for route53
# Routeh53 --> hosted zones --> created private hosted zone  
# Domain Name: choose your own name #valaxy.net
# Type: Private hosted zone for Amzon VPC

# Step 8: create an S3 bucket
 #aws s3 mb s3://demo.k8s.valaxy.net #replace demo.k8.... w/ the hosted zone created above
aws s3 mb s3://cynthia-kube.net

#Step 9: Expose environment variable:
 #export KOPS_STATE_STORE=s3://demo.k8s.valaxy.net
export KOPS_STATE_STORE=s3://cynthia-kube.net

#Step10: Create sshkeys before creating cluster
 ssh-keygen

# Step 11: Create kubernetes cluster definitions on S3 bucket: check zone on aws console
#kops create cluster --cloud=aws --zones=ap-south-1b --name=demo.k8s.valaxy.net --dns-zone=valaxy.net --dns private 
kops create cluster --cloud=aws --zones=us-east-1c --name=cynthia-kube.net --dns-zone=cynthia-kube.net --dns private 

#Step 12: Create kubernetes cluser
#kops update cluster demo.k8s.valaxy.net --yes
kops update cluster cynthia-kube.net --yes
# keep this link handy you'll need it: ssh to the master: ssh -i ~/.ssh/id_rsa ubuntu@api.cynthia-kube.net. the script will generate the link for you.

# Step 13: Validate your cluster
kops validate cluster

# Step 14: To list nodes
kubectl get nodes

