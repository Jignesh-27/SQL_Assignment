CREATE DATABASE IMDb;

USE imdb;

-- All column data.
SELECT * FROM imdb_top;

-- Distinct released years.
SELECT DISTINCT(Released_Year) FROM imdb_top;

-- Total number of series titles.
SELECT COUNT(Series_Title) AS No_of_Titles FROM imdb_top;

-- Titles released in year 2020.
SELECT series_title, released_year FROM imdb_top
WHERE Released_Year = 2020;

-- Average runtime among all titles.
SELECT AVG(Runtime) AS Average_Length FROM imdb_top;

-- Titles with more than 8 IMDb rating.
SELECT Series_Title, IMDB_Rating FROM imdb_top
WHERE IMDB_Rating > 8;

-- Titles and directors movies with a Meta score above 70.
SELECT Series_Title, Director, meta_score FROM imdb_top
WHERE Meta_score > 70;

-- Total gross earnings for all series.
SELECT SUM(Gross) AS Total_Collection FROM imdb_top;

-- Series titles and genres for movies with a certificate rating of 'PG'.
SELECT Series_Title, Genre, Certificate FROM imdb_top
WHERE Certificate = 'PG';

-- Titles and overviews for movies directed Quentin Tarantino.
SELECT Series_Title, Overview FROM imdb_top
WHERE Director = 'Quentin Tarantino';

-- Series title with the highest IMDB rating.
SELECT Series_Title, MAX(IMDB_Rating) AS Rating FROM imdb_top
GROUP BY Series_Title, IMDB_Rating LIMIT 1;

-- Number of movies in each genre.
SELECT Genre, COUNT(Genre) AS No_of_titles FROM imdb_top
GROUP BY Genre;

-- Series title with the maximum runtime.
SELECT Series_title, MAX(Runtime) AS Runtime FROM imdb_top GROUP BY Series_title
ORDER BY Runtime Desc Limit 1;

-- Series with a Meta_score between 60 and 80.
SELECT Series_Title, Meta_score FROM imdb_top
WHERE Meta_score BETWEEN 60 AND 80;

-- Average IMDB rating for each director.
SELECT Director, AVG(IMDB_Rating) AS Average_Rating FROM imdb_top
GROUP BY Director;

-- Series released after the year 2000 with an IMDB rating above 7.
SELECT Series_Title, Released_Year, IMDB_Rating FROM imdb_top
WHERE Released_Year > 2000 AND IMDB_Rating > 7;

-- Series with the highest number of votes.
SELECT Series_Title,No_of_Votes FROM imdb_top
ORDER BY No_of_Votes DESC LIMIT 1;

-- Series titles and star names for movies released in 2020.
SELECT Series_Title,Released_Year, Star1, Star2 FROM imdb_top
WHERE Released_Year = 2020;

-- Number of movies for each certificate rating.
SELECT Certificate, COUNT(Series_Title) AS Genrewise_Count FROM imdb_top
GROUP BY Certificate;

-- Top movies with rating in descending order.
SELECT * FROM imdb_top
ORDER BY IMDB_Rating DESC;

-- Top 5 highest-rated series with the longest runtime.
SELECT Series_title,Runtime FROM imdb_top
ORDER BY Runtime DESC LIMIT 5;

-- Total gross earnings for movies in the 'Action' genre released after 2010.
SELECT SUM(Gross) AS Total_Earning FROM imdb_top
WHERE Released_Year > 2010 AND Genre like '%Action%';

-- Series titles and overviews for movies where the number of votes is greater than the average number of votes.
SELECT Series_Title, Overview FROM imdb_top WHERE No_of_Votes >
(SELECT AVG(No_of_Votes) FROM imdb_top);

-- Series titles and released years for movies where the last digit of the released year matches the last digit of the Meta_score.
SELECT Series_Title, Released_Year, Meta_score FROM imdb_top
WHERE Released_Year LIKE '%9' AND Meta_score LIKE '%9';

-- Released years and their corresponding average IMDb ratings for movies where the average IMDb rating is greater than 7.5.
SELECT Released_year, AVG(IMDB_Rating) AS Avg_Rating FROM imdb_top 
GROUP BY Released_year HAVING Avg_Rating > 7.5;

-- Most series titles by lead actor.
SELECT star1 as Lead_Actor , count(star1) As Titles FROM imdb_top 
GROUP BY STAR1 ORDER BY Titles DESC LIMIT 1;

-- Titles where the director has also acted in at least one other movie in the database.
SELECT Series_Title FROM imdb_top
WHERE Director IN 
(SELECT DISTINCT Director FROM imdb_top WHERE Star1 = Director OR Star2 = Director OR Star3 = Director OR Star4 = Director);

-- List the names of actors who have starred in movies directed by Christopher Nolan.
SELECT DISTINCT Star1 AS Actors FROM imdb_top
WHERE Director = 'Christopher Nolan'

UNION

SELECT DISTINCT Star2 FROM imdb_top
WHERE Director = 'Christopher Nolan'

UNION

SELECT DISTINCT Star3 FROM imdb_top
WHERE Director = 'Christopher Nolan'

UNION

SELECT DISTINCT Star4 FROM imdb_top
WHERE Director = 'Christopher Nolan';

-- Genre with the highest average IMDb rating.
SELECT Genre, AVG(IMDB_Rating) AS Top_Avg_Rating FROM imdb_top
GROUP BY Genre ORDER BY Top_Avg_Rating DESC Limit 1;

-- Movies with a rating higher than the average rating of movies released in the same year.
SELECT Series_title FROM imdb_top T1
WHERE IMDB_Rating > (SELECT AVG(IMDB_Rating) FROM imdb_top T2 WHERE T1.Released_Year = T2.Released_Year);

-- Titles of movies that have a lower gross income than the average gross income of movies directed by Quentin Tarantino.
SELECT Series_title FROM imdb_top
WHERE Gross < (SELECT AVG(Gross) FROM imdb_top WHERE Director = 'Quentin Tarantino');






















