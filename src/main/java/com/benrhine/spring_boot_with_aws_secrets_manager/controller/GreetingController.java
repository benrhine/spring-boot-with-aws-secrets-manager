package com.benrhine.spring_boot_with_aws_secrets_manager.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GreetingController {

    @Value("${app.username:default-username}")
    private String username;

    @Value("${app.password:default-password}")
    private String password;

    @GetMapping("/greet")
    public String greet(@RequestParam(defaultValue = "World") String name) {
        return "Hello, " + name + "!";
    }

    @GetMapping("/secret")
    public String getSecret() {
        return "Loaded credentials - Username: " + username + ", Password: " + password;
    }
}