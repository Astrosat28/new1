@Autowired
private HttpClientService httpClientService;

@GetMapping("/check")
public ResponseEntity<String> checkWebsite(@RequestParam String url) {
    boolean isUp = httpClientService.isWebsiteUp(url);
    return ResponseEntity.ok(isUp ? "Website is up" : "Website is down");
}

..
package com.example.websitestatus.service;

import org.apache.hc.client5.http.classic.methods.HttpGet;
import org.apache.hc.client5.http.fluent.Executor;
import org.apache.hc.client5.http.fluent.Request;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.core5.ssl.SSLContexts;
import org.apache.hc.core5.ssl.TrustAllStrategy;
import org.apache.hc.core5.util.Timeout;
import org.springframework.stereotype.Service;

import javax.net.ssl.SSLContext;
import java.io.IOException;

@Service
public class HttpClientService {

    private SSLContext createIgnoreSSLContext() {
        try {
            return SSLContexts.custom()
                    .loadTrustMaterial(null, TrustAllStrategy.INSTANCE)
                    .build();
        } catch (Exception e) {
            throw new RuntimeException("Error creating SSL context", e);
        }
    }

    public boolean isWebsiteUp(String url) {
        try {
            SSLContext sslContext = createIgnoreSSLContext();

            // Create a custom HTTP client with SSL context
            CloseableHttpClient httpClient = HttpClients.custom()
                    .setSslContext(sslContext)
                    .build();

            // Use Executor to execute the request with the custom client
            int statusCode = Executor.newInstance(httpClient)
                    .execute(Request.get(url)
                            .connectTimeout(Timeout.ofSeconds(10))
                            .responseTimeout(Timeout.ofSeconds(10))
                    )
                    .returnResponse()
                    .getCode();

            return statusCode == 200 || statusCode == 302 || statusCode == 401;

        } catch (IOException e) {
            System.err.println("Error accessing website: " + e.getMessage());
            return false;
        }
    }
}

.......
package com.example.websitestatus.controller;

import com.example.websitestatus.model.Website;
import com.example.websitestatus.service.WebsiteStatusService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/websites")
public class WebsiteStatusController {
    private final WebsiteStatusService statusService;

    public WebsiteStatusController(WebsiteStatusService statusService) {
        this.statusService = statusService;
    }

    @PostMapping("/check")
    public String checkWebsiteStatus(@RequestBody Website website) {
        return statusService.checkWebsiteStatus(website);
    }
}

........................................................
package com.example.websitestatus.service;

import com.example.websitestatus.model.Website;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WebsiteStatusService {
    private final HttpClientService httpClientService;

    public WebsiteStatusService(HttpClientService httpClientService) {
        this.httpClientService = httpClientService;
    }

    public String checkWebsiteStatus(Website website) {
        if (!httpClientService.isWebsiteUp(website.getUrl())) {
            return "Website is Down";
        }

        if (website.getLoginUrl() != null && !website.getLoginUrl().isEmpty()) {
            System.setProperty("webdriver.chrome.driver", "/path/to/chromedriver");
            WebDriver driver = new ChromeDriver();

            try {
                driver.get(website.getLoginUrl());
                WebElement usernameField = driver.findElement(By.name("username"));
                WebElement passwordField = driver.findElement(By.name("password"));
                WebElement submitButton = driver.findElement(By.name("submit"));

                usernameField.sendKeys(website.getUsername());
                passwordField.sendKeys(website.getPassword());
                submitButton.click();

                return "Website Login Successful";
            } catch (Exception e) {
                return "Website Login Failed";
            } finally {
                driver.quit();
            }
        }

        return "Website is Up";
    }
}

........
package com.example.websitestatus.service;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.springframework.stereotype.Service;

import java.io.IOException;

@Service
public class HttpClientService {
    public boolean isWebsiteUp(String url) {
        try {
            Connection.Response response = Jsoup.connect(url).timeout(5000).execute();
            return response.statusCode() == 200;
        } catch (IOException e) {
            return false;
        }
    }
}

..............
package com.example.websitestatus.model;

public class Website {
    private String url;
    private String loginUrl;
    private String username;
    private String password;

    // Constructors, Getters, and Setters
    public Website() {}

    public Website(String url, String loginUrl, String username, String password) {
        this.url = url;
        this.loginUrl = loginUrl;
        this.username = username;
        this.password = password;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getLoginUrl() {
        return loginUrl;
    }

    public void setLoginUrl(String loginUrl) {
        this.loginUrl = loginUrl;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}

/.....

......import pyodbc

def fetch_all_records():
    # Replace the following placeholders with your actual server, database, username, and password
    server_name = 'YOUR_SERVER_NAME'         # e.g., 'localhost\\SQLEXPRESS'
    database_name = 'YOUR_DATABASE_NAME'     # e.g., 'TestDB'
    username = 'YOUR_USERNAME'               # e.g., 'sa'
    password = 'YOUR_PASSWORD'               # e.g., 'your_password'

    # Ensure all connection parameters are strings
    if not all(isinstance(param, str) for param in [server_name, database_name, username, password]):
        print("All connection parameters must be strings.")
        return

    # Construct the connection string as a single line
    connection_string = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        f"SERVER={server_name};"
        f"DATABASE={database_name};"
        f"UID={username};"
        f"PWD={password}"
    )

    try:
        # Establish connection
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()

        # Define the SQL query
        query = "SELECT * FROM [dbo].[release data]"

        # Ensure the query is a string
        if not isinstance(query, str):
            raise TypeError("The SQL query must be a string.")

        # Execute the query
        cursor.execute(query)

        # Fetch all results
        rows = cursor.fetchall()

        # Print each row in the terminal
        for row in rows:
            print(row)

        # Close cursor and connection
        cursor.close()
        conn.close()

        print("Query executed successfully and all records have been printed.")
    except TypeError as te:
        print("TypeError:", te)
    except pyodbc.Error as db_err:
        print("Database error:")
        print(db_err)
    except Exception as e:
        print("An unexpected error occurred:")
        print(e)

if __name__ == "__main__":
    fetch_all_records()

....

/* release.component.css */

/* Group container spacing */
.group {
    margin-bottom: 1rem;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  
  /* The clickable bar for the year-month heading */
  .group-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #e6e6e6; /* subtle gray */
    padding: 0.5rem 1rem;
    cursor: pointer;
    font-weight: bold;
    user-select: none; /* avoid text selection on click */
  }
  
  .group-bar:hover {
    background-color: #d9d9d9; /* slightly darker on hover */
  }
  
  /* Title on the left of the group bar */
  .group-title {
    font-size: 1.1rem;
  }
  
  /* +/- icon on the right */
  .toggle-icon {
    font-size: 1.2rem;
  }
  
  /* Container for cards within a group */
  .card-container {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem;
    padding: 1rem; /* indentation inside group */
    background-color: #fafafa;
  }
  
  /* Each email card */
  .email-card {
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 4px;
    flex: 0 0 calc(33.33% - 1rem); 
    /* tries to show 3 cards per row, 
       or adjust as needed (50% for 2 cards, etc.) */
    min-width: 250px; 
    max-width: 350px; 
    box-shadow: 1px 1px 4px rgba(0, 0, 0, 0.1);
  }
  
  /* Card header can have a distinct background or styling */
  .card-header {
    padding: 0.5rem 1rem;
    background-color: #007bff; /* a blue header color */
    color: #fff;
    border-bottom: 1px solid #ddd;
    border-radius: 4px 4px 0 0;
  }
  
  .card-title {
    font-weight: bold;
    font-size: 1rem;
  }
  
  /* Card body with email details */
  .card-body {
    padding: 0.75rem 1rem;
    color: #333;
  }
  
  .card-body div {
    margin-bottom: 0.4rem; /* space between lines */
  }
  
  .card-body strong {
    color: #555; /* subtle emphasis */
  }
  
............
<!-- release.component.html -->
<h2>Release Page</h2>

<!-- If there's no data at all -->
<div *ngIf="releaseData && releaseData.length === 0">
  <p>No release data available</p>
</div>

<!-- If we do have grouped data, loop through each group -->
<div class="group" *ngFor="let group of groupedData">
  <!-- Bar or heading for the group -->
  <div class="group-bar" (click)="toggleGroupExpand(group)">
    <!-- Display yearMonth and an icon or +/- to indicate collapse state -->
    <span class="group-title">{{ group.yearMonth }}</span>
    <span class="toggle-icon">{{ group.expanded ? '−' : '+' }}</span>
  </div>

  <!-- Show/hide cards based on group.expanded -->
  <div class="card-container" *ngIf="group.expanded">
    <div class="email-card" *ngFor="let item of group.items">
      <div class="card-header">
        <div class="card-title">{{ item.subject }}</div>
      </div>
      <div class="card-body">
        <div><strong>Sender Name:</strong> {{ item.senderName }}</div>
        <div><strong>Sender Email:</strong> {{ item.senderEmail }}</div>
        <div><strong>CC Recipients:</strong> {{ item.ccRecipients }}</div>
        <div>  <strong>Email Body:</strong>
          <span [title]="(item.emailBody || '').length > 30 ? item.emailBody : null">
            {{ 
              (item.emailBody || '').length > 30
                ? (item.emailBody || '').slice(0, 30) + '...'
                : (item.emailBody || '')
            }}
          </span></div>
        <div><strong>Saved File Name:</strong> {{ item.savedFileName }}</div>
        <div><strong>Received Time:</strong> {{ item.receivedTime }}</div>
        <div><strong>Processed Date:</strong> {{ item.processedDate }}</div>
        <div><strong>Recipients:</strong> {{ item.recipients }}</div>
      </div>
    </div>
  </div>
</div>

------------
// release.component.ts
import { Component, OnInit } from '@angular/core';
import { ReleaseService } from '../services/release.service';
import { CommonModule } from '@angular/common';

interface ReleaseData {
  id: number;
  senderName: string;
  senderEmail: string;
  ccRecipients: string;
  subject: string;
  emailBody: string;
  savedFileName: string;
  receivedTime: string;
  processedDate: string;
  recipients: string;
}

interface GroupedData {
  yearMonth: string;
  items: ReleaseData[];
  expanded: boolean; // <-- to track if the group is expanded
}

@Component({
  selector: 'app-release',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './release.component.html',
  styleUrls: ['./release.component.css']
})
export class ReleaseComponent implements OnInit {
  releaseData: ReleaseData[] = [];
  groupedData: GroupedData[] = [];

  constructor(private releaseService: ReleaseService) {}

  ngOnInit(): void {
    this.fetchReleaseData();
  }

  fetchReleaseData(): void {
    this.releaseService.getReleaseData()
      .subscribe({
        next: (data: ReleaseData[]) => {
          this.releaseData = data;
          this.groupedData = this.groupByYearMonth(data);
        },
        error: (err) => console.error('Error fetching release data:', err)
      });
  }
  getTruncatedBody(body: string): string {
    if (body.length > 30) {
      return body.slice(0, 30) + '...';
    }
    return body;
  }
  

  private groupByYearMonth(data: ReleaseData[]): GroupedData[] {
    const map = new Map<string, ReleaseData[]>();

    data.forEach(item => {
      // Example: "2024-11-23 16:50:24.433"
      // We'll parse out the YYYY-MM from receivedTime
      const dateStr = item.receivedTime.split(' ')[0]; // "2024-11-23"
      const [year, month] = dateStr.split('-');        // ["2024","11","23"]
      const yearMonth = `${year}-${month}`;            // "2024-11"

      if (!map.has(yearMonth)) {
        map.set(yearMonth, []);
      }
      map.get(yearMonth)!.push(item);
    });

    // Convert Map to an array of GroupedData objects
    const groupedArray: GroupedData[] = [];
    map.forEach((items, ym) => {
      groupedArray.push({
        yearMonth: ym,
        items,
        expanded: false // initially collapsed
      });
    });

    // Optional: sort the array if desired
    // groupedArray.sort((a, b) => b.yearMonth.localeCompare(a.yearMonth));

    return groupedArray;
  }

  toggleGroupExpand(group: GroupedData): void {
    group.expanded = !group.expanded;
  }
}

---------

sdasd

Short Version:

Streamlined Information Access: The website centralizes all critical release management data, including coding standards, audit requirements, and developer guidelines, ensuring teams save time and reduce errors.

Enhanced Governance: Provides quick access to governance details like key contacts, operational tasks, and a knowledge repository, promoting effective decision-making and collaboration.

Improved Efficiency: Quick links to essential resources like the annual release calendar and admin SharePoint site simplify navigation and improve productivity.

Standardized Practices: Detailed guidelines, templates, and rules enforce consistent coding and release processes, ensuring compliance with industry standards.



---

Long Version:

1. Current Activity Component:

Displays the latest emails organized by date, enabling the team to stay updated on ongoing tasks and priorities in real time.

Reduces the need for manual tracking of communications, ensuring timely decision-making and action.


2. Rules and Regulations Component:

Offers a comprehensive repository of coding standards, audit requirements, high-level procedures, and detailed process flows.

Ensures all team members adhere to uniform practices, reducing non-compliance risks and audit findings.


3. Developer Guidelines Component:

Includes clear instructions for release entry and change processes, promoting structured and error-free releases.

Provides templates (FV, CV) that standardize documentation, saving time and maintaining consistency across projects.


4. Quick Links Component:

Hosts direct links to vital resources like the admin SharePoint site and the annual release calendar.

Eliminates time spent searching for frequently used information, improving overall efficiency.


5. Program Management and Governance Component:

Centralizes critical governance information, including key contacts of core team members, release emails, and operational assignments.

Enhances transparency and accountability by providing easy access to the knowledge repository and operational tasks.

Facilitates collaboration between teams and stakeholders by offering a one-stop resource for governance-related queries.



---

Value Addition for Upper Management:

Time Savings: By centralizing information, the website reduces time wasted on searching for or consolidating data, allowing teams to focus on delivery.

Risk Mitigation: Standardized guidelines and compliance rules minimize the chances of errors, audit findings, and failed releases.

Transparency: Clear governance details and documented processes ensure better oversight and control.

Productivity Boost: Simplified navigation and access to tools enhance team efficiency and satisfaction, indirectly improving project outcomes.

Collaboration: A single platform for operational and governance information fosters better communication between cross-functional teams.


These points demonstrate the critical role your release management website plays in streamlining operations and ensuring compliance, which directly aligns with organizational goals and adds measurable value.


