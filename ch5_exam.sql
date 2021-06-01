-- 1

SELECT LPAD(SUBSTR(REPLACE(phone_number, '.' , '-'),4), 14, '(031)')
FROM EMPLOYEES;

-- 2
SELECT employee_id 사원번호, emp_name 사원명, HIRE_DATE 입사일자, ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) 근속년수
FROM employees
WHERE  ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) >= 22
ORDER BY ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12);

-- 3
SELECT cust_main_phone_number "기존 전화번호", TRANSLATE(cust_main_phone_number,'1234567890','ABCDEFGHIJ') new_phone_number
FROM CUSTOMERS
ORDER BY cust_name;

-- 4
CREATE TABLE exam3 (
    name VARCHAR2(100),
    new_phone_number VARCHAR2(25)
);

-- 5
INSERT INTO exam3 (name, new_phone_number)
SELECT cust_name ,TRANSLATE(cust_main_phone_number,  '1234567890', 'ABCDEFGHIJ')
FROM CUSTOMERS;


-- 6

SELECT name, TRANSLATE(new_phone_number, 'ABCDEFGHIJ', '1234567890')
FROM exam3;



-- 7 번

SELECT 출생년도,
CASE WHEN 출생년도 BETWEEN 1950 AND 1959 THEN '1950년대'
        WHEN 출생년도 BETWEEN 1960 AND 1969 THEN '1960년대'
        WHEN 출생년도 BETWEEN 1970 AND 1979 THEN '1970년대'
        WHEN 출생년도 BETWEEN 1980 AND 1989 THEN '1980년대'
        WHEN 출생년도 BETWEEN 1990 AND 1999 THEN '1990년대'
ELSE '기타'
END AS 년대
FROM (SELECT cust_year_of_birth AS 출생년도 FROM CUSTOMERS);

-- 8
SELECT TO_CHAR(hire_date,'MM') 월, COUNT(*) "입사인원"
FROM employees
GROUP BY TO_CHAR(hire_date,'MM')
ORDER BY TO_CHAR(hire_date,'MM') ASC;

-- 9

SELECT region, SUM(loan_jan_amt) "2011년 대출액"
FROM kor_loan_status
WHERE period LIKE  '2011%'
GROUP BY region;

