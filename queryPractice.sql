
-- All info of student table
select * from students;

select email as student_Email from students;

select first_name as serial_Students, student_age as age from students ORDER BY student_age ASC;  

select email as student_email from students where email LIKE '%benjamin%';

select upper (first_name) from students;

select * from students WHERE CONCAT(first_name, ' ', last_name) = 'John Doe'; 

select * from students WHERE student_age BETWEEN 16 AND 22; 

SELECT * from students where first_name ilike 'emma';

