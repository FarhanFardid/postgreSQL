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
    userId INTEGER REFERENCES "user"(id)
)