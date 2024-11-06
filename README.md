To conduct a thorough analysis of Netflix's dataset and extract meaningful insights for the business problem, here are some recommended queries and directions for exploration:

### 1. **Content Performance Analysis**
   - **Top and Bottom Rated Titles**: Find the highest and lowest-rated titles on IMDb and TMDB. This can reveal content quality trends and help Netflix understand what types of shows/movies are well-received.
   - **Popularity vs. Ratings**: Analyze if there’s a correlation between a title’s popularity (`tmdb_popularity`) and its rating (`imdb_score`). This can help understand if highly-rated shows are also popular, or if popularity is independent of quality.

### 2. **Genre and Category Preferences**
   - **Most Popular Genres**: Identify which genres appear most frequently. You could break this down by `show_type` (TV show vs. movie) and by `release_year` to see if preferences change over time.
   - **Top-Rated Genres**: Determine which genres have the highest average IMDb score, which can give insights into the quality associated with each genre.
   - **Trending Genres Over Time**: Track the popularity of genres by year to see how trends evolve. For instance, you might find that certain genres are becoming more popular or less popular over time.

### 3. **Regional Analysis**
   - **Content by Country**: Count the number of titles produced by each country to understand where Netflix’s content is primarily coming from.
   - **Top-Rated Content by Country**: Look at IMDb scores for titles from different countries to identify if some regions produce higher-rated content on average.
   - **Popular Countries over Time**: Analyze if the content popularity by country has shifted over the years.

### 4. **Age and Certification Analysis**
   - **Content Distribution by Age Rating**: Determine the number of titles per age certification to understand the distribution of content for different age groups.
   - **Ratings by Age Certification**: Compare the IMDb scores across different age certifications to see if titles with certain ratings (e.g., PG-13 vs. R) tend to have higher or lower ratings.

### 5. **Actor and Director Analysis (Using Credits Table)**
   - **Most Frequent Actors and Directors**: Identify actors or directors who appear most often in Netflix titles. This can help highlight popular industry figures.
   - **Top-Rated Actors and Directors**: Analyze IMDb scores for titles featuring specific actors or directors, providing insight into who’s associated with higher-rated content.
   - **Genre-Specific Actors/Directors**: Identify actors or directors frequently associated with specific genres.

### 6. **Yearly Trends**
   - **Content Released Per Year**: Track the number of titles released each year to observe any growth in Netflix’s catalog.
   - **Genre Popularity by Year**: See if certain genres gained or lost popularity over time, which could reveal changing viewer preferences.

### 7. **Correlation and Aggregated Insights**
   - **Correlations Between Scores and Popularity**: Perform correlation analyses between `imdb_score`, `tmdb_score`, and `tmdb_popularity` to understand if these factors are aligned.
   - **Aggregated Score Insights**: Create summary statistics, like average `imdb_score` or `tmdb_popularity`, for each genre, country, and age certification.

Each of these analyses would provide Netflix with insights into content trends, quality, and popularity across different dimensions, helping them make data-driven decisions about their catalog.


1. What were the top 10 movies according to IMDB score?
2. What were the top 10 shows according to IMDB score? 
3. What were the bottom 10 movies according to IMDB score? 
4. What were the bottom 10 shows according to IMDB score? 
5. What were the average IMDB and TMDB scores for shows and movies? 
6. Count of movies and shows in each decade
7. What were the average IMDB and TMDB scores for each production country?
8. What were the average IMDB and TMDB scores for each age certification for shows and movies?
9. What were the 5 most common age certifications for movies?
10. Who were the top 20 actors that appeared the most in movies/shows? 
11. Who were the top 20 directors that directed the most movies/shows? 
12. Calculating the average runtime of movies and TV shows separately
13. Finding the titles and  directors of movies released on or after 2010
14. Which shows on Netflix have the most seasons?
15. Which genres had the most movies? 
16. Which genres had the most shows? 
17. Titles and Directors of movies with high IMDB scores (>7.5) and high TMDB popularity scores (>80) 
18. What were the total number of titles for each year? 
19. Actors who have starred in the most highly rated movies or shows
20. Which actors/actresses played the same character in multiple movies or TV shows? 
21. What were the top 3 most common genres?
22. Average IMDB score for leading actors/actresses in movies or shows 
