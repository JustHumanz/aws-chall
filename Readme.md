### Terra form berisi soal 1
how to use   
```
cd terra
export AWS_SECRET_ACCESS_KEY="blablabla"
export AWS_ACCESS_KEY_ID="blablablabla"
terraform init
terraform plan
terraform apply
```


### CICD
let's assume the EC2 already installed/running docker service and gitlab runner  
and for this case i use `Docker socket binding` to build image  
How to use  
```
fist is export the EC2 priv key and name it as SSH KEY after that export variable with name IPADDR witch IPADDR contains IP address of EC2
```