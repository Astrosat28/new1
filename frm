package com.example.my_spring_boot_selenium.model;

public class Action {
    private String type;
    private String target;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }
}

.
package com.example.my_spring_boot_selenium.model;


import java.util.List;

public class HealthCheck {
    private String url;
    private List<Action> actions;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public List<Action> getActions() {
        return actions;
    }

    public void setActions(List<Action> actions) {
        this.actions = actions;
    }
}
....
package com.example.my_spring_boot_selenium.model;

import java.util.List;

public class HealthData {
    private List<HealthCheck> websites;

    public List<HealthCheck> getWebsites() {
        return websites;
    }

    public void setWebsites(List<HealthCheck> websites) {
        this.websites = websites;
    }
}
.
package com.example.my_spring_boot_selenium;

import com.example.my_spring_boot_selenium.model.HealthData;
import com.example.my_spring_boot_selenium.model.HealthCheck;
import jakarta.annotation.PostConstruct;
import org.springframework.context.annotation.Configuration;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;

import java.io.InputStream;
import java.util.List;

@Configuration
public class HealthConfig {

    private List<HealthCheck> websites;

    @PostConstruct
    public void loadYaml() {
        // Create a Yaml instance that knows how to construct HealthData objects.
        Yaml yaml = new Yaml(new Constructor(HealthData.class));

        try (InputStream inputStream = 
                this.getClass().getClassLoader().getResourceAsStream("health.yml")) {

            if (inputStream == null) {
                System.out.println("WARNING: 'health.yml' not found in resources!");
                return;
            }

            // Load the YAML as a HealthData object
            HealthData data = yaml.load(inputStream);
            if (data != null) {
                this.websites = data.getWebsites();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<HealthCheck> getWebsites() {
        return websites;
    }
}
.
package com.example.my_spring_boot_selenium;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class MySpringBootSeleniumApplication {

    public static void main(String[] args) {
        SpringApplication.run(MySpringBootSeleniumApplication.class, args);
    }

    /**
     * Run automatically at startup to execute the Selenium tests.
     */
    @Bean
    public CommandLineRunner run(SeleniumService seleniumService) {
        return args -> {
            seleniumService.runHealthChecks();
        };
    }
}
.
package com.example.my_spring_boot_selenium;

import com.example.my_spring_boot_selenium.model.Action;
import com.example.my_spring_boot_selenium.model.HealthCheck;
import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.List;

@Service
public class SeleniumService {

    private final HealthConfig healthConfig;

    public SeleniumService(HealthConfig healthConfig) {
        this.healthConfig = healthConfig;
    }

    public void runHealthChecks() {
        // 1) Retrieve the list of websites from YAML
        List<HealthCheck> websiteList = healthConfig.getWebsites();
        if (websiteList == null || websiteList.isEmpty()) {
            System.out.println("No websites found in health.yml");
            return;
        }

        // 2) Set up Selenium (ChromeDriver)
        // Make sure /path/to/chromedriver is correct or use WebDriverManager:
         io.github.bonigarcia.wdm.WebDriverManager.chromedriver().setup();
        
        //System.setProperty("webdriver.chrome.driver", "/path/to/chromedriver"); 
        WebDriver driver = new ChromeDriver();

        // 3) Create an HTTP client for checking status codes
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {

            for (HealthCheck healthCheck : websiteList) {
                String url = healthCheck.getUrl();

                // 3a) Print HTTP status
                int statusCode = getHttpStatusCode(httpClient, url);
                System.out.println("URL: " + url + " | HTTP Status Code: " + statusCode);

                // 3b) Perform Selenium actions
                for (Action action : healthCheck.getActions()) {
                    try {
                        performAction(driver, action);
                        System.out.println("Action [" + action.getType() + "] on [" 
                                           + action.getTarget() + "] succeeded.");
                    } catch (Exception e) {
                        System.out.println("Action [" + action.getType() + "] on [" 
                                           + action.getTarget() + "] failed. " + e.getMessage());
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // Close the browser
            driver.quit();
        }
    }

    private int getHttpStatusCode(CloseableHttpClient httpClient, String url) {
        HttpGet request = new HttpGet(url);
        try (CloseableHttpResponse response = httpClient.execute(request)) {
            return response.getCode(); // e.g. 200, 404, etc.
        } catch (IOException e) {
            System.out.println("Error fetching status for " + url + ": " + e.getMessage());
            return -1;
        }
    }

    private void performAction(WebDriver driver, Action action) {
        switch (action.getType()) {
            case "goto":
                driver.get(action.getTarget());
                break;
            case "clickById":
                driver.findElement(By.id(action.getTarget())).click();
                break;
            case "clickByCss":
                driver.findElement(By.cssSelector(action.getTarget())).click();
                break;
            case "clickByXpath":
                driver.findElement(By.xpath(action.getTarget())).click();
                break;
            default:
                throw new IllegalArgumentException("Unsupported action type: " + action.getType());
        }
    }
}
.
websites:
  - url: "https://www.geeksforgeeks.org/"
    actions:
      - type: "goto"
        target: "https://www.geeksforgeeks.org/"
      - type: "clickByCss"
        target: "a#wp-block-search__button"
      - type: "clickById"
        target: "mega-menu-pull"

.
<?xml version="1.0" encoding="UTF-8"?>
<project 
    xmlns="http://maven.apache.org/POM/4.0.0" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
                        https://maven.apache.org/xsd/maven-4.0.0.xsd">
    
    <modelVersion>4.0.0</modelVersion>

    <!-- Parent: Spring Boot Starter Parent -->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.1.2</version>
        <relativePath/>
    </parent>

    <groupId>com.example.my_spring_boot_selenium</groupId>
    <artifactId>my-spring-boot-selenium</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>war</packaging>
    <name>my-spring-boot-selenium</name>
    <description>Demo project for Spring Boot + Selenium + SnakeYAML</description>

    <properties>
        <java.version>17</java.version>
    </properties>

    <dependencies>
        <!-- Spring Boot Starters -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <!-- If you need JPA/JDBC, otherwise remove these. -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-jdbc</artifactId>
        </dependency>

        <!-- For packaging as WAR -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-tomcat</artifactId>
            <scope>provided</scope>
        </dependency>

        <!-- Optional DB drivers -->
        <dependency>
            <groupId>com.microsoft.sqlserver</groupId>
            <artifactId>mssql-jdbc</artifactId>
            <version>8.4.1.jre11</version>
        </dependency>
        <dependency>
            <groupId>com.h2database</groupId>
            <artifactId>h2</artifactId>
            <scope>runtime</scope>
        </dependency>

        <!-- Selenium and WebDriverManager -->
        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-java</artifactId>
            <version>4.11.0</version>
        </dependency>
        <dependency>
            <groupId>io.github.bonigarcia</groupId>
            <artifactId>webdrivermanager</artifactId>
            <version>5.5.0</version>
        </dependency>

        <!-- SnakeYAML -->
        <dependency>
            <groupId>org.yaml</groupId>
            <artifactId>snakeyaml</artifactId>
            <version>1.29</version>
        </dependency>

        <!-- Jakarta annotation for @PostConstruct -->
        <dependency>
            <groupId>jakarta.annotation</groupId>
            <artifactId>jakarta.annotation-api</artifactId>
            <version>2.1.1</version>
        </dependency>

        <!-- Apache HttpClient 5 -->
        <dependency>
            <groupId>org.apache.httpcomponents.client5</groupId>
            <artifactId>httpclient5</artifactId>
            <version>5.2</version>
        </dependency>

        <!-- Spring Boot testing -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

    </dependencies>

    <build>
        <plugins>
            <!-- Spring Boot Maven Plugin -->
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>

            <!-- Maven Compiler Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.8.1</version>
                <configuration>
                    <source>${java.version}</source>
                    <target>${java.version}</target>
                </configuration>
            </plugin>
        </plugins>
    </build>
</project>
