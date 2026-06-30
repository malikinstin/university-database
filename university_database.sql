USE UNIVERSITY_DB;

-- Creates the instructor table
DROP TABLE IF EXISTS INSTRUCTOR;
CREATE TABLE INSTRUCTOR(
InstName VARCHAR(30) NOT NULL PRIMARY KEY,
InstOffice VARCHAR(30),
InstRank VARCHAR(20)
);

--Creates the course table
DROP TABLE IF EXISTS COURSE;
CREATE TABLE COURSE(
CourseNo VARCHAR(10) NOT NULL PRIMARY KEY,
Title VARCHAR(100),
CrHour INT,
InstName VARCHAR(30) NOT NULL,
FOREIGN KEY (InstName) REFERENCES INSTRUCTOR(InstName)
);


--Creates student table
DROP TABLE IF EXISTS STUDENT;
CREATE TABLE STUDENT(
StudentNo VARCHAR(10) NOT NULL PRIMARY KEY,
LastName VARCHAR(20),
FirstName VARCHAR(20),
AddressType VARCHAR(30),
City VARCHAR(20),
StateCity VARCHAR(3),
Zip VARCHAR(20),
EnrollDate DATE,
Undergrad VARCHAR(5)
);

DROP TABLE IF EXISTS GRADE;
CREATE TABLE GRADE(
InstName VARCHAR(30) NOT NULL,
StudentNo VARCHAR(10) NOT NULL,
CourseNo VARCHAR(10) NOT NULL,
StudentGrade VARCHAR(2),
PRIMARY KEY (InstName, StudentNo, CourseNo),
FOREIGN KEY (InstName) REFERENCES INSTRUCTOR(InstName),
FOREIGN KEY (StudentNo) REFERENCES STUDENT(StudentNo),
FOREIGN KEY (CourseNo) REFERENCES COURSE(CourseNo)
);

DROP TABLE IF EXISTS TAKES;
CREATE TABLE TAKES(
StudentNo VARCHAR(10) NOT NULL,
CourseNo VARCHAR(10),
PRIMARY KEY(StudentNo, CourseNo),
FOREIGN KEY (CourseNo) REFERENCES COURSE(CourseNo),
FOREIGN KEY (StudentNo) REFERENCES STUDENT(StudentNo)
);

INSERT INTO INSTRUCTOR ( InstName, InstOffice, InstRank)
VALUES ('Lujan', 'BE109', 'Assistant'),
('Morris', 'BE110', 'Full'), 
('Presley', 'BE144', 'Associate'),
('Wilke', 'BE220', 'Full');

INSERT INTO COURSE (CourseNo, Title, CrHour, InstName)
VALUES ('DIS 110', 'Introduction to DOS', 2, 'Lujan'),
('DIS 118', 'Microcomputer Applications', 3, 'Wilke'),
('DIS 138', 'Introduction to Windows', 2, 'Lujan'),
('DIS 140', 'Introduction to Databases/Access', 3, 'Presley'),
('DIS 150', 'Introduction to Spreadsheet/Excel', 2, 'Morris');

INSERT INTO STUDENT(StudentNo, LastName, FirstName, AddressType, City, StateCity, Zip, EnrollDate, Undergrad)
VALUES ('0103', 'OCasey', 'Harriet','4088 Ottumwa Way', 'Lexington', 'KY', '40515', '1997-08-25', 'Yes'),
('0122', 'Logan', 'Janet', '860 Charleston St.', 'Lexington', 'MA','55500', '1998-01-19', 'No'),
('0123', 'Hagen', 'Greg', '6065 Rainbow Falls Rd.', 'Springfield', 'MO', '65803','1997-06-10', 'Yes'),
('0139', 'Carol', 'Pat', '4018 Landers Lane', 'Lafayette', 'CO', '84548', '1997-08-25', 'Yes'),
('0148', 'Wolf', 'Bee', '1775 Bear Trail', 'Cincinati', 'OH', '45208', '1998-01-19', 'Yes'),
('0167', 'Krumple', 'Scott', '580 E Main St.', 'Lexington', 'KY', '40506-0034','1997-08-25', 'No'),
('0171', 'Harvey', 'Elliot', '34 Kerry Dr', 'El Mano', 'CO', '80646','1997-08-25', 'Yes'),
('0181', 'Zygote', 'Carrie', '8607 Ferndale St', 'Grenoble', 'CA', '91360-4260','1997-08-25', 'Yes'),
('0194', 'Loftus', 'Abner', '8077 Montana Place', 'Big Fish Bay', 'WI', '53717','1998-01-19', 'Yes'),
('0251', 'Grainger', 'John', '2256 N Sante Fe Dr.', 'Iliase', 'CA', '91210','1998-01-19', 'Yes');

INSERT INTO TAKES(StudentNo, CourseNo)
VALUES('0103', 'DIS 110'),
('0103', 'DIS 118'),
('0122', 'DIS 118'),
('0122', 'DIS 138'),
('0122', 'DIS 140'),
('0123', 'DIS 110'),
('0123', 'DIS 140'),
('0148', 'DIS 140'),
('0148', 'DIS 150'),
('0167', 'DIS 140'),
('0167', 'DIS 150'),
('0181', 'DIS 118'),
('0181', 'DIS 140'),
('0181', 'DIS 150');

INSERT INTO GRADE(InstName, StudentNo, CourseNo, StudentGrade)
VALUES ('Lujan', '0103', 'DIS 110', 'A'),
('Lujan', '0123', 'DIS 110', 'B'),
('Lujan', '0122', 'DIS 138', 'A'),
('Lujan', '0167', 'DIS 138', 'C'),
('Morris', '0148', 'DIS 150', 'C'),
('Morris', '0167', 'DIS 150', 'D'),
('Morris', '0181', 'DIS 150', 'E'),
('Presley', '0122', 'DIS 140', 'A'),
('Presley', '0123', 'DIS 140', 'B'),
('Presley', '0148', 'DIS 140', 'C'),
('Presley', '0167', 'DIS 140', 'C'),
('Presley', '0181', 'DIS 140', 'B'),
('Wilke', '0103', 'DIS 118', 'A'),
('Wilke', '0122', 'DIS 118', 'A'),
('Wilke', '0181', 'DIS 118', 'D');

SELECT * FROM INSTRUCTOR;

BEGIN TRAN;
UPDATE STUDENT
SET City ='Cincinnati'
WHERE StudentNo='0148';

SELECT StudentNo, LastName, FirstName, city
FROM STUDENT
WHERE StudentNo= '0148';

COMMIT;

BEGIN TRAN;
UPDATE STUDENT
SET City = 'London'
WHERE StudentNo = '0148';

SELECT StudentNo, LastName, FirstName, city
FROM STUDENT
WHERE StudentNo = '0148';
ROLLBACK;

ALTER TABLE INSTRUCTOR
ADD Email VARCHAR(50);

BEGIN TRAN;
DELETE FROM STUDENT
WHERE StudentNo = '0251';

SELECT * FROM STUDENT
WHERE StudentNo = '0251';
ROLLBACK;

SELECT * FROM STUDENT
WHERE StudentNo = '0251';

SELECT * FROM INSTRUCTOR;

ALTER TABLE INSTRUCTOR
ALTER COLUMN Email VARCHAR(100);

ALTER TABLE INSTRUCTOR
DROP COLUMN Email;

ALTER TABLE INSTRUCTOR
ADD CONSTRAINT UQ_InstOffice UNIQUE(InstOffice);

SELECT * FROM INSTRUCTOR
WHERE InstRank = 'Full'; 

SELECT FirstName, LastName, City
FROM STUDENT
WHERE EnrollDate > '1998-01-01';

SELECT * FROM STUDENT
WHERE EnrollDate BETWEEN '1997-08-25' AND '1998-01-19';

SELECT * FROM COURSE
WHERE CrHour IN (2, 3);

SELECT FirstName, LastName, Undergrad
FROM STUDENT
WHERE LastName LIKE 'H%';

SELECT * FROM STUDENT
WHERE Zip LIKE '%-%';

SELECT FirstName, LastName, EnrollDate
FROM STUDENT
ORDER BY EnrollDate ASC;

SELECT FirstName, LastName, EnrollDate
FROM STUDENT
ORDER BY EnrollDate DESC;

SELECT InstName as NameOfLecturer,
InstOffice OfficeLocation,
instrank as Designation
from INSTRUCTOR
where InstName= 'Lujan'


SELECT * FROM STUDENT
WHERE Undergrad IS NOT NULL;


SELECT DISTINCT StateCity FROM STUDENT;

SELECT FirstName, LastName, StateCity
FROM STUDENT
WHERE StateCity = 'KY' OR StateCity = 'CA'
ORDER BY LastName ASC;

SELECT * FROM STUDENT;
SELECT * FROM GRADE;


SELECT FirstName, LastName, CourseNo, StudentGrade
FROM STUDENT
INNER JOIN GRADE ON STUDENT.StudentNo = GRADE.StudentNo;

SELECT STUDENT.StudentNo, FirstName, LastName, COURSE.CourseNo, Title, StudentGrade
FROM STUDENT
INNER JOIN GRADE ON STUDENT.StudentNo = GRADE.StudentNo
INNER JOIN COURSE ON GRADE.CourseNo = COURSE.CourseNo;

SELECT STUDENT.StudentNo, FirstName, LastName, GRADE.CourseNo, StudentGrade
FROM STUDENT
LEFT JOIN GRADE ON STUDENT.StudentNo =GRADE.StudentNo;

SELECT STUDENT.StudentNo, FirstName, LastName, GRADE.CourseNo, StudentGrade
FROM STUDENT
LEFT JOIN GRADE ON STUDENT.StudentNo =GRADE.StudentNo
WHERE StudentGrade IS NULL;

SELECT STUDENT.StudentNo, FirstName, LastName, GRADE.CourseNo, StudentGrade
FROM STUDENT
RIGHT JOIN GRADE ON STUDENT.StudentNo = GRADE.StudentNo;

SELECT STUDENT.StudentNo, FirstName, LastName, GRADE.CourseNo, StudentGrade
FROM GRADE
LEFT JOIN STUDENT ON GRADE.StudentNo = STUDENT.StudentNo;

SELECT COURSE.CourseNO,StudentNo,Title
FROM COURSE
LEFT JOIN TAKES ON COURSE.CourseNo = TAKES.CourseNo;


SELECT * FROM TAKES;