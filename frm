package com.example.webtest.service;

import com.example.webtest.model.WebsiteConfig;
import com.example.webtest.utils.YamlLoader;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import io.github.bonigarcia.wdm.WebDriverManager;

import java.util.List;

public class WebsiteTester {
    public static void main(String[] args) {
        // Load website configurations from YAML file
        List<WebsiteConfig> websites = YamlLoader.loadConfig("src/main/resources/config.yaml");

        // Setup WebDriver using WebDriverManager
        WebDriverManager.chromedriver().setup();
        WebDriver driver = new ChromeDriver();

        for (WebsiteConfig config : websites) {
            try {
                System.out.println("Testing website: " + config.getUrl());

                driver.get(config.getUrl());

                // Find user ID field and enter the value
                WebElement userIdField = driver.findElement(By.name(config.getUser_id_field()));
                userIdField.sendKeys(config.getUser_id());

                // Find password field and enter the value
                WebElement passwordField = driver.findElement(By.name(config.getPassword_field()));
                passwordField.sendKeys(config.getPassword());

                // Submit the form (assuming there's a login button)
                passwordField.submit();

                // Check if transaction status field exists after login
                WebElement transactionStatus = driver.findElement(By.name(config.getTransaction_status_field()));

                if (transactionStatus.isDisplayed()) {
                    System.out.println("Transaction status field found!");
                } else {
                    System.out.println("Transaction status field NOT found!");
                }
            } catch (Exception e) {
                System.out.println("Error processing website: " + config.getUrl());
                System.out.println("Exception: " + e.getMessage());
            }
        }

        // Close the browser
        driver.quit();
    }
}

..
package com.example.webtest.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.yaml.YAMLFactory;
import com.example.webtest.model.WebsiteConfig;

import java.io.File;
import java.io.IOException;
import java.util.List;

public class YamlLoader {
    public static List<WebsiteConfig> loadConfig(String filePath) {
        ObjectMapper objectMapper = new ObjectMapper(new YAMLFactory());
        try {
            YamlWrapper wrapper = objectMapper.readValue(new File(filePath), YamlWrapper.class);
            return wrapper.getWebsites();
        } catch (IOException e) {
            throw new RuntimeException("Error loading YAML file", e);
        }
    }

    // Helper class to wrap website list from YAML
    private static class YamlWrapper {
        private List<WebsiteConfig> websites;
        public List<WebsiteConfig> getWebsites() { return websites; }
        public void setWebsites(List<WebsiteConfig> websites) { this.websites = websites; }
    }
}

..
package com.example.webtest.model;

public class WebsiteConfig {
    private String url;
    private String user_id;
    private String password;
    private String user_id_field;
    private String password_field;
    private String transaction_status_field;

    // Getters and Setters
    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    public String getUser_id() { return user_id; }
    public void setUser_id(String user_id) { this.user_id = user_id; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getUser_id_field() { return user_id_field; }
    public void setUser_id_field(String user_id_field) { this.user_id_field = user_id_field; }

    public String getPassword_field() { return password_field; }
    public void setPassword_field(String password_field) { this.password_field = password_field; }

    public String getTransaction_status_field() { return transaction_status_field; }
    public void setTransaction_status_field(String transaction_status_field) { this.transaction_status_field = transaction_status_field; }
}

...
websites:
  - url: "https://www.bankofamerica.com"
    user_id: "your_user_id"
    password: "your_password"
    user_id_field: "onlineid1"
    password_field: "passcode1"
    transaction_status_field: "transactionStatus"

  - url: "https://www.anotherbank.com"
    user_id: "your_user_id"
    password: "your_password"
    user_id_field: "useridField"
    password_field: "passwordField"
    transaction_status_field: "transactionStatusField"

,
