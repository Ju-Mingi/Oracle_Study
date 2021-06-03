-- ANSI �ܺ� ����

-- ������ �ܺ����� ����
SELECT A. EMPLOYEE_ID, A.EMP_NAME, B.JOB_ID, B.DEPARTMENT_ID
FROM EMPLOYEES A, JOB_HISTORY B
WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID(+)
AND A.DEPARTMENT_ID = B.DEPARTMENT_ID(+);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ANSI ������ ����� �ܺ�����

-- ���� ���̺� : EMPLOYEES
SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.JOB_ID, B.DEPARTMENT_ID
FROM EMPLOYEES A
LEFT OUTER JOIN JOB_HISTORY B -- OUTER ���� ����
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID AND A.DEPARTMENT_ID = B.DEPARTMENT_ID);

-- ���� ���̺� : JOB_HISTORY
SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.JOB_ID, B.DEPARTMENT_ID
FROM JOB_HISTORY B
RIGHT OUTER JOIN EMPLOYEES A -- OUTER ���� ����
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID AND A.DEPARTMENT_ID = B.DEPARTMENT_ID);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTER ����
-- OUTER�� �����ϰ� ����Ͽ��� �ܺ� ������ �ǹ��Ѵ�.
SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.JOB_ID, B.DEPARTMENT_ID
FROM JOB_HISTORY B
RIGHT JOIN EMPLOYEES A -- OUTER ���� ����
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID AND A.DEPARTMENT_ID = B.DEPARTMENT_ID);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CROSS JOIN 
-- ���� �������� ���� īŸ�þ� ���ΰ� ����

-- ���� ������ īŸ�þ� ����

SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_ID, B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B;

-- ANSI ������ CROSS ����

SELECT A.EMPLOYEE_ID, EMP_NAME, B.DEPARTMENT_ID, B.DEPARTMENT_NAME
FROM EMPLOYEES A
CROSS JOIN DEPARTMENTS B;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FULL OUTER ����
-- �� ���̺�  NULL ���� ���Ե� ��� ( A ���̺��� ������ ���� B ���̺� ���� , B ���̺��� ���� A ���̺� ���� ���)

CREATE TABLE MINKY_A (EMP_ID INT);
CREATE TABLE MINKY_B (EMP_ID INT);
INSERT INTO MINKY_A VALUES ( 10);
INSERT INTO MINKY_A VALUES ( 20);
INSERT INTO MINKY_A VALUES ( 40);
INSERT INTO MINKY_B VALUES ( 10);
INSERT INTO MINKY_B VALUES ( 20);
INSERT INTO MINKY_B VALUES ( 30);

-- ���̺� Ȯ��
SELECT *
FROM MINKY_A;

SELECT *
FROM MINKY_B;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- A ���̺� �������� �ܺ�����
SELECT A.EMP_ID, B.EMP_ID
FROM MINKY_A A
LEFT OUTER JOIN MINKY_B B
ON (A.EMP_ID = B.EMP_ID);
-- 30 �� ����

-- B ���̺� �������� �ܺ�����
SELECT A.EMP_ID, B.EMP_ID
FROM MINKY_B B
RIGHT OUTER JOIN MINKY_A A
ON (A.EMP_ID = B.EMP_ID);
-- 40�� ����
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- �� ������ ���� �����Ϸ��� �ǵ��� �ܺ����� ���� ���� �߻�

SELECT A.EMP_ID, B.EMP_ID
FROM MINKY_A A,  MINKY_B B
WHERE A.EMP_ID(+) = B.EMP_ID(+);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CROSS JOIN ����� ��� ���� ������ �����Ƿ� A���̺��� �� �� 3 , B ���̺��� �� �� 3 ���� ��� �� ���� 9
SELECT A.EMP_ID, B.EMP_ID
FROM MINKY_A A
CROSS JOIN MINKY_B B;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- �� ���̺� ��θ� �ܺ� ���� ��� �ֱ����� FULL OUTER JOIN ���

SELECT A.EMP_ID, B.EMP_ID
FROM MINKY_A A
FULL OUTER JOIN MINKY_B B
ON (A.EMP_ID = B.EMP_ID);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SUB-QUERY

/* SQL ���� �ȿ��� ������ ���Ǵ� �� �ٸ� SELECT ��
 �ϳ��� SQL ���� �������� ���� ������ ������ ������ ��� SELECT ���� ���������� ���� �ȴ�. ���� ���� ���� ���� �������� ��밡���ϴ�.
 SELECT, FROM, WHERE ������ ��� ��밡��
 INSERT, UPDATE, MERGE, DELETE �������� ��밡��*/
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ������ ���� ��������
-- ���� ���̺�� ���� ������ �ɸ��� �ʴ� ��������

-- �� ����� ��� �޿� �̻��� �޴� ��� ���� ��ȸ
SELECT count(*)
FROM employees
WHERE salary >= (SELECT AVG(salary) FROM employees);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- �μ� ���̺��� parent_id�� NULL�� �μ���ȣ�� ���� ����� �� �Ǽ��� ��ȯ
SELECT count(*)
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE parent_id IS NULL);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- job_history ���̺� �ִ� employee_id, job_id �� ���� ���� ���� ��� ���̺��� ã��
SELECT employee_id, emp_name, job_id
FROM employees
WHERE (employee_id, job_id) IN (SELECT employee_id, job_id FROM job_history);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- �� ����� �޿��� ��� �ݾ����� ����
UPDATE employees
SET salary = (SELECT AVG(salary) FROM employees);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ��� �޿����� ���� �޴� ��� ����
DELETE employees
WHERE salary >= (SELECT AVG(salary) FROM employees);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ������ �ִ� ����

-- ���� ���� �ȿ��� ���� �������� ���� �μ� ���̺��� �μ���ȣ�� job_history ���̺��� �μ���ȣ�� ���� ���� ��ȸ
SELECT a.department_id, a.department_name
FROM departments a
-- EIXSTS �����ڸ� ��������� ���� ���� ���� ���� ������ ���ԵǾ��ִ�.
WHERE EXISTS( SELECT 1 FROM job_history b WHERE a.department_id = b.department_id);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- job_history �� �ִ� �μ��� ��ȸ�Ǿ���.
-- job_history �� ���̺��� ��ȸ
-- ����� �μ���ȣ�� ������ (WHERE���� ����Ͽ� job_history ���̺�� ��� ���̺��� ����� ��ġ�ϴ� ��, �μ����̺��� �μ���ȣ�� ��ġ�ϴ� ��)
SELECT a.employee_id, (SELECT b.emp_name FROM employees b WHERE a.employee_id = b.employee_id) AS emp_name,
a.department_id, (SELECT b.department_name FROM departments b WHERE a.department_id = b.department_id) AS dep_name
FROM job_history a;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- �μ����̺��� �μ���ȣ ��ȸ ( ��� ���̺�� �μ���ȣ�� ������ �޿��� ��� �޿� �̻�)
SELECT a.department_id, a.department_name
FROM departments a
WHERE EXISTS (SELECT 1 FROM employees b WHERE a.department_id = b.department_id AND b.salary > (SELECT AVG(salary) FROM employees));
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- �μ� ���̺��� ���� �μ��� ��ȹ�ο� ���ϴ� ������� �μ��� ��� �޿��� ��ȸ
SELECT department_id, TRUNC(AVG(salary))
FROM employees a
WHERE department_id IN ( SELECT department_id FROM departments WHERE parent_id = 90)
GROUP BY department_id;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ����
UPDATE employees a
SET a.salary = ( SELECT sal FROM ( SELECT b.department_id, AVG(c.salary) AS sal
FROM departments b, employees c WHERE b.parent_id = 90 AND b.department_id = c.department_id GROUP BY b.department_id) d
WHERE a.department_id = d.department_id)
WHERE a.department_id IN ( SELECT department_id FROM departments WHERE parent_id = 90);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Ȯ��
SELECT department_id, MIN(salary), MAX(salary)
FROM employees a
WHERE department_id IN ( SELECT department_id FROM departments WHERE parent_id = 90)
GROUP BY department_id;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
MERGE INTO employees a
USING ( SELECT b.department_id, AVG(c.salary) AS sal
            FROM departments b, employees c
           WHERE b.parent_id = 90
           AND b.department_id = c.department_id
           GROUP BY b.department_id) d
           ON (a.department_id = d.department_id)
           WHEN MATCHED THEN UPDATE SET a.salary = d.sal;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FROM ������ ����ϴ� SUB-QUERY �� INLINE VIEW
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ��ȹ�� ���Ͽ� �ִ� �μ��� ���� ����� ��ձ޿����� ���� �޴� ��� ���
SELECT a.employee_id , a.emp_name, b.department_id, b.department_name
FROM employees a, departments b, ( SELECT AVG(c.salary) AS avg_salary 
                                                     FROM departments b, employees c
                                                     WHERE b.parent_id = 90 -- ��ȹ��
                                                     AND b.department_id = c.department_id ) d
WHERE a.department_id  = b.department_id
AND a.salary > d.avg_salary;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- �� ��� ����� > �� ��� ����� ������ �����ϴ� ���� ��� �����
SELECT a.*
FROM ( SELECT a.sales_month, ROUND(AVG(a.amount_sold)) AS month_avg
            FROM sales a, customers b, countries c
            WHERE a.sales_month BETWEEN '200001' AND '200012'
            AND a.cust_id = b.CUST_ID
            AND b.country_id = c.country_id
            AND c.country_name = 'Italy'
            GROUP BY a.sales_month ) a,
            (SELECT ROUND(AVG(a.amount_sold)) AS year_avg
            FROM sales a, customers b, countries c
            WHERE a.sales_month BETWEEN '200001' AND '200012'
            AND a.cust_id = b.CUST_ID
            AND b.country_id = c.country_id
            AND c.country_name = 'Italy') b
WHERE a.month_avg > b.year_avg ;