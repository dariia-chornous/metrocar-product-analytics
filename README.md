# 🚗 Metrocar Product Analytics

> Business-oriented product analytics case study focused on user funnel performance, operational bottlenecks, conversion analysis, and platform effectiveness for the Metrocar ride-sharing service.

The project analyzes the full user journey from app download to ride completion, identifies key drop-off points, and provides actionable recommendations to improve conversion and operational efficiency.

---

## 📊 Dashboard

**Interactive Tableau dashboard:**
👉 [View on Tableau Public](https://public.tableau.com/app/profile/dariia.chornous/viz/MetrocarProductAnalyticsDashboard/MetrocarProductAnalyticsDashboard)

---

## 💡 Key Insights

* The largest drop-off (~49%) occurs between **Ride Accepted → Ride Completed**.
* Driver acceptance time above **10 minutes** leads to ~50% ride cancellations after acceptance.
* iOS demonstrates the highest revenue per download and overall platform efficiency.
* User drop-off patterns vary significantly during peak traffic hours.

---

## 🎯 Project Goals

* Analyze the end-to-end user funnel from app download to completed ride
* Identify operational bottlenecks and key user drop-off points
* Measure conversion rates across funnel stages
* Analyze the impact of driver acceptance time on ride cancellations
* Compare platform effectiveness across iOS, Android, and Web
* Provide business-oriented recommendations to improve conversion and operational performance

---

## 🛠️ Tools & Stack

| Tool / Technology              | Purpose                                                    |
| ------------------------------ | ---------------------------------------------------------- |
| **SQL (PostgreSQL)**           | Data extraction, joins, aggregations, funnel calculations  |
| **Tableau Public**             | Interactive dashboard and data visualization               |
| **Google Sheets / Excel**      | Metric validation, exploratory analysis, chart prototyping |
| **CSV datasets**               | Aggregated analytical datasets for visualization           |
| **Product & Funnel Analytics** | Funnel conversion and drop-off analysis                    |

---

## 📁 Project Structure

```text
metrocar-product-analytics/
│
├── README.md
├── .gitignore
│
├── data/
│   └── csv/
│       ├── active_ride_completed_users.csv
│       ├── conversion.csv
│       ├── drop-off_days.csv
│       ├── drop-off_hours.csv
│       ├── drop-off_hours_days_heatmap.csv
│       ├── drop-off_points.csv
│       ├── funnel.csv
│       ├── platforms_effectiveness.csv
│       └── time_to_accept.csv
│
├── spreadsheet/
│   └── Metrocar_Product_Analytics.xlsx
│
├── sql/
│   ├── 01_funnel_users.sql
│   ├── 02_funnel_conversion.sql
│   ├── 03_drop_off_points.sql
│   ├── 04_drop_off_hours.sql
│   ├── 05_drop_off_days.sql
│   ├── 06_time_to_accept.sql
│   ├── 07_platforms_effectiveness.sql
│   ├── 08_active_ride_completed_users.sql
│   └── 09_drop_off_hours_days_heatmap.sql
│
├── dashboard/
│   └── Metrocar_Product_Analytics_Dashboard.twbx
│
└── docs/
    └── Metrocar_Product_Analytics_Report.pdf
```

---

## 🔍 Analysis Areas

### 1. Funnel Conversion Analysis

Analysis of the full user journey:

**Download → Signup → Ride Request → Ride Accepted → Ride Completed → Payment → Review**

The analysis identifies:

* conversion rates between funnel stages
* largest drop-off points
* overall funnel performance

---

### 2. Drop-off & Operational Bottlenecks

Analysis of where and when users abandon the process:

* drop-off between funnel stages
* drop-off patterns by hour of day
* drop-off patterns by weekday
* heatmap analysis of peak drop-off periods
* operational bottlenecks impacting ride completion

---

### 3. Driver Acceptance Time Analysis

Analysis of how driver acceptance time impacts ride cancellations after acceptance.

The project identifies a critical threshold where long waiting times significantly increase ride cancellations and negatively affect operational efficiency.

---

### 4. Platform Effectiveness Analysis

Comparison of:

* conversion to payment
* revenue per download
* total revenue
* overall platform efficiency

across:

* iOS
* Android
* Web

---

### 5. User Activity & Ride Completion Analysis

Analysis of:

* active users
* completed rides
* engagement patterns

to better understand user behavior across the ride lifecycle.

---

## 📄 Executive Report

The project includes an executive-style business report with:

* key findings
* operational insights
* business recommendations
* dashboard screenshots

Available in the [`docs/`](./docs/) folder.

---

## 📌 Business Recommendations

Based on the analysis, several optimization opportunities were identified:

* Reduce driver acceptance time below 10 minutes
* Improve ride completion rates after acceptance
* Prioritize marketing investment in iOS
* Optimize operational coverage during peak traffic hours
* Improve onboarding and user retention flows
