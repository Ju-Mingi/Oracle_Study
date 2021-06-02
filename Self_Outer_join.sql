-- SELF JOIN
-- 동일한 테이블을 사용해 조인
SELECT a.employee_id, a.emp_name, b.emp_name, a.department_id
FROM employees a, employees b
WHERE a.employee_id < b.employee_id
AND a. department_id = b.department_id
AND a.department_id = 20;

-- 외부조인 OUTER JOIN
-- 일반조인의 확장 개념
-- 어느 한쪽 테이블에 조인 조건에 명시된 컬럼값이 없거나,
-- 해당 로우가 존재하지 않아도 데이터를 모두 추출함

-- 일반 조인
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM departments a, job_history b
WHERE a.department_id = b.department_id;

-- 외부 조인
SELECT a.department_id, a.department_name, b.job_id, b.department_id
FROM departments a, job_history b
-- 조인 조건에서 데이터가 없는 테이블의 컬럼에 (+) 기호를 붙임
WHERE a.department_id = b.department_id(+);

-- Another ex

-- 1
SELECT a.employee_id, a.emp_name, b.job_id, b.department_id
FROM employees a, job_history b
WHERE a.employee_id = b.employee_id(+)
AND a.department_id = b.department_id;

-- 2
-- 1에서 4건 밖에 조회되지 않은 이유
-- 외부 조인은 조건에 해당하는 조인 조건 모두에 (+) 를 붙여야함.
SELECT a.employee_id, a.emp_name, b.job_id, b.department_id
FROM employees a, job_history b
WHERE a.employee_id = b.employee_id(+)
AND a.department_id = b.department_id(+);


/*                         외부 조인시 주의 사항

1. 조인 대상 테이블 중 데이터가 없는 테이블 조인 조건에 (+)를 붙인다

2. 외부 조인의 조인 조건이 여러개일 떄 모든 조건에 (+)를 붙인다.

3. 한번에 한 테이블에만 외부 조인을 할수 있다.
        ex )  조인 테이블 대상 A, B, C 3개
               A를 기준으로 B 테이블을 외부 조인으로 연결했다면,
               동시에 C를 기준으로 B 테이블에 외부 조인을 걸 수 없음.

4. (+) 연산자가 붙은 조건과 OR을 같이 사용 불가

5. (+) 연산자가 붙은 조건에는 IN 연산자를 같이 사용할 수 없다.
    (단 IN절에 포함되는 값이 1개일 경우는 가능하다.)
*/

-- ANSI 조인

-- ANSI 내부 조인

-- <기존문법>
SELECT a. employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id
AND a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');

-- <ANSI>

SELECT a. employee_id, a.emp_name, b.department_id, b.department_name
FROM employees a
INNER JOIN departments b
-- 조인 조건은 ON절에 명시
-- 조인 조건 컬럼이 같을 경우 USING 사용 가능
ON (a.department_id = b.department_id)
-- 조인 조건 외의 조건은 WHERE절에 명시 
WHERE a.hire_date >= TO_DATE('2003-01-01','YYYY-MM-DD');
