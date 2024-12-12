from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

urls = [
    "https://www.wordstream.com/blog/ws/2022/07/14/website-examples",
    "https://www.nytimes.com/"
]

# Set up headless Chrome
chrome_options = Options()
chrome_options.add_argument("--headless")

# Specify the path to ChromeDriver
service = Service("C:\\chromedriver.exe")
driver = webdriver.Chrome(service=service, options=chrome_options)

for url in urls:
    driver.get(url)
    
    # Wait until the document.readyState is "complete"
    try:
        WebDriverWait(driver, 30).until(
            lambda d: d.execute_script("return document.readyState") == "complete"
        )
    except Exception as e:
        print(f"{url} might not have fully loaded (document.readyState never complete). Error: {e}")
        continue

    # Now wait for a key element that signifies the page has rendered its main content.
    # Adjust selectors based on the actual structure of the page.

    try:
        if "nytimes.com" in url:
            # On NYTimes homepage, top stories block is a good indicator
            WebDriverWait(driver, 30).until(
                EC.presence_of_element_located((By.CSS_SELECTOR, "section[data-testid='block-TopStories']"))
            )
        else:
            # For the Wordstream article page, the post title is a good indicator
            WebDriverWait(driver, 30).until(
                EC.presence_of_element_located((By.CSS_SELECTOR, "h1.post-title"))
            )

        print(f"{url} is up and fully running.")
    except Exception as e:
        print(f"{url} might not have fully loaded. Error: {e}")

driver.quit()

============
import boto3
import json

# Create a client for the AWS Pricing API
pricing_client = boto3.client('pricing', region_name='us-east-1')

# Define filters based on your requirements
filters = [
    {'Type': 'TERM_MATCH', 'Field': 'ServiceCode', 'Value': 'AmazonEC2'},
    {'Type': 'TERM_MATCH', 'Field': 'instanceType', 'Value': 't2.micro'},
    {'Type': 'TERM_MATCH', 'Field': 'operatingSystem', 'Value': 'Windows'},
    {'Type': 'TERM_MATCH', 'Field': 'location', 'Value': 'US East (N. Virginia)'},
    {'Type': 'TERM_MATCH', 'Field': 'tenancy', 'Value': 'Shared'},
]

# Retrieve pricing information
response = pricing_client.get_products(
    ServiceCode='AmazonEC2',
    Filters=filters,
    MaxResults=100
)

# Parse and display pricing information
for price_item in response['PriceList']:
    price_json = json.loads(price_item)
    product = price_json['product']
    terms = price_json['terms']

    # Extract product attributes
    attributes = product['attributes']
    instance_type = attributes.get('instanceType')
    os = attributes.get('operatingSystem')
    region = attributes.get('location')
    tenancy = attributes.get('tenancy')

    # Extract pricing terms
    on_demand_terms = terms.get('OnDemand', {})
    for term_id, term in on_demand_terms.items():
        price_dimensions = term.get('priceDimensions', {})
        for dim_id, dim in price_dimensions.items():
            price_per_unit = dim.get('pricePerUnit', {}).get('USD')
            unit = dim.get('unit')

            print(f"Instance Type: {instance_type}")
            print(f"Operating System: {os}")
            print(f"Region: {region}")
            print(f"Tenancy: {tenancy}")
            print(f"Price per {unit}: ${price_per_unit}")

=====

<form [formGroup]="formGroup" style="max-width: 400px; margin-right: auto;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
      <label style="width: 30%; text-align: left;">Name</label>
      <mat-form-field style="width: 70%;">
        <input matInput style="border-radius: 25px;" placeholder="Enter Name" formControlName="name">
      </mat-form-field>
    </div>
  
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
      <label style="width: 30%; text-align: left;">Company</label>
      <mat-form-field style="width: 70%;">
        <input matInput style="border-radius: 25px;" placeholder="Enter Company" formControlName="company">
      </mat-form-field>
    </div>
  
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
      <label style="width: 30%; text-align: left;">Place</label>
      <mat-form-field style="width: 70%;">
        <input matInput style="border-radius: 25px;" placeholder="Enter Place" formControlName="place">
      </mat-form-field>
    </div>
  
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
      <label style="width: 30%; text-align: left;">Language</label>
      <mat-form-field style="width: 70%;">
        <input matInput style="border-radius: 25px;" placeholder="Enter Language" formControlName="language">
      </mat-form-field>
    </div>
  
    <button mat-raised-button color="primary" type="submit">Submit</button>
  </form>
  
