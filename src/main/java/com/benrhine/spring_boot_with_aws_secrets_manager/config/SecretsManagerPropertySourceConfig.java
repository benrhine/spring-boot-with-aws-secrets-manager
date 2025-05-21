package com.benrhine.spring_boot_with_aws_secrets_manager.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.ConfigurableEnvironment;

import javax.annotation.PostConstruct;

@Configuration
public class SecretsManagerPropertySourceConfig {

    private final ConfigurableEnvironment environment;

    @Value("${spring.application.name}")
    private String applicationName;

    @Value("${api-key1}")
    private String apiKeyValue1;

    @Value("${api-key2}")
    private String apiKeyValue2;

    @Value("${api-key3}")
    private String apiKeyValue3;

    @Value("${api-key4}")
    private String apiKeyValue4;

    @Value("${spring.datasource.username}")
    private String dbUser;

    @Value("${spring.datasource.password}")
    private String dbPass;

    @Value("${username}")
    private String username;

    @Value("${password}")
    private String password;

    public SecretsManagerPropertySourceConfig(ConfigurableEnvironment environment) {
        this.environment = environment;
    }

    @PostConstruct
    public void testValuesPresent() {
        System.out.println("Test properties present");
        System.out.println(applicationName);
        System.out.println("From secret with leading / - " + apiKeyValue1);
        System.out.println("From secret with leading / - " + apiKeyValue2);
        System.out.println("From secret without leading / - " + apiKeyValue3);
        System.out.println("From secret without leading / - " + apiKeyValue4);
        System.out.println("Demonstrate secret load through spring property - " + dbUser);
        System.out.println("Demonstrate secret load through spring property - " + dbPass);
        System.out.println("Demonstrate secret load directly - " + username);
        System.out.println("Demonstrate secret load directly - " + password);
        System.out.println("End Test properties present");
    }
}