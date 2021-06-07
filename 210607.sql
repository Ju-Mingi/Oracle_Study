-- 21.06.07
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
PL/SQL
 BLOCK PL/SQL 소스 프로그램의 기본 단위
 선언부, 실행부, 예외 처리부로 구성되어있다.
 */
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 /*
 [구문]
 이름부 -- 블록의 명칙 생략 시 익명 블록이 됨
 IS(AS)
 선언부 -- DECLARE 시작 실행부와 예외 처리부에서 사용할 각종 변수, 상수, 커서등을 선언 , 반드시 세미콜론 붙여야함. 사용한 변수나 상수가 없으면 생략 가능
 BEGIN
 실행부 -- 실제 로직 처리 SQL 문장 중 DDL 사용 불가, DML만 사용 가능, 세미콜론을 붙여야함.
 EXCEPTION
 예외처리부 -- 로직 처리 중 오류 발생시 처리할 내용을 기술, 생략 가능
END;
*/
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 익명블록의 예시

DECLARE vi_num NUMBER;
BEGIN vi_num := 100; -- PL/SQL 에서 값의 할당은 = 이 아닌 := 을 사용한다.
DBMS_OUTPUT.PUT_LINE(vi_num);
END;
/

-- 출력하기

SET SERVEROUTPUT ON
DECLARE
        vi_num NUMBER;
BEGIN
        vi_num := 100;
        DBMS_OUTPUT.PUT_LINE(vi_num);
END;
/


-- 블록을 실행하는데 소요되는 시간 확인하기

SET SERVEROUTPUT ON
SET TIMING ON
DECLARE
vi_num NUMBER;
BEGIN
vi_num := 100;
DBMS_OUTPUT.PUT_LINE(vi_num);
END;
/
-- SQL DEV 에서 / 를 사용하지 않아도 됨

-- SQL PLUS
-- PL / SQL에서 하위 프로그램 (DECLARE, BEGIN, END)이있는 경우 사용 된 세미콜론은 하위 프로그램의 일부로 간주되므로 슬래시를 사용해야합니다.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 변수
-- 변수 선언 방법 : DATATYPE := 초기값;
-- 다른 프로그래밍 언어에서 사용하는 변수와 개념이 같다.
-- 초기값을 할당하지 않는 경우 NULL 값이 할당된다.
-- SQL 타입, PL/SQL 타입 2 종류가 있다.

-- PL/SQL 데이터 타입으로는 BOOLEAN, PLS_INTEGER, BINARY_INTEGER 등이 있다.

/* PLS_INTEGER 하위 타입
NATURAL                    음수 제외 (0 포함)
NATURALN                  음수 제외이지만 NULL 할당 불가, 반드시 선언 시 초기화 필요 
POSITIVE                     양수 (0 미포함)
POSITIVEN                   양수이지만 NULL 할당 불가, 반드시 선언 시 초기화 필요
SIGNTYPE                    -1,0,1
SIMPLE_INTEGER      NULL 이 아닌 모든 값, 반드시 선언 시 초기화 필요
*/
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 상수 CONSTANT

-- 형태 CONSTANT DATATYPE := 상수 값;
-- 한 번 값을 할당하면 변하지 않고 SQL 타입과 PL/SQL 타입 모두 사용 가능하다.
-- 특정 값을 할당하고 실행부에서 사용하고자 할 때 사용 된다.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 연산자
-- PL/SQL 블록에서는 모든 SQL 연산자를 사용할 수 있다.

DECLARE
    a INTEGER := 2**2*3**2;
 BEGIN
    DBMS_OUTPUT.PUT_LINE('a = ' || TO_CHAR(a));
 END;
 /
 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DML 문
-- SELECT INTO 테이블에서 특정 값을 선택해 변수에 할당할 경우 사용
DECLARE
vs_emp_name VARCHAR2(80); -- 사원명 변수 
vs_dep_name VARCHAR2(80); -- 부서명 변수
BEGIN
SELECT a.emp_name, b.department_name -- 특정 값 선택
INTO vs_emp_name, vs_dep_name -- vs_~~ 변수에 할당
FROM employees a, departments b
WHERE a.department_id = b.department_id
AND a.employee_id = 100;

-- 까먹지 말자 !!     || <- 문자열 연결 연산자
DBMS_OUTPUT.PUT_LINE(vs_emp_name || ' - ' || vs_dep_name);
END;
/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- %TYPE
-- 변수명 테이블명.컬럼명%TYPE 해당 변수에 컬럼 타입을 자동으로 가져온다. 

DECLARE
vs_emp_name employees.emp_name%TYPE;
vs_dep_name departments.department_name%TYPE;
BEGIN
SELECT a.emp_name, b.department_name -- 특정 값 선택
INTO vs_emp_name, vs_dep_name -- vs_~~ 변수에 할당
FROM employees a, departments b
WHERE a.department_id = b.department_id
AND a.employee_id = 100;
DBMS_OUTPUT.PUT_LINE(vs_emp_name || ' - ' || vs_dep_name);
END;
/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LABEL 특정 부분에 이름을 부여
-- <<라벨명>> 형태
-- GOTO 문을 사용하면 해당 라벨로 이동 가능 GOTO 라벨명;

BEGIN
GOTO second_message;
<<first_message>>
DBMS_OUTPUT.PUT_LINE('Hello');
GOTO the_end;
<<second_message>>
DBMS_OUTPUT.PUT_LINE('PL/SQL GOTO Demo');
GOTO first_message;
<<the_end>>
DBMS_OUTPUT.PUT_LINE('and good bye...');
END;
/

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--SQL 과 PL/SQL의 데이터 타입별 길이 차이
CREATE  TABLE ch08_varchar2(
VAR1 VARCHAR(4000));

INSERT INTO ch08_varchar2 (VAR1)
VALUES ('tQbADHDjqtRCvosYCLwzbyKKrQCdJubDPTHnzqvjRwGxhQJtrVbXsLNlgeeMCemGMYpvfoHUHDxIPTDjleABGoowxlzCVipeVwsMFRNzZYgHfQUSIeOITaCKJpxAWwydApVUlQiKDgJlFIOGPOKoJsoemqNbOLdZOBcQhDcMLXuYjRQZDIpgpmImgiwzcLkSilCmLrSbmFNsKEEpzCHDylMvkYPKPNeuJxLvJiApNCYzrMcflECbxwNTKSxaEwVvCYnTnFfMFgDqxobWcSmMJrNTQIVOeWlPaMTfRHsrlFSukppmljmOojPSgJiSbQcgtWWOwUNNYFGtgCGBsIcTGAiHWBxtYVXecoJgJCAJptIVmVTZSKliRLoPYTIUpksBuQaqFHLhCkosWChoMjbqgLtBIRBynsKjKiLrdeHVvZanNVElDjLWwlCDhbpsAVQMTzjzhoKIJBdthynMBMVjeNmsKAjdAYhPZKmuKOuMloQdkqPjoKbfjDEeATciMrXiMQorMhYmBlMODBbyLLIkbmtZdPcWGSuxFEUwXnWpvnunEgcLelSneRIpgRNTzTkHqgLbpxoHzCYgSWlIAvKljCnmWiPWGGwlUFOudRSdoqUxntyhNYEiVXtMObywEltTImawnElpmeiWwlTjGTFceqyjhNqiDLxwduubykWzDmFSJNvVvDZibrCpAReqQjlQZcxuVqjKGKvoDuEcQPQeDzmdMYSOTIQdPDNfDffCOUWflHSQhvVTiYumBQIoyznWNITGZkefknJpGEutUnhBgLPQTWTBeTYccqlLrxvRjfJpdpfVDqqfKCngemIEDDHNdvBxCqKDTrrJAumXMKgpWLIHctQuACeNaKnffpYXiioLxZDrxpuZPPUGpRsCtoQuBfogkKuusVATkMyajKTPSyTQbfhZepRjNdrhkymqKvsAcThYbMSMnkKcLWFPAMeGysBVKkQtFMPvRBoDszlSZcMYzwxkKQwJnuVnDxShYiHFlzgDWqhZoqeypyFVBNDtHkiVzHkQisYLbsbVneJyHbHdtaIFLVbfTqbkGQTEjFlPiGUddPUIoLWALrbKcLwBizwhJvaXkvOphcGWpdNAhxgehCvjcQFSFhxrBuANKjyWncWAUpKKJcfQCsQlLfpqdMhjWGkAMMWUaDfCrGtmtkiIZOdNapEnvfFKiHAhBhejgKSuyKXFQXyCaLwwvonHsceJKgjtnYVZvBCYYBSqNCqVqCGewootJJsqrCnmiteMZBbyMPnIrdcielnGUYmwiOPmEqKGvxDmDRTDRumnSRcnvgxLbaiQIuzdslEIMquvvwmvgaumqPkduNyfRtXErCPvDYLelhjNNOjbGryRpTtDHxIJebMEtKryUyZRIdADeTEBExwHMRHzAYFizYiesaMhNIsOUzUTmyEMuFQrsUEtjwhUWIvADNlrcxPZwRazPMMvdVZssmXbXuCkRoPYNGLPwUmrWrrIgQoMSGMPvTcbHnbtleyKYmOMgymANQBZDMoqAOzMHrAVunIiykCudFVNObNgXOoyfQRICbFsWygSZXufipvrWWmRnBWYdoKmIRewOObUjiNDdQsxQIXtlbPSSngfQPfeQKOolVASXIuAmeODKtSOPaEaFKcedGzzsbrPlsPnRRuYFeVdhyufpjFVVrTPczSQkmPYXercLMmVEaDmJXKTqEVNSKeOshDCDJwdINFsLhAuKIIfOdjSEndDwumQLvePVjzNoIfUELOANeshoNgwVhFADjtUIjIhQAIyRnzSoxSRSWklITMgdjQZTthwsnBVLWyfSsAdLzOnEqmMCGBlTYGjtqvKbBoATRwkPkOTSbUhZClVzjiLLIFEMuptuodeRKXUaBfUhVTtasFsZdVnKtEfLldJYsxjlrBADRqhEBEmBKxlXKgEhiKcwAdztcETMUteJwadfaZLEBRjwJOGaIMhsfAxtuBQWyQLGXPDlFQmkcMsKsGUlQBEAubDqbuBYqXLZgmhPftLkYaCYGReLCVXssOxzJFJwnxKJzaaYzfVpbHYBtiBeQZRilJZqrrMTrVtYAcwGxAAddwtlxzdZebfZHjzqRmrrBPNbkVHqjCHtVKUjIDPVSrtyEsPRPoyyPOFOSBcgClTzlAIPmPMkdlpFHctzKGpyQMInMwPKojVErCOrHbCsZoEXqyOcHReSybmxwYabyioVnDxPEvskutVHLWQTNudmKICoaoSGKqONrBmvtGNBKAaJxCRKTDOIqrJOsQVOmGxmuIDEddVYvDwILTyushOAiXbkRIKgNLnFJdOagmiOHKRBKIIkxkOUeZWMRNlqpJdFgKjrGhIzrgBtgjVOtZAskKRbqzRVwLUoUAtRpRkoRQNLIrbLmmjZTugXJBNCscnMguKVAFDKpODtCsmdlBvQGALeBGUitYBxLYhJxeVcAnTWmTAvCITzdzqiBfEudEIBmkDAXIFmoOmsTMZDOnhXYrgMDlDbjednYWWJbGhrXFrxMQmQSmRBwoOqWGbGmjZNlJCvSHvmtZUkIScWXVdfSsdvdyQNpGFIOuteXhCMLmmEHrMucEmFbCIOHTJINAuIUOPfAfijIPkZjppGCCSRJNXWNCmliwUgABkHWuelUWeLsyVKVcZWOSeiQBQibCQJQUgGkTrXZxdBLsgjeMIwOyORDBpywuvlrLScRNhvaCYaKKRvOZeqBebUWWFhNnIRJvedFNfFPgWZJgNRaUpyYWFNiXJfAqNjyCEQYwAdFBQKKolwrufmJOfrToJFEsoNjaphcNvfWGIjKrKZSoSJEsbRqNVcoprpcGrnBgcNAnWUFpRldcPJkPfaoLKRCmVyMAWMXmnScodKisCTqllZEWQQSCFETxLNntgdcFEFRsTSIhuewwrHIlOeCcRqkzgQhKnKyHZHdFsMEKvPywLbjaspVxUMEkVzCGcGoTmaBjUMwJuAYdSTaYGDHHWDrvGgMVTtehpzfgofkmqtamffJbCKOzJgPsHNEnFarjADJGyKLwwitCiBXIraUdZtZwNjUtGbWqxksepVYztIBrimByoYQfUQgOndzFmhnuSmhYWvHliWUHgbvBIkYasDElNsjcCLtMvjQEhJjWvlnAscPwOYfelrfgfRAZGBxdFlMNkfYEWLbkfUhbRPHoDZsaAQdoKhAAWzOcHoAkkHPQMNIxgHNJaqEFBqCuMYEtLpMnIiMCWWEPnBYgYrxlXFGYpQWUNFevwcEUvUzDeSZNrdmahAfjeLSAGjHVnqyTzJkiVXjDJXzOiszXQCErQwwDMMqjLxWebJwNAVdrXeyMDRYXmLMDnuWLVaShVGhlgvbjOdOnhCDTNVazYDnzstqxjOuWbLcDaavRumKUOQXBQwKtdFgOzXiQKWFporrIcylIHlTmTKAIpBqNUbkajLTlwAHieCcqPIJYhegwQhWpYZdfxpQXDKtYzsrmnvdiTKgXfXKlIHPHlxQtqXGhMVPOBAKVZJfkrDNEwnQFwgfoHJSqQxTzRswVLrtFgpVzKcLilgznElWUfhERyeUrCcFCuGJddlFHJrXsqRdUjqUwaBmJVNwjRbCFiVMOSFuNctNVzhmhUpoddsMPUFMvNIMsMjHIWYiLjhSajZqpDkMvUOUCbYKfNHGpdUeWGUtDXHDNSCEXqYrhWhvnISnjfoBMCwwptksarPImRZaRxBMjoBdlmRGlIuQZDzCLnxxioATnGVFFTATUpeypOCaCeJAvPLxEXYzlCgXvXirGSZFyZPPSCdOSHxeELRsetFrWgqPNNpwgbgBEYPOSpLWeVdqOxPaQnidyPVMmELzeJPWgNsWBdPJPjhkdGpeAYZfrBNqdbOwzbtLiWMPafjgWQNcWKqmcleWLcMJoGSAEIUyFuzElZKXonHOMDdGMtSKEFUWdfPfnDecKNhIjAKRYmkXgpPAzlKIOpViZPkZdozzAoWwDnXkfDikvkXcQaoBtzKkcRhNpJRYaGTkdnlfotsJZsLqpYaWoK')
;

DECLARE
    vs_sql_varchar2 VARCHAR2(4000);
    vs_plsql_varchar2 VARCHAR2(32767);
BEGIN
--ch08_varchar2 테이블의 값을 변수에 담는다.
    SELECT VAR1
    INTO vs_sql_varchar2
    FROM ch08_varchar2;

-- PL/SQL 변수에 4000BYTE 이상 크기의 값을 넣는다.
    vs_plsql_varchar2 := vs_sql_varchar2 || ' - ' || vs_sql_varchar2 || ' - ' || vs_sql_varchar2;

-- 각 변수 크기 출력
DBMS_OUTPUT.PUT_LINE('SQL VARCHAR2 길이 : ' || LENGTHB(vs_sql_varchar2)); 
DBMS_OUTPUT.PUT_LINE('PL/SQL VARCHAR2 길이 : ' || LENGTHB(vs_plsql_varchar2));
END;
/
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 구구단 3단

BEGIN
DBMS_OUTPUT.PUT_LINE(' 3 * 1 = ' || 3*1);
DBMS_OUTPUT.PUT_LINE(' 3 * 2 = ' || 3*2);
DBMS_OUTPUT.PUT_LINE(' 3 * 3 = ' || 3*3);
DBMS_OUTPUT.PUT_LINE(' 3 * 4 = ' || 3*4);
DBMS_OUTPUT.PUT_LINE(' 3 * 5 = ' || 3*5);
DBMS_OUTPUT.PUT_LINE(' 3 * 6 = ' || 3*6);
DBMS_OUTPUT.PUT_LINE(' 3 * 7 = ' || 3*7);
DBMS_OUTPUT.PUT_LINE(' 3 * 8 = ' || 3*8);
DBMS_OUTPUT.PUT_LINE(' 3 * 9 = ' || 3*9);
END;
/

-- 반복문을 사용하기

BEGIN
FOR i IN 1..9 LOOP
DBMS_OUTPUT.PUT_LINE('3 * ' || i || ' = ' || 3*i);
END LOOP;
END;
/

-- 사원테이블에서 201번 사원의 이름과 이메일 주소를 출력하는 익명 블록 만들기

DECLARE
vs_emp_name VARCHAR2(80);
--vs_emp_name employees.employee_id%TYPE;
vs_emp_email VARCHAR2(50);
--vs_emp_email employees.email%TYPE;
BEGIN
SELECT emp_name, email
INTO vs_emp_name, vs_emp_email
FROM employees
WHERE employee_id = 201;

--CHR(10) : line feed(new line) 커서가 위치한 줄의 아래로 이동
--CHR(13) : carriage return 현재 커서가 위치한 줄의 맨 앞으로 커서 이동

DBMS_OUTPUT.PUT_LINE('201번' || CHR(10) || CHR(13) || '사원명 : '|| vs_emp_name || CHR(10)|| CHR(13) || '이메일 ' || vs_emp_email);
END;
/

-- 사원테이블에서 사원번호가 제일 큰 사원을 찾아낸 뒤, 이 '번호+1'번으로 아래의 사원을 사원 테이블에 신규 입력하는 익명 블록을 만들어 보기
DECLARE
empno_max employees.employee_id%TYPE;
BEGIN
SELECT MAX(employee_id)
INTO empno_max
FROM employees;

INSERT INTO employees(employee_id, emp_name, email, hire_date, department_id)
VALUES (empno_max + 1, 'Harrison Ford', 'HARRIS', SYSDATE, 50);
COMMIT;
END;
/

-- 확인 하기
SELECT *
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID DESC;