TRUNCATE TABLE users, posts RESTART IDENTITY; 

INSERT INTO users (email, username) VALUES ('email1', 'user1');
INSERT INTO users (email, username) VALUES ('email2', 'user2');
INSERT INTO posts (title, content, views, user_id) VALUES ('title1', 'content1', 5 , 1);
INSERT INTO posts (title, content, views, user_id) VALUES ('title2', 'content2', 3 , 2);
