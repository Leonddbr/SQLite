-- database: db.sqlite
--1
SELECT * FROM lessons WHERE course_id = (SELECT id FROM courses WHERE slug = 'html-para-iniciantes') ORDER BY lesson_order ASC;

SELECT id FROM courses WHERE slug = 'html-para-iniciantes';