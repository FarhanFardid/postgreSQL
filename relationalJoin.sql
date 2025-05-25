create table writer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
) 

insert into writer (name) VALUES ('Robert'), ('Henry'),('Roy'), ('Phil');
insert into writer (id, name) VALUES (5,null);

select * FROM writer;

create table books (
    book_id SERIAL PRIMARY KEY,
    book_name VARCHAR(50),
    writer_id INTEGER REFERENCES writer(id)
)

drop table books;
insert INTO books (book_name, writer_id ) values  ('Good Boy', 2), ('Bad Boy', 3), ('Cricket', 4), ('Football', 1), ('Hockey', Null);

select * from books;

-- Full Inner Join
select * from writer join books on id = books.writer_id; 
select  book_name, name from books join writer on writer_id = writer.id; 

-- Left outer join
select name , book_name from books LEFT join writer on writer_id = writer.id;

-- Right outer join
select name , book_name from books RIGHT join writer on writer_id = writer.id;

-- Full outer join
select * from books FULL OUTER JOIN writer on writer_id = writer.id;

-- Cross join
select * from books CROSS JOIN writer;

-- Natural join
select * from books NATURAL JOIN writer;
