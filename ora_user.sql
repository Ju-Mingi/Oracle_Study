CREATE TABLE ex2_1(
COLUMN1 CHAR(10),
COLUMN2 VARCHAR2(10),
COLUMN3 NVARCHAR2(10),
COLUMN4 NUMBER
);

INSERT INTO ex2_1 (column1, column2) VALUES ('abc','abc');

SELECT column1, LENGTH(column1) as len1,
column2, LENGTH(column2) as len2
FROM ex2_1;

CREATE TABLE ex2_2(
COLUMN1 VARCHAR2(3),
COLUMN2 VARCHAR2(3 byte),
COLUMN3 VARCHAR2(3 char)
);

INSERT INTO ex2_2 VALUES('abc', 'abc', 'abc');

SELECT column1, LENGTH(column1) AS len1,
column2, LENGTH(column2) AS len2,
column3, LENGTH(column3) AS len3
FROM ex2_2;

INSERT INTO ex2_2 (column3) VALUES ('È«±æµ¿');

SELECT column3, LENGTH(column3) AS len3, LENGTHB(column3) AS bytelen FROM ex2_2;

CREATE TABLE ex2_3(
COL_INT INTEGER,
COL_DEC DECIMAL,
COL_NUM NUMBER
);

SELECT column_id, column_name, data_type, data_length
    FROM user_tab_cols
    WHERE table_name = 'EX2_3'
    ORDER BY column_id;

CREATE TABLE EX2_4(
    COL_FLOT1 FLOAT(32),
    COL_FLOT2 FLOAT
);

INSERT INTO ex2_4 (col_flot1, col_flot2) VALUES (1234567891234, 1234567891234);

CREATE TABLE EX2_5(
    COL_DATE DATE,
    COL_TIMESTAMP TIMESTAMP
);

INSERT INTO EX2_5 VALUES (SYSDATE, SYSTIMESTAMP);
SELECT *
FROM EX2_5;


CREATE TABLE EX2_6(
    COL_NULL VARCHAR2(10),
    COL_NOT_NULL VARCHAR2(10) NOT NULL
);

INSERT INTO EX2_6 VALUES ('AA','BB');

SELECT constraint_name, constraint_type, table_name, search_condition
FROM user_constraints
WHERE table_name = 'EX2_6';

CREATE TABLE EX2_7(
COL_UNIQUE_NULL VARCHAR2(10) UNIQUE,
COL_UNIQUE_NNULL VARCHAR2(10) UNIQUE NOT NULL,
COL_UNIQUE VARCHAR2(10),
CONSTRAINTS unique_nm1 UNIQUE (COL_UNIQUE)
);

SELECT constraint_name, constraint_type, table_name, search_condition FROM user_constraints WHERE table_name = 'EX2_7';

INSERT INTO EX2_7 VALUES ('AA', 'AA', 'AA');
INSERT INTO EX2_7 VALUES ('AA', 'AA', 'AA');

INSERT INTO EX2_7 VALUES ('', 'BB', 'BB');
INSERT INTO EX2_7 VALUES ('', 'CC', 'CC');

CREATE TABLE EX2_8(
    COL1 VARCHAR2(10) PRIMARY KEY,
    COL2 VARCHAR2(10)
);

SELECT constraint_name, constraint_type, table_name, search_condition
FROM user_constraints
WHERE table_name = 'EX2_8';

--INSERT INTO EX2_8 VALUES ('','AA'); NULL 입력 불가

INSERT INTO EX2_8 VALUES ('AA','AA');

--INSERT INTO EX2_8 VALUES ('AA','AA'); 무결성 제약 조건 위배

CREATE TABLE EX2_9(
num1 NUMBER
CONSTRAINT check1 CHECK (num1 BETWEEN 1 AND 9),
gender VARCHAR2(10)
CONSTRAINT check2 CHECK (gender IN ('MALE','FEMALE'))
);

SELECT constraint_name, constraint_type, table_name, search_condition
FROM user_constraints
WHERE table_name = 'EX2_9';

--INSERT INTO EX2_9 VALUES (10, 'MAN'); <- 제약조건 위배

INSERT INTO EX2_9 VALUES (5,'FEMALE'); 

-- 21/05/18

-- 시간 컬럼의 DEFAULT 값을 명시해줌
CREATE TABLE EX2_10(
    Col1 VARCHAR2(10) NOT NULL,
    Col2 VARCHAR2(10) NULL,
    Create_date DATE DEFAULT SYSDATE);


INSERT INTO EX2_10 (Col1, Col2) VALUES ('AA','BB');

SELECT *
    FROM EX2_10;

-- 테이블 삭제 [CASCADE CONSTRAINTS] 생략 가능 <- 제약조건 삭제
--DROP TABLE EX2_10 [CASCADE CONSTRAINTS];

-- 컬럼 이름 바꾸기
--ALTER TABLE EX2_10 RENAME COLUMN COL1 TO COL11;
--AlTER TABLE  EX2_10 RENAME COLUMN Col11 TO Col1;

SELECT *
    FROM EX2_10;
    
-- 컬럼 내역 확인    
DESC EX2_10;

-- 컬럼 타입 변경
ALTER TABLE EX2_10 MODIFY COL2 VARCHAR2(30);

DESC EX2_10;

-- 컬럼 추가 
ALTER TABLE EX2_10 ADD COL3 NUMBER;

DESC EX2_10;

-- EX2_10 의 COL3 삭제
ALTER TABLE EX2_10 DROP COLUMN COL3;

DESC EX2_10;

-- COL1 에 PRIMARY KEY 제약조건 추가하기
ALTER TABLE EX2_10 ADD CONSTRAINT PK_EX2_10 PRIMARY KEY (COL1);

-- 확인
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
    FROM USER_CONSTRAINTS
    WHERE TABLE_NAME = 'EX2_10';

-- CO1의 제약조건 삭제 (PRAMARY KEY) 제약조건명이 존재하므로 추가나 삭제 모두 가능하다.   
ALTER TABLE EX2_10 DROP CONSTRAINT PK_EX2_10;

-- 확인
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
    FROM USER_CONSTRAINTS
    WHERE TABLE_NAME = 'EX2_10';

-- 테이블 복사 CREATE TABLE [테이블명] AS(~처럼) SELECT [COLUMN1,...]  FROM [복사할 테이블명]   
CREATE TABLE EX2_9_1 AS
SELECT *
    FROM EX2_9;

-- 5.21

SELECT a.employee_id, a.emp_name, a.department_id, b.department_name
 FROM employees a,
 departments b
 WHERE a.department_id = b.department_id;
 
 -- VIEW 만들기
  
 CREATE OR REPLACE VIEW EMP_DEPART_V1 AS
 SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.DEPARTMENT_ID,
 B.DEPARTMENT_NAME
 
 FROM EMPLOYEES A,
    DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;

-- 21.05.24

-- SYNONYM 삭제
DROP SYNONYM SYN_CHANNEL;

-- SYNONYM 생성
CREATE OR REPLACE SYNONYM SYN_CHANNEL
    FOR CHANNELS;

-- SYNONYM 조회
SELECT COUNT(*)
    FROM SYN_CHANNEL;

-- HR 사용자는 DEFAULT로 계정이 LOCK 이므로 UNLOCK
ALTER USER HR IDENTIFIED BY HR ACCOUNT UNLOCK;

-- HR 유저에게 SYN_CHANNEL에 대한 권한 부여
GRANT SELECT ON SYN_CHANNEL TO HR;

-- SYN_CHANNEL2 생성
CREATE OR REPLACE PUBLIC SYNONYM SYN_CHANNEL2
    FOR CHANNELS;

-- PUBLIC SYNONYM 삭제
DROP PUBLIC SYNONYM SYN_CHANNEL2;

CREATE SEQUENCE my_seq1
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 1000
NOCYCLE
NOCACHE;

DELETE EX2_8;

-- INSERT 1회
INSERT INTO EX2_8 (col1) VALUES (MY_SEQ1.NEXTVAL);
-- INSERT 2회 실행
INSERT INTO EX2_8 (col1) VALUES (MY_SEQ1.NEXTVAL);

SELECT *
    FROM EX2_8;

-- 해당 시퀀스의 현재 값 확인하기
SELECT MY_SEQ1.CURRVAL
FROM DUAL;
-- INSERT 3회 실행
INSERT INTO EX2_8 (COL1) VALUES (MY_SEQ1.NEXTVAL);

-- 테이블 확인
SELECT *
    FROM EX2_8;

-- 주의 NEXTVAL 사용시 INSERT문 외에 SELECT문에서도 값이 증가된다.

SELECT MY_SEQ1.NEXTVAL
FROM DUAL;

-- INSERT 4회 실행
INSERT INTO EX2_8 (COL1) VALUES (MY_SEQ1.NEXTVAL);

SELECT *
    FROM EX2_8;
-- INSERT문을 4번만 실행하였는데 4행의 COL1열의 값이 5가 됨을 볼 수 있다.

DROP SEQUENCE MY_SEQ1;

-- 예제 1
CREATE TABLE ORDERS(
    ORDER_ID NUMBER(12,0) PRIMARY KEY,
    ORDER_DATE DATE,
    ORDER_MODE VARCHAR2(8 BYTE) CONSTRAINT CHECK_ORDER_MODE CHECK (ORDER_MODE IN ('direct','online')),
    CUSTOMER_ID NUMBER(6,0),
    ORDER_STATUS NUMBER(2,0),
    ORDER_TOTAL NUMBER(8,2) DEFAULT 0,
    SALES_REP_ID NUMBER(6,0),
    PROMOTION_ID NUMBER(6,0)
);

-- 예제 2
CREATE TABLE ORDER_ITEMS(
    ORDER_ID NUMBER(12,0),
    LINE_ITEM_ID NUMBER(3,0),
    CONSTRAINT CHECK_ID PRIMARY KEY(ORDER_ID,LINE_ITEM_ID),
    PRODUCT_ID NUMBER(3,0),
    UNIT_PRICE NUMBER(8,2) DEFAULT 0,
    QUANTITY NUMBER(8,0) DEFAULT 0
);
-- DEFAULT 옵션 넣기(변경)
ALTER TABLE ORDER_ITEMS MODIFY (PRODUCT_ID DEFAULT 0);

--예제 3

CREATE TABLE PROMOTIONS(
    PROMO_ID NUMBER(6,0) PRIMARY KEY,
    PROMO_NAME VARCHAR2(20)
);

-- 최소 1 , 최대 99999999, 1000 시작, 1 증가, ORDER_SEQ 시퀸스 생성

CREATE SEQUENCE ORDERS_SEQ
    INCREMENT BY 1
    START WITH 1000
    MINVALUE 1
    MAXVALUE 99999999
    NOCYCLE
    NOCACHE;
    
--- SELECT 학습하기 ---


-- 사원 테이블에서 급여가 5000 이 넘는 사원번호와 사원명을 조회하기
SELECT EMPLOYEE_ID, EMP_NAME
FROM EMPLOYEES
WHERE SALARY > 5000

-- JOB_ID 가 IT_PROG AND 조건 추가
-- AND JOB_ID = 'IT_PROG'

-- JOB_ID 가 IT_PROG OR 조건 추가
OR  JOB_ID = 'IT_PROG'
ORDER BY EMPLOYEE_ID;  -- 사번으로 정렬해서 보기

-- 한 개 이상의 테이블에서 데이터를 조회하기

SELECT A.EMPLOYEE_ID, A.EMP_NAME, A.DEPARTMENT_ID,
    B.DEPARTMENT_NAME AS DEP_NAME

FROM EMPLOYEES A,
    DEPARTMENTS B

WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;



-- 210525


CREATE TABLE EX3_1(
COL1 VARCHAR2(10),
COL2 NUMBER,
COL3 DATE
);

-- INSERT 학습하기

INSERT INTO EX3_1(COL3,COL1,COL2)
VALUES (SYSDATE, 'DEF', 20);

-- 실패 , 컬럼 값의 수와 순서, 데이터타입이 일치해야한다.
INSERT INTO EX3_1(COL1,COL2,COL3)
VALUES ('ABC', 10, 30);

-- 컬럼명 기술 생략 형태

-- 컬럼명을 생략하더라도 테이블 생성시 기술했던 컬럼 순서대로 값을 나열하면 가능
INSERT INTO EX3_1
VALUES ('GHI', 1, SYSDATE);


INSERT INTO EX3_1 (COL1,COL2)
VALUES ('GHI', 20);

-- 컬럼명을 기술하지 않음 == 테이블에 있는 모든 컬럼에 값을 입력
-- 총 3개의 컬럼이 있고 입력할 컬럼을 명시하지 않았으므로 2개 나열시 오류 발생
INSERT INTO EX3_1
VALUES ('GHI', 30);

-- INSERT ~ SELECT 형태

CREATE TABLE EX3_2(
    emp_id NUMBER,
    emp_name VARCHAR2(100)
);

-- 컬럼 순서와 데이터 타입을 맞춤
INSERT INTO EX3_2(emp_id, emp_name)
SELECT employee_id, emp_name
FROM employees
WHERE salary > 5000;

-- 데이터 타입을 맞추지 않았는데 INSERT 성공
-- 묵시적 형변환의 예시
INSERT INTO EX3_1 (col1,col2,col3)
VALUES (10,'10','2014-01-01');

SELECT *
FROM EX3_1;

UPDATE EX3_1
SET COL2 = 50;


-- 21.05.26

-- EX3_3 테이블 생성
CREATE TABLE EX3_3(
    employee_id NUMBER,
    bonus_amt NUMBER DEFAULT 0);
 
 -- 조회   
SELECT *
FROM EX3_3;

-- SALES 테이블에서 2000년 10월 ~ 200년 12월까지 매출을 달성한 사원번호 입력

INSERT INTO EX3_3 (employee_id)
SELECT e.employee_id
FROM employees e, sales s
WHERE e.employee_id = s.employee_id
AND s.SALES_MONTH BETWEEN '200010' AND '200012'
-- 사원번호의 중복을 제거함
GROUP BY e.employee_id;

-- 조회
SELECT *
FROM EX3_3
ORDER BY employee_id;

-- 관리자 사번이 ex3_3 테이블에 있는 사원의 사번과 일치하면 1% 보너스
-- 일치 하지 않으면 급여의 0.1% 보너스 지급 (급여가 8000 미만인 사원만 해당)

-- 사번 , 관리자 사번, 급여, 급여 * 0.01 조회
SELECT employee_id, manager_id, salary,salary * 0.01
FROM employees
WHERE employee_id IN (SELECT employee_id FROM EX3_3);

-- 사원테이블에서 관리자 사번이 146 인 것 중 ex3_3 테이블에 없는 사원의 사번, 관리자 사번, 급여, 급여*0.001 조회
SELECT employee_id , manager_id, salary, salary * 0.001
FROM employees
WHERE employee_id NOT IN (SELECT employee_id FROM ex3_3)
AND manager_id = 146;

-- 병합하기
MERGE INTO ex3_3 d -- ex3_3 테이블을 d 로 정의
USING (SELECT employee_id, salary, manager_id
            FROM employees
            WHERE manager_id = 146) b -- 관리자 사번이 146
            ON (d.employee_id = b.employee_id) -- d , b 조건이 같을 때 업데이트
WHEN MATCHED THEN -- 조건이 맞다면
    UPDATE SET d.bonus_amt = d.bonus_amt + b.salary * 0.01 -- 1% 보너스 지급
WHEN NOT MATCHED THEN -- 조건이 틀리다면
    INSERT (d.employee_id, d.bonus_amt) VALUES (b.employee_id, b.salary * 0.001) -- 0.1 보너스 지급
    WHERE (b.salary < 8000); -- 급여가 8000 미만

-- 조회
SELECT *
    FROM ex3_3
    ORDER BY employee_id;
    
MERGE INTO ex3_3 d -- ex3_3 테이블을 d 로 정의
USING (SELECT employee_id, salary, manager_id
            FROM employees
            WHERE manager_id = 146) b -- 관리자 사번이 146
            ON (d.employee_id = b.employee_id) -- d , b 조건이 같을 때 업데이트
WHEN MATCHED THEN -- 조건이 맞다면
    UPDATE SET d.bonus_amt = d.bonus_amt + b.salary * 0.01 -- 1% 보너스 지급
    DELETE WHERE (B.employee_id = 161) -- 조건에 맞는 161 사원 삭제
WHEN NOT MATCHED THEN -- 조건이 틀리다면
    INSERT (d.employee_id, d.bonus_amt) VALUES (b.employee_id, b.salary * 0.001) -- 0.1 보너스 지급
    WHERE (b.salary < 8000); -- 급여가 8000 미만

-- 조회
SELECT *
    FROM ex3_3
    ORDER BY employee_id;


-- 테이블에 있는 데이터 삭제

DELETE EX3_3;

-- 확인 하기
SELECT *
FROM EX3_3
ORDER BY employee_id;

-- 테이블의 파티션 삭제

-- 파티션 조회
SELECT partition_name
FROM user_tab_partitions
WHERE table_name = 'SALES';

-- 삭제
/* DELETE 테이블명 PARTITION 파티션명
 WHERE DELETE 조건*/
 
 -- COMMIT ROLLBACK TRUNCATE
 
 CREATE TABLE EX3_4(
    employee_id NUMBER);
    
INSERT INTO EX3_4 VALUES (100);

SELECT *
    FROM EX3_4;

-- 실행 전까지는 세션에만 저장이 되어 잇기 때문에 데이터 베이스에 반영하기 위해서 커밋    
COMMIT;

-- 한번 실행하면 데이터가 완전히 삭제되고 복귀도 되지 않는다. 사용시 항상 주의해야한다.
TRUNCATE TABLE EX3_4;

-- 의사 컬럼

-- ROWNUM = 쿼리에서 반환 되는 각 rows 에 대한 순서 값
-- 데이터가 많은 경우는 시간이 오래걸림
SELECT ROWNUM, employee_id
FROM employees
-- 조건을 붙여서 사용하면 편리하다.
WHERE ROWNUM < 5;

-- ROWID = 테이블에 저장된 각 rows가 저장된 주소값을 가르키는 의사컬럼
SELECT ROWNUM, employee_id, ROWID
FROM employees
WHERE ROWNUM < 5;

-- 문자 연산자

-- 사번 - 사원명
SELECT employee_id || '-' || emp_name AS employee_info
FROM employees
WHERE ROWNUM < 5;

-- 표현식

-- CASE 표현식 == CASE문
SELECT employee_id, salary,
    CASE WHEN salary <= 5000 AND salary <= 15000 THEN 'B등급'
    ELSE 'A등급'
    END AS salary_grade
FROM employees;

-- 조건식

-- 급여가 2000 이거나 3000, 4000 인 사원을 추출
SELECT employee_id, salary
FROM employees
WHERE salary = ANY (2000, 3000, 4000)
ORDER BY employee_id;

-- ANY 를 OR 로 변경 가능
SELECT employee_id, salary
FROM employees
WHERE salary = 2000
OR  salary = 3000
OR salary = 4000
ORDER BY employee_id;

-- ALL 은 모든 조건을 동시에 만족해야한다.

SELECT employee_id, salary
FROM employees
WHERE salary = ALL(2000, 3000, 4000)
ORDER BY employee_id;

-- SOME 은 ANY 와 동일하게 사용되며 동작

-- 논리 조건식

-- 급여가 3000 미만인 사원 출력
SELECT employee_id, salary
FROM employees
WHERE NOT (salary >= 3000)
ORDER BY employee_id;

-- NULL 조건식

SELECT employee_id,salary
FROM employees
WHERE (salary IS NOT NULL)
ORDER BY employee_id;

-- BETWEEN AND 조건식

SELECT employee_id, salary
FROM employees
WHERE salary BETWEEN 2000 AND 2500
ORDER BY employee_id;

-- IN 조건식

SELECT employee_id, salary
FROM employees
WHERE salary IN (2000, 3000, 4000)
ORDER BY employee_id;

-- EXISTS 조건식

SELECT department_id, department_name
FROM departments a
WHERE EXISTS ( SELECT *
                        FROM employees b
                        WHERE a.department_id = b.department_id
                        AND b.salary > 8900)
ORDER BY a.department_name;

-- LIKE 조건식
-- 사원이름이 A 로 시작하는 사원을 조회
SELECT emp_name
FROM employees
WHERE emp_name LIKE 'A%'
ORDER BY emp_name;

-- 예제 
CREATE TABLE ex3_5(
names VARCHAR2(30));

INSERT INTO ex3_5 VALUES ('홍길동');
INSERT INTO ex3_5 VALUES ('홍길똥');
INSERT INTO ex3_5 VALUES ('홍길떵');
INSERT INTO ex3_5 VALUES ('홍길띵');
INSERT INTO ex3_5 VALUES ('홍길띵똥');

SELECT *
FROM ex3_5
WHERE names LIKE '홍길%';

SELECT *
FROM ex3_5
WHERE names LIKE '홍길_'; -- 한글자만 조회


-- 예제 1
-- 테이블 생성후 사원테이블에서 관리자 사번이 124, 급여가 2000에서 3000사이에 있는 사원의 사번, 사원명, 급여, 관리자사번 입력하는 INSERT문 작성

CREATE TABLE ex3_6(
    employee_id NUMBER(6,0),
    emp_name VARCHAR(80 BYTE),
    salary NUMBER(8,2),
    manager_id NUMBER(6,0));
    
INSERT INTO ex3_6
SELECT employee_id, emp_name, salary, manager_id
FROM employees
WHERE manager_id  = '124'
AND salary BETWEEN '2000' AND '3000'
ORDER BY employee_id;

SELECT *
FROM ex3_6;

-- 예제2
-- 관리자사번이 145번인 사원을 찾아 위 테이블에 있는 사원의 사번과 일치하면
-- 보너스 금액에 자신의 급여의 1%를 보너스로 갱신하고
-- ex3_3 테이블에 있는 사원의 사번과 일치하지 않는 사원을 신규입력 (보너스 금액은 급여의 0.5%) 하는 MERGE문 작성

DELETE EX3_3;

INSERT INTO EX3_3 (employee_id)
SELECT e.employee_id
FROM employees e, sales s
WHERE e.employee_id = s.employee_id
AND s.SALES_MONTH BETWEEN '200010' AND '200012'
GROUP BY e.employee_id;

SELECT *
FROM ex3_3;

MERGE INTO ex3_3 d
USING (SELECT employee_id,salary,manager_id
            FROM employees
            WHERE manager_id = 145) b
            ON (d.employee_id = b.employee_id)
WHEN MATCHED THEN
    UPDATE SET d.bonus_amt = d.bonus_amt + b.salary * 0.01
WHEN NOT MATCHED THEN
    INSERT (d.employee_id, d.bonus_amt) VALUES (b.employee_id, b.salary * 0.005);
    
SELECT *
FROM EX3_3
ORDER BY employee_id;

-- 예제 3
-- 사원테이블에서 커미션 값이 없는 사원의 사번과 사원명을 추출
SELECT employee_id, emp_name
FROM employees
WHERE commission_pct IS NULL;

-- 예제 4
-- 아래 쿼리를 논리 연산자로 변환

/*SELECT employee_id, salary
FROM employees
WHERE salary BETWEEN 2000 AND 2500
ORDER BY employee_id;
를 논리연산자로 변환하기*/


SELECT employee_id, salary
FROM employees
WHERE salary >= 2000 AND salary <= 2500
ORDER BY employee_id;

-- 예제 5

-- 두 쿼리를 ANY,ALL을 사용해서 동일한 결과를 추출하게 변경

-- 1 쿼리
SELECT employee_id, salary
FROM employees
WHERE salary IN (2000,3000,4000)
ORDER BY employee_id;

SELECT employee_id, salary
FROM employees
WHERE salary = ANY (2000,3000,4000)
ORDER BY employee_id;

-- 2 쿼리
SELECT employee_id, salary
FROM employees
WHERE salary NOT IN (2000,3000,4000)
ORDER BY employee_id;

SELECT employee_id, salary
FROM employees
WHERE salary <>ALL (2000,3000,4000)
ORDER BY employee_id;

-- 21.05.27

-- 절대값 반환 함수 ABS
SELECT ABS(10), ABS(-10), ABS(-10.123)
FROM DUAL;

-- CEIL 매개변수 n과같거나 큰 정수를 반환

SELECT CEIL(10.123), CEIL(10.541), CEIL(11.001)
FROM DUAL;

-- FLOOR 매개변수 n보다 작거나 가장 큰 정수를 반환

SELECT FLOOR(10.123), FLOOR(10.541), FLOOR(11.001)
FROM DUAL;

-- ROUND(n,i) 반올림

-- i 양수일 경우
SELECT ROUND(10.154, 1), ROUND(10.154,2), ROUND(11.001)
FROM DUAL;

-- i 음수일 경우
SELECT ROUND(0, 3), ROUND(115.155, -1), ROUND(115.155, -2)
FROM DUAL;

-- TRUNC(n1, n2)
-- 반올림을 하지 않고 n1을 소수점 기준 n2 자리에서 무조건 잘라낸 결과 반환
-- n2 생략가능, 디폴트 값 0, 양수의 경우 소수점 기준 오른쪽, 음수는 왼쪽 자르기

SELECT TRUNC(115.155), TRUNC(115.155, 1), TRUNC(115.155, 2), TRUNC(115.155, -2)
FROM DUAL;

-- POWER(n2, n1) n2를 n1 제곱한 결과를 반환 (n2가 음수일 경우 n1은 정수만 올 수 있음)

SELECT POWER(3, 2), POWER(3, 3), POWER(3, 3.0001)
FROM DUAL;

-- n2가 음수
SELECT POWER(-3, 3.0001)
FROM DUAL; -- ERROR

-- SQRT n의 제곱근을 반환
SELECT SQRT(2), SQRT(5)
FROM DUAL;

-- MOD(n2, n1)
SELECT MOD(19,4), MOD(19.123, 4.2)
FROM DUAL;

-- REMAINDER(n2, n1) MOD와 반환값은 같지만 나머지를 구하는 내부적 연산 방법이 약간 다름

SELECT REMAINDER(19, 4), REMAINDER(19.123, 4.2)
FROM DUAL;

-- EXP 지수 함수 e(2.71828183~) 의 n 제곱 반환
-- LN 자연 로그 함수 밑수가 e
-- LOG(n2, n1) 밑수를 n2로 하는 n1의 로그값 반환

SELECT EXP(2), LN(2.713), LOG(10, 100)
FROM DUAL;

-- 문자 함수

-- 첫문자는 대문자로 나머지는 소문자로 반환
-- 첫문자 인식 기준 공백,알파벳(숫자 포함)을 제외한 문자를 인식
SELECT INITCAP('NEVERSAYGOOBYE'), INITCAP('never6say*good가bye')
FROM DUAL;

-- LOWER 문자를 모두 소문자로
-- UPPER 문자를 모두 대문자로
SELECT LOWER('NEVER SAY GOODBYE'), UPPER('never say goobbye')
FROM DUAL;

-- CONCAT = || 연산자와 같이 매개변수로 들어오는 두 문자를 붙여서 반환
SELECT CONCAT('I Have', ' A Dream'), 'I Have' || ' A Dream'
FROM DUAL;

-- SUBSTR 문자열 자르기 (char, pos, len)
SELECT SUBSTR('ABCDEFG', 1, 4), SUBSTR('ABCDEFG', -1, 4)
FROM DUAL;

-- SUBSTRB 문자의 바이트 수 만큼 자르기
SELECT SUBSTRB('ABCDEFG', 1, 4), SUBSTRB('가나다라마바사', 1, 4)
FROM DUAL;

-- LTRIM 왼쪽 기준으로 명시된 문자 한 번씩만 제거
-- RTRIM 오른쪽 기준
-- 보통 공백을 제거할 때 많이 사용
SELECT LTRIM('ABCDEFGABC', 'ABC'),
       LTRIM('가나다라', '가'),
       RTRIM('ABCDEFGABC', 'ABC'),
       RTRIM('가나다라', '라')
FROM DUAL;

-- LPAD(expr1,n,expr2)
-- 매개변수로 들어온 expr2 문자열(생략 시 디폴트는 공백 한 문자) n자리만큼 왼쪽부터 채워
-- expr1을 반환하는 함수
-- RPAD는 오른쪽부터 채움
SELECT LTRIM('가나다라', '나'), RTRIM('가나다라', '나')
FROM DUAL;

CREATE TABLE EX4_1(
phone_num VARCHAR2(30));

INSERT INTO ex4_1 VALUES ('111-1111');
INSERT INTO ex4_1 VALUES ('111-2222');
INSERT INTO ex4_1 VALUES ('111-3333');

SELECT *
FROM ex4_1;

SELECT LPAD(phone_num, 12, '(02)')
FROM ex4_1;

SELECT RPAD(phone_num, 12, '(02)')
FROM ex4_1;

-- REPLACE 문자열 대체
-- TRANSLATE 문자열 자체가 아닌 문자 한 글자씩 매핑하여 바꾼 결과 반환
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나', '너')
FROM DUAL;

SELECT LTRIM(' ABC DEF '),
       LTRIM(' ABC DEF '),
       REPLACE(' ABC DEF ', ' ','')
FROM DUAL;

SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') AS rep,
       TRANSLATE('나는 너를 모르는데 너는 나를 알겠는가?', '나는', '너를') AS trn
FROM DUAL;

--SELECT employee_id,
--       TRANSLATE(EMP_NAME,'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'thehillsarealivewiththesou')
--       AS TRANS_NAME
--FROM employees;

-- INSTR(str, substr, pos, occur)
-- str 문자열에서 substr과 일치하는 위치를 반환
-- pos 는 시작위치로 디폴트는 1
-- occur은 몇 번째 일치하는지를 명시하여 디폴트 1
SELECT INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약') AS INSTR1,
        INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5) AS INSTR2,
        INSTR('내가 만약 외로울 때면, 내가 만약 괴로울 때면, 내가 만약 즐거울 때면', '만약', 5, 2) AS INSTR3
FROM DUAL;

-- LENGTH 매개변수로 들어온 문자열의 개수를 반환, LENGTHB 해당 문자열의 바이트 수 반환
SELECT LENGTH('대한민국'),LENGTHB('대한민국')
FROM DUAL;

-- 날짜 함수

-- SYSDATE, SYSTIMESTAMP 현재 일자 시간을 반환
SELECT SYSDATE, SYSTIMESTAMP
FROM DUAL;

-- ADD_MONTH(date, integer) 매개변수로 들어온 날짜에 integer만큼의 월을 더한 날짜를 반환
SELECT ADD_MONTHS(SYSDATE, 1), ADD_MONTHS(SYSDATE, -1)
FROM DUAL;

-- MONTHS_BETWEEN(date1, date2) 두 날짜 사이의 개월 수 반환 date2가 date1 보다 빠른 날짜
SELECT MONTHS_BETWEEN(SYSDATE, ADD_MONTHS(SYSDATE, 1)) mon1,
       MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, 1), SYSDATE) mon2
FROM DUAL;

-- LAST_DAY(date)
-- date 날짜 기준으로 해당 월의 마지막 일자 반환
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- ROUND(date,format), TRUNC(date,format)
-- 숫자함수이면서 날짜 함수로도 쓰임
-- ROUND는 format에 따라 반올림한 날짜, TRUNC는 잘라낸 날짜를 반환
SELECT SYSDATE, ROUND(SYSDATE, 'month'), TRUNC(SYSDATE, 'month')
FROM DUAL;

-- NEXT_DAY(date, char)
-- date를 char에 명시한 날짜로 다음 주 주중 일자를 반환한다.
SELECT NEXT_DAY(SYSDATE, '금요일')
FROM DUAL;

-- 변환 함수

-- TO_CHAR(숫자 혹은 날짜,format)
-- 숫자나 날짜를 문자로 변환해주는 함수
-- 명시적 형변환
SELECT TO_CHAR(123456789,'999,999,999')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;

-- TO_NUNBER(expr, format)
-- 문자나 다른 유형의 숫자를 NUMBER 형으로 변환하는 함수
SELECT TO_NUMBER('123456')
FROM DUAL;

-- TO_DATE(char, format), TO_TIMESTAMP(char, format)
-- 문자를 날짜형으로 변환하는 함수
-- DATE 는 DATE로 TIMESTAMP는 TIMESTAMP로

SELECT TO_DATE('20210527', 'YYYY-MM-DD')
FROM DUAL;

SELECT TO_TIMESTAMP('12:18:50', 'HH24:MI:SS')
FROM DUAL;

-- NVL(expr1, expr2), NVL2(expr1,expr2,expr3)

-- NVL = expr1이 NULL 일 경우 expr2로 반환
-- NVL2 = NVL의 확장 = expr1이 NULL이 아니면 expr2 반환 NULL이면 expr3 반환

SELECT NVL(manager_id, employee_id)
FROM employees
WHERE manager_id IS NULL;

SELECT NVL2(commission_pct, salary + ( salary * commission_pct), salary) AS salary2
FROM employees;

-- COALESCE(expr1, expr2 ~)
-- 매개 변수로 들어오는 표현식에서 NULL 이 아닌 첫 번째 표현식을 반환하는 함수
SELECT employee_id, salary, commission_pct,
        COALESCE (salary * commission_pct, salary) AS salary2
FROM employees;

-- LNNVL(조건식)
-- 매개변수로 들어오느 조건식의 결과가 FALSE 나 UNKNOWN 이면 TRUE
 -- TRUE이면 FALSE 반환
 
 -- 커미션이 0.2인 사원 조회
 SELECT employee_id, commission_pct
 FROM employees
 WHERE commission_pct < 0.2;
 
 -- 커미션이 NULL인 사원까지 조회하기 (NVL 사용)
 SELECT COUNT(*)
 FROM employees
 WHERE NVL(commission_pct, 0) < 0.2;
 
 -- 커미션이 0.2 이상 조건이 TRUE -> FALSE 반환
 SELECT COUNT(*)
 FROM employees
 WHERE LNNVL(commission_pct >= 0.2);
 
--21.05.28
 
 -- 기타함수
 
 -- 최대 최소 값 찾기
 SELECT GREATEST(1, 2, 3, 2),
            LEAST(1, 2, 3, 2)
FROM DUAL;
 
 -- 문자도 가능하다
 
 SELECT GREATEST('이순신',  '강감찬', '세종대왕'),
            LEAST('이순신',  '강감찬', '세종대왕')
FROM DUAL;

-- DECODE(expr, search1, result1, search2, result2....,default)
-- 비교대상 expr <- search(n) 과 같으면 result(n) 출력

SELECT prod_id,
    DECODE(channel_id, 3, 'Direct',
                                 9, 'Direct',
                                 5, 'Indirect',
                                 4, 'Indirect',
                                 'Ohters') decodes
FROM sales
WHERE rownum < 10;

-- self check

-- 1
SELECT LPAD(SUBSTR(phone_number,5), 12, '(02)')
FROM employees;

-- 2

SELECT employee_id 사원번호, emp_name 사원명, HIRE_DATE 입사일자, ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12) 근속년수
FROM employees
WHERE  ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)>= 10
ORDER BY ROUND(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12);

-- 3

SELECT REPLACE(cust_main_phone_number, '-' , '/')
FROM CUSTOMERS;

-- 4

SELECT TRANSLATE(cust_main_phone_number, '0123456789', 'ABCDEFGHIJ')
FROM CUSTOMERS;

-- 5

SELECT SUBSTR(TO_NUMBER(TO_CHAR(SYSDATE, 'yyyymmdd')),1,4)  - cust_year_of_birth 나이
FROM CUSTOMERS;

SELECT DECODE(SUBSTR(SUBSTR(TO_NUMBER(TO_CHAR(SYSDATE, 'yyyymmdd')),1,4)  - cust_year_of_birth,1,1),
                    3,'30대',
                    4,'40대',
                    5,'50대',
                    '기타') 연령
FROM CUSTOMERS;

-- 6 

SELECT 나이,
CASE WHEN 나이 BETWEEN 20 AND 29 THEN '20대'
        WHEN 나이 BETWEEN 30 AND 39 THEN '30대'
        WHEN 나이 BETWEEN 40 AND 49 THEN '40대'
        WHEN 나이 BETWEEN 50 AND 59 THEN '50대'
        WHEN 나이 BETWEEN 60 AND 69 THEN '60대'
        WHEN 나이 BETWEEN 70 AND 79 THEN '70대'
        WHEN 나이 BETWEEN 80 AND 89 THEN '80대'
        WHEN 나이 BETWEEN 90 AND 99 THEN '90대'
END AS 연령대
FROM (SELECT TRUNC(TO_CHAR(SYSDATE,'YYYY') - cust_year_of_birth) AS 나이 FROM CUSTOMERS);
