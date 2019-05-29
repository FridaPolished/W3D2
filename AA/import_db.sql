
PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS replies;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT,
  body TEXT,
  author_id INTEGER,
  
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE questions_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,  
  follower_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (follower_id) REFERENCES users(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT,
  subject_question_id INTEGER NOT NULL,
  parent_id INTEGER,
  original_author_id INTEGER NOT NULL,

  FOREIGN KEY (subject_question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (original_author_id) REFERENCES users(id)
);

CREATE TABLE likes (
  id INTEGER PRIMARY KEY,
  likes INTEGER,
  likes_user_id INTEGER NOT NULL,
  likes_question_id INTEGER NOT NULL,

  FOREIGN KEY (likes_user_id) REFERENCES users(id),
  FOREIGN KEY (likes_question_id) REFERENCES questions(id)
); 

INSERT INTO
  users (fname, lname)
VALUES
  ('John', 'Smith'),
  ('Mary', 'Brown'),
  ('Wayne', 'Bruce');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('John question', 'JohnJohn', 1),
  ('Mary question', 'MaryMary', 2),
  ('Wayne question', 'WayneWayne', 3);

INSERT INTO
  replies (body, subject_question_id)
VALUES
  ('John answer', 1),
  ('Mary answer', 2),
  ('Wayne answer', 3);

INSERT INTO
  likes (likes, likes_question_id, likes_user_id)
VALUES
  (10, 2, 3),
  (20, 3, 5),
  (100, 3, 8);
