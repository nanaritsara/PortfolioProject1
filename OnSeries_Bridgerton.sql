/*
OBJECTIVE: BOOK SERIES
SHOWCASE: CASE STATEMENTS, CTE'S, NUMERIC FUNCTIONS, STRING FUNCTIONS, TEMP TABLES
*/





---------------------------------------------------------------------------
----- BRIDGERTON SERIES
---------------------------------------------------------------------------


CREATE TABLE   bridgerton_series
         (Book_Author VARCHAR(50), Book_Serie VARCHAR(50), Book_Order INTEGER, Book_Title VARCHAR(50), Page_Count INTEGER,  
		  Protagonist VARCHAR(50), Protagonist_Gender VARCHAR(50), Protagonist_Age INTEGER,
          Deuteragonist VARCHAR(50), Deuteragonist_Gender VARCHAR(50), Deuteragonist_Age INTEGER)





---------------------------------------------------------------------------

----- INSERT INTO FROM INITIAL TABLES.


INSERT INTO   PortfolioProject_Books.dbo.bridgerton_series (Book_Author, Book_Serie, Book_Title, Page_Count)
SELECT		Book_Author, Book_Series, Book_Title, Page_Counts
FROM		PortfolioProject_Books.dbo.books_2021$
WHERE		Book_Series = 'Bridgerton'

INSERT INTO   PortfolioProject_Books.dbo.bridgerton_series (Book_Author, Book_Serie, Book_Title, Page_Count)
SELECT		Book_Author, Book_Series, Book_Title, Page_Counts
FROM		PortfolioProject_Books.dbo.books_2022$
WHERE		Book_Series = 'Bridgerton'





---------------------------------------------------------------------------
----- DATA COMPLETION
---------------------------------------------------------------------------


UPDATE		PortfolioProject_Books.dbo.bridgerton_series
SET		Book_Order = 1, Protagonist = 'Daphne', Protagonist_Gender = 'F', Protagonist_Age = 21,
		Deuteragonist = 'Simon Basset', Deuteragonist_Gender = 'M', Deuteragonist_Age = 29
WHERE		Book_Title = 'The Duke and I'

UPDATE		PortfolioProject_Books.dbo.bridgerton_series
SET		Book_Order = 2, Protagonist = 'Anthony', Protagonist_Gender = 'M', Protagonist_Age = 29,
		Deuteragonist = 'Kate Sheffield', Deuteragonist_Gender = 'F', Deuteragonist_Age = 21
WHERE		Book_Title = 'The Viscount Who Loved Me'

UPDATE		PortfolioProject_Books.dbo.bridgerton_series
SET		Book_Order = 3, Protagonist = 'Benedict', Protagonist_Gender = 'M', Protagonist_Age = 30,
		Deuteragonist = 'Sophie Beckett', Deuteragonist_Gender = 'F', Deuteragonist_Age = 22
WHERE		Book_Title = 'An Offer From A Gentleman'

UPDATE		PortfolioProject_Books.dbo.bridgerton_series
SET		Book_Order = 4, Protagonist = 'Colin', Protagonist_Gender = 'M', Protagonist_Age = 33,
		Deuteragonist = 'Penelope Featherington', Deuteragonist_Gender = 'F', Deuteragonist_Age = 28
WHERE    Book_Title = 'Romancing Mr. Bridgerton'

UPDATE		PortfolioProject_Books.dbo.bridgerton_series
SET		Book_Order = 5, Protagonist = 'Eloise', Protagonist_Gender = 'F', Protagonist_Age = 28,
		Deuteragonist = 'Phillip Crane', Deuteragonist_Gender = 'M', Deuteragonist_Age = 30
WHERE    Book_Title = 'To Sir Phillip, With Love'


UPDATE		PortfolioProject_Books.dbo.bridgerton_series
SET		Book_Order = 6, Protagonist = 'Francesca', Protagonist_Gender = 'F', Protagonist_Age = 26,
		Deuteragonist = 'Michael Stirling', Deuteragonist_Gender = 'M', Deuteragonist_Age = 33
WHERE    Book_Title = 'When He Was Wicked'

UPDATE		PortfolioProject_Books.dbo.bridgerton_series
SET		Book_Order = 7, Protagonist = 'Hyacinth', Protagonist_Gender = 'F', Protagonist_Age = 22,
		Deuteragonist = 'Gareth St. Clair', Deuteragonist_Gender = 'M', Deuteragonist_Age = 28
WHERE    Book_Title = 'It''s In His Kiss'


----------


INSERT INTO		PortfolioProject_Books.dbo.bridgerton_series
		(Book_Author, Book_Serie, Book_Order, Book_Title, Page_Count,
		 Protagonist, Protagonist_Gender, Protagonist_Age, 
		 Deuteragonist, Deuteragonist_Gender, Deuteragonist_Age)
VALUES   ('Julia Quinn', 'Bridgerton', 8, 'On The Way To The Wedding', 496,
          'Gregory', 'M', 26, 'Lucy Abernathy', 'F', 20)





---------------------------------------------------------------------------

----- UPDATE ON [Protagonist].


UPDATE		PortfolioProject_Books.dbo.bridgerton_series
SET		Protagonist = CONCAT(Protagonist, ' Bridgerton')





---------------------------------------------------------------------------

----- UPDATE ON [Publication].

ALTER TABLE    PortfolioProject_Books.dbo.bridgerton_series
ADD		Publication INTEGER

UPDATE		PortfolioProject_Books.dbo.bridgerton_series
SET		Publication = CASE
		WHEN Book_Order = 1 THEN 2000
		WHEN Book_Order = 2 THEN 2000
		WHEN Book_Order = 3 THEN 2001
		WHEN Book_Order = 4 THEN 2002
		WHEN Book_Order = 5 THEN 2003
		WHEN Book_Order = 6 THEN 2004
		WHEN Book_Order = 7 THEN 2005
		ELSE 2006 END





---------------------------------------------------------------------------
----- DATA EXPLORATION
---------------------------------------------------------------------------


---------------------------------------------------------------------------
----- CHARACTER'S TITLES.


SELECT		Book_Title, Protagonist, CASE
		WHEN Protagonist LIKE 'Anthony%' THEN 'Viscount Bridgerton'
		WHEN Protagonist LIKE 'Daphne%' THEN 'Duchess of Hastings'
		WHEN Protagonist LIKE 'Francesca%' THEN 'Countess of Kilmartin'
		WHEN Protagonist LIKE 'Hyacinth%' THEN 'Baroness St. Clair'
		ELSE NULL END AS Protagonist_Title,
		Deuteragonist, CASE
		WHEN Deuteragonist LIKE 'Kate%' THEN 'Viscountess Bridgerton'
		WHEN Deuteragonist LIKE 'Penelope%' THEN 'Lady Whistledown'
		WHEN Deuteragonist LIKE 'Simon%' THEN 'Duke of Hastings'
		WHEN Deuteragonist LIKE 'Phillip%' THEN 'Sir Phillip Crane'
		WHEN Deuteragonist LIKE 'Michael%' THEN 'Earl of Kilmartin'
		WHEN Deuteragonist LIKE 'Lucy%' THEN 'Lady Lucinda'
		WHEN Deuteragonist LIKE 'Gareth%' THEN 'Baron St. Clair'
		ELSE NULL END AS Deuteragonist_Title
FROM		PortfolioProject_Books.dbo.bridgerton_series
ORDER BY	Protagonist





---------------------------------------------------------------------------
----- AGE GAPS BETWEEN [Protagonist] AND [Deuteragonist].


SELECT		Book_Title, Protagonist, Deuteragonist, ABS(Protagonist_Age - Deuteragonist_Age) AS Age_Gap
FROM		PortfolioProject_Books.dbo.bridgerton_series
ORDER BY	Protagonist

SELECT		AVG(ABS(Protagonist_Age - Deuteragonist_Age)) AS Average_Age_Gap
FROM		PortfolioProject_Books.dbo.bridgerton_series





---------------------------------------------------------------------------
----- INITIAL PAGE COUNTS.


SELECT		Book_Title AS Longest_Story, CONCAT_WS(' and ', Protagonist, Deuteragonist) AS Main_Characters, Page_Count
FROM		PortfolioProject_Books.dbo.bridgerton_series
WHERE		Page_Count = (SELECT MAX(Page_Count) FROM PortfolioProject_Books.dbo.bridgerton_series)

SELECT		Book_Title AS Shortest_Story, CONCAT_WS(' and ', Protagonist, Deuteragonist) AS Main_Characters, Page_Count
FROM		PortfolioProject_Books.dbo.bridgerton_series
WHERE		Page_Count = (SELECT MIN(Page_Count) FROM PortfolioProject_Books.dbo.bridgerton_series)





---------------------------------------------------------------------------
----- OBJECTIVE: RETAIL PRICES.
---------------------------------------------------------------------------


CREATE TABLE	#bridgerton_prices
		(Book_Order INT, Book_Title VARCHAR(50), 
		 Hardcover_Pages INT, Hardcover_Price MONEY, 
		 Paperback_Pages INT, Paperback_Price MONEY, 
		 Kindle_Pages INT, Kindle_Price MONEY, 
		 Audio_Length INT, Audible_Price MONEY)


INSERT INTO		#bridgerton_prices (Book_Order, Book_Title)
SELECT		Book_Order, Book_Title
FROM		PortfolioProject_Books.dbo.bridgerton_series





----- DATA ON PRICES ARE BASED ON AMAZON.DE AND AUDIBLE.DE. THE CURRENCY IS EURO (€). THE AUDIO LENGTHS ARE IN MINUTES.


UPDATE		#bridgerton_prices
SET		Hardcover_Pages = 464, Hardcover_Price = 30.42, Paperback_Pages = 480, Paperback_Price = 7.39, 
		Kindle_Pages = 433, Kindle_Price = 8.99, Audio_Length = (12*60)+9, Audible_Price = 24.95
WHERE		Book_Order = 1

UPDATE		#bridgerton_prices
SET		Hardcover_Pages = 480, Hardcover_Price = 30.27, Paperback_Pages = 480, Paperback_Price = 7.39, 
		Kindle_Pages = 469, Kindle_Price = 5.09, Audio_Length = (12*60)+24, Audible_Price = 24.95
WHERE		Book_Order = 2

UPDATE		#bridgerton_prices
SET		Hardcover_Pages = 480, Hardcover_Price = 30.79, Paperback_Pages = 416, Paperback_Price = 7.39, 
		Kindle_Pages = 474, Kindle_Price = 5.69, Audio_Length = (12*60)+22, Audible_Price = 24.95
WHERE		Book_Order = 3

UPDATE		#bridgerton_prices
SET		Hardcover_Pages = 496, Hardcover_Price = 28.78, Paperback_Pages = 480, Paperback_Price = 7.80, 
		Kindle_Pages = 480, Kindle_Price = 1.01, Audio_Length = (13*60)+17, Audible_Price = 24.95
WHERE		Book_Order = 4

UPDATE		#bridgerton_prices
SET		Hardcover_Pages = 416, Hardcover_Price = 28.78, Paperback_Pages = 432, Paperback_Price = 8.11, 
		Kindle_Pages = 432, Kindle_Price = 4.39, Audio_Length = (11*60)+10, Audible_Price = 18.95
WHERE		Book_Order = 5

UPDATE		#bridgerton_prices
SET		Hardcover_Pages = 464, Hardcover_Price = 27.74, Paperback_Pages = 432, Paperback_Price = 7.79, 
		Kindle_Pages = 448, Kindle_Price = 5.09, Audio_Length = (11*60)+29, Audible_Price = 18.95
WHERE		Book_Order = 6

UPDATE		#bridgerton_prices
SET		Hardcover_Pages = 448, Hardcover_Price = 26.63, Paperback_Pages = 432, Paperback_Price = 8.01, 
		Kindle_Pages = 431, Kindle_Price = 5.69, Audio_Length = (11*60)+11, Audible_Price = 18.95
WHERE		Book_Order = 7

UPDATE		#bridgerton_prices
SET		Hardcover_Pages = 496, Hardcover_Price = 27.74, Paperback_Pages = 496, Paperback_Price = 7.79, 
		Kindle_Pages = 381, Kindle_Price = 5.69, Audio_Length = 13*60, Audible_Price = 24.95
WHERE		Book_Order = 8


SELECT * 
FROM PortfolioProject_Books.dbo.bridgerton_series
ORDER BY Book_Order

