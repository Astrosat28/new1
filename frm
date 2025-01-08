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


