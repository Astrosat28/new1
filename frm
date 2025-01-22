    @GetMapping("/api/status/summary")
    public Map<String, Object> getWebsiteStatusesSummary() {
        List<WebsiteStatus> statuses = websiteStatusService.checkAllWebsites();

        long upCount = statuses.stream().filter(WebsiteStatus::isUp).count();
        long downCount = statuses.size() - upCount;

        Map<String, List<WebsiteStatus>> groupedByStatusMessage = statuses.stream()
                .collect(Collectors.groupingBy(WebsiteStatus::getStatusMessage));

        // Build the summary response
        Map<String, Object> response = new LinkedHashMap<>();
        response.put("totalWebsites", statuses.size());
        response.put("upCount", upCount);
        response.put("downCount", downCount);
        response.put("groupedByStatusMessage", groupedByStatusMessage);
        response.put("allStatuses", statuses);

        return response;
    }
....
package com.example.websitestatuschecker.controller;

import com.example.websitestatuschecker.model.WebsiteStatus;
import com.example.websitestatuschecker.service.WebsiteStatusService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
public class WebsiteStatusController {

    private static final Logger LOGGER = LoggerFactory.getLogger(WebsiteStatusController.class);

    private final WebsiteStatusService websiteStatusService;

    public WebsiteStatusController(WebsiteStatusService websiteStatusService) {
        this.websiteStatusService = websiteStatusService;
    }

    @GetMapping("/api/status")
    public List<WebsiteStatus> getWebsiteStatuses() {
        List<WebsiteStatus> statuses = websiteStatusService.checkAllWebsites();

        // Print detailed status to the console (logs)
        for (WebsiteStatus status : statuses) {
            LOGGER.info("URL: {} | Code: {} | Message: {} | IsUp: {}",
                    status.getUrl(), status.getStatusCode(),
                    status.getStatusMessage(), status.isUp());
        }

        // Return the same list as JSON in the response for Postman
        return statuses;
    }
}


...........
package com.example.websitestatuschecker.model;

public class WebsiteStatus {

    private String url;
    private int statusCode;
    private String statusMessage;
    private boolean isUp;

    public WebsiteStatus() {
    }

    public WebsiteStatus(String url, int statusCode, String statusMessage, boolean isUp) {
        this.url = url;
        this.statusCode = statusCode;
        this.statusMessage = statusMessage;
        this.isUp = isUp;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(int statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusMessage() {
        return statusMessage;
    }

    public void setStatusMessage(String statusMessage) {
        this.statusMessage = statusMessage;
    }

    public boolean isUp() {
        return isUp;
    }

    public void setUp(boolean up) {
        isUp = up;
    }

    @Override
    public String toString() {
        return "WebsiteStatus{" +
                "url='" + url + '\'' +
                ", statusCode=" + statusCode +
                ", statusMessage='" + statusMessage + '\'' +
                ", isUp=" + isUp +
                '}';
    }
}
...........
package com.example.websitestatuschecker.service;

import com.example.websitestatuschecker.model.WebsiteStatus;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

@Service
public class WebsiteStatusService {

    private static final List<String> WEBSITES = List.of(
            "https://dashboard-accurate.com/accurate",
            "https://dashboard-acc.com/accu",
            "https://das.com/accurate",
            "https://dashbo.com/accur",
            "https://dashtwo.com/rate",
            "https://dashboardonecurate.com/lk",
            "https://americari.com/urate",
            "https://bfg.nhkd-accurate.com/ac",
            "https://www.apple.com",
            "https://www.google.com"
    );

    public List<WebsiteStatus> checkAllWebsites() {
        List<WebsiteStatus> statuses = new ArrayList<>();
        RestTemplate restTemplate = new RestTemplate();

        for (String url : WEBSITES) {
            WebsiteStatus status;
            try {
                ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);

                // getStatusCode() now returns HttpStatusCode in Spring Boot 3.x
                HttpStatusCode statusCode = response.getStatusCode();

                // Option 1: Handle as HttpStatusCode, not necessarily an enum
                int rawStatus = statusCode.value(); // e.g. 200, 404, etc.
                
                // If you need a standard HttpStatus enum:
                HttpStatus httpStatus = HttpStatus.resolve(rawStatus);

                // isUp could be something like 2xx => up, else => down
                boolean isUp = (httpStatus != null && httpStatus.is2xxSuccessful());

                status = new WebsiteStatus(
                        url,
                        rawStatus,                           // store integer code
                        (httpStatus != null)
                                ? httpStatus.getReasonPhrase() // standard reason phrase
                                : "Unknown HTTP Status",
                        isUp
                );
            } catch (Exception ex) {
                status = new WebsiteStatus(
                        url,
                        0,
                        ex.getMessage(),
                        false
                );
            }
            statuses.add(status);
        }

        return statuses;
    }
}
