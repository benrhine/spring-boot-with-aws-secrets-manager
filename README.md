# spring-boot-with-aws-secrets-manager

Example of a SpringBoot application that can retrieve Aws Secrets. This will demonstrate being able to connect the SpringBoot
`application.properties` to the Aws SecretManager and how to access those secrets from within the `application.properties`
file and within the application itself in multiple ways.

This uses https://www.baeldung.com/spring-boot-integrate-aws-secrets-manager to help build this example

## Create Aws Secrets

Login to the desired aws account using `aws sso login`

Execute the following ...

```shell
aws secretsmanager create-secret --name test/secret/ --secret-string "{\"api-key1\":\"apiKeyValue1\",\"api-key2\":\"apiKeyValue2\"}" 

aws secretsmanager create-secret --name /test/secret2 --secret-string "{\"api-key3\":\"apiKeyValue3\",\"api-key4\":\"apiKeyValue4\"}" 

aws secretsmanager create-secret --name rds/credentials  --secret-string file://mycredentials.json  
```

Note: You may need to add the `--profile` option to create secrets in the correct location

## Legacy Credential Access

Spring _seems_ to have an issue with accessing the Aws SSO Credentials and may need to use the `ssocreds` helper as 
described here https://github.com/benrhine/general-documentation/blob/main/how-to/local-deploy.adoc#ssocreds

## Execution

Application can be executed with either Gradle or Maven

### Gradle

```shell
./gradlew clean bootRun  
```

### Maven

```shell
./mvnw clean spring-boot:run   
```
