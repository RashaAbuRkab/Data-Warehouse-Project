# ⚽ Football Analytics Data Warehouse

<div style="text-align: center;">
  <img src="https://github.com/user-attachments/assets/7051763f-f01e-4444-8201-2acc577a3b57" alt="Football Analytics" width="700"/>
</div>

## 📌 Problem: Inefficient Data Management in a Sports Analytics Company

A leading football analytics company, specializing in performance statistics for Europe’s top five leagues (2014-2020), faced several challenges:


### Challenges:
#### 1️⃣ Data Fragmentation
- Match statistics, player details, and team data were scattered across multiple disconnected systems, making data retrieval inefficient.

#### 2️⃣ Slow Reporting and Analysis
- Analysts manually compiled reports, leading to delays in performance evaluations and decision-making.

#### 3️⃣ Limited Advanced Insights
- The lack of a centralized system prevented in-depth analytics such as expected goals (xG) or long-term performance trends.

---

## 💡 Solution: Building a Unified Data Warehouse

### Approach:
As Data Engineers, we collaborated with the company to understand their requirements, analyze existing data structures, and design a scalable **Star Schema** data warehouse.

#### ✅ Step 1: Data Warehouse Design
- **Data Sources:** We integrated multiple datasets:
  - `teams`
  - `leagues`
  - `players`
  - `games`
  - `team_stats`
  - `shots`
  - `appearances`

- **ETL Process:**
  - Extract, transform, and load (ETL) pipeline cleans and centralizes data.
  - Star Schema Model:
    - **Fact Tables:** Store numerical data (e.g., goals, xG, shots).
    - **Dimension Tables:** Store descriptive data (e.g., teams, players, leagues).

#### ✅ Step 2: Unified & Automated Data Processing
- The Data Warehouse becomes a **single source of truth** for all stakeholders.
- Scheduled ETL jobs ensure up-to-date and accurate data integration.

#### ✅ Step 3: Fast & Actionable Insights
- Analysts gain real-time access to key performance indicators:
  - Compare team statistics across multiple seasons.
  - Track player performance using goals, assists, xG, and disciplinary records.
  - Compute advanced metrics such as shot efficiency and expected goals (xG).

---

## 🔍 Data Model Evolution
### Before vs. After
To better illustrate the transformation, the following images showcase the **existing schema** vs. the **optimized Star Schema**:

| Legacy Schema | Optimized Star Schema |
|--------------|----------------------|
|![oldschema](https://github.com/user-attachments/assets/61146d38-19f7-43da-b4fc-1aa600ddc413) | ![starschema](https://github.com/user-attachments/assets/7d7bac87-ea6a-4a72-ae1d-3c222f8e7be0) |




## ⚙️ Setup Instructions : 
### **1️⃣ Clone the Repository :**
```bash
git clone https://github.com/YourGitHubUsername/dwh-201-final-project
```
### **2️⃣ Install Dependencies :**
```bash
pip install -r requirements.txt
```
### **3️⃣ Configure database :**
- Edit the `config/db_config.json` file with your PostgreSQL credentials.
### **4️⃣ Run the ETL Pipeline :**
```bash
    python scripts/ingestion.py
    python scripts/transformation.py
```

## 📈 Impact: A Data-Driven Football Analytics Company

### **Before Data Warehouse:**
❌ Disconnected datasets requiring manual processing.
❌ Slow reporting, leading to delayed decisions.
❌ No support for advanced statistical analysis.

### **After Data Warehouse:**
✅ **Real-Time Insights:** Faster access to key statistics.
✅ **Advanced Analytics:** Deeper player and team performance tracking.
✅ **Reliable Reporting:** Automated and accurate reports for coaches and analysts.

---

## 🎯 Conclusion
By integrating all football data into a structured **Data Warehouse**, the company can:
- Provide real-time comparative analysis of teams and players.
- Equip coaches and management with valuable metrics for training and scouting.
- Automate reporting processes, offering a competitive edge in football analytics.

This transformation has revolutionized how the company processes and leverages data, leading to **faster, smarter, and more data-driven decision-making**.

## 👨‍💻 Team Members 
### **This project was developed by:**
- Roaa Alhaddad
- Rasha Abu Rkab
- Fatma Alzahraa Alhabbash
- Shahed Althalethini


