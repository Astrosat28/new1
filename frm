package com.example.demo.config;

import com.example.demo.model.Action;
import java.util.List;

public class HealthConfig {
    private List<String> urls;
    private List<Action> actions;

    // Getters and Setters
    public List<String> getUrls() {
        return urls;
    }

    public void setUrls(List<String> urls) {
        this.urls = urls;
    }

    public List<Action> getActions() {
        return actions;
    }

    public void setActions(List<Action> actions) {
        this.actions = actions;
    }
}
.
action.java
package com.example.demo.model;

public class Action {
    private String type;
    private String selector;
    private String value;

    // Getters and Setters
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSelector() {
        return selector;
    }

    public void setSelector(String selector) {
        this.selector = selector;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
selenium executor 
package com.example.demo.service;

import com.example.demo.config.HealthConfig;
import com.example.demo.model.Action;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.*;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.stereotype.Service;
import java.net.HttpURLConnection;
import java.util.ArrayList;
import java.util.List;
import java.net.URL;

@Service
public class SeleniumExecutor {
    public void executeActions(HealthConfig config) {
        WebDriverManager.chromedriver().setup();
        WebDriver driver = new ChromeDriver();

        try {
            for (String url : config.getUrls()) {
                driver.get(url);

                for (Action action : config.getActions()) {
                    WebElement parentElement = findElement(driver, action.getSelector(), action.getValue());
                    if (parentElement != null) {
                        // 1) Collect ALL <a> tags under the found element
                        List<WebElement> anchorElements = parentElement.findElements(By.tagName("a"));

                        // 2) Extract their href attributes and store them in a List
                        List<String> linkHrefs = new ArrayList<>();
                        for (WebElement anchor : anchorElements) {
                            String href = anchor.getAttribute("href");
                            if (href != null && !href.isEmpty()) {
                                linkHrefs.add(href);
                            }
                        }

                        // 3) Print them out (or store them somewhere else)
                        System.out.println("Found " + linkHrefs.size() + " links under element with "
                                + action.getSelector() + "=" + action.getValue() + ":");
                        for (String link : linkHrefs) {
                            System.out.println("  - " + link);
                        }
                        for (String link : linkHrefs) {
                            int statusCode = checkLinkStatus(link);
                            System.out.println("  - " + link + " => " + statusCode);
                        }

                        // 4) (Optional) Still click the parent element, if you actually need to:
                        parentElement.click();
                        System.out.println("Clicked element: " + action.getValue());
                    } else {
                        System.out.println("Element not found: " + action.getValue());
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            driver.quit();
        }
    }

    private WebElement findElement(WebDriver driver, String selector, String value) {
        switch (selector) {
            case "id":
                return driver.findElement(By.id(value));
            case "css":
                return driver.findElement(By.cssSelector(value));
            case "xpath":
                return driver.findElement(By.xpath(value));
            default:
                throw new IllegalArgumentException("Unsupported selector: " + selector);
        }
    }
    private int checkLinkStatus(String link) {
        HttpURLConnection connection = null;
        try {
            URL url = new URL(link);
            connection = (HttpURLConnection) url.openConnection();
            // Optional: you can set request method, timeouts, etc.
            connection.setRequestMethod("GET");
            connection.setConnectTimeout(5000); // 5 seconds
            connection.setReadTimeout(5000);    // 5 seconds
            connection.connect();

            return connection.getResponseCode();
        } catch (Exception e) {
            // If something goes wrong (e.g., malformed URL, timeout, etc.), you can decide what to do
            System.err.println("Error checking link " + link + " : " + e.getMessage());
            return -1; // Indicate an error
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }
}

// package com.example.demo.service;

// import com.example.demo.config.HealthConfig;
// import com.example.demo.model.Action;
// import org.openqa.selenium.By;
// import org.openqa.selenium.WebDriver;
// import org.openqa.selenium.WebElement;
// import org.openqa.selenium.chrome.ChromeDriver;
// import io.github.bonigarcia.wdm.WebDriverManager;
// import org.springframework.stereotype.Service;
// import java.util.ArrayList;
// import java.util.List;

// @Service
// public class SeleniumExecutor {
//     public void executeActions(HealthConfig config) {
//         WebDriverManager.chromedriver().setup();
//         WebDriver driver = new ChromeDriver();

//         try {
//             for (String url : config.getUrls()) {
//                 driver.get(url);

//                 for (Action action : config.getActions()) {
//                     WebElement element = findElement(driver, action.getSelector(), action.getValue());
//                     if (element != null) {
//                         element.click();
//                         System.out.println("Clicked element: " + action.getValue());
//                     } else {
//                         System.out.println("Element not found: " + action.getValue());
//                     }
//                 }
//             }
//         } catch (Exception e) {
//             e.printStackTrace();
//         } finally {
//             driver.quit();
//         }
//     }

//     private WebElement findElement(WebDriver driver, String selector, String value) {
//         switch (selector) {
//             case "id":
//                 return driver.findElement(By.id(value));
//             case "css":
//                 return driver.findElement(By.cssSelector(value));
//             case "xpath":
//                 return driver.findElement(By.xpath(value));
//             default:
//                 throw new IllegalArgumentException("Unsupported selector: " + selector);
//         }
//     }
// }
yaml parser
package com.example.demo.util;

import com.example.demo.config.HealthConfig;
import org.yaml.snakeyaml.Yaml;
import org.yaml.snakeyaml.constructor.Constructor;

import java.io.InputStream;

public class YamlParser {
    public static HealthConfig parseYaml(String filePath) {
        Yaml yaml = new Yaml(new Constructor(HealthConfig.class));
        InputStream inputStream = YamlParser.class
                .getClassLoader()
                .getResourceAsStream(filePath);
        return yaml.load(inputStream);
    }
}
demoapp
package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import com.example.demo.config.HealthConfig;
import com.example.demo.service.SeleniumExecutor;
import com.example.demo.util.YamlParser;

@SpringBootApplication
public class DemoApplication {
    public static void main(String[] args) {
        // Start Spring Boot application
        ConfigurableApplicationContext context = SpringApplication.run(DemoApplication.class, args);

        // Parse the YAML file
        HealthConfig config = YamlParser.parseYaml("health.yml");

        // Execute the actions using Selenium
        SeleniumExecutor seleniumExecutor = context.getBean(SeleniumExecutor.class);
        seleniumExecutor.executeActions(config);
    }
}
health.yaml 
urls:
  - https://www.w3schools.com/
actions:
  - type: click
    selector: id
    value: "subtopnav"
  # - type: click
  #   selector: css
  #   value: a.someClass
.
pom.xml
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
