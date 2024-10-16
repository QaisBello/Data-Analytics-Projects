# Measurement of Air Quality Parameters with Implications on Occupant Wellbeing At Selected Halls In The University Of Lagos

## Overview
This project focuses on measuring indoor air quality (IAQ) parameters and their potential impact on occupant well-being in university lecture halls. The study examines key IAQ parameters such as particulate matter (PM2.5, PM10), carbon dioxide (CO2), temperature, and humidity. The goal is to assess the IAQ levels and provide recommendations to improve the air quality for healthier indoor environments.

## Technologies Used
- **IAQ Monitors**: For collecting data on CO2, PM2.5, PM10, temperature, and humidity.
- **R Software**: For statistical data analysis to identify patterns in pollutant concentrations.
- **WHO & ASHRAE Standards**: Used for comparing collected data with international air quality standards.

## Steps
1. **Data Collection**:
   - A cross-sectional approach was used to gather IAQ measurements over five days in three lecture halls at the University of Lagos.
   - Air quality monitors were placed at strategic locations to capture data during peak and off-peak hours.

2. **Data Analysis**:
   - Statistical analysis was performed using **R software** to assess pollutant concentrations and compare them against WHO and ASHRAE guidelines.
   - The study identified patterns of air quality fluctuations based on occupancy rates and time of day.

3. **Comparison to Guidelines**:
   - The pollutant levels were compared to international air quality standards to determine whether they met safety thresholds.

## Key Insights
### 1. **CO2 Levels**:
   - In the **Engineering Lecture Theatre (ELT)**, CO2 concentrations frequently exceeded the ASHRAE guideline of 1000 ppm, with a peak of **3019 ppm** during peak occupancy. The average CO2 level was **1490.78 ppm**, indicating inadequate ventilation.
   - **Café 2001** and the **Glass House** had lower CO2 levels, consistently below the ASHRAE threshold, showing that their ventilation systems were more effective.
![Image alt text](https://github.com/QaisBello/Data-Analytics-Projects/blob/c3b20a9f96cfc673e8718fd7c7e9ca3c8da49c1b/Indoor%20Air%20Quaity%20Analysis/Plots/Indoor%20CO2%20levels%20%20Day%201%20to%20Day%205%20across%20the%20three%20locations.%20.png)

### 2. **PM2.5 Levels**:
   - The WHO guideline of **15 µg/m³** for PM2.5 was frequently exceeded across all locations. During peak occupancy, the highest PM2.5 level recorded was **82 µg/m³** in Café 2001.
   - The **ELT** also experienced high PM2.5 levels, with an average of **39.25 µg/m³**, indicating poor filtration and ventilation systems.
![Image alt text](https://github.com/QaisBello/Data-Analytics-Projects/blob/b91aa250a82551e2a68dfb0fcb4a847b51bd3ede/Indoor%20Air%20Quaity%20Analysis/Plots/Indoor%20PM2.5%20levels%20Day%201%20to%20Day%205%20across%20the%20three%20locations.%20.png)

### 3. **PM10 Levels**:
   - The WHO guideline of **45 µg/m³** for PM10 was consistently exceeded, with the **Glass House** peaking at **159.3 µg/m³**. This indicates particulate matter levels were often unsafe, especially during high-occupancy events.
![Image alt text](https://github.com/QaisBello/Data-Analytics-Projects/blob/c8f6024ad9dbd1358fafc06eb48dd460f5634ae4/Indoor%20Air%20Quaity%20Analysis/Plots/Indoor%20PM10%20levels%20Day%201%20to%20Day%205%20across%20the%20three%20locations.%20.png)

## Conclusion & Recommendations
- The results demonstrate that IAQ in high-occupancy educational spaces like the **ELT**, **Café 2001**, and **Glass House** is below recommended standards, particularly concerning CO2 and particulate matter.
- Immediate interventions such as upgrading ventilation systems and installing efficient air filtration units are needed to improve air quality.
- Regular IAQ assessments and real-time air quality monitoring are essential to ensure pollutant levels remain within safe limits, improving occupant well-being and comfort.

