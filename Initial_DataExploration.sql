/*
DATA EXPLORATION
SHOWCASE: AGGREGATE FUNCTIONS, COMPARISON OPERATORS, CTE'S, STRING FUNCTIONS, SUBQUERIES, TYPECASTING, WINDOW FUNCTIONS
*/





---------------------------------------------------------------------------
----- {Q: How many book have I read in each language?}

SELECT		DISTINCT Reading_Language
FROM		booklists.books_2018

SELECT		Reading_Language, COUNT(Book_Title) AS Book_Counts
FROM		booklists.books_2018
GROUP BY	Reading_Language





---------------------------------------------------------------------------
----- [Q: Have I read any translated versions?]

SELECT		Book_Author, Book_Title, Original_Language, Reading_Language
FROM		booklists.books_2018
WHERE		Original_Language <> Reading_Language

/*
SELECT		COUNT(Book_Title) AS Translated_Versions
FROM		booklists.books_2018	
WHERE		Original_Language NOT LIKE Reading_Language
*/ 





---------------------------------------------------------------------------
----- {Q: Have I read novels which are longer than 300 pages?}

SELECT		Book_Author, Book_Title, Page_Counts
FROM		booklists.books_2018
WHERE		Page_Counts >= 300 AND Fiction = TRUE
ORDER BY	Page_Counts

/*
SELECT		Book_Author, Book_Title, Page_Counts
FROM		booklists.books_2018
WHERE		CAST(Page_Counts AS VARCHAR(50)) NOT LIKE "1_%" AND CAST(Page_Counts AS VARCHAR(50)) NOT LIKE "2_%" AND Non_Fiction = FALSE
ORDER BY	Page_Counts
*/





---------------------------------------------------------------------------
------ {Q: Which are the smallest and largest books I have read?]}

SELECT		MIN(Page_Counts) AS Smallest,  -- [A: 106 pages.] 
		MAX(Page_Counts) AS Largest    -- [A: 768 pages.]
FROM		booklists.books_2019

SELECT		Book_Author, Book_Title, Page_Counts 
FROM		booklists.books_2019
WHERE		Page_Counts IN (106, 768)
ORDER BY	Page_Counts





---------------------------------------------------------------------------
------ {Q: What is the average number of pages I read in a year?}

SELECT		Reading_Year, CAST(AVG(Page_Counts) AS INT) AS Average_Pages 
FROM		booklists.books_2019
GROUP BY	Reading_Year

/*
{A: 286 pages.}

SELECT		Reading_Year, ROUND(SUM(Page_Counts)/MAX(Reading_Order)) AS Average_Pages 
FROM		booklists.books_2019
GROUP BY	Reading_Year
*/





---------------------------------------------------------------------------
------ {Q: Based on the data available, how many words have I read in the year of 2019?}

SELECT		COUNT(Word_Counts), MAX(Reading_Order)
FROM		booklists.books_2019
WHERE		Word_Counts IS NOT NULL

------ {A: 14 out of 33 rows provide data of [Word_Counts].}

SELECT		Book_Title, Page_Counts, Word_Counts, ROUND(Word_Counts/Page_Counts) Average_Per_Page
FROM		booklists.books_2019
WHERE		Word_Counts IS NOT NULL
ORDER BY	4

SELECT		ROUND(SUM(Word_Counts/Page_Counts)/COUNT(Word_Counts)) Average_Per_Page  
FROM		booklists.books_2019

/*
------ {A: The average number of words per page is 228.}

SELECT		CAST(AVG(Word_Counts/Page_Counts) AS INT) Average_Per_Page   
FROM		booklists.books_2019
*/

SELECT		Reading_Year, 
		SUM(Word_Counts) + (SELECT (SUM(Page_Counts)*228) FROM booklists.books_2019 WHERE Word_Counts IS NULL) AS Total_Words
FROM		booklists.books_2019
WHERE		Word_Counts IS NOT NULL
GROUP BY	Reading_Year

/*
------ {A: The estimated total word count for 2019 is 2.273.352 words.}

SELECT		SUM(Word_Counts) AS Records          -- {A: 1014792}      
FROM		booklists.books_2019
WHERE		Word_Counts IS NOT NULL

SELECT		(SUM(Page_Counts)*228) AS No_Records -- {A: 1258560}
FROM		booklists.books_2019
WHERE		Word_Counts IS NULL 

SELECT		1258560+101479                       -- {A: 2273352}
*/





---------------------------------------------------------------------------
----- {Q: How many books have I read in each format?}

SELECT		DISTINCT Reading_Book_Format, COUNT(Reading_Book_Format) OVER(PARTITION BY Reading_Book_Format) AS Book_Counts
FROM		booklists.books_2020





---------------------------------------------------------------------------
----- {Q: Have I read multiple books by the same author?}

SELECT		Book_Author, COUNT(Book_Title) OVER(PARTITION BY Book_Author) AS Book_Counts, Book_Title
FROM		booklists.books_2020
ORDER BY	Book_Counts DESC





---------------------------------------------------------------------------
----- {Q: How many books are written by Asian, Black or White authors?}

SELECT		COUNT(Book_Title) AS By_Asian_Authors,
		(SELECT COUNT(Book_Title) FROM booklists.books_2020 WHERE Author_Ethnicity LIKE '%Black%') AS By_Black_Authors,
		(SELECT	COUNT(Book_Title) FROM booklists.books_2020 WHERE Author_Ethnicity LIKE '%White%') AS By_White_Authors
FROM		booklists.books_2020
WHERE		Author_Ethnicity LIKE '%Asian%'





---------------------------------------------------------------------------
----- {Q: How many books are written by female authors?}

SELECT		COUNT(Book_Title) AS By_Female_Authors, 
		(SELECT COUNT(Book_Title) FROM booklists.books_2021 WHERE Author_Gender = 'M') AS By_Male_Authors
FROM		booklists.books_2021
WHERE		Author_Gender = 'F'

WITH		PercentageTable AS 
		(SELECT		100*(SELECT COUNT(Book_Title) FROM booklists.books_2021 WHERE Author_Gender = 'F')/MAX(Reading_Order) AS Percentage 
		 FROM		booklists.books_2021)
SELECT		CONCAT(ROUND(Percentage, 2), '%') AS ByFemaleAuthors
FROM		PercentageTable

------ {A: 19 Books which make up 73.08%.}





---------------------------------------------------------------------------
----- {Q: How many books are of the "Robert Langdon" series?}

WITH		RobertLangdonSeries AS
		(SELECT		COUNT(Book_Title) AS Y19_Book_Counts, 
						(SELECT COUNT(Book_Title) FROM booklists.books_2020 WHERE Book_Series = 'Robert Langdon') AS Y20_Book_Counts,
						(SELECT COUNT(Book_Title) FROM booklists.books_years_unknown WHERE Book_Series = 'Robert Langdon') AS YUK_Book_Counts        
		 FROM		booklists.books_2019` 
		 WHERE		Book_Series = 'Robert Langdon')
SELECT		Y19_Book_Counts, Y20_Book_Counts, YUK_Book_Counts, Y19_Book_Counts + Y20_Book_Counts + YUK_Book_Counts AS Total_Book_Counts
FROM		RobertLangdonSeries  




