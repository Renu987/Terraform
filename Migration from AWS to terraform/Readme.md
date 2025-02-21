## How to Migrate an AWS existing resource to Terraform using "terraform import"

Create a folder --main.tf -- 

```
terraform init
terraform plan -generate-config-out=generate_result.tf

````

A file will be created in your folder with thee name generate_result.tf

Copy the content in that file and delete the file

Now go to main.tf and replace the import block with the copied content

```
terraform plan
````

Still not fixed it will create a new resource instead of migration (showing 1 to add)

```
terraform import aws_instnace.example id # id of your ec2 instance
terraform plan
```

Now it will create a statefile for you in the folder and when you use tf plan it will show no infra changes

Hence your ec2 instance is migrated now to terraform
