-- PL/SQL 사용자 정의 함수

CREATE OR REPLACE FUNCTION my_mod( num1 NUMBER, num2 NUMBER )
RETURN NUMBER -- 첫번째 리턴에는 반환될 데이터 타입 명시
IS
    vn_remainder NUMBER := 0; -- 반환 할 나머지
    vn_quotient NUMBER := 0; -- 몫

BEGIN
 vn_quotient := FLOOR(num1 / num2); -- 정수 부분을 걸러내기
 vn_remainder := num1 - (num2 * vn_quotient); 
 
    RETURN vn_remainder; -- 나머지 반환

END;
/

-- 사용자 지정 함수 호출
SELECT my_mod(14, 3) remainder FROM DUAL;


-- 사용자 지정 함수를 사용
-- 국가 테이블을 읽어 국가번호를 받아 국가명을 반환하는 함수

CREATE OR REPLACE FUNCTION fn_get_country_name( p_country_id NUMBER) -- 함수명 지정, 매개변수 지정(데이터 타입도 지정한다)
    RETURN VARCHAR2 -- 반환할 데이터 타입 (여기서는 국가명이기 때문에 VARCHAR2를 사용)
IS
vs_country_name COUNTRIES.COUNTRY_NAME%TYPE;
vn_count NUMBER := 0; -- 국가가 있는지 확인 COUNT
BEGIN
    SELECT COUNT(*)
    INTO vn_count
    FROM countries
    WHERE country_id = p_country_id;
    
    -- 매개변수로 들어오는 국가가 없을 경우
    IF vn_count = 0 THEN
        vs_country_name := '해당국가 없음';
    
    ELSE
        SELECT country_name
        INTO vs_country_name
        FROM countries
        WHERE country_id = p_country_id;
    END IF;
    
    RETURN vs_country_name; -- 국가명을 반환한다.
END;
/

--  실행

SELECT fn_get_country_name (52777) COUN1, fn_get_country_name (10000) COUN2 FROM DUAL;

-- 매개변수 없이 함수를 만들 수 있다.
-- 현재 로그인한 사용자 이름을 반환하는 함수
CREATE OR REPLACE FUNCTION fn_get_user
    RETURN VARCHAR2
IS
    vs_user_name VARCHAR2(80);
BEGIN
    SELECT USER
    INTO vs_user_name
    FROM DUAL;
    
    RETURN vs_user_name;
END;
/

-- EXECUTE

SELECT fn_get_user(), fn_get_user FROM DUAL; -- 매개변수가 없을 경우 () 는 생략 가능

--프로시저
/*
특정한 로직을 처리하기만 하고 결과 값을 반환하지 않는 서브 프로그램
개별적인 단위 업무는 주로 프로시저로 구현해 처리한다.
즉 테이블에서 데이터를 추출해 입맛에 맞게 조작하고 그 결과를 다른 테이블에 다시 저장하거나 갱신하는 일련의 처리를 할 때 주로 프로시저를 사용
*/

CREATE OR REPLACE PROCEDURE my_new_job_proc(
    p_job_id IN JOBS.JOB_ID%TYPE,
    p_job_title IN JOBS.JOB_TITLE%TYPE,
    p_min_sal IN JOBS.MIN_SALARY%TYPE,
    p_max_sal IN JOBS.MAX_SALARY%TYPE )
    IS
    
    BEGIN
    INSERT INTO JOBS( job_id, job_title, min_salary, max_salary, create_date, update_date)
    VALUES (p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE);
    COMMIT;
END;
/

-- PROCEDURE 실행

-- EXEC , EXECUTE 둘 중 하나 선택

EXEC my_new_job_proc ('SN_JOB1', 'SAMPLE JOB1', 1000, 5000); -- 로직을 처리하기만 하고 결과값을 반환하지 않는다.

-- JOBS 테이블에 반영되었는지 확인
SELECT *
FROM JOBS
WHERE JOB_ID = 'SN_JOB1';

EXEC my_new_job_proc ('SN_JOB1', 'SAMPLE JOB1', 1000, 5000); -- job_id 는 primary key 로 잡혀있는데도 동일한 job_id 를 또 입력하려고 시도하여 오류 발생

-- 동일한 job_id 가 들어왔을 때 신규 insert 대신 다른 정보를 갱신하도록 procedure 수정

CREATE OR REPLACE PROCEDURE my_new_job_proc(
    p_job_id IN JOBS.JOB_ID%TYPE,
    p_job_title IN JOBS.JOB_TITLE%TYPE,
    p_min_sal IN JOBS.MIN_SALARY%TYPE := 10, -- 디폴트 값 설정 가능하다.
    p_max_sal IN JOBS.MAX_SALARY%TYPE:= 100 )
    
    IS
    vn_cnt NUMBER := 0;
    
    BEGIN
    -- 동일한 job_id 여부 체크
    
    SELECT COUNT(*)
    INTO vn_cnt
    FROM JOBS
    WHERE job_id = p_job_id;
    
    -- 없다면 INSERT 진행
    IF vn_cnt = 0 THEN
        INSERT INTO JOBS( job_id, job_title, min_salary, max_salary, create_date, update_date)
        VALUES (p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE);
    
    ELSE -- 있으면 UPDATE
    
    UPDATE JOBS
        SET job_title = p_job_title,
            min_salary = p_min_sal,
            max_salary = p_max_sal,
            update_date = SYSDATE
        WHERE job_id = p_job_id;
    END IF;
    COMMIT;
END;
/
-- 다시 실행 해보기 (촤소 급여, 최대 급여 수정)
EXEC my_new_job_proc ('SN_JOB1', 'SAMPLE JOB1', 2000, 6000);

SELECT *
FROM JOBS
WHERE job_id = 'SN_JOB1';

-- 매개변수와 입력 값을 매핑해서 사용해보기

EXECUTE my_new_job_proc (p_job_id => 'SN_JOB1', p_job_title => 'SAMPLE JOB1', p_min_sal => 2000, p_max_sal => 7000);

SELECT *
FROM JOBS
WHERE job_id = 'SN_JOB1';

-- OUT, IN OUT 매개변수

CREATE OR REPLACE PROCEDURE my_new_job_proc(
    p_job_id IN JOBS.JOB_ID%TYPE,
    p_job_title IN JOBS.JOB_TITLE%TYPE,
    p_min_sal IN JOBS.MIN_SALARY%TYPE := 10, -- 디폴트 값 설정 가능하다.
    p_max_sal IN JOBS.MAX_SALARY%TYPE:= 100,
    p_upd_date OUT JOBS.UPDATE_DATE%TYPE)
    
    IS
    vn_cnt NUMBER := 0;
    vn_cur_date JOBS.UPDATE_DATE%TYPE := SYSDATE;
    
    BEGIN
    -- 동일한 job_id 여부 체크
    
    SELECT COUNT(*)
    INTO vn_cnt
    FROM JOBS
    WHERE job_id = p_job_id;
    
    -- 없다면 INSERT 진행
    IF vn_cnt = 0 THEN
        INSERT INTO JOBS( job_id, job_title, min_salary, max_salary, create_date, update_date)
        VALUES (p_job_id, p_job_title, p_min_sal, p_max_sal, vn_cur_date, vn_cur_date);
    
    ELSE -- 있으면 UPDATE
    
    UPDATE JOBS
        SET job_title = p_job_title,
            min_salary = p_min_sal,
            max_salary = p_max_sal,
            update_date = vn_cur_date
        WHERE job_id = p_job_id;
    END IF;
    
    -- OUT 매개변수에 일자 할당
    p_upd_date := vn_cur_date;
    COMMIT;
END;
/

-- 익명 블록에서 프로시저를 실행 할 때는 EXEC 를 붙이지 않는다. 그래서 오류가 발생한 것.
DECLARE
    vd_cur_date JOBS.UPDATE_DATE%TYPE;
 BEGIN
    EXECUTE my_new_job_proc( 'SN_JOB1', 'SAMPLE JOB1', 2000, 6000, vd_cur_date);
    DBMS_OUTPUT.PUT_LINE (vd_cur_date);
END;
/
-- 익명 블록에서 EXEC 붙이지 않았을 경우 정상 실행
DECLARE
    vd_cur_date JOBS.UPDATE_DATE%TYPE;
 BEGIN
    my_new_job_proc( 'SN_JOB1', 'SAMPLE JOB1', 2000, 6000, vd_cur_date);
    DBMS_OUTPUT.PUT_LINE (vd_cur_date);
END;
/

-- INOUT 매개변수
-- 선언과 동시에 입출력
-- OUT 매개변수는 해당 프로시저가 성공적으로 실행을 완료할 때까지 값이 할당되지 않는다.
-- 그렇기 때문에 매개변수에 값을 전달해서 사용한 후 이 매개변수에 값을 받아와 참조하고 싶을 경우 IN OUT 을 사용

CREATE OR REPLACE PROCEDURE my_parameter_test_proc(
    p_var1 VARCHAR2,
    p_var2 OUT VARCHAR2, -- OUT 매개변수는 프로시저가 성공적으로 실행을 완료할 때까지 값이 할당되지 않음
    p_var3 IN OUT VARCHAR2)
    
IS

BEGIN
    DBMS_OUTPUT.PUT_LINE('p_var1 value = ' || p_var1);
    DBMS_OUTPUT.PUT_LINE('p_var2 value = ' || p_var2);
    DBMS_OUTPUT.PUT_LINE('p_var3 value = ' || p_var3);
    
    p_var2 := ' B2';
    p_var3 := ' C2';

END;
/

-- EXECUTE

DECLARE
    v_var1 VARCHAR2(10) := 'A';
    v_var2 VARCHAR2(10) := 'B';
    v_var3 VARCHAR2(10) := 'C';
BEGIN
    my_parameter_test_proc (v_var1, v_var2, v_var3);
    
    DBMS_OUTPUT.PUT_LINE('v_var2 value = ' || v_var2);
    DBMS_OUTPUT.PUT_LINE('v_var3 value = ' || v_var3);
END;
/

/*
    IN 매개변수는 참조만 가능하며 값을 할당할 수 없다.
    OUT 매개변수에 값을 전달할 수 있지만 의미는 없다.
    OUT, IN OUT 매개변수에는 디폴트 값을 설정할 수 없다.
    IN 매개변수에는 변수나 상수, 각 데이터 유형에 따른 값을 전달할 수 있지만, OUT, IN OUT 매개변수를 전달 할 때는 반드시 변수 형태로 값을 넘겨주어야한다.
*/

