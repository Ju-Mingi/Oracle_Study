-- 1

SELECT LPAD(SUBSTR(REPLACE(phone_number, '.' , '-'),4), 14, '(031)')
FROM EMPLOYEES;

-- 2
SELECT employee_id �����ȣ, emp_name �����, HIRE_DATE �Ի�����, ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) �ټӳ��
FROM employees
WHERE  ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) >= 22
ORDER BY ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12);

-- 3
SELECT cust_main_phone_number "���� ��ȭ��ȣ", TRANSLATE(cust_main_phone_number,'1234567890','ABCDEFGHIJ') new_phone_number
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



-- 7 ��

SELECT ����⵵,
CASE WHEN ����⵵ BETWEEN 1950 AND 1959 THEN '1950���'
        WHEN ����⵵ BETWEEN 1960 AND 1969 THEN '1960���'
        WHEN ����⵵ BETWEEN 1970 AND 1979 THEN '1970���'
        WHEN ����⵵ BETWEEN 1980 AND 1989 THEN '1980���'
        WHEN ����⵵ BETWEEN 1990 AND 1999 THEN '1990���'
ELSE '��Ÿ'
END AS ���
FROM (SELECT cust_year_of_birth AS ����⵵ FROM CUSTOMERS);

-- 8
SELECT TO_CHAR(hire_date,'MM') ��, COUNT(*) "�Ի��ο�"
FROM employees
GROUP BY TO_CHAR(hire_date,'MM')
ORDER BY TO_CHAR(hire_date,'MM') ASC;

-- 9

SELECT region, SUM(loan_jan_amt) "2011�� �����"
FROM kor_loan_status
WHERE period LIKE  '2011%'
GROUP BY region;

