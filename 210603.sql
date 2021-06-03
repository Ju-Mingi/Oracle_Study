-- ANSI 외부 조인

-- 기존의 외부조인 문법
SELECT A. EMPLOYEE_ID, A.EMP_NAME, B.JOB_ID, B.DEPARTMENT_ID
FROM EMPLOYEES A, JOB_HISTORY B
WHERE A.EMPLOYEE_ID = B.EMPLOYEE_ID(+)
AND A.DEPARTMENT_ID = B.DEPARTMENT_ID(+);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ANSI 문법을 사용한 외부조인

-- 기준 테이블 : EMPLOYEES
SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.JOB_ID, B.DEPARTMENT_ID
FROM EMPLOYEES A
LEFT OUTER JOIN JOB_HISTORY B -- OUTER 생략 가능
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID AND A.DEPARTMENT_ID = B.DEPARTMENT_ID);

-- 기준 테이블 : JOB_HISTORY
SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.JOB_ID, B.DEPARTMENT_ID
FROM JOB_HISTORY B
RIGHT OUTER JOIN EMPLOYEES A -- OUTER 생략 가능
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID AND A.DEPARTMENT_ID = B.DEPARTMENT_ID);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OUTER 생략
-- OUTER를 생략하고 명시하여도 외부 조인을 의미한다.
SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.JOB_ID, B.DEPARTMENT_ID
FROM JOB_HISTORY B
RIGHT JOIN EMPLOYEES A -- OUTER 생략 가능
ON (A.EMPLOYEE_ID = B.EMPLOYEE_ID AND A.DEPARTMENT_ID = B.DEPARTMENT_ID);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CROSS JOIN 
-- 기존 문법에서 쓰인 카타시안 조인과 같음

-- 기존 문법의 카타시안 조인

SELECT A.EMPLOYEE_ID, A.EMP_NAME, B.DEPARTMENT_ID, B.DEPARTMENT_NAME
FROM EMPLOYEES A, DEPARTMENTS B;

-- ANSI 조인의 CROSS 조인

SELECT A.EMPLOYEE_ID, EMP_NAME, B.DEPARTMENT_ID, B.DEPARTMENT_NAME
FROM EMPLOYEES A
CROSS JOIN DEPARTMENTS B;
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FULL OUTER 조인
-- 두 테이블에  NULL 값이 포함된 경우 ( A 테이블의 데이터 값이 B 테이블에 없고 , B 테이블의 값이 A 테이블에 없을 경우)

CREATE TABLE MINKY_A (EMP_ID INT);
CREATE TABLE MINKY_B (EMP_ID INT);
INSERT INTO MINKY_A VALUES ( 10);
INSERT INTO MINKY_A VALUES ( 20);
INSERT INTO MINKY_A VALUES ( 40);
INSERT INTO MINKY_B VALUES ( 10);
INSERT INTO MINKY_B VALUES ( 20);
INSERT INTO MINKY_B VALUES ( 30);

-- 테이블 확인
SELECT *
FROM MINKY_A;

SELECT *
FROM MINKY_B;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- A 테이블 기준으로 외부조인
SELECT A.EMP_ID, B.EMP_ID
FROM MINKY_A A
LEFT OUTER JOIN MINKY_B B
ON (A.EMP_ID = B.EMP_ID);
-- 30 이 빠짐

-- B 테이블 기준으로 외부조인
SELECT A.EMP_ID, B.EMP_ID
FROM MINKY_B B
RIGHT OUTER JOIN MINKY_A A
ON (A.EMP_ID = B.EMP_ID);
-- 40이 빠짐
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 두 데이터 값을 포함하려는 의도로 외부조인 사용시 오류 발생

SELECT A.EMP_ID, B.EMP_ID
FROM MINKY_A A,  MINKY_B B
WHERE A.EMP_ID(+) = B.EMP_ID(+);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CROSS JOIN 사용의 경우 조인 조건이 없으므로 A테이블의 건 수 3 , B 테이블의 건 수 3 으로 결과 건 수는 9
SELECT A.EMP_ID, B.EMP_ID
FROM MINKY_A A
CROSS JOIN MINKY_B B;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 두 테이블 모두를 외부 조인 대상에 넣기위해 FULL OUTER JOIN 사용

SELECT A.EMP_ID, B.EMP_ID
FROM MINKY_A A
FULL OUTER JOIN MINKY_B B
ON (A.EMP_ID = B.EMP_ID);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SUB-QUERY

/* SQL 문장 안에서 보조로 사용되는 또 다른 SELECT 문
 하나의 SQL 문을 기준으로 메인 쿼리를 제외한 나머지 모든 SELECT 문을 서브쿼리로 보면 된다. 따라서 여러 개의 서브 쿼리문을 사용가능하다.
 SELECT, FROM, WHERE 절에서 모두 사용가능
 INSERT, UPDATE, MERGE, DELETE 문에서도 사용가능*/
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 연관성 없는 서브쿼리
-- 메인 테이블과 연관 조건이 걸리지 않는 서브쿼리

-- 전 사원의 평균 급여 이상을 받는 사원 수를 조회
SELECT count(*)
FROM employees
WHERE salary >= (SELECT AVG(salary) FROM employees);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 부서 테이블에서 parent_id가 NULL인 부서번호를 가진 사원의 총 건수를 반환
SELECT count(*)
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE parent_id IS NULL);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- job_history 테이블에 있는 employee_id, job_id 두 값과 같은 건을 사원 테이블에서 찾음
SELECT employee_id, emp_name, job_id
FROM employees
WHERE (employee_id, job_id) IN (SELECT employee_id, job_id FROM job_history);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 전 사원의 급여를 평균 금액으로 갱신
UPDATE employees
SET salary = (SELECT AVG(salary) FROM employees);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 평균 급여보다 많이 받는 사원 삭제
DELETE employees
WHERE salary >= (SELECT AVG(salary) FROM employees);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 연관성 있는 쿼리

-- 서브 쿼리 안에서 메인 쿼리에서 사용된 부서 테이블의 부서번호와 job_history 테이블의 부서번호가 같은 건을 조회
SELECT a.department_id, a.department_name
FROM departments a
-- EIXSTS 연산자를 사용함으로 서브 쿼리 내에 조인 조건이 포함되어있다.
WHERE EXISTS( SELECT 1 FROM job_history b WHERE a.department_id = b.department_id);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- job_history 에 있는 부서만 조회되었다.
-- job_history 의 테이블을 조회
-- 사번과 부서번호를 가져옴 (WHERE절을 사용하여 job_history 테이블과 사원 테이블의 사번과 일치하는 것, 부서테이블의 부서번호가 일치하는 것)
SELECT a.employee_id, (SELECT b.emp_name FROM employees b WHERE a.employee_id = b.employee_id) AS emp_name,
a.department_id, (SELECT b.department_name FROM departments b WHERE a.department_id = b.department_id) AS dep_name
FROM job_history a;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 부서테이블의 부서번호 조회 ( 사원 테이블과 부서번호가 같으며 급여가 평균 급여 이상)
SELECT a.department_id, a.department_name
FROM departments a
WHERE EXISTS (SELECT 1 FROM employees b WHERE a.department_id = b.department_id AND b.salary > (SELECT AVG(salary) FROM employees));
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 부서 테이블에서 상위 부서가 기획부에 속하는 사원들의 부서별 평균 급여를 조회
SELECT department_id, TRUNC(AVG(salary))
FROM employees a
WHERE department_id IN ( SELECT department_id FROM departments WHERE parent_id = 90)
GROUP BY department_id;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 갱신
UPDATE employees a
SET a.salary = ( SELECT sal FROM ( SELECT b.department_id, AVG(c.salary) AS sal
FROM departments b, employees c WHERE b.parent_id = 90 AND b.department_id = c.department_id GROUP BY b.department_id) d
WHERE a.department_id = d.department_id)
WHERE a.department_id IN ( SELECT department_id FROM departments WHERE parent_id = 90);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 확인
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
-- FROM 절에서 사용하는 SUB-QUERY 인 INLINE VIEW
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 기획부 산하에 있는 부서에 속한 사원의 평균급여보다 많이 받는 사원 목록
SELECT a.employee_id , a.emp_name, b.department_id, b.department_name
FROM employees a, departments b, ( SELECT AVG(c.salary) AS avg_salary 
                                                     FROM departments b, employees c
                                                     WHERE b.parent_id = 90 -- 기획부
                                                     AND b.department_id = c.department_id ) d
WHERE a.department_id  = b.department_id
AND a.salary > d.avg_salary;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 월 평균 매출액 > 연 평균 매출액 조건을 만족하는 월의 평균 매출액
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