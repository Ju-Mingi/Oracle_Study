-- 내부조인
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 동등 조인 EQUI JOIN
SELECT a.employee_id, a.emp_name, a.department_id, b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SEMI JOIN

-- 서브 쿼리에 존재하는 메인 쿼리 데이터가 여러 건 존재하더라도 최종 반환되는 메인 쿼리 데이터에는 중복되는건 없다.

-- EXISTS
SELECT department_id, department_name
FROM departments a
WHERE EXISTS (SELECT * FROM employees b WHERE a.department_id = b.department_id AND b.salary > 3000)
ORDER BY a.department_name;

-- IN
SELECT department_id, department_name
FROM departments a
WHERE a.department_id IN (SELECT b.department_id FROM employees b WHERE b.salary > 3000)
ORDER BY department_name;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 일반 조인을 사용했을 경우

-- 데이터 중복이 발생

SELECT a.department_id, a.department_name
FROM departments a, employees b
WHERE a.department_id = b.department_id
AND b.salary > 3000
ORDER BY a.department_name;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 안티조인

SELECT a.employee_id, a.emp_name, a.department_id, b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id
AND a.department_id NOT IN (SELECT department_id FROM departments WHERE manager_id IS NULL);

SELECT count(*)
FROM employees a
WHERE NOT EXISTS ( SELECT 1 FROM departments c WHERE a.department_id = c.department_id AND manager_id IS NULL);