-- What are the 5 oldest users?
SELECT username, created_at FROM users ORDER BY created_at LIMIT 5;

-- What day of the week do most users register on?
SELECT dayname(created_at) AS dayofweek, count(dayname(created_at)) AS count FROM users
GROUP BY dayofweek
ORDER BY count DESC;

-- Find all the users who have never posted a photo
SELECT username from users
LEFT JOIN photos
  ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Find the most liked photo of all time
SELECT username, count(likes.photo_id) as likes from users
JOIN photos
  ON users.id = photos.user_id
JOIN likes
  ON photos.id = likes.photo_id
GROUP BY likes.photo_id
ORDER BY likes DESC
LIMIT 1;

-- How many times does the avg user post?
SELECT ((SELECT count(*) FROM photos) / (SELECT count(*) FROM users)) AS avg;

-- What are the 5 most commonly used hashtags?
SELECT tag_name, count(photo_tags.tag_id) AS count FROM tags
JOIN photo_tags
  ON tags.id = photo_tags.tag_id
GROUP BY tag_name
ORDER BY count DESC
LIMIT 5;

-- Find users who have liked every photo (suspected bots)
SELECT username, Count(*) AS num_likes
FROM users
INNER JOIN likes
  ON users.id = likes.user_id 
GROUP  BY likes.user_id
HAVING num_likes = (SELECT Count(*) FROM photos);
