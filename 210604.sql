-- Inline View

-- 1. 연도 사원별 이탈리아 매출액
SELECT SUBSTR(a.sales_month,1,4) AS 년도, a.employee_id 최대매출사원명, SUM(a.amount_sold) AS 최대매출액
FROM sales a, customers b, countries c
WHERE a.cust_ID = b.CUST_ID
AND b.country_id = c.COUNTRY_ID
AND c.country_name = 'Italy'
GROUP BY SUBSTR(a.sales_month,1,4), a.employee_id;

-- 2. 1 결과를 바탕으로 연도별 최대, 최소 매출액 구하기
SELECT 년도, MAX(최대매출액) AS 최대매출액
FROM( SELECT SUBSTR(a.sales_month,1,4) AS 년도, a.employee_id 최대매출사원명, SUM(a.amount_sold) AS 최대매출액
FROM sales a, customers b, countries c
WHERE a.cust_ID = b.CUST_ID
AND b.country_id = c.COUNTRY_ID
AND c.country_name = 'Italy'
GROUP BY SUBSTR(a.sales_month,1,4),  a.employee_id
) K
GROUP BY 년도
ORDER BY 년도;

--  1과 2의 결과를 조인해서 최대매출, 최소매출액을 발생한 사원을 찾음

SELECT emp.년도, emp.최대매출사번,emp2.사원명, emp.최대매출액
FROM( 
            SELECT SUBSTR(a.sales_month,1,4) AS 년도, a.employee_id 최대매출사번, SUM(a.amount_sold) AS 최대매출액
            FROM sales a, customers b, countries c
            WHERE a.cust_ID = b.CUST_ID
            AND b.country_id = c.COUNTRY_ID
            AND c.country_name = 'Italy'
            GROUP BY SUBSTR(a.sales_month,1,4), a.employee_id
            ) emp,
            (
                SELECT 년도, MAX(최대매출액) AS 최대매출액
                FROM( SELECT SUBSTR(a.sales_month,1,4) AS 년도, a.employee_id 최대매출사번, SUM(a.amount_sold) AS 최대매출액
                FROM sales a, customers b, countries c
                WHERE a.cust_ID = b.CUST_ID
                AND b.country_id = c.COUNTRY_ID
                AND c.country_name = 'Italy'
                GROUP BY SUBSTR(a.sales_month,1,4),  a.employee_id) K
                GROUP BY 년도
                ) sale,
                (SELECT employee_id,emp_name 사원명 FROM employees) emp2
WHERE emp.년도 = sale.년도
AND emp.최대매출액 = sale.최대매출액
AND emp.최대매출사번 = emp2.employee_id
ORDER BY 년도;


-- Self-Check

-- 1
SELECT a.employee_id 사번, a.emp_name 사원명, d.job_title job명칭, b.start_date job시작일자, b.end_date job종료일자, c.department_name job수행부서명
FROM employees a, job_history b, departments c, jobs d
WHERE a.employee_id = b.employee_id
AND a.department_id = c.department_id
AND b.job_id = d.job_id
AND a.employee_id = 101;

-- 2

SELECT a.employee_id, a.emp_name, b.job_id, b.department_id
FROM employees a, job_history b
WHERE a.employee_id = b.employee_id(+)
AND  a.department_id = b.department_id(+);

-- 3
-- IN절에 값이 1개인 경우, 즉 department_id IN (10)일 경우 department_id = 10 로 변환할 수 있으므로, 외부조인을 하더라도 값이 1개인 경우는 사용할 수 있다.

-- 4

-- 다음의 쿼리를 ANSI 문법으로 바꾸기
SELECT a.department_id, a.department_name
FROM departments a, employees b
WHERE a.department_id = b.department_id
AND b.salary > 3000
ORDER BY a.department_name;

-- ANSI
SELECT a.department_id, a.department_name
FROM departments a
INNER JOIN employees b
ON ( a.department_id = b.department_id)
WHERE b.salary > 3000
ORDER BY department_name;

-- 5
-- 연관성 있는 쿼리를 연관성 없는 쿼리로 만들기
SELECT a.department_id, a.department_name
 FROM departments a
WHERE EXISTS ( SELECT 1 
                 FROM job_history b
                WHERE a.department_id = b.department_id );

-- 정답
SELECT  a.department_id, a.department_name
FROM departments a
WHERE a.department_id IN (SELECT department_id FROM job_history);