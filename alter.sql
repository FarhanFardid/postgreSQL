-- get  all table info
SELECT * FROM person;

-- add new table attribute column
ALTER Table person ADD COLUMN email VARCHAR(25) DEFAULT 'default@gmail.com' NOT NULL;

-- insert new values
INSERT INTO person values(6, 'Richie', 'Rich', 21, 'rr@rich.com');

-- Rename a column attribute name
ALTER TABLE person RENAME COLUMN age TO person_age;

-- Modify the attribute type 
ALTER Table person ALTER COLUMN first_name TYPE VARCHAR(50);

-- Modify the  constraint of column attribute
ALTER Table person ALTER COLUMN person_age set NOT NULL;

ALTER Table person ALTER COLUMN person_age DROP NOT NULL;