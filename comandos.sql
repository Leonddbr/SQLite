-- database: db.sqlite
--1
SELECT * FROM lessons WHERE course_id = (SELECT id FROM courses WHERE slug = 'html-para-iniciantes') ORDER BY lesson_order ASC;

--2
SELECT SUM(seconds) FROM lessons WHERE course_id = (SELECT id FROM courses WHERE slug = 'css-animacoes');

--3
SELECT COUNT(*), course_id FROM lessons GROUP BY course_id;

--4
SELECT SUM(seconds) as segundos ,course_id FROM lessons GROUP BY course_id ORDER BY segundos DESC;

--5
SELECT SUM(seconds) AS segundos,course_id FROM lessons  GROUP BY course_id HAVING  segundos > 2300 ORDER BY segundos DESC;

--6
SELECT SUM(seconds) as segundos , "courses"."title" FROM lessons 
JOIN courses ON lessons.course_id = courses.id
GROUP BY course_id ORDER BY segundos DESC;

--7
SELECT "id" FROM "certificates"
WHERE "user_id" = (SELECT "id" FROM "users" WHERE "email" = 'mariana@email.com');

--8
SELECT "lc"."user_id", "l"."title", "lc"."completed"
FROM "lessons" AS "l"
LEFT JOIN "lessons_completed" AS "lc"
ON "lc"."lesson_id" = "l"."id" AND "lc"."user_id" = (SELECT "id" FROM "users" WHERE "email" = 'lucas@email.com');

--9
SELECT *
FROM "lessons"
WHERE "course_id" = (SELECT "course_id" FROM "lessons" WHERE "slug" = 'funcoes-e-escopo')
AND "lesson_order" IN (
  (SELECT "lesson_order" FROM "lessons" WHERE "slug" = 'funcoes-e-escopo') - 1,
  (SELECT "lesson_order" FROM "lessons" WHERE "slug" = 'funcoes-e-escopo'),
  (SELECT "lesson_order" FROM "lessons" WHERE "slug" = 'funcoes-e-escopo') + 1
)
ORDER BY "lesson_order";

WITH "current" AS (
  SELECT "course_id", "lesson_order"
  FROM "lessons"
  WHERE "slug" = 'funcoes-e-escopo'
)
SELECT *
FROM "lessons"
WHERE "course_id" = (SELECT "course_id" FROM "current")
AND "lesson_order" IN (
  (SELECT "lesson_order" FROM "current") - 1,
  (SELECT "lesson_order" FROM "current"),
  (SELECT "lesson_order" FROM "current") + 1
)
ORDER BY "lesson_order";