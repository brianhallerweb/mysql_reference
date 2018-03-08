-- This code is all about creating and querying a 1 table database about books.

-- To run files in MySQL, you open the CLI and run source file_name.sql
-- start the cli with $ mysql -u root -p
-- Your password is "missoula"

-- Create and use a database called book_shop
CREATE DATABASE book_shop;
USE book_shop;
SELECT database();

-- Create a table of books
CREATE TABLE books
	(
		book_id INT NOT NULL AUTO_INCREMENT,
		title VARCHAR(100),
		author_fname VARCHAR(100),
		author_lname VARCHAR(100),
		released_year INT,
		stock_quantity INT,
		pages INT,
		PRIMARY KEY(book_id)
	);

-----------------------------------------
-- Basic CRUD commands

-- Insert data into the table called books
INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

-- query the entire table
SELECT * FROM books;

-- update a row (I don't want to change the books data)
UPDATE cats SET age=14 WHERE name='Misty';

-- delete a row (I don't want to change the books data)
DELETE FROM cats WHERE name='Egg';
---------------------------------------------


---------------------------------------------
-- String Functions

-- concat()
SELECT CONCAT(author_fname, ' ', author_lname) AS "Full Name" FROM books;

-- substring()
SELECT SUBSTRING(title, 1, 10) FROM books;

-- replace()
SELECT REPLACE(title, 'e ', '3') FROM books;

-- reverse()
SELECT REVERSE(author_fname) FROM books;

-- char_length()
SELECT author_lname, CHAR_LENGTH(author_lname) AS 'length' FROM books;

-- upper() and lower()
SELECT UPPER(title) FROM books;
------------------------------------------------


-------------------------------------------------
-- Refining queries

-- distinct
SELECT DISTINCT author_fname, author_lname FROM books;

-- order by
-- ORDER BY is ascending by default so you have to specify DESC if you want that
SELECT author_fname, author_lname FROM books
ORDER BY author_lname, author_fname;

-- limit
SELECT title, released_year FROM books
ORDER BY released_year DESC LIMIT 5;

-- like
-- like is basically a way of doing searches
SELECT title FROM books WHERE title LIKE '%the%';
-- the double % means that you are looking for "the" anywhere in title. If you take off one or the other, you are searching for titles that start or end with "the". If you take off both % signs, you are searching for titles that are exactly "the".
-- _ is a wildcard character. It matches any character.
--------------------------------------------------------


---------------------------------------------------------
--Aggregate functions

-- count()
SELECT COUNT(*) FROM books WHERE title LIKE '%the%';

-- group by
-- This example shows the number of books released each year.
SELECT released_year, COUNT(*) FROM books GROUP BY released_year;
-- It is important to remember that if you want to use GROUP BY with WHERE, the WHERE will always be read before the GROUP BY. If you need a WHERE after the GROUP BY, you have to use HAVING.


-- min() and max()
-- This query will find the longest book. Notice that it uses a sub query.
SELECT title, pages FROM books
WHERE pages = (SELECT Max(pages) FROM books);

-- sum()
SELECT author_fname,
       author_lname,
       Sum(pages)
FROM books
GROUP BY
    author_lname,
    author_fname;

-- avg()
SELECT author_fname, author_lname, AVG(pages) FROM books
GROUP BY author_lname, author_fname;
-----------------------------------------------------


-----------------------------------------------------
-- Logical operators

-- not equal
SELECT title FROM books WHERE released_year != 2017;

-- not like
SELECT title FROM books WHERE title NOT LIKE '%the%';

-- and
SELECT
    title,
    author_lname,
    released_year FROM books
WHERE author_lname='Eggers'
    AND released_year > 2010;
-- you can also write AND as &&

-- or
SELECT title,
       author_lname,
       released_year,
       stock_quantity
FROM   books
WHERE  author_lname = 'Eggers'
              || released_year > 2010
OR     stock_quantity > 100;

-- between and not between
-- BETWEEN is inclusive
SELECT title, released_year FROM books
WHERE released_year BETWEEN 2004 AND 2015;

-- in and not in
-- this is just a shortcut to doing a bunch of ORs (and ANDs in the case of "not in")
SELECT title, author_lname FROM books
WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');

-- case statements
-- These are often used to make a new column filled with conditional data
SELECT title, released_year,
       CASE
         WHEN released_year >= 2000 THEN 'Modern Lit'
         ELSE '20th Century Lit'
       END AS GENRE
FROM books;
----------------------------------------------------
