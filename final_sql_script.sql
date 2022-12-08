-- If you had problems creating tables in steps 5 and 6 of the final,
-- this script will create enough of what you need to run the
-- queries in step 7. This is incomplete!

DROP TABLE IF EXISTS MonstersB CASCADE;
DROP TABLE IF EXISTS LocationsB CASCADE;
DROP TABLE IF EXISTS ClassesB CASCADE;
DROP TABLE IF EXISTS EnrolledB CASCADE;
DROP TABLE IF EXISTS AlumniB;

CREATE TABLE MonstersB(
  monster_id INTEGER PRIMARY KEY,
  name VARCHAR(26),
  dob DATE CHECK (dob < NOW()),
  species VARCHAR(10),
  diet VARCHAR(15),
  gpa NUMERIC(3,2),
  credits INTEGER,
  teacher BOOLEAN DEFAULT FALSE
);

DROP TABLE IF EXISTS LocationsB;
CREATE TABLE LocationsB(
  location_id INTEGER PRIMARY KEY,
  building_code CHAR(2),
  room_num INTEGER,
  capacity INTEGER
);

DROP TABLE IF EXISTS ClassesB;
CREATE TABLE ClassesB(
  class_id INTEGER PRIMARY KEY,
  title VARCHAR(20),
  location_id INTEGER,
  duration INTEGER,
  days VARCHAR(5),
  start_time TIME,
  instructor_id INTEGER,
  FOREIGN KEY(location_id) REFERENCES LocationsB(location_id),
  FOREIGN KEY(instructor_id) REFERENCES MonstersB(monster_id)
);

DROP TABLE IF EXISTS EnrolledB;
CREATE TABLE EnrolledB(
  monster_id INTEGER,
  class_id INTEGER,
  FOREIGN KEY(monster_id) REFERENCES MonstersB(monster_id),
  FOREIGN KEY(class_id) REFERENCES ClassesB(class_id),
  PRIMARY KEY(monster_id, class_id)
);

DROP TABLE IF EXISTS AlumniB;
CREATE TABLE AlumniB(
  monster_id INTEGER PRIMARY KEY,
  FOREIGN KEY(monster_id) REFERENCES MonstersB(monster_id),
  grad_year INTEGER,
  degree VARCHAR(12)
);

INSERT INTO MonstersB(monster_id, name, dob, species, diet, gpa, credits, teacher)
  VALUES(1, 'Cookie Monster', '1969-11-10', NULL, 'Cookies', 3.2, 76, FALSE);
INSERT INTO MonstersB(monster_id, name, dob, species, diet, gpa, credits, teacher)
  VALUES(2, 'Marceline', '1056-02-03', 'Vampire', 'The Color Red', 0.0, 0, TRUE);
INSERT INTO MonstersB(monster_id, name, dob, species, diet, gpa, credits, teacher)
  VALUES(3, 'Chewbacca', '1977-05-25', 'Wookie', 'Omnivore', 2.6, 24, FALSE);
INSERT INTO MonstersB(monster_id, name, dob, species, diet, gpa, credits, teacher)
  VALUES(4, 'Dracula', '1543-08-15', 'Vampire', 'Blood', 4.0, 112, TRUE);
INSERT INTO MonstersB(monster_id, name, dob, species, diet, gpa, credits, teacher)
  VALUES(5, 'Maleficent', '1856-10-26', 'Dragon', 'Carnivore', 3.8, 63, FALSE);


INSERT INTO LocationsB(location_id, building_code, room_num, capacity)
  VALUES(1, 'CL', 101, 100);
INSERT INTO LocationsB(location_id, building_code, room_num, capacity)
  VALUES(2, 'CL', 503, 34);
INSERT INTO LocationsB(location_id, building_code, room_num, capacity)
  VALUES(3, 'MU', 220, 12);

INSERT INTO ClassesB(class_id, title, location_id, duration, days, start_time, instructor_id)
  VALUES(1, 'Intro to Guitar', 3, 120, 'TH', '14:00:00', 2);
INSERT INTO ClassesB(class_id, title, location_id, duration, days, start_time, instructor_id)
  VALUES(2, 'Monser First Aid', 3, 60, 'MWF', '21:00:00', 4);

INSERT INTO EnrolledB(class_id, monster_id) -- Monster First Aid
  VALUES(2,1), (2,3), (2,5);
INSERT INTO EnrolledB(class_id, monster_id) -- Intro to Guitar
  VALUES(1,3), (1,5);

INSERT INTO AlumniB(monster_id, grad_year, degree)
  VALUES(4, 1732, 'Management');
