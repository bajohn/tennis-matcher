cd src/api-handler
rm  ../artifacts/lambda_function_payload.zip 
zip -r ../artifacts/lambda_function_payload.zip  .
cd ../terraform
terraform validate
terraform apply