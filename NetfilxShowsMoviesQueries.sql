USE NetflixMoviesShows; 

DROP TABLE IF EXISTS Title, Credit, Genre, ProdCountry, TitleHasGenre, TitleProdCountry CASCADE;

CREATE TABLE Title (
id VARCHAR(100) PRIMARY KEY, 
title VARCHAR(150) NOT NULL, 
show_type VARCHAR(7) NOT NULL, 
description TEXT, 
release_year INTEGER NOT NULL, 
age_certification VARCHAR(10), 
runtime INTEGER , 
seasons integer, 
imdb_id VARCHAR(50), 
imdb_score FLOAT, 
imdb_votes FLOAT, 
tmdb_popularity FLOAT, 
tmdb_score FLOAT
); 

CREATE TABLE Credit (
person_id INTEGER PRIMARY KEY, 
id VARCHAR(100), 
name VARCHAR(255), 
character_name VARCHAR(255), 
role VARCHAR(10), 
FOREIGN KEY (id) REFERENCES Title(id)
); 
CREATE TABLE ProdCountry(
country varchar(30) primary KEY
);

CREATE TABLE Genre(
genre_name VARCHAR(30) primary key
); 
CREATE TABLE TitleHasGenre(
title_id  VARCHAR(100) , 
genre VARCHAR(30),
PRIMARY KEY (title_id, genre), 
FOREIGN KEY (title_id) REFERENCES Title(id), 
FOREIGN KEY (genre) REFERENCES Genre(genre_name)
);

CREATE TABLE TitleProdCountry(
title_id  VARCHAR(100), 
country VARCHAR(30), 
primary key (title_id, country), 
FOREIGN KEY (title_id) REFERENCES Title(id), 
foreign key (country) references ProdCountry(country)
);

/*
to know where the files are loaded from we run this commande 
SHOW VARIABLES LIKE 'secure_file_priv';
output:
C:/ProgramData/MySQL/MySQL Server 8.0/Uploads
*/
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflixdatasets/cleaned_titles.csv'
INTO TABLE Title
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflixdatasets/cleaned_credits.csv'
INTO TABLE Credit
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflixdatasets/countries.csv'
INTO TABLE ProdCountry
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflixdatasets/genres.csv'
INTO TABLE Genre
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflixdatasets/titleHasGenre.csv'
INTO TABLE TitleHasGenre
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/netflixdatasets/titleProdCountry.csv'
INTO TABLE TitleProdCountry
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/* 1. Content Performance Analysis */
/* Find the 10 highest and the 10 lowest-rated titles on IMDb and TMDB (shows and movies) */
/*on IMDB SCORE*/
/*SHOWS*/

select title, imdb_score, show_type  from Title where show_type='SHOW' order by imdb_score DESC LIMIT 10; 
select title, imdb_score, show_type from Title where show_type='SHOW' order by imdb_score  LIMIT 10; 

/*MOVIEs*/
select title, imdb_score, show_type  from Title where show_type='MOVIE' order by imdb_score DESC LIMIT 10; 
select title, imdb_score, show_type  from Title where show_type='MOVIE' order by imdb_score  LIMIT 10; 

/*Average IMDb and TMDb Scores by Type (Show vs. Movie)*/
select show_type, round(avg(imdb_score),2) as AverageIMDB,  round(avg(tmdb_score),2) as AverageTMDB 
from Title
group by show_type; 
/*2. Genre and Category Preferences*/
/*Most Popular Genres: Identify which genres appear most frequently.
*/
select  show_type as Type, genre as Genre, count(*) as absfrequence
from Title, TitleHasGenre 
where Title.id=TitleHasGenre.title_id and show_type='MOVIE'
group by  genre
order by  absfrequence DESC; 

select  show_type as Type, genre as Genre, count(*) as absfrequence
from Title, TitleHasGenre 
where Title.id=TitleHasGenre.title_id and show_type='SHOW'
group by  genre
order by  absfrequence DESC; 

/*Trending Genres Over Time:*/

SELECT release_year as Yyear, genre, absfrequence, show_type
FROM (
    SELECT 
        Title.release_year, 
        genre, 
        COUNT(*) AS absfrequence, 
        show_type
    FROM Title
    JOIN TitleHasGenre ON Title.id = TitleHasGenre.title_id
    WHERE show_type = 'MOVIE'
    GROUP BY Title.release_year, genre
) AS genre_frequencies
JOIN (
    SELECT release_year as released_year, MAX(absfrequence) AS max_frequence
    FROM (
        SELECT 
            Title.release_year, 
            genre, 
            COUNT(*) AS absfrequence
        FROM Title
        JOIN TitleHasGenre ON Title.id = TitleHasGenre.title_id
        WHERE show_type = 'MOVIE'
        GROUP BY Title.release_year, genre
    ) AS genre_counts
    GROUP BY released_year
) AS max_per_year
ON genre_frequencies.release_year = released_year
AND genre_frequencies.absfrequence = max_per_year.max_frequence
ORDER BY genre_frequencies.release_year ;

/*Top-Rated Genres: Determine which genres have the highest average IMDb score,*/

select genre, ROUND(avg(imdb_score),2) as avgIMDB 
from Title join TitleHasGenre on Title.id=TitleHasGenre.title_id
group by genre
order by avgIMDB DESC; 

/*Top-Rated Genres: Determine which genres have the highest average tmdb_popularity */

select genre, ROUND(avg(tmdb_popularity),2) as avg_tmdbPopularity 
from Title join TitleHasGenre on Title.id=TitleHasGenre.title_id
group by genre
order by  avg_tmdbPopularity DESC; 

/*Count of movies and shows in each decade*/

/*movies and shows*/
select CONCAT(FLOOR(release_year / 10) * 10, 's') as decade, count(*) as NbRealization
From Title 
group by  decade
order by decade ; 

/* movies - shows*/
select decade, nbShows, nbMovies 
From
(select NbShowsPerYear.decade, nbShows, nbMovies 
From
((select CONCAT(FLOOR(release_year / 10) * 10, 's') as decade, count(*) as nbShows
From Title where show_type='SHOW'
group by decade 
order by decade ) as NbShowsPerYear
LEFT JOIN
(select CONCAT(FLOOR(release_year / 10) * 10, 's') as decade, count(*) as nbMovies
From Title where show_type='MOVIE'
group by decade 
order by decade) as  NbMoviesPerYear 
on NbShowsPerYear.decade=NbMoviesPerYear.decade) ) as tab1
UNION (select NbShowsPerYear.decade, nbShows, nbMovies 
From
((select CONCAT(FLOOR(release_year / 10) * 10, 's') as decade, count(*) as nbShows
From Title where show_type='SHOW'
group by decade 
order by decade ) as NbShowsPerYear
RIGHT JOIN
(select CONCAT(FLOOR(release_year / 10) * 10, 's') as decade, count(*) as nbMovies
From Title where show_type='MOVIE'
group by decade 
order by decade) as  NbMoviesPerYear 
on NbShowsPerYear.decade=NbMoviesPerYear.decade) )  ; 

/*3. Regional Analysis*/
/*Content by Country: Count the number of titles produced by each country to understand where Netflix’s content is primarily coming from.*/
select country, count(*) as nbTitles 
from Title join TitleProdCountry on Title.id=TitleProdCountry.title_id
group by country
order by nbTitles DESC; 

/*What were the average IMDB and TMDB scores for each production country*/
select country, ROUND(avg(imdb_score),2) as avgIMDB, ROUND(avg(tmdb_score),2) as avgTMDB
from Title join TitleProdCountry on Title.id=TitleProdCountry.title_id
group by country
order by avgIMDB DESC, avgTMDB DESC ; 

/*4. Age and Certification Analysis*/
/*What were the average IMDB and TMDB scores for each age certification for shows and movies?*/
select age_certification, ROUND(avg(imdb_score),2) as avgIMDB, ROUND(avg(tmdb_score),2) as avgTMDB 
from Title
group by age_certification 
order by avgIMDB DESC, avgTMDB DESC; 

/*What were the 5 most common age certifications for movies?*/
select age_certification, count(*) as nbMoviesPerCert
from Title
where show_type='MOVIE' AND age_certification != 'N/A'
group by age_certification
order by nbMoviesPerCert DESC
limit 5;

/*5. Actor and Director Analysis*/

/*Most Frequent Actors and Directors: Identify actors and directors who appear most often in Netflix titles.*/
select person_id, name, character_name, count(*) as nb_apparitions
from Credit
where role LIKE '%ACTOR%'
group by person_id
order by nb_apparitions DESC
limit 20; 

select person_id, name, count(*) as nb_apparitions
from Credit
where role LIKE '%DIRECTOR%'
group by person_id
order by nb_apparitions DESC
limit 20; 

/* Titles and Directors of movies with high IMDB scores (>7.5) and high TMDB popularity scores (>80)*/
select Credit.name as Director, Title.title as Title
from Credit join Title on Credit.id=Title.id
where imdb_score>7.5 and  tmdb_popularity>80 and role LIKE '%DIRECTOR%' and show_type='MOVIE'; 

/*Actors who have starred in the most highly rated movies or shows*/
select Credit.name as Actor, count(*) as highlyTitles
from Credit join Title on Credit.id=Title.id
where imdb_score>8.0
and  tmdb_score>8.0
and role LIKE '%ACTOR%'
group by Actor
order by highlyTitles DESC; 

/*Which actors played the same character in multiple movies or TV shows?*/

select Credit.name as Actor, character_name, count(distinct Title.title) as nb_plays
from Credit join Title on Credit.id=Title.id
where (show_type="MOVIE" or show_type="SHOW")
group by Actor, character_name
having count(*) >=2
order by nb_plays DESC; 

/*Finding the titles and directors of movies released on or after 2010*/
select distinct title,  name as Director, release_year
from Title join Credit on Title.id = Credit.id
where show_type='MOVIE' 
and role LIKE '%DIRECTOR%'
and release_year>=2010
order by release_year DESC;

/*6. Yearly Trends*/
/*Content Released Per Year: Track the number of titles released each year to observe any growth in Netflix’s catalog.*/
select release_year, count(id) as nb_titles_realised
from Title
group by release_year
order by release_year; 
/*Genre Popularity by Year: See if certain genres gained or lost popularity over time, which could reveal changing viewer preferences.*/
select distinct genre,  release_year as year, ROUND(avg(tmdb_popularity),2) as avg_tmdbPopularity
from Title join TitleHasGenre on Title.id=TitleHasGenre.title_id
where genre in (
select genre from (select genre, ROUND(avg(tmdb_popularity),2) as avg_tmdbPopularity 
from Title join TitleHasGenre on Title.id=TitleHasGenre.title_id
group by genre
order by  avg_tmdbPopularity DESC
limit 5
) as fiveMostPop
)
group by genre, release_year
order by genre, release_year;  

/*7. Runtime and Season Analysis*/
/*Calculating the average runtime of movies and TV shows separately*/
select show_type, round(avg(runtime), 2) as runtime_min
from Title
group by show_type; 

/*Which shows on Netflix have the most seasons*/
select title as show_title, seasons as nb_seasons
from Title 
where show_type='SHOW'
order by seasons DESC 
limit 50; 
