select * from mod8_practice

create table students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INTEGER check (age>12)
);

insert into students values (1, 'John', 'doe',20, 'john@gmail.com');
INSERT INTO students (student_id, first_name, last_name, student_age, email) VALUES
(1, 'John', 'Doe', 20, 'john@gmail.com'),
(2, 'Alice', 'Smith', 22, 'alice@gmail.com'),
(3, 'Bob', 'Johnson', 19, 'bob@gmail.com'),
(4, 'Emma', 'Williams', 21, 'emma@gmail.com'),
(5, 'Liam', 'Brown', 23, 'liam@gmail.com'),
(6, 'Olivia', 'Jones', 18, 'olivia@gmail.com'),
(7, 'Noah', 'Garcia', 20, 'noah@gmail.com'),
(8, 'Ava', 'Miller', 22, 'ava@gmail.com'),
(9, 'Elijah', 'Davis', 24, 'elijah@gmail.com'),
(10, 'Sophia', 'Rodriguez', 19, 'sophia@gmail.com'),
(11, 'James', 'Martinez', 21, 'james@gmail.com'),
(12, 'Isabella', 'Hernandez', 23, 'isabella@gmail.com'),
(13, 'William', 'Lopez', 20, 'william@gmail.com'),
(14, 'Mia', 'Gonzalez', 22, 'mia@gmail.com'),
(15, 'Benjamin', 'Wilson', 25, 'benjamin@gmail.com');

select * from students;

alter TABLE students RENAME COLUMN age to student_age;

alter TABLE students ADD COLUMN email VARCHAR(50) NOT NULL;

alter Table students alter COLUMN first_name set NOT NULL;

alter TABLE students ADD constraint unique_student_email unique(email);

TRUNCATE table students;

