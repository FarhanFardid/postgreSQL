-- Departments table structure
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY ,
    department_name VARCHAR(50) NOT NULL
);

-- Data insert to Departments Table
INSERT INTO departments (department_name) VALUES
('CSE'), ('EEE'), ('BBA'), ('ENG'), ('LAW');

-- Students Table Structure
CREATE Table students(
    student_id SERIAL PRIMARY KEY ,
    name VARCHAR(40) NOT NULL,
    age INTEGER NOT NULL  CHECK (age > 0),
    score NUMERIC,
    department_id INTEGER REFERENCES departments(department_id)  ON DELETE SET NULL
);

-- Data insert to Students Table
INSERT INTO students (name, age, score, department_id) VALUES
('Afsana Rahman', 20, 88.5, 1),
('Tanvir Alam', 22, 74.0, 2),
('Nusrat Jahan', 19, 91.2, 1),
('Hasibul Islam', 21, 66.5, 3),
('Mehzabin Chowdhury', 20, 84.3, 4),
('Fahim Khan', 23, 79.9, 2),
('Jannatul Ferdous', 18, 95.0, 1),
('Rafiq Hasan', 22, 69.4, 5),
('Sadia Karim', 20, 87.2, 3),
('Naimur Rahman', 21, 90.0, 1),
('Priya Das', 19, 73.1, 4),
('Sabbir Hossain', 22, 68.5, 2),
('Rumana Aktar', 20, 92.7, 1),
('Kawsar Mahmud', 23, 64.3, 5),
('Farzana Shumi', 21, 86.6, 3),
('Tahsin Alam', 20, 89.8, 1),
('Sumaiya Ahmed', 19, 70.2, 4),
('Shafiq Rahman', 22, 78.4, 2),
('Lubna Haque', 20, 93.1, 1),
('Arif Chowdhury', 23, 60.5, 5);



-- Course Enrollments Table Structure
CREATE TABLE course_enrollments(
    course_id SERIAL PRIMARY KEY ,
    student_id INTEGER REFERENCES students(student_id),
    course_title VARCHAR(50) NOT NULL,
    enrolled_on DATE NOT NULL
);

-- Data insert to Course Enrollments Table
INSERT INTO course_enrollments (student_id, course_title, enrolled_on) VALUES
(1, 'Data Structures', '2024-02-15'),
(2, 'Circuit Analysis', '2024-03-10'),
(3, 'Algorithms', '2024-02-20'),
(4, 'Microeconomics', '2024-03-05'),
(5, 'English Literature', '2024-04-01'),
(6, 'Digital Electronics', '2024-02-28'),
(7, 'Computer Networks', '2024-03-12'),
(8, 'Constitutional Law', '2024-01-25'),
(9, 'Financial Accounting', '2024-03-30'),
(10, 'Operating Systems', '2024-02-10'),
(11, 'Advanced Writing', '2024-03-18'),
(12, 'Signals and Systems', '2024-04-03'),
(13, 'Software Engineering', '2024-02-26'),
(14, 'Criminal Law', '2024-03-15'),
(12, 'Marketing Principles', '2024-03-25'),
(11, 'Database Systems', '2024-02-18'),
(17, 'World Literature', '2024-03-01'),
(18, 'Control Systems', '2024-03-22'),
(19, 'Artificial Intelligence', '2024-04-08'),
(20, 'International Law', '2024-02-12');



DROP TABLE students;
DROP TABLE course_enrollments;


-- Q1: Retrieve all students who scored higher than the average score.
SELECT * from students where score > (SELECT AVG(score) from students );

-- Q2: Find students whose age is greater than the average age of all students.
SELECT * from students WHERE age > (SELECT AVG(age) from students);

-- Q3: Get names of students who are enrolled in any course (use IN with subquery).
SELECT  name from students where student_id in (SELECT student_id from course_enrollments);

-- Q4: Retrieve departments with at least one student scoring above 90 (use EXISTS).

SELECT * from departments where department_id in (SELECT department_id from students WHERE score>90 );

SELECT * from departments d WHERE EXISTS(
    SELECT 1 from students  s WHERE s.department_id=d.department_id AND s.score>90
);

-- Q5: Create a view to show each student’s name, department, and score.
CREATE VIEW student_info AS 
SELECT name, department_name , score 
from students s JOIN departments d ON s.department_id=d.department_id;

-- Q6: Create a view that lists all students enrolled in any course with the enrollment date.

CREATE VIEW enrolled_students AS
SELECT  s.student_id,
    s.name,
    s.age,
    s.score,
    s.department_id,
    c.course_title,
    c.enrolled_on 
    from  students s JOIN course_enrollments c ON s.student_id = c.student_id;

-- Q7: Query from your created views to verify the data.
SELECT * from student_info;
SELECT * from enrolled_students;

-- Q8: Create a function that takes a student's score and returns a grade (e.g., A, B, C, F).
CREATE OR REPLACE FUNCTION grading_system(p_score NUMERIC)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE
 grade VARCHAR;
BEGIN
IF p_score >= 90 THEN
grade :='A';
ELSEIF p_score >= 80 THEN
grade :='B'; 
ELSEIF p_score >= 70 THEN
grade :='C';
ELSE
grade :='F';
END IF;

RETURN grade;
END;
$$;


SELECT name, score, grading_system(score) AS grade
FROM students;

-- Q9: Create a function that returns the full name and department of a student by ID.
CREATE or REPLACE FUNCTION student_detail(p_std_id INT)
RETURNS  VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE 
std_name VARCHAR;
department_title VARCHAR;
BEGIN
SELECT s.name, d.department_name INTO std_name , department_title from students s JOIN departments d ON s.department_id = d.department_id where s.student_id = p_std_id;

RETURN std_name || ' from department of - ' || department_title;
END;
$$;

SELECT * from student_detail(5);

-- Q10: Write a stored procedure to update a student's department
CREATE PROCEDURE update_dept(p_std_id INT, p_dept_id INT)
LANGUAGE plpgsql
AS
$$
BEGIN
UPDATE students 
SET department_id = p_dept_id
where student_id = p_std_id;
END;
$$;

CALL update_dept(3,2);

-- Q11: Write a procedure to delete students who haven't enrolled in any course.

CREATE OR REPLACE PROCEDURE delete_students()
LANGUAGE plpgsql
AS $$
BEGIN
DELETE from students where student_id NOT IN (SELECT student_id from course_enrollments );
  RAISE NOTICE 'Deleted students who were not enrolled in any course.';
END;
$$; 

CALL delete_students();

-- Q12: Create a trigger that automatically logs enrollment when a student is added to course_enrollments.

CREATE TABLE enrollment_logs (
    log_id SERIAL PRIMARY KEY,
    student_id INT,
    course_title VARCHAR(50),
    enrolled_on DATE,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE OR REPLACE FUNCTION log_enrollment()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO enrollment_logs(student_id, course_title, enrolled_on)
      VALUES (NEW.student_id, NEW.course_title, NEW.enrolled_on);
    
    RETURN NEW;
END;
$$;

CREATE TRIGGER trigger_log_enrollment
AFTER INSERT ON course_enrollments
FOR EACH ROW
EXECUTE FUNCTION log_enrollment();

INSERT INTO course_enrollments(student_id, course_title, enrolled_on)
VALUES (5, 'Database Systems', CURRENT_DATE);

-- Q13: Add a trigger that sets the score to 0 if a new student record is added without a score.
CREATE OR REPLACE FUNCTION default_score()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN 
IF New.score IS NULL THEN
New.score := 0;
END IF;
RETURN New;
END;
$$;

CREATE Trigger default_score_trigger
BEFORE INSERT on students
FOR EACH ROW
EXECUTE FUNCTION default_score();

INSERT INTO students (name, age, department_id) 
VALUES ('Rafiul Islam', 22, 3);

-- Q14: Add an index to the score column in the students table.

CREATE INDEX idx_student_score on students (score);


-- Q15: Add a composite index on student_id and enrolled_on in the course_enrollments table.

CREATE INDEX idx_student_enrollment 
ON course_enrollments(student_id, enrolled_on);

-- Q16: Compare query performance with and without indexes using EXPLAIN
-- Before indexing
EXPLAIN ANALYSE SELECT * from students where age >= 20;
-- After Indexing
CREATE INDEX idx_student_age on students (age);

EXPLAIN ANALYSE SELECT * from course_enrollments where enrolled_on ='2024-03-10' ;