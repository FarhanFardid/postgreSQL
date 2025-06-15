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
CREATE VIEW student_info AS SELECT name, department_name , score from students s JOIN departments d ON s.department_id=d.department_id;

SELECT * from student_info;