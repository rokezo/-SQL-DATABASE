CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    full_name VARCHAR(100)
);

CREATE TABLE genres (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(50)
);

CREATE TABLE shops (
    shop_id INT PRIMARY KEY,
    shop_name VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200),
    pages INT,
    price DECIMAL(10,2),
    sold INT,
    author_id INT,
    genre_id INT,
    shop_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
    FOREIGN KEY (shop_id) REFERENCES shops(shop_id)
);

INSERT INTO authors (author_id, full_name) VALUES 
(1, '���� ���'),
(2, '��� �����'),
(3, '����� ������');

INSERT INTO genres (genre_id, genre_name) VALUES 
(1, '����������'),
(2, '��������'),
(3, '�������');

INSERT INTO shops (shop_id, shop_name, country) VALUES 
(1, 'Book World', 'USA'),
(2, 'Book Land', 'Canada'),
(3, 'Readers Paradise', 'UK');

INSERT INTO books (book_id, title, pages, price, sold, author_id, genre_id, shop_id) VALUES 
(1, 'The Mystery of the Lost Key', 400, 15.99, 25, 1, 2, 1),
(2, 'Adventure in the Jungle', 600, 12.50, 40, 2, 3, 2),
(3, 'Future World', 550, 18.75, 35, 1, 1, 3),
(4, 'Detective Stories', 700, 20.99, 45, 2, 2, 1);

SELECT * FROM books WHERE pages > 500 AND pages < 650;

SELECT * FROM books WHERE LEFT(title, 1) IN ('A', '�');

SELECT * FROM books WHERE genre_id = (SELECT genre_id FROM genres WHERE genre_name = '��������') AND sold > 30;

SELECT * FROM books WHERE title LIKE '%Microsoft%' AND title NOT LIKE '%Windows%';

SELECT CONCAT(b.title, ', ', g.genre_name, ', ', a.full_name) AS book_info
FROM books b
JOIN genres g ON b.genre_id = g.genre_id
JOIN authors a ON b.author_id = a.author_id
WHERE b.price / b.pages < 0.65;

SELECT *
FROM books
WHERE LEN(title) - LEN(REPLACE(title, ' ', '')) = 3;


SELECT b.title AS book_title, g.genre_name, a.full_name AS author_name, b.price, b.sold, s.shop_name
FROM books b
JOIN genres g ON b.genre_id = g.genre_id
JOIN authors a ON b.author_id = a.author_id
JOIN shops s ON b.shop_id = s.shop_id
WHERE b.title NOT LIKE '%A%'
AND g.genre_name != '�������������'
AND a.full_name != '������� �����'
AND b.price BETWEEN 10 AND 20
AND b.sold >= 8
AND s.country NOT IN ('������', '����');



SELECT 'ʳ������ ������' AS [����������], CAST(COUNT(*) AS NVARCHAR(50)) AS [ʳ������] FROM authors
UNION
SELECT 'ʳ������ ����', CAST(COUNT(*) AS NVARCHAR(50)) FROM books
UNION
SELECT '������� ���� �������', FORMAT(AVG(price), 'N', 'uk-UA') AS [ֳ��] FROM books
UNION
SELECT '������� ������� �������', FORMAT(AVG(pages), 'N1', 'uk-UA') AS [�������] FROM books;


SELECT g.genre_name AS [��������], SUM(b.pages) AS [���� �������]
FROM books b
JOIN genres g ON b.genre_id = g.genre_id
GROUP BY g.genre_name;


SELECT a.full_name AS [�����], COUNT(*) AS [ʳ������ ����], SUM(b.pages) AS [���� �������]
FROM books b
JOIN authors a ON b.author_id = a.author_id
GROUP BY a.full_name;

SELECT b.title AS [����� �����], b.pages AS [ʳ������ �������]
FROM books b
JOIN genres g ON b.genre_id = g.genre_id
WHERE g.genre_name = '�������������'
ORDER BY b.pages DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;


SELECT g.genre_name AS [��������], FORMAT(AVG(b.pages), 'N1') AS [������� ������� �������]
FROM books b
JOIN genres g ON b.genre_id = g.genre_id
WHERE b.pages <= 400
GROUP BY g.genre_name;

SELECT g.genre_name AS [��������], SUM(b.pages) AS [���� �������]
FROM books b
JOIN genres g ON b.genre_id = g.genre_id
WHERE b.pages > 400 AND g.genre_name IN ('�������������', '�����������', '������')
GROUP BY g.genre_name;














