## Using Terraform in Codepipeline for creating resources in AWS and destroying on approval

# Prerequisites: 
1) First create the scripts and keep in the github repository
2) Create S3 bucket and dynamodb table for backend statefiles configuaration
   

Go to AWS management console and open the service code build

Create a project in code build using buildspec.yml and github as source (https://github.com/Renu987/Terraform)

Role ( give resource full access like ec2 full access and s3 full access+ CloudWatchLogsFullAccess/adminstarotor access)

once it is success create a pipeline in codepipeline adding code build stage

Edit the pipeline and Add approval stage in pipeline (manual approval)

Add other stage for terraform destroy using code build as provider using buildspec file for destry

use the same role for both build stages as it has required policies attached

## AWS Code Pipeline:

```
Source Provider : GITHUB
Repo URL : Renu987/Terraform
Branch : main
Other providers ---> Codebuild --> Provisioned codebuild project
Create pipeline ----> Edit pipeline ---> Add stage after build stage
Name : Approval stage ---> add action --> (manual approval/SNS)  
Add stage --> Name : Destory --> Add action --> provider: Codebuild --> Destroy codebuild project --> Release pipeline after saving
```





