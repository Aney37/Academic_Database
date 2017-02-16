DROP TABLE course_taken;
DROP TABLE course_taught;
DROP TABLE course;
DROP TABLE student;
DROP TABLE teacher;

CREATE TABLE teacher(
	teacher_id NUMBER(10) NOT NULL,
	teacher_name VARCHAR(30),
	address VARCHAR(30),
	joining_date date,
		PRIMARY KEY (teacher_id)
);

CREATE TABLE student(
	student_roll NUMBER(10) NOT NULL,
	student_name VARCHAR(30),
	gender VARCHAR(10),
	religion VARCHAR(20),
	address VARCHAR(20),
	email VARCHAR(50),
	adviser_id NUMBER(10),
	cgpa NUMBER(3,2),
	department VARCHAR(20) DEFAULT 'CSE' ,
		PRIMARY KEY (student_roll),
		FOREIGN KEY (adviser_id) REFERENCES teacher (teacher_id) ON DELETE CASCADE
);

CREATE TABLE course(
	course_no VARCHAR(20) NOT NULL,
	course_name VARCHAR(50) UNIQUE,
	credit NUMBER(3,2) CHECK(credit>0 AND credit<5),
		PRIMARY KEY (course_no)
);

CREATE TABLE course_taught(
	teacher_id NUMBER(10),
	course_no VARCHAR(20),
	year VARCHAR(10),
	term VARCHAR(10),
		--PRIMARY KEY (teacher_id,course_no),
		FOREIGN KEY (teacher_id) REFERENCES teacher (teacher_id) ON DELETE CASCADE,
		FOREIGN KEY (course_no) REFERENCES course (course_no) ON DELETE CASCADE
);

CREATE TABLE course_taken(
	student_roll NUMBER(10),
	course_no VARCHAR(20),	
	year VARCHAR(10),
	term VARCHAR(10),
		PRIMARY KEY (student_roll,course_no),
		--FOREIGN KEY (student_roll) REFERENCES student (student_roll) ON DELETE CASCADE,
		FOREIGN KEY (course_no) REFERENCES course (course_no) ON DELETE CASCADE
);

describe teacher;
describe student;
describe course;
describe course_taught;
describe course_taken;



ALTER TABLE course_taught ADD CONSTRAINT constraint1
	PRIMARY KEY (teacher_id,course_no);
ALTER TABLE course_taken ADD CONSTRAINT constraint2
	FOREIGN KEY (student_roll) REFERENCES student (student_roll);

DESCRIBE course_taught;
DESCRIBE course_taken;


                  ----------------- TRIGGER START -----------------

CREATE OR REPLACE TRIGGER check_roll BEFORE INSERT OR UPDATE ON student
FOR EACH ROW
DECLARE
   c_min number := 1207001;
   c_max number := 1207060;
BEGIN
  IF :new.student_roll > c_max OR :new.student_roll < c_min THEN
  RAISE_APPLICATION_ERROR(-20000,'Invalid Roll');
END IF;
END;
/
                      
                 ----------------- TRIGGER END ----------------------



                 ----------------- INSERT DATA START -------------------

insert into teacher(teacher_id,teacher_name,address,joining_date) values(1,'A','Khulna','03-JUN-10');
insert into teacher(teacher_id,teacher_name,address,joining_date) values(2,'B','Dhaka','06-MAR-11');
insert into teacher(teacher_id,teacher_name,address,joining_date) values(3,'C','Khulna','25-AUG-09');
insert into teacher(teacher_id,teacher_name,address,joining_date) values(4,'D','Rajshahi','11-MAY-12');
insert into teacher(teacher_id,teacher_name,address,joining_date) values(5,'E','Mymensingh','16-FEB-09');
insert into teacher(teacher_id,teacher_name,address,joining_date) values(6,'F','Mymensingh','01-JAN-13');
insert into teacher(teacher_id,teacher_name,address,joining_date) values(7,'G','Mymensingh','16-FEB-09');
insert into teacher(teacher_id,teacher_name,address,joining_date) values(8,'H','Dhaka','17-NOV-12');


insert into student(student_roll,student_name,gender,religion,address,email,adviser_id,cgpa) values(1207003,'Tanim','Male','Islam','Jessore','mama@yahoo.com',1,3.33);
insert into student(student_roll,student_name,gender,religion,address,email,adviser_id,cgpa) values(1207004,'Opu','Male','Islam','Dhaka','opu@yahoo.com',5,3.21);
insert into student(student_roll,student_name,gender,religion,address,email,adviser_id,cgpa) values(1207005,'Golap','Male','Islam','Rajshahi','golu@yahoo.com',4,3.67);
insert into student(student_roll,student_name,gender,religion,address,email,adviser_id,cgpa) values(1207036,'Rifat','Male','Islam','Khulna','amit@yahoo.com',8,3.78);
insert into student(student_roll,student_name,gender,religion,address,email,adviser_id,cgpa) values(1207046,'Saif','Male','Islam','Dhaka','vez@yahoo.com',3,3.45);
insert into student(student_roll,student_name,gender,religion,address,email,adviser_id,cgpa) values(1207039,'Mashfi','Female','Islam','Barisal','mashfi@yahoo.com',6,3.22);
insert into student(student_roll,student_name,gender,religion,address,email,adviser_id,cgpa) values(1207033,'Ashik','Male','Islam','Khulna','proshik@yahoo.com',4,3.39);
insert into student(student_roll,student_name,gender,religion,address,email,adviser_id,cgpa) values(1207035,'Prome','Female','Islam','Rajshahi','dalim@yahoo.com',1,3.55);
insert into student(student_roll,student_name,gender,religion,address,email,adviser_id,cgpa) values(1207048,'Rima','Female','Islam','Barisal','rima@yahoo.com',2,3.62);
insert into student(student_roll,student_name,gender,religion,address,email,adviser_id,cgpa) values(1207037,'Aney','Female','Hindu','Dhaka','aney@yahoo.com',8,3.92);


insert into course(course_no,course_name,credit) values('cse 3109','Database system',3.00);
insert into course(course_no,course_name,credit) values('cse 3110','Database system lab',1.50);
insert into course(course_no,course_name,credit) values('cse 3119','Software engineering',4.00);
insert into course(course_no,course_name,credit) values('cse 3120','Software engineering lab',1.50);
insert into course(course_no,course_name,credit) values('cse 3103','Microprocessor',3.00);
insert into course(course_no,course_name,credit) values('cse 3104','Microprocessor lab',1.50);
insert into course(course_no,course_name,credit) values('cse 3101','Theory of computation',2.00);


insert into course_taught(teacher_id,course_no,year,term) values(1,'cse 3109','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(2,'cse 3109','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(1,'cse 3110','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(2,'cse 3110','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(3,'cse 3119','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(6,'cse 3119','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(3,'cse 3120','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(4,'cse 3120','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(2,'cse 3103','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(5,'cse 3103','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(2,'cse 3104','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(5,'cse 3104','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(7,'cse 3101','3rd','1st');
insert into course_taught(teacher_id,course_no,year,term) values(8,'cse 3101','3rd','1st');


insert into course_taken(student_roll,course_no,year,term) values(1207037,'cse 3109','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207037,'cse 3110','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207037,'cse 3103','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207037,'cse 3104','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207037,'cse 3119','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207037,'cse 3120','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207037,'cse 3101','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207033,'cse 3109','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207033,'cse 3110','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207033,'cse 3103','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207033,'cse 3119','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207033,'cse 3120','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207033,'cse 3104','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207033,'cse 3101','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207048,'cse 3109','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207048,'cse 3110','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207048,'cse 3103','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207048,'cse 3104','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207048,'cse 3119','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207048,'cse 3120','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207048,'cse 3101','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207003,'cse 3109','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207003,'cse 3110','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207003,'cse 3103','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207003,'cse 3104','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207003,'cse 3119','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207003,'cse 3120','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207003,'cse 3101','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207046,'cse 3109','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207046,'cse 3110','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207046,'cse 3103','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207046,'cse 3104','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207046,'cse 3119','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207046,'cse 3120','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207046,'cse 3101','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207035,'cse 3109','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207035,'cse 3110','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207035,'cse 3103','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207035,'cse 3104','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207035,'cse 3119','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207035,'cse 3120','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207035,'cse 3101','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207039,'cse 3109','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207039,'cse 3110','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207039,'cse 3103','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207039,'cse 3104','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207039,'cse 3119','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207039,'cse 3120','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207039,'cse 3101','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207005,'cse 3109','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207005,'cse 3110','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207005,'cse 3103','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207005,'cse 3104','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207005,'cse 3119','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207005,'cse 3120','3rd','1st');
insert into course_taken(student_roll,course_no,year,term) values(1207005,'cse 3101','3rd','1st');

                  ------------------ INSERT DATA END ------------------




SELECT * FROM teacher;
SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM course_taught;
SELECT * FROM course_taken;


ALTER TABLE teacher
  ADD  email VARCHAR(30);

DESCRIBE teacher;

ALTER TABLE teacher
  MODIFY email VARCHAR(20);

DESCRIBE teacher;


ALTER TABLE teacher
  RENAME COLUMN email to mail;

DESCRIBE teacher;

ALTER TABLE teacher
  DROP COLUMN mail;

DESCRIBE teacher;


UPDATE student SET adviser_id = 7 WHERE student_roll = 1207039;
SELECT * FROM student;

DELETE FROM teacher WHERE teacher_id = 6;
SELECT * FROM teacher;

SELECT course_no FROM course_taught;
SELECT DISTINCT (course_no) FROM course_taught;



SELECT course_no,(credit*5) FROM course WHERE credit=3.00;
SELECT course_no,(credit*5) AS Multiplied FROM course WHERE credit=3.00;


SELECT teacher_id,teacher_name FROM teacher;
SELECT teacher_id,teacher_name FROM teacher where teacher_id>2;
SELECT teacher_id,teacher_name FROM teacher where teacher_id=2 or teacher_id=4;


SELECT teacher_name,teacher_id FROM teacher where teacher_id between 2 and 4;
SELECT teacher_name,teacher_id FROM teacher where teacher_id not between 2 and 4;
SELECT teacher_name,teacher_id FROM teacher where teacher_id>=2 and teacher_id<=8;


SELECT teacher_name,teacher_id FROM teacher where teacher_id IN (2,8);
SELECT teacher_name,teacher_id FROM teacher where teacher_id NOT IN (2,4);


SELECT course_no,credit,course_name from course;
SELECT course_no,credit,course_name from course where course_name like '%system%';
SELECT course_no,credit,course_name from course where course_name like '%system';
SELECT course_no,credit,course_name from course where course_name like '%System%';



SELECT student_roll,student_name,address from student order by student_roll;
SELECT student_roll,student_name,address from student order by student_roll desc;
SELECT student_name,address,adviser_id,student_roll from student order by adviser_id,student_roll;
SELECT student_name,address,adviser_id,student_roll from student order by adviser_id,student_roll desc;
SELECT student_name,address,adviser_id,student_roll from student order by adviser_id desc,student_roll desc;
SELECT student_name,address,adviser_id,student_roll from student order by adviser_id desc,student_roll;


              ------------------- AGGREGATE FUNCTIONS -----------------

SELECT count(*) from teacher;
SELECT count(*),count(address) from teacher;


SELECT count(*),sum(credit),avg(credit) from course;
SELECT count(*),sum(credit),avg(nvl(credit,0)) from course;


SELECT count(credit),count(distinct credit),count(all credit) from course;


SELECT gender,count(student_roll) from student group by gender;
SELECT gender,count(student_roll) from student where student_roll<1207037 group by gender;


SELECT gender,count(student_roll) from student group by gender HAVING gender='Female' ;
SELECT gender,count(student_roll) from student group by gender HAVING count(student_roll)>2 ;
SELECT gender,count(student_roll) from student group by gender HAVING count(religion)=4;



                 ----------------- SUBQUERY START -------------------

select teacher_id,teacher_name from teacher where teacher_id in
                          ( select teacher_id from course_taught where course_no='cse 3109');

select c.course_no,c.course_name from course c where c.course_no in
                   ( select t.course_no from course_taken t where t.student_roll in 
                      (select s.student_roll from student s where s.student_name='Aney'));

                 ----------------- SUBQUERY END ----------------------



               -------------------- SET OPERATION START ----------------------

SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id = 2
UNION ALL
SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id IN (SELECT teacher_id FROM teacher WHERE teacher_name = 'A');


SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id = 2
UNION
SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id IN (SELECT teacher_id FROM teacher WHERE teacher_name = 'A');


SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id = 2
INTERSECT
SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id IN (SELECT teacher_id FROM teacher WHERE teacher_name = 'A');

SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id = 2
MINUS
SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id IN (SELECT teacher_id FROM teacher WHERE teacher_name = 'A');

SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id IN (SELECT teacher_id FROM teacher WHERE teacher_name = 'A')
MINUS
SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id = 2;

SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id = 2
UNION
SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id IN (SELECT teacher_id FROM teacher WHERE teacher_name = 'A')
INTERSECT
SELECT student_roll, student_name, adviser_id FROM student WHERE student_roll <1207037;

SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id = 2
UNION
(
SELECT student_roll, student_name, adviser_id FROM student WHERE adviser_id IN (SELECT teacher_id FROM teacher WHERE teacher_name = 'A')
INTERSECT
SELECT student_roll, student_name, adviser_id FROM student WHERE student_roll <1207037
);

                 ------------------- SET OPERATION END -----------------------



                 -------------------- JOIN OPERATION START ----------------------

SELECT s.student_roll, s.student_name, t.teacher_name FROM student s JOIN teacher t ON s.adviser_id = t.teacher_id;
SELECT teacher_id, teacher_name, course_no FROM teacher JOIN course_taught USING (teacher_id);
SELECT teacher_id, teacher_name, course_no FROM teacher NATURAL JOIN course_taught;
SELECT t.teacher_id, c.course_no FROM teacher t CROSS JOIN course_taught c;
SELECT teacher_id, teacher_name, course_no FROM teacher INNER JOIN course_taught USING (teacher_id);
SELECT teacher_id, teacher_name, course_no FROM teacher LEFT OUTER JOIN course_taught USING (teacher_id);
SELECT teacher_id, teacher_name, course_no FROM teacher RIGHT OUTER JOIN course_taught USING (teacher_id);
SELECT teacher_id, teacher_name, course_no FROM teacher FULL OUTER JOIN course_taught USING (teacher_id);

                 ------------------- JOIN OPERATION END --------------------------



--lab 7--

SET SERVEROUTPUT ON  
DECLARE  
   teacher_no  NUMBER;  
BEGIN  
   SELECT COUNT(teacher_id) INTO teacher_no    
   FROM teacher;  
   DBMS_OUTPUT.PUT_LINE('The number of teacher is  : ' ||  
teacher_no);  
 END;  
/


SET SERVEROUTPUT ON
DECLARE
   name student.student_name%type;
BEGIN
   SELECT student_name  INTO name  
   FROM student where student_roll=1207037;
   DBMS_OUTPUT.PUT_LINE('The name is : ' || name);
 END;
/




SET SERVEROUTPUT ON
DECLARE
   number_female student.student_roll%type;
BEGIN
   SELECT count(student_roll) into number_female from student 
group by gender HAVING gender='Female' ;
   DBMS_OUTPUT.PUT_LINE('The number of female student is : ' || number_female);
 END;
/



SET SERVEROUTPUT ON
DECLARE
   adviser_name teacher.teacher_name%type;
   name student.student_name%type:='Aney';
BEGIN
   SELECT teacher_name into adviser_name from teacher where teacher_id in(select adviser_id from student where student_name=name);

   DBMS_OUTPUT.PUT_LINE('The name of the adviser is : ' || adviser_name);
 END;
/


               --------------------- IF-ELSE START --------------------                          

SET SERVEROUTPUT ON
DECLARE
    credit course.credit%type;
    course_title  course.course_name%type;
    type_name varchar2(10);
	
BEGIN
    course_title := 'Database system';

    SELECT credit  INTO credit
    FROM course
    WHERE course_name=course_title ;

    IF credit > 1.50  THEN
                type_name:='theory';
   
   ELSE
	type_name:='lab'; 
    END IF;
DBMS_OUTPUT.PUT_LINE('The type of the course is : ' || type_name);
EXCEPTION
         WHEN others THEN
	      DBMS_OUTPUT.PUT_LINE (SQLERRM);
END;
/
SHOW errors

                   ------------------ IF-ELSE END --------------------


                   ------------------ LOOP START ---------------------

SET SERVEROUTPUT ON
DECLARE
   counter teacher.teacher_id%type := 1;
   t_id    teacher.teacher_id%type;
   t_name  teacher.teacher_name%type;
  
BEGIN
   
    LOOP

      SELECT teacher_id, teacher_name INTO t_id, t_name FROM teacher WHERE teacher_id = counter;

      DBMS_OUTPUT.PUT_LINE ('Record :' || counter);
      DBMS_OUTPUT.PUT_LINE (t_id || '-' || t_name);
      DBMS_OUTPUT.PUT_LINE ('-----------');
      counter := counter + 1;
      EXIT WHEN counter > 5;
   END LOOP;

   EXCEPTION
      WHEN others THEN
         DBMS_OUTPUT.PUT_LINE (SQLERRM);

END;
/

SET SERVEROUTPUT ON
DECLARE
   counter teacher.teacher_id%type := 1;
   t_id    teacher.teacher_id%type;
   t_name  teacher.teacher_name%type;
  
BEGIN
   
   WHILE counter <= 5
    LOOP

      SELECT teacher_id, teacher_name INTO t_id, t_name FROM teacher WHERE teacher_id = counter;

      DBMS_OUTPUT.PUT_LINE ('Record :' || counter);
      DBMS_OUTPUT.PUT_LINE (t_id || '-' || t_name);
      DBMS_OUTPUT.PUT_LINE ('-----------');
      counter := counter + 1;

   END LOOP;

   EXCEPTION
      WHEN others THEN
         DBMS_OUTPUT.PUT_LINE (SQLERRM);

END;
/

                --------------------- LOOP END -----------------------


                 -------------------- CURSOR START -------------------- 

SET SERVEROUTPUT ON
DECLARE
     CURSOR s_info IS
  SELECT student_roll, student_name FROM student;
  s_record s_info%ROWTYPE;

BEGIN
OPEN s_info;
      LOOP
        FETCH s_info INTO s_record;
        EXIT WHEN s_info%ROWCOUNT > 4;
      DBMS_OUTPUT.PUT_LINE (s_record.student_roll || '  ' || s_record.student_name);
      END LOOP;
      CLOSE s_info;   
END;
/

                 ------------------- CURSOR END ------------------------------



                   ----------------- PROCEDURE START ---------------------

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE getemp IS 
   roll_r student.student_roll%type;
   name_n student.student_name%type;
BEGIN
    
    SELECT student_name INTO name_n
    FROM student
    WHERE  student_roll =1207037;
    DBMS_OUTPUT.PUT_LINE('Name: '||name_n);
END;
/
SHOW ERRORS;

BEGIN
   getemp;
END;
/



SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE getn(
   roll_r student.student_roll%TYPE) IS
BEGIN
    UPDATE student set student_name='Paul' where student_roll=roll_r; 
END;
/
SHOW ERRORS;

BEGIN
   getn(1207037);
END;
/

              ---------------------- PROCEDURE END ----------------------


             
               ---------------------- FUNCTION START --------------------

CREATE OR REPLACE FUNCTION avg_cgpa RETURN NUMBER IS
   cg_avg student.cgpa%type;
BEGIN

  SELECT AVG(cgpa) INTO cg_avg FROM student WHERE student_roll IN (SELECT student_roll FROM student WHERE adviser_id = 1);
  
  RETURN cg_avg;
END;
/

SET SERVEROUTPUT ON
BEGIN
   DBMS_OUTPUT.PUT_LINE('Average CGPA  : '|| avg_cgpa);
END;
/

               --------------------- FUNCTION END -----------------------

commit;

