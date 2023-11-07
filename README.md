# thesis-terraform
A cluster létrehozásához szükséges terraform források találhatóak a repositoryban.

### Create plan
```
terraform plan -var "do_token=${DO_PAT}" -var "pvt_key=$HOME/.ssh/id_rsa"
```

### Apply plan
```
terraform apply -var "do_token=${DO_PAT}" -var "pvt_key=$HOME/.ssh/id_rsa"
```


###  Destroy Plan

```
terraform plan -destroy -out=terraform.tfplan -var "do_token=${DO_PAT}" -var "pvt_key=$HOME/.ssh/id_rsa"

terraform apply terraform.tfplan
```
