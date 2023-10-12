-- Use the albums_db database
USE albums_db;

-- What is the primary key for the albums table?
DESCRIBE albums; 
-- A: The primary key is the id

-- What does the column named 'name' represent?
SELECT name FROM albums; 
-- A: It represents the title of the album

-- What do you think the sales column represents?
SELECT sales from albums;
-- A: It represents the number of albums sold

-- Find the name of all albums by Pink Floyd.
SELECT artist, name 
FROM albums 
WHERE artist = 'Pink Floyd';
-- A: The Dark Side of the Moon and The Wall

-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT name, release_date
FROM albums
WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
-- A: The album was released in 1967

-- What is the genre for the album Nevermind?
SELECT name, genre
FROM albums
WHERE name = 'Nevermind';
-- A: The genres are Grunge and Alternative rock

-- Which albums were released in the 1990s?
SELECT name, release_date
FROM albums
WHERE release_date > 1989 AND release_date < 2000;
-- A: The Bodyguard, Jagged Little Pill, Come On Over, Falling into You, Let's Talk About Love, Dangerous, The Immaculate Collection, Titanic, Metallica, Nevermind, Supernatural

-- Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.
SELECT name as low_selling_albums, 
sales
FROM albums
WHERE sales < 20;
-- A: Grease, Bad, Sgt.Peppers, Dirty Dancing, Let's Talk About Love, Dangerous, The Immaculate Collection, Abbey Road, Born in the U.S.A, Brothers in Arms, Titanic, Nevermind, The Wall