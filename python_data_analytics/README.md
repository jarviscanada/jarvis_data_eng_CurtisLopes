# Python Data Analytics - LGS
## Introduction
London Gift Shop (LGS) is a UK-based online retailer seeking to 
boost revenue by gaining a better understanding of customer behaviour.
This is a proof of concept project that analyzes historical purchase 
data to help the marketing team design personalized  campaigns for different 
customer segments.

The project was completed using Python, PSQL database, docker, and Jupyter Notebook. We used 
libraries such as Pandas, Matplotlib and Seaborn to perform data analysis
and visualization. Using these tools we built an RFM (Recency, Frequency, Monetary)
model to segment customers. These insights can be used by the LGS marketing team
to create campaign strategies such as promotions for high-value customers, or reactivation
campaigns for lapsed buyers. The project was deployed using Jupyter Notebook and GitHub.

# Implementation
## Project Architecture
LGS Team provided raw data in the form of an SQL file
-->Setup a PSQL data Warehouse, provisioned using a docker container
-->Used Jupyter Notebook running in docker to complete data analysis,
-->created docker network, connecting the Notebook to the PSQL data warehouse
-->Uploaded Notebook to GitHub for LGS's Marketing Team

## Data Analytics and Wrangling
[View the analysis notebook](./python_data_analytics/retail_data_analytics_wrangling.ipynb)

# Improvements
1. Integrate with a Web App so LGS stakeholders can explore segments
2. Automate Data Pipeline so RFM scores are updated regularly
3. Integration with LGS Marketing Platform to automatically generate
personalized campaigns for customer segments when specific criteria are met