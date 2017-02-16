SELECT * FROM teacher;
SELECT * FROM student;
SELECT * FROM course;
SELECT * FROM course_taught;
SELECT * FROM course_taken;


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




select teacher_id,teacher_name from teacher where teacher_id in
                          ( select teacher_id from course_taught where course_no='cse 3109');

select c.course_no,c.course_name from course c where c.course_no in
                   ( select t.course_no from course_taken t where t.student_roll in 
                      (select s.student_roll from student s where s.student_name='Aney'));



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


SELECT s.student_roll, s.student_name, t.teacher_name FROM student s JOIN teacher t ON s.adviser_id = t.teacher_id;
SELECT teacher_id, teacher_name, course_no FROM teacher JOIN course_taught USING (teacher_id);
SELECT teacher_id, teacher_name, course_no FROM teacher NATURAL JOIN course_taught;
SELECT t.teacher_id, c.course_no FROM teacher t CROSS JOIN course_taught c;
SELECT teacher_id, teacher_name, course_no FROM teacher INNER JOIN course_taught USING (teacher_id);
SELECT teacher_id, teacher_name, course_no FROM teacher LEFT OUTER JOIN course_taught USING (teacher_id);
SELECT teacher_id, teacher_name, course_no FROM teacher RIGHT OUTER JOIN course_taught USING (teacher_id);
SELECT teacher_id, teacher_name, course_no FROM teacher FULL OUTER JOIN course_taught USING (teacher_id);




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


----lab 8 ----

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

