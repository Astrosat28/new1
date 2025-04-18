CREATE TABLE dbo.visitorlog (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userid NVARCHAR(100),
    url NVARCHAR(2048),
    timestamp DATETIME,
    ipaddress NVARCHAR(45)
);


<project xmlns="http://maven.apache.org/POM/4.0.0" ...>
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.office</groupId>
  <artifactId>visitor-logger</artifactId>
  <version>1.0.0</version>
  <dependencies>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-security</artifactId>
    </dependency>
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    <dependency>
      <groupId>com.microsoft.sqlserver</groupId>
      <artifactId>mssql-jdbc</artifactId>
      <version>12.2.0.jre11</version>
    </dependency>
  </dependencies>
</project>


spring.datasource.url=jdbc:sqlserver://YOUR_SERVER;databaseName=YOUR_DB
spring.datasource.username=your_user
spring.datasource.password=your_pass
spring.jpa.hibernate.ddl-auto=none
spring.jpa.show-sql=true

@Entity
@Table(name = "visitorlog", schema = "dbo")
public class VisitorLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String userid;
    private String url;
    private LocalDateTime timestamp;
    private String ipaddress;

    // Getters and Setters
}

@Repository
public interface VisitorLogRepository extends JpaRepository<VisitorLog, Long> {}


@Component
public class VisitorLoggingFilter extends OncePerRequestFilter {

    @Autowired
    private VisitorLogRepository logRepository;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String userId = (auth != null) ? auth.getName() : "anonymous";

        VisitorLog log = new VisitorLog();
        log.setUserid(userId);
        log.setUrl(request.getRequestURL().toString());
        log.setIpaddress(request.getRemoteAddr());
        log.setTimestamp(LocalDateTime.now());

        logRepository.save(log);
        filterChain.doFilter(request, response);
    }
}


<dependency>
  <groupId>com.office</groupId>
  <artifactId>visitor-logger</artifactId>
  <version>1.0.0</version>
</dependency>


----------------------------------------------------------------------------------------------------------------------------------------------------
Here’s a concise and professional training session summary you can present to your team:


---

Training Session Summary: Email Extraction to Angular Display Workflow

Objective:
To train the team on the end-to-end workflow for extracting specific Outlook emails, processing them, storing in the database, and displaying categorized email data on the Angular frontend.


---

Modules Covered:

1. Email Extraction via Python:

Used win32com.client to connect with Outlook.

Filtered emails based on specific subject patterns (e.g., "FV Release", "CV Update", etc.).

Parsed content such as subject, date, body, and attachments if needed.



2. Database Insertion:

Cleaned and structured email data.

Connected to MS SQL database using pyodbc or sqlalchemy.

Inserted records into a predefined table schema.



3. Java REST API Layer:

Created using Spring Boot.

Exposed endpoints to fetch email data by category or latest status.

Included endpoints for deletion or update if applicable.



4. Angular Frontend:

Consumed the REST API to display categorized emails.

Implemented components with routing and UI filters.

Provided view by categories such as:

FV Release

CV Release

MOPA FV / CV






---

Training Outcomes:

Understand the full pipeline: Outlook → Python → Database → API → Angular.

Learn how to add new subject filters or modify categories.

Gain ability to troubleshoot data flow and integration issues.

Understand deployment and maintenance best practices.



---

Let me know if you want slides, flow diagrams, or a more hands-on script for live demo.





.
<h1 style="color: #650030; font-weight: bold; text-align: left; margin-top: 20px;">
  LFG Landscape and Cognizant Involvement - Retail
</h1>

<!-- layout.component.html -->
<div class="main-container">
  <div class="custom-row row-1">
    <div class="custom-col row-1-div-1">
      <div class="card business-card">
        <div class="card-body" style="text-align: center;">
          Key Business Transaction
        </div>
      </div>
    </div>
    <div class="custom-col row-1-div-2">
      <div class="card card-top">
        <div class="card-body">
          Contact Center Transactions
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Contract Updates
        </div>
      </div>
    </div>

    <div class="custom-col row-1-div-3">
      <div class="card card-top">
        <div class="card-body">
          Return Mail Processing
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Disbursement / Money Out
        </div>
      </div>
    </div>

    <div class="custom-col row-1-div-4">
      <div class="card card-top">
        <div class="card-body">
          Death Record Validation
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Money In / Cash Receipt
        </div>
      </div>
    </div>

    <div class="custom-col row-1-div-5">
      <div class="card card-top">
        <div class="card-body">
          Product Illustrations
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Broker Changes
        </div>
      </div>
    </div>

    <div class="custom-col row-1-div-6">
      <div class="card card-top">
        <div class="card-body">
          Claims Processing
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Producer Solutions Audit
        </div>
      </div>
    </div>

  </div>

  <div class="custom-row row-2">
    <div class="custom-col row-2-div-1">
      <div class="card systems-interaction-card">
        <div class="card-body">
          Systems of Interaction
        </div>
      </div>
    </div>
  
    <div class="custom-col row-2-div-2" style="flex: 2; font-weight: bold;" >
      Ops Interaction
      <div class="card-grid-2x3" style="padding-top: 3px;">
        <div class="card card-1" [title]="cardDescriptions['card1']">
          <div class="card-body">AWD</div>
        </div>
        <div class="card card-2" style=" background-color: #650030;" [title]="cardDescriptions['card2']">
          <div class="card-body" style="color:white; font-weight: 600;">Lifewriter</div>
        </div>
        <div class="card card-3" [title]="cardDescriptions['card1']">
          <div class="card-body">NBSTP</div>
        </div>
        <div class="card card-4" [title]="cardDescriptions['card1']">
          <div class="card-body">Design IT</div>
        </div>
        <div class="card card-5" style=" background-color: #650030;" [title]="cardDescriptions['card1']">
          <div class="card-body" style="color:white; font-weight: 600;">ALIP</div>
        </div>
        <div class="card card-6 invisiblecard">
          <div class="card-body">Card 6</div>
        </div>
      </div>
      <div class="bridge-card" [title]="cardDescriptions['card1']" >DXC Admin CICS Terminals</div>
    </div>
  
    <div class="custom-col row-2-div-3" style="flex: 2; background-color: #e2e3e5; max-width: 15%; font-weight: bold;">
      Contact Center Interaction
      <div class="card-pair-horizontal">
        <div class="card horizontal-card card-left" style="    background-color: #ffc107;" [title]="cardDescriptions['card1']">
          <div class="card-body" style="color:#212529;">CSA</div>
        </div>
        <div class="card horizontal-card card-right" style="background-color:#4169E1;" [title]="cardDescriptions['card1']">
          <div class="card-body" >CSW</div>
        </div>
      </div>
    </div>
  
    <div class="custom-col row-2-div-5" style="background-color: #e2e3e5;">
      <div style="text-align: center;
        margin-top: 0;
        padding-bottom: 35px; font-weight: bold;">IVR</div>
      <div class="card single-card card-div5" style="margin-bottom: 32px; background-color: #650030;">
        <div class="card-body" >Five 9</div>
      </div>
    </div>
  
    <div class="custom-col row-2-div-6" style="background-color: #e2e3e5;">
      <div style="text-align: center;
      margin-top: 0;
      padding-bottom: 35px; font-weight: bold;">Agent Interaction</div>

      <div class="card single-card card-div6" style="margin-bottom: 32px; background-color: #650030;">
        <div class="card-body">Secured Sites</div>
      </div>
    </div>
  </div>

  <div class="custom-row row-3">
    <div class="custom-col row-3-div-1">
      <div class="card administration-card">
        <div class="card-body">
          Administration
        </div>
      </div>
    </div>
    <div class="custom-col row-3-div-2-3" >
      Policy Admin
      <div class="card-grid-3x2">
        <div class="card card-a"  style="    background-color: #ffc107;"><div class="card-body" style="color:#212529;">FW - VTG</div></div>
        <div class="card card-b"  style="    background-color: #ffc107;"><div class="card-body" style="color:#212529;">Fusion VTG</div></div>
        <div class="card card-c"  style="    background-color: #ffc107;"><div class="card-body" style="color:#212529;">Life COMM</div></div>
        <div class="card card-d" style="    background-color: #4169E1;"><div class="card-body">FAST</div></div>
        <div class="card card-e"  style="    background-color: #ffc107;"><div class="card-body" style="color:#212529;">Concord VTG</div></div>
        <div class="card card-f" style="    background-color: #4169E1;"><div class="card-body">APS</div></div>
      </div>
    </div>
    <div class="custom-col row-3-div-4" style=" background-color:  #e2e3e5; font-weight: bold;">Claims Admin
      <div class="card card-top-3-4" style="    background-color: #4169E1;">
        <div class="card-body">ICAS</div>
      </div>
      <div class="card card-bottom-3-4" style="    background-color: #4169E1;">
        <div class="card-body">SCIR</div>
      </div>
    </div>
    <div class="custom-col row-3-div-5" style=" background-color:  #e2e3e5; overflow-y: hidden;">
      <div style="margin-bottom: 10px;margin-top:-6px; font-weight: bold; font-size: 0.9rem; ">Producer Mgmt / Compensation</div>
      <div class="card-grid-3x2-div5" style="height: 65%;" >
        <div class="card card-5a"  style="    background-color: #ffc107;"><div class="card-body" style="color:#212529; font-weight: normal;">IMPACT</div></div>
        <div class="card card-5b" style="    background-color: #4169E1;"><div class="card-body"  style="color:white; font-weight: normal;">PCMN</div></div>
        <div class="card card-5c"  style="    background-color: #650030;"><div class="card-body"  style="color:white; font-weight: normal; font-size: 13px;">Life Comp</div></div>
        <div class="card card-5d" style="    background-color: #4169E1;"><div class="card-body"  style="color:white; font-weight: normal;">Bosscoft</div></div>
        <div class="card card-5e invisiblecard"><div class="card-body">Card E</div></div>
        <div class="card card-5f" style="    background-color: #4169E1;"><div class="card-body"  style="color:white; font-weight: normal;">PMAC 3</div></div>
      </div>
    </div>
    <div class="custom-col row-3-div-6" style=" background-color:  #e2e3e5; ">
      <div style="font-weight: bold; font-size: 0.9rem;margin-bottom: 10px;margin-top:-6px;">Billing & Payments Processing</div>
      <div class="card-grid-2x2-div6">
        <div class="card card-6a" style="    background-color: #4169E1;"><div class="card-body" >MPB8</div></div>
        <div class="card card-6b" style="    background-color: #4169E1;"><div class="card-body">Perpay</div></div>
        <div class="card card-6c" style="    background-color: #4169E1;"><div class="card-body">PO 8 List</div></div>
        <div class="card card-6d"  style="    background-color: #ffc107;"><div class="card-body" style="color:#212529;">RPS</div></div>
      </div>
    </div>
  </div>

  <div class="custom-row row-4">
    <div class="custom-col row-4-div-1">
      <div class="card administration-card">
        <div class="card-body">
          Analytics
        </div>
      </div>
    </div>
    <div class="custom-col row-4-div-2to6">
      <div class="flex-cards-wrapper">
        <div class="flex-card card-a" style="    background-color: #4169E1;">ALICE</div>
        <div class="flex-card card-b" style=" background-color: #650030;">Alfresco</div>
        <div class="flex-card card-c" style=" background-color: #650030;">Retaill Q</div>
        <div class="flex-card card-d" style="    background-color: #4169E1;">Conservation Database System</div>
        <div class="flex-card card-e" style="    background-color: #4169E1;">Hedge Reports</div>
        <div class="flex-card card-f" style="    background-color: #4169E1;">Midas</div>
        <div class="flex-card card-g" style="    background-color: #4169E1;">Serial Annuity</div>
        <div class="flex-card card-h" style="    background-color: #4169E1;"> Child Support</div>
      </div>
    </div>
  </div>

  <div class="custom-row row-5">
    <div class="custom-col row-5-div-1">
      <div class="card administration-card">
        <div class="card-body">
          Peripherals Systems
        </div>
      </div>
    </div>
    <div class="custom-col row-5-div-2" style=" background-color:  #e2e3e5; font-weight: bold; overflow-y: hidden;">Client Communication
      <div class="card-grid-2x2-with-footer">
        <div class="grid-section" >
          <div class="card card-5-2a" style="    background-color: #4169E1;"><div class="card-body">Statements</div></div>
          <div class="card card-5-2b" style="    background-color: #4169E1;"><div class="card-body">xPressions</div></div>
          <div class="card card-5-2c" style="    background-color: #4169E1;"><div class="card-body">Reissue Print</div></div>
          <div class="card card-5-2d" style="    background-color: #4169E1;"><div class="card-body">Contract Print</div></div>
        </div>
        <div class="card card-5-2-footer"  style="    background-color: #650030;">
          <div class="card-body">Print & Mailing Systems</div>
        </div>
      </div>
    </div>
    <div class="custom-col row-5-div-3" style=" background-color:  #e2e3e5; font-weight: bold;">Accounting
      <div class="card-grid-2x2-div5-3">
        <div class="card card-5-3a" style="    background-color: #4169E1;"><div class="card-body">GAA 8</div></div>
        <div class="card card-5-3b" style="    background-color: #4169E1;"><div class="card-body">GRL</div></div>
        <div class="card card-5-3c" style="    background-color: #4169E1;"><div class="card-body">GEAC</div></div>
        <div class="card card-5-3d invisiblecard" ><div class="card-body">Card D</div></div>
      </div>
    </div>
    <div class="custom-col row-5-div-4" style=" background-color:  #e2e3e5;  ">
      <div style="font-weight: bold; font-size:0.95rem; margin-top: -25px;">Treasury & Payment Processing</div>
      <div class="card-pair-row-5-4">
        <div class="card card-left-5-4" style="    background-color: #4169E1;"><div class="card-body">CDS</div></div>
        <div class="card card-right-5-4" style="    background-color: #4169E1;"><div class="card-body">Kyribs</div></div>
      </div>
    </div>
    <div class="custom-col row-5-div-5" style=" background-color:  #e2e3e5; font-weight: bold;"> Taxation
      <div class="card-stack-5-5">
        <!-- Top Row -->
        <div class="card-pair-5-5">
          <div class="card card-5-5a" style="    background-color: #4169E1;"><div class="card-body">Taxport</div></div>
          <div class="card card-5-5b" style="    background-color: #4169E1;"><div class="card-body">Tax 1099</div></div>
        </div>
    
        <!-- Bottom Full Width Card -->
        <div class="card card-5-5c" style="    background-color: #4169E1;">
          <div class="card-body">Premium Pro Lifee</div>
        </div>
      </div>
    </div>
    <div class="custom-col row-5-div-6" style=" background-color:  #e2e3e5; font-weight: bold;">Risk Management
      <div class="card card-5-6a" style="    background-color: #4169E1;">
        <div class="card-body" >Life Valuation</div>
      </div>
      <div class="card card-5-6b" style="    background-color: #4169E1;">
        <div class="card-body">Annuity Valuation</div>
      </div>
    </div>
  </div>

  <div class="custom-row row-6">
    <div class="custom-col row-6-div-1">
      <div class="card business-card">
        <div class="card-body" style="text-align: center;">
          Key Business Outcomes
        </div>
      </div>
    </div>
  
    <div class="custom-col row-6-div-2">
      <div class="card card-top">
        <div class="card-body">
          Illustrations
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Annuity Payouts
        </div>
      </div>
    </div>
  
    <div class="custom-col row-6-div-3">
      <div class="card card-top">
        <div class="card-body">
          Statements
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Bill
        </div>
      </div>
    </div>
  
    <div class="custom-col row-6-div-4">
      <div class="card card-top">
        <div class="card-body">
          Claim Payments
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Commission Payouts
        </div>
      </div>
    </div>
  
    <div class="custom-col row-6-div-5">
      <div class="card card-top">
        <div class="card-body">
          Query Resolution
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          BOR Updates
        </div>
      </div>
    </div>
  
    <div class="custom-col row-6-div-6">
      <div class="card card-top">
        <div class="card-body">
          Contract Updates
        </div>
      </div>
      <div class="card card-bottom">
        <div class="card-body">
          Premium Processing
        </div>
      </div>
    </div>
  </div>
  
</div>

.....................................css
/* Full width + flex behavior */
.main-container {
   width: 100vw; 
   transform: scale(0.65);
  transform-origin: top left;  
     width: 142.857%;           
   /* height: auto;  */
}

/* Each row: horizontal flex container */
.custom-row {
  display: flex;
  width: 100%;
  min-height: 15vh;
  margin-bottom: 5px;
}

/* Each column: equal width, remove borders */
.custom-col {
  flex: 1;
  padding: 10px;
  overflow: auto;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  box-sizing: border-box;
  margin-right: 15px;
}

/* Row height settings */
.row-1 { min-height: 15vh; }
.row-2 { min-height: 20vh; }
.row-3 { min-height: 20vh; }
.row-4 { min-height: 12vh; }
.row-5 { min-height: 20vh; }
.row-6 { min-height: 15vh; }

/* Background color examples */
.row-1-div-1 { background-color: #ffffff; }
.row-1-div-2 { background-color: #ffffff; }
.row-1-div-3 { background-color: #ffffff; }
.row-1-div-4 { background-color: #ffffff; }
.row-1-div-5 { background-color: #ffffff; }
.row-1-div-6 { background-color: #ffffff; }

/* Unique styling for each card */
.card-top {
  width: 100%;
  height: 45%;
  margin-bottom: 5%;
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #cce5ff;
}

.card-bottom {
  width: 100%;
  height: 45%;
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #cce5ff;
}

.business-card {
  background-color: #99ccff     ;  /* Bootstrap primary #4169E1 */
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 55%;              /* Adjust as needed */
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.2rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
.systems-interaction-card {
  background-color: #4169E1;
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 80%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.1rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
.card-grid-2x3 {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(3, 1fr);
  gap: 10px;
  width: 80%;
  height: 80%;
}

/* Base card styles */
.card-grid-2x3 .card {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 500;
  font-size: 0.95rem;
  border-radius: 8px;
  height: 80%;
}

/* Unique card colors */
.card-1 { background-color: #4169E1; } /* #4169E1 */
.card-2 { background-color: #28a745; } /* green */
.card-3 { background-color: #4169E1; } /* orange */
.card-4 { background-color: #4169E1; } /* purple */
.card-5 { background-color: #dc3545; } /* red */
.card-6 { background-color: #17a2b8; } /* teal */

.row-2 {
  min-height: 20vh;
  position: relative;         /* Enable absolute positioning inside */
  overflow: visible;          /* Allow overflow across cols */
  z-index: 0;
}

.row-2-div-2 {
  position: relative;
  overflow: visible; /* Important to allow content to overflow into Div 3 */
  background-color: #e2e3e5;
}
.bridge-card {
  position: absolute;
  bottom: 20px;              /* Appear just below the 2x3 grid */
  left: 50%;                  /* Start in middle of Div 2 */
  transform: translateX(10%); /* Nudge right into Div 3 */
  width: 82%;                /* Stretch across Div 2 + part of Div 3 */
  height: 28px;
  background-color: #ffc107;  /* Yellow */
  color: #212529;
  border-radius: 10px;
  text-align: center;
  line-height: 28px;
  font-weight: bold;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
  z-index: 5;
}
.invisiblecard{
  visibility: hidden;
}

/* Wrapper for 2 horizontal cards */
.card-pair-horizontal {
  display: flex;
  width: 100%;
  height: 100%;
  gap: 10px;
  justify-content: center;
  align-items: center;
}

/* Base style for both horizontal cards */
.horizontal-card {
  flex: 1;
  height: 30px; /* adjust as needed */
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 500;
  font-size: 0.95rem;
  color: white;
}

/* Unique colors (optional) */
.card-left {
  background-color: #ffc107; /* teal */
}

.card-right {
  background-color: #4169E1; /* purple */
}


.single-card {
  width: 100%;
  height: 28%;
  display: flex;
  border-radius: 10px;
  align-items: center;
  justify-content: center;
  border-radius: 12px;
  font-weight: 600;
  font-size: 1rem;
  color: white;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

/* Unique styles for each */
.card-div5 {
  background-color: #17a2b8; /* teal/cyan */
}

.card-div6 {
  background-color: #dc3545; /* red */
}

.administration-card {
  background-color: #4169E1;
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 80%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.1rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
.analytics-card {
  background-color: #4169E1;
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 80%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.1rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
.peripherals-card {
  background-color: #4169E1;
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 80%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.1rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
/* Regular columns keep default flex */
.row-3-div-1,
.row-3-div-4,
.row-3-div-5,
.row-3-div-6 {
  flex: 1;
}

/* Combined div spans double width */
.row-3-div-2-3 {
  flex: 2;
  padding: 10px;
  background-color: #e2e3e5; /* Light yellow background for visibility */
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
}
.card-grid-3x2 {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  width: 90%;
  height: 70%;
}

/* Base card styles */
.card-grid-3x2 .card {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 500;
  font-size: 0.95rem;
  border-radius: 8px;
  height: 70%;
}

/* Unique card colors */
.card-a { background-color: #007bff; } /* Blue */
.card-b { background-color: #28a745; } /* Green */
.card-c { background-color: #fd7e14; } /* Orange */
.card-d { background-color: #6f42c1; } /* Purple */
.card-e { background-color: #dc3545; } /* Red */
.card-f { background-color: #17a2b8; } /* Teal */


.card-top-3-4,
.card-bottom-3-4 {
  width: 90%;
  height: 25%;
  margin: 2.5% 0;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 600;
  font-size: 0.95rem;
}

/* Unique background colors */
.card-top-3-4 {
  background-color: #20c997; /* Teal green */
}

.card-bottom-3-4 {
  background-color: #ff6f61; /* Coral */
}

/* 3x2 grid for row-3-div-5 */
.card-grid-3x2-div5 {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  width: 100%;
  height: 60%;
}

/* Base card style */
.card-grid-3x2-div5 .card {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 600;
  font-size: 0.95rem;
  border-radius: 10px;
  height: 80%;
}

/* Unique colors for each card */
.card-5a { background-color: #1abc9c; }  /* turquoise */
.card-5b { background-color: #e67e22; }  /* carrot */
.card-5c { background-color: #9b59b6; }  /* amethyst */
.card-5d { background-color: #f39c12; }  /* orange */
.card-5e { background-color: #2ecc71; }  /* emerald */
.card-5f { background-color: #34495e; }  /* wet asphalt */

/* 2x2 grid for row-3-div-6 */
.card-grid-2x2-div6 {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  width: 100%;
  height: 60%;
}

/* Base style for each card */
.card-grid-2x2-div6 .card {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 600;
  font-size: 0.95rem;
  border-radius: 10px;
  height: 100%;
}

/* Unique colors */
.card-6a { background-color: #ff4757; }  /* red */
.card-6b { background-color: #1e90ff; }  /* blue */
.card-6c { background-color: #2ed573; }  /* green */
.card-6d { background-color: #ffa502; }  /* orange */

/* Row 4 - keep as is */
.row-4 {
  min-height: 12vh;
}

/* Div 1 keeps its standard width */
.row-4-div-1 {
  flex: 1;
}

/* Combined Div 2–6 */
.row-4-div-2to6 {
  flex: 5;
  padding: 10px;
  background-color: #f0f8ff; /* Alice blue for visibility */
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: bold;
}

/* Wrapper for horizontal cards */
.flex-cards-wrapper {
  display: flex;
  flex-wrap: nowrap;
  width: 100%;
  gap: 10px;
  justify-content: space-between;
}

/* Card styling */
.flex-card {
  padding: 8px 16px;
  border-radius: 8px;
  text-align: center;
  font-weight: 600;
  color: white;
  white-space: nowrap;
  flex-shrink: 1;       /* allow squeezing */
  flex-grow: 1;         /* allow growing */
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Unique card background colors */
.card-a { background-color: #007bff; }  /* Blue */
.card-b { background-color: #28a745; }  /* Green */
.card-c { background-color: #fd7e14; }  /* Orange */
.card-d { background-color: #6f42c1; }  /* Purple */
.card-e { background-color: #20c997; }  /* Teal */
.card-f { background-color: #dc3545; }  /* Red */
.card-g { background-color: #17a2b8; }  /* Cyan */
.card-h { background-color: #ffc107; }  /* Yellow */

/* Wrapper */
.card-grid-2x2-with-footer {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
  gap: 10px;
}

/* Grid Section */
.grid-section {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  flex-grow: 1;
}

/* Base card style */
.grid-section .card,
.card-5-2-footer {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: normal;
  font-size: 0.80rem;
  border-radius: 10px;
  height: 80%;
}

/* Unique colors for grid cards */
.card-5-2a { background-color: #1abc9c; }
.card-5-2b { background-color: #3498db; }
.card-5-2c { background-color: #9b59b6; }
.card-5-2d { background-color: #f39c12; }

/* Footer card */
.card-5-2-footer {
  background-color: #e74c3c;
  height: 30px;
  font-size: 0.8rem;
}
/* 2x2 grid for row-5-div-3 */
.card-grid-2x2-div5-3 {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(2, 1fr);
  gap: 10px;
  width: 100%;
  height: 100%;
}

/* Base card styling */
.card-grid-2x2-div5-3 .card {
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: normal;
  font-size: 0.95rem;
  border-radius: 10px;
  height: 75%;
  margin-top:10px;
}

/* Unique card colors */
.card-5-3a { background-color: #e67e22; }  /* carrot orange */
.card-5-3b { background-color: #16a085; }  /* green blue */
.card-5-3c { background-color: #8e44ad; }  /* purple */
.card-5-3d { background-color: #c0392b; }  /* red */

/* Horizontal card pair for row-5-div-4 */
.card-pair-row-5-4 {
  display: flex;
  width: 100%;
  height: 35%;
  gap: 10px;
  margin-top: 15px;
}

/* Base card styling */
.card-pair-row-5-4 .card {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: normal;
  font-size: 0.95rem;
  color: white;
  border-radius: 10px;
}

/* Unique card colors */
.card-left-5-4 { background-color: #27ae60; }   /* green */
.card-right-5-4 { background-color: #2980b9; }  /* blue */

/* Container for stack layout */
.card-stack-5-5 {
  display: flex;
  flex-direction: column;
  gap: 10px;
  width: 100%;
  height: 40%;
}

/* Top row pair */
.card-pair-5-5 {
  display: flex;
  gap: 10px;
  height:40%;
}

/* Base card styles */
.card-pair-5-5 .card,
.card-5-5c {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 0.95rem;
  color: white;
  border-radius: 10px;
  height: 100%;
}

/* Unique card colors */
.card-5-5a { background-color: #8e44ad; }  /* purple */
.card-5-5b { background-color: #e67e22; }  /* orange */
.card-5-5c {
  background-color: #2ecc71;              /* green */
  height: 50px;                            /* set height for bottom card */
}
/* Vertical stacked cards in row-5-div-6 */
.row-5-div-6 .card {
  width: 100%;
  height: 45%;
  margin: 2.5% 0;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 0.95rem;
  color: white;
}

/* Unique background colors */
.card-5-6a {
  background-color: #f39c12; /* orange */
}

.card-5-6b {
  background-color: #3498db; /* blue */
}

/* Row 6 base height (copied from Row 1) */
.row-6 {
  min-height: 15vh;
}

/* Background color examples (duplicate of row-1-div-x) */
.row-6-div-1 { background-color: #ffffff; }
.row-6-div-2 { background-color: #ffffff; }
.row-6-div-3 { background-color: #ffffff; }
.row-6-div-4 { background-color: #ffffff; }
.row-6-div-5 { background-color: #ffffff; }
.row-6-div-6 { background-color: #ffffff; }

/* Unique styling for each card in Row 6 (copied from Row 1) */
.row-6-div-1 .business-card {
  background-color: #99ccff  ;
  color: white;
  border-radius: 12px;
  width: 100%;
  height: 40%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 1.2rem;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

/* Row 6 Top & Bottom card styles */
.row-6-div-2 .card-top,
.row-6-div-3 .card-top,
.row-6-div-4 .card-top,
.row-6-div-5 .card-top,
.row-6-div-6 .card-top {
  width: 100%;
  height: 45%;
  margin-bottom: 5%;
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #cce5ff;
}

.row-6-div-2 .card-bottom,
.row-6-div-3 .card-bottom,
.row-6-div-4 .card-bottom,
.row-6-div-5 .card-bottom,
.row-6-div-6 .card-bottom {
  width: 100%;
  height: 45%;
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #cce5ff;
}
.card:hover {
  cursor: pointer;
  opacity: 0.9;
  transition: all 0.2s;
}
.............................................
import { Component } from '@angular/core';

@Component({
  selector: 'app-jim3',
  
 
  templateUrl: './jim3.component.html',
  styleUrl: './jim3.component.css'
})
export class Jim3Component {
  cardDescriptions: { [key: string]: string } = {
    card1: 'This is the description for Card 1. It shows transaction statistics.This is the description for Card 1. It shows transaction statistics.This is the description for Card 1. It shows transaction statistics.This is the description for Card 1. It shows transaction statistics.This is the description for Card 1. It shows transaction statistics.',
    card2: 'This is the description for Card 2. It displays system health metrics.'
  };
}
