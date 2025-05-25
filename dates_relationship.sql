SELECT now();

SELECT CURRENT_DATE; 

SELECT now():: Date;

create TABLE "user" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE table blog (
    blog_id SERIAL PRIMARY KEY,
    content VARCHAR(100),
    userId INTEGER REFERENCES "user"(id) on delete CASCADE
)

insert into "user" (name) values ('john'),('jory'),('Roy'),('phil');
select * from "user";

insert into blog (content, userId) VALUES ('hello everyone', 2), ('good morning', 1), ('Good night', 3);
select * from blog;

drop Table blog;

delete  from "user" where id='2' 