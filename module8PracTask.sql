drop TABLE students;

create Table students (
    id SERIAL PRIMARY KEY,
    roll INTEGER UNIQUE,
    name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL check (age >10),
    department VARCHAR(50) NOT NULL,
    score NUMERIC check (score between 0 and 100) ,
    status VARCHAR(25) NOT NULL,
    last_login DATE
)

-- op1: Add a column email (VARCHAR) to the existing students table.

alter Table students ADD COLUMN email VARCHAR(50) NOT NULL;

-- op2: Rename the column email to student_email.

ALTER Table students RENAME COLUMN email to student_email; 

-- op3: Add a UNIQUE constraint to student_email.

ALTER Table students ADD constraint unique_student_email UNIQUE(student_email);

INSERT INTO students (id, roll, name, age, department, score, status, last_login, student_email) VALUES
(1, 101, 'John Doe', 20, 'CSE', 85, 'passed', '2025-05-01', 'john.doe@example.com'),
(2, 102, 'Alice Smith', 21, 'EEE', 78, 'passed', '2025-05-03', 'alice.smith@example.com'),
(3, 103, 'Bob Johnson', 22, 'CSE', 59, 'passed', '2024-05-05', 'bob.johnson@example.com'),
(4, 104, 'Emma Brown', 19, 'BBA', 92, 'passed', '2025-05-07', 'emma.brown@example.com'),
(5, 105, 'Liam Davis', 23, 'CSE', 40, 'failed', '2025-05-10', 'liam.davis@example.com'),
(6, 106, 'Olivia Wilson', 20, 'EEE', 66, 'passed', '2025-05-11', 'olivia.wilson@example.com'),
(7, 107, 'Noah Garcia', 24, 'BBA', 88, 'passed', '2025-05-12', 'noah.garcia@example.com'),
(8, 108, 'Ava Martinez', 22, 'CSE', 73, 'passed', '2025-05-13', 'ava.martinez@example.com'),
(9, 109, 'William Lee', 21, 'EEE', 51, 'passed', '2025-05-14', 'william.lee@example.com'),
(10, 110, 'Sophia Clark', 20, 'BBA', 36, 'failed', '2025-05-15', 'sophia.clark@example.com'),
(11, 111, 'James Lewis', 23, 'CSE', 95, 'passed', '2025-05-16', 'james.lewis@example.com'),
(12, 112, 'Isabella Walker', 19, 'EEE', 44, 'failed', '2024-05-17', 'isabella.walker@example.com'),
(13, 113, 'Benjamin Hall', 20, 'BBA', 67, 'passed', '2025-05-18', 'benjamin.hall@example.com'),
(14, 114, 'Mia Allen', 22, 'CSE', 89, 'passed', '2023-05-19', 'mia.allen@example.com'),
(15, 115, 'Lucas Young', 21, 'EEE', 56, 'passed', '2024-05-20', 'lucas.young@example.com'),
(16, 116, 'Charlotte Hernandez', 20, 'BBA', 39, 'failed', '2024-05-21', 'charlotte.hernandez@example.com'),
(17, 117, 'Henry King', 24, 'CSE', 77, 'passed', '2025-05-22', 'henry.king@example.com'),
(18, 118, 'Amelia Wright', 23, 'EEE', 91, 'passed', '2025-05-23', 'amelia.wright@example.com'),
(19, 119, 'Logan Scott', 22, 'BBA', 62, 'passed', '2023-05-24', 'logan.scott@example.com'),
(20, 120, 'Harper Green', 21, 'CSE', 83, 'passed', '2022-05-20', 'harper.green@example.com');


-- op4: Add a PRIMARY KEY to a new table named courses.

CREATE Table courses (
    id SERIAL,
    courseName VARCHAR(50),
    courseStudent INTEGER NOT NULL 
)

select * from courses;
drop TABLE courses;
ALTER Table courses ADD constraint pk_course_id PRIMARY KEY(id);

-- op5: Drop a column from any existing table.

ALTER TABLE courses DROP COLUMN courseStudent;

-- op6: Write a query to find all students who have a score greater than 80 and not null.

SELECT * from students where score> 80 and score IS NOT Null;

-- op7: Use the NOT operator to exclude students from a specific department.
select * from students where NOT department = 'CSE';

-- op8: Fetch students whose names start with ‘A’ using LIKE and ILIKE.

SELECT * from students where name like 'A%';

SELECT * from students where name ilike 'l%';

-- op9: Select all students whose age is between 18 and 22.

SELECT * from students where age BETWEEN 18 AND 22;

-- op10: Retrieve rows using IN for a specific set of roll numbers.

SELECT * from students where age IN (19, 21); 

-- op11: Count how many students exist in the students table.
SELECT count(id) as total_Student  from students count(id);

-- op12: Find the average score of students in a specific department.

select * from students where department='CSE';
select sum(score) as score_sum, count(id) as total_dept_student from students where department='CSE';
select avg(score) from students where department='CSE';

-- op13: Get the maximum and minimum age of all students.

select max(age) as max_age, min(age) as min_age from students;

-- op14: Update the status of students who scored less than 60 to 'failed'

update students set status ='failed' where score < 60;

-- op15: Delete students who have not logged in since last year
Select * FROM students where EXTRACT (year from last_login)  < EXTRACT (year from current_Date);
DELETE  FROM students where EXTRACT (year from last_login)  < EXTRACT (year from current_Date);

-- op16: Use LIMIT and OFFSET to fetch the second page of results (5 per page)
SELECT * FROM students LIMIT 5 OFFSET 5;

select * from students;