Específico: IAM, Route53, KMS, Parameter Store, Cognito, STS, Cloudwatch
Frontend / arquivos: S3, Cloudfront
Servidores: EC2, ELB, Beanstalk
Banco de dados: RDS (M-AZ, RR), Elasticache, DynamoDB, DynamoDB Streams, DAX
Serviços: Lambda, API Gateway, X-Ray, SQS, SNS, Kinesis
Compilation: CodeCommit, CodeDeploy, CodePipeline, Cloudformation, SAM

Applications:
  - Map application
  - Simulator

- Map application:
  - Cognito for login
  - S3 / Cloudfront for frontend (React / Typescript)
  - List of devices is stored in RDS (M-AZ, RR)
  - Backend using API Gateway, Lambda, X-Ray

- Simulator
  - Application is stored in Beanstalk (Java)
  - Tracking data is stored in Kineses
    - From Kinesis is processed and the stored in DynamoDB
    - Cached in elasticache
    - DAX? 
    - DynamicDB streams will activate Lambda to set the color (?) of the line? something
