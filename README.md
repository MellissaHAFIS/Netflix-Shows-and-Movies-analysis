# Netflix Data Analysis Project
![5 Netflix Shows For A Good Scare](https://github.com/user-attachments/assets/f4782d75-bd66-4266-ac88-a80570948251)

## Project Overview

This project involves analyzing Netflix’s extensive dataset of TV shows and movies to gain insights into various aspects such as content performance, genre preferences, regional content distribution, and popular actors and directors. The dataset consists of two files, one containing show titles and another listing the cast, with over 5,000 titles and 77,000 credits of actors and directors. The analysis covers SQL-based data extraction and data visualization for actionable insights.

## Objective

To help Netflix gather valuable insights from its extensive dataset, enabling them to better understand and cater to user preferences.

## Tools and Technologies Used

- **Python**: For data cleaning and preparation.
- **MySQL**: For storing the cleaned dataset, modeling tables, and running analytical queries.
- **Data Visualization Tool**: For final analysis and presentation: Tableau.

## Project Structure

- `data/`: Contains the raw data files (`titles.csv` and `credits.csv`).
- `notebooks/`: Python notebooks for data cleaning and preparation.
- `scripts/`: SQL scripts used for data modeling and queries, Python file for cleaning the original dataset.
- `README.md`: Project documentation.
- `images/`: Folder for images.

---

## Data Cleaning and Preparation

Data cleaning was performed using a Python notebook, which includes explicit steps for handling missing values, restructuring columns, and transforming data. Key steps in this stage:

1. **Handling Missing Values**: Used appropriate methods to fill missing data based on the type of attribute.
2. **Splitting Lists**: Converted list-type columns, like genres, into separate tables to normalize the data structure.
3. **Data Transformation**: Converted data types, handled null values, and ensured consistency.

---

## Database Modeling

The following tables were created as CSV files at the first (also in the data cleaning process) time to have a structured data storage and optimized querying then in SQL: 

- **Title**: Contains information on each Netflix title, such as name, type, description, release year, runtime, genres, IMDb and TMDb ratings.
- **Genre**: A separate table to store each unique genre, normalized for querying.
- **Credit**: Stores cast and crew information, including actor and director details.
- **Country**: A separate table to store each unique counrty code, normalized for querying.
- **TitleHasGenre**: The relationship between Title and Genre.
- **TitleHasCountry**: The relationship between Title and Country.
  
---

## Analytical SQL Queries

Here’s **an overview** of the SQL queries and the insights they aimed to uncover.

### 1. Content Performance Analysis
   - **Highest/Lowest Rated Titles**: Retrieved the 10 highest and 10 lowest-rated shows and movies on IMDb and TMDb.
   - **Average Scores by Type**: Calculated average IMDb and TMDb scores, broken down by TV show and movie.

### 2. Genre and Category Preferences
   - **Most Popular Genres**: Identified which genres appear most frequently, segmented by show type and release year.
   - **Top-Rated Genres**: Determined genres with the highest average IMDb score and TMDb popularity score.
   - **Genre Trends Over Time**: Tracked changes in genre popularity over the years.

### 3. Regional Analysis
   - **Content by Country**: Counted titles by production country to understand Netflix’s content sourcing.
   - **Average Scores by Country**: Found average IMDb and TMDb scores per country.

### 4. Age and Certification Analysis
   - **Scores by Age Certification**: Analyzed average IMDb and TMDb scores for each age certification, segmented by show type.
   - **Most Common Age Certifications**: Identified the five most frequent age certifications for movies.

### 5. Actor and Director Analysis
   - **Top Titles by Directors**: Listed titles and directors with high IMDb scores and TMDb popularity.
   - **Frequent Actors/Directors**: Found the most common actors and directors in Netflix titles.
   - **Actors with Consistent Roles**: Identified actors who played the same character in multiple shows or movies.

### 6. Yearly Trends
   - **Content Release Trends**: Counted titles released each year to observe catalog growth.
   - **Genre Popularity by Year**: Monitored genre popularity changes over time.

### 7. Runtime and Season Analysis
   - **Average Runtime**: Calculated the average runtime for movies and TV shows separately.
   - **Shows with Most Seasons**: Identified shows with the highest number of seasons.

---

## Data Visualization

The next step involves visualizing the findings to make the analysis more accessible and interpretable.

1. **Set up Tableau**: Connect Power Tableau to the MySQL database.
2. **Load Queries**: Load SQL queries into Tableau to create interactive dashboard.
3. **Key Visualizations**.

   ![Netflix shows and movies analysis](https://github.com/user-attachments/assets/9f45df15-52a9-49c6-a0a2-4fa8463dea87)


---

## How to Reproduce This Project

1. **Data Cleaning and Preparation**: Run the Python notebook in `notebooks/` for data preprocessing.
2. **Database Setup**: Run the python script, provided in `scripts/` for cleaning the dataset and produce the CleanedDataSet ( or just clone the one above). Then use the provided SQL script in `scripts/` to create tables and import cleaned data into MySQL.
3. **SQL Queries**: Run analytical queries provided in the `scripts/` folder to generate insights.
4. **Visualization**: Use Tableau to load SQL results and create interactive visualizations.

---

## Conclusion

This project provides a detailed analysis of Netflix’s TV shows and movies dataset, offering insights into performance trends, genre preferences, regional distributions, and more. By following the structured process outlined in this README, stakeholders can replicate the analysis and tailor it to specific business questions for informed decision-making.
