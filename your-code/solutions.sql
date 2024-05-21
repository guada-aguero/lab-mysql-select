USE pubs;

-- Challenge 1 - Who Have Published What At Where?

SELECT 
    au.au_id AS 'AUTHOR ID',
    CONCAT(au.au_lname, ', ', au.au_fname) AS 'AUTHOR NAME',
    tt.title AS 'TITLE',
    pb.pub_name AS 'PUBLISHER',
    DATE(tt.pubdate) AS 'PUBLICATION DATE'
FROM 
    authors au
JOIN 
    titleauthor ta ON ta.au_id = au.au_id
JOIN 
    titles tt ON tt.title_id = ta.title_id
JOIN 
    publishers pb ON pb.pub_id = tt.pub_id;
	
-- Challenge 2 - Who Have Published How Many At Where?

SELECT 
    au.au_id AS 'AUTHOR ID',
    au.au_lname AS 'LAST NAME',
    au.au_fname AS 'FIRST NAME',
    pb.pub_name AS 'PUBLISHER',
    COUNT(tt.title_id) AS 'TITLE COUNT'
FROM 
    authors au
JOIN 
    titleauthor ta ON ta.au_id = au.au_id
JOIN 
    titles tt ON tt.title_id = ta.title_id 
JOIN 
    publishers pb ON pb.pub_id = tt.pub_id
GROUP BY
	au.au_id, au.au_lname, au.au_fname, pb.pub_name;
    
-- Challenge 3 - Best Selling Authors
SELECT
	au.au_id AS 'AUTHOR ID',
    au.au_lname AS 'LAST NAME',
    au.au_fname AS 'FIRST NAME',
    SUM(ss.qty) AS 'TOTAL'
FROM 
    authors au
JOIN 
    titleauthor ta ON ta.au_id = au.au_id
JOIN 
    sales ss ON ss.title_id = ta.title_id
GROUP BY
	au.au_id, au.au_lname, au.au_fname
ORDER BY 
	TOTAL DESC
LIMIT 3;

-- Challenge 4 - Best Selling Authors Ranking
SELECT
	au.au_id AS 'AUTHOR ID',
    au.au_lname AS 'LAST NAME',
    au.au_fname AS 'FIRST NAME',
    IFNULL(SUM(ss.qty), 0) AS 'TOTAL'
FROM 
    authors au
LEFT JOIN 
    titleauthor ta ON ta.au_id = au.au_id
LEFT JOIN 
    sales ss ON ss.title_id = ta.title_id
GROUP BY
	au.au_id, au.au_lname, au.au_fname
ORDER BY 
	TOTAL DESC;