UserController
  package com.example.demo.controller;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.example.demo.entity.AppUser;
import com.example.demo.service.UserService;
import java.util.List;
@RestController
public class UserController {
    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/api/user")
    public AppUser saveUser(@RequestBody AppUser user) {
        
            System.out.println("Received user data: " + user);
        return userService.saveUser(user);
    }

     @GetMapping("api/users")
    public ResponseEntity<List<AppUser>> getAllUsers() {
        List<AppUser> appUsers = userService.getAllUsers();
        System.out.println("Fetched user data: " + appUsers);
        return new ResponseEntity<>(appUsers, HttpStatus.OK);
    }
    @GetMapping("api/users/{startId}/{endId}")
    public ResponseEntity<List<AppUser>> getUsersInRange(@PathVariable Long startId, @PathVariable Long endId) {
        List<AppUser> appUsers = userService.getUsersInRange(startId, endId);
        System.out.println("Fetched user data: " + appUsers);
        return new ResponseEntity<>(appUsers, HttpStatus.OK);
    }
    @GetMapping("/api/users/month/{month}")
    public ResponseEntity<List<AppUser>> getUsersByMonth(@PathVariable String month) {
        List<AppUser> appUsers = userService.getUsersByMonth(month);
        System.out.println("Fetched user data for month: " + month + ", Data: " + appUsers);
        return new ResponseEntity<>(appUsers, HttpStatus.OK);
    }
  
        @PutMapping("/api/user/{id}")
public ResponseEntity<AppUser> updateUser(@PathVariable Long id, @RequestBody AppUser updatedUser) {
    AppUser existingUser = userService.getUserById(id);
    if (existingUser != null) {
        existingUser.setName(updatedUser.getName());
        existingUser.setNumber(updatedUser.getNumber());
        userService.saveUser(existingUser);
        return new ResponseEntity<>(existingUser, HttpStatus.OK);
    } else {
        return new ResponseEntity<>(HttpStatus.NOT_FOUND);
    }
}

}

AppUser.java entity
  package com.example.demo.entity;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Column;
import lombok.Data;
import javax.persistence.Table;
@Data
@Entity
@Table(name = "app_user")
public class AppUser {
    @Id
     @GeneratedValue(strategy = GenerationType.IDENTITY)
    
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    @Column(nullable = false)
    private Integer number;
    @Column(nullable = true) // Or set this to true if this column can be nullable
    private String month;
}

userrepository.java
  package com.example.demo.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo.entity.AppUser;
import java.util.List;


public interface UserRepository extends JpaRepository<AppUser, Long> {
    List<AppUser> findByIdBetween(Long startId, Long endId);
    @Query("SELECT u FROM AppUser u WHERE u.month = :month")
    List<AppUser> findUsersByMonth(@Param("month") String month);
    
}
userservice.java
package com.example.demo.service;
import org.springframework.stereotype.Service;
import com.example.demo.entity.AppUser;
import com.example.demo.repository.UserRepository;
import java.util.List;

@Service
public class UserService {
    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public AppUser saveUser(AppUser user) {
        return userRepository.save(user);
    }
    public List<AppUser> getAllUsers() {
        return userRepository.findAll();
    }
    public List<AppUser> getUsersInRange(Long startId, Long endId) {
        return userRepository.findByIdBetween(startId, endId);
    }
   
    public List<AppUser> getUsersByMonth(String month) {
        return userRepository.findUsersByMonth(month);
    }
    // Add this method to your UserService class
public AppUser getUserById(Long id) {
    return userRepository.findById(id).orElse(null);
}

    
}

demoapplication.java
package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@SpringBootApplication
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}
 @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**").allowedOrigins("http://localhost:4200");
            }
        };
    }
}
app.pro
  spring.datasource.url=jdbc:sqlserver://AADITYA;databaseName=mydb1;integratedSecurity=true
spring.datasource.driver-class-name=com.microsoft.sqlserver.jdbc.SQLServerDriver
spring.jpa.database-platform=org.hibernate.dialect.SQLServer2012Dialect

spring.jpa.hibernate.ddl-auto=update


  pom.xml
  <?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<parent>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-parent</artifactId>
		<version>2.5.5</version>
		<relativePath/> <!-- lookup parent from repository -->
	</parent>
	<groupId>com.example</groupId>
	<artifactId>demo</artifactId>
	<version>0.0.1-SNAPSHOT</version>
	<name>demo</name>
	<description>Demo project for Spring Boot</description>
	<properties>
		<java.version>11</java.version>
	</properties>
	<dependencies>
	
	<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.18.20</version>
    <scope>provided</scope>
</dependency>


<dependency>
    <groupId>com.microsoft.sqlserver</groupId>
    <artifactId>mssql-jdbc</artifactId>
    <version>8.4.1.jre11</version>
</dependency>

		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-data-jpa</artifactId>
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
        <source>11</source>
        <target>11</target>
    </configuration>
</plugin>

		</plugins>
	</build>

</project>
