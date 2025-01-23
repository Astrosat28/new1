.
package com.example.websitechecker.controller;

import com.example.websitechecker.service.WebsiteCheckService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@RestController
public class WebsiteCheckController {

    private final WebsiteCheckService websiteCheckService;

    public WebsiteCheckController(WebsiteCheckService websiteCheckService) {
        this.websiteCheckService = websiteCheckService;
    }

    @GetMapping("/check-websites")
    public List<Map<String, String>> checkWebsites() {
        // You can modify the list as per your requirements.
        List<Map<String, String>> websites = Arrays.asList(
                Map.of("url", "https://www.geeksforgeeks.org")
                // You can add more websites if needed
        );

        // Delegate to the service
        return websiteCheckService.checkWebsites(websites);
    }
}

.
package com.example.websitechecker.service;

import io.github.bonigarcia.wdm.WebDriverManager;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class WebsiteCheckService {

    // Maximum duration in milliseconds (60 seconds)
    private static final long MAX_DURATION_MS = 60_000; 

    public List<Map<String, String>> checkWebsites(List<Map<String, String>> websites) {
        List<Map<String, String>> results = new ArrayList<>();

        // Record the start time
        long startTime = System.currentTimeMillis();

        // Ensure the ChromeDriver is set up
        WebDriverManager.chromedriver().setup();

        // Configure ChromeOptions to run headless (no visible browser)
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless");

        // Create a WebDriver instance
        WebDriver driver = new ChromeDriver(options);

        try {
            // Labeled loop to allow breaking out of both loops at once
            outerLoop:
            for (Map<String, String> site : websites) {
                String url = site.get("url");
                if (url == null) {
                    continue;
                }

                // Check if time has exceeded before even starting on this site
                if ((System.currentTimeMillis() - startTime) >= MAX_DURATION_MS) {
                    // Time limit reached, break out completely
                    break outerLoop;
                }

                // Navigate to the main website
                driver.get(url);

                // Collect all <a> and <img> tags
                List<WebElement> anchorElements = driver.findElements(By.tagName("a"));
                List<WebElement> imageElements = driver.findElements(By.tagName("img"));

                // Build a list of all links from anchors & images
                List<String> allLinks = new ArrayList<>();

                for (WebElement anchor : anchorElements) {
                    String href = anchor.getAttribute("href");
                    if (href != null && !href.isBlank()) {
                        allLinks.add(href);
                    }
                }

                for (WebElement img : imageElements) {
                    String src = img.getAttribute("src");
                    if (src != null && !src.isBlank()) {
                        allLinks.add(src);
                    }
                }

                // Now check each link
                for (String link : allLinks) {
                    // Check elapsed time at start of each link iteration
                    if ((System.currentTimeMillis() - startTime) >= MAX_DURATION_MS) {
                        // Time limit reached; break out of the outer loop
                        break outerLoop;
                    }

                    Map<String, String> result = new HashMap<>();
                    result.put("parentWebsite", url);
                    result.put("checkedLink", link);

                    try {
                        // Navigate to link
                        driver.navigate().to(link);
                        // If no exception, consider it "UP"
                        result.put("status", "UP");
                    } catch (Exception e) {
                        // If there's an exception, treat it as "DOWN"
                        result.put("status", "DOWN");
                        result.put("error", e.getMessage());
                    } finally {
                        // Navigate back to the parent URL so we can continue
                        driver.navigate().back();
                    }
                    results.add(result);
                }

                // Return to the main website one last time if needed
                driver.get(url);
            }
        } finally {
            // Close the browser
            driver.quit();
        }

        return results;
    }
}

.
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
					<parent>
						<groupId>org.springframework.boot</groupId>
						<artifactId>spring-boot-starter-parent</artifactId>
						<version>3.1.2</version>
						
						<relativePath/> <!-- lookup parent from repository -->
					</parent>
	<groupId>com.example</groupId>
	<artifactId>demo</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<packaging>war</packaging>
	<name>demo</name>
	<description>Demo project for Spring Boot</description>
	<properties>
		<java.version>17</java.version>
	</properties>



	<dependencies>
		<dependency>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-starter-tomcat</artifactId>
				<scope>provided</scope>
			</dependency>
		<dependency>
				<groupId>org.projectlombok</groupId>
				<artifactId>lombok</artifactId>
				<version>1.18.20</version>
				<scope>provided</scope>
		</dependency>
		

		
 	
		
		<dependency>
        <groupId>org.seleniumhq.selenium</groupId>
        <artifactId>selenium-java</artifactId>
        <version>4.11.0</version> 
        <!-- or a version that matches your BOM or preference -->
    </dependency>

    <!-- WebDriverManager -->
    <dependency>
        <groupId>io.github.bonigarcia</groupId>
        <artifactId>webdrivermanager</artifactId>
        <version>5.5.0</version>
    </dependency>
		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-web</artifactId>
		</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-test</artifactId>
			<scope>test</scope>
		</dependency>

		<dependency>
    <groupId>com.h2database</groupId>
    <artifactId>h2</artifactId>
    <scope>runtime</scope>
</dependency>
	</dependencies>

	<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
			</plugin>
			<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-surefire-plugin</artifactId>
    <version>3.0.0-M5</version>
</plugin>
			<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.8.1</version>
    <configuration>
        <source>17</source>
        <target>17</target>
    </configuration>
</plugin>

		</plugins>
	</build>

</project>
