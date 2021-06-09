-- PL/SQL ����� ���� �Լ�

CREATE OR REPLACE FUNCTION my_mod( num1 NUMBER, num2 NUMBER )
RETURN NUMBER -- ù��° ���Ͽ��� ��ȯ�� ������ Ÿ�� ���
IS
    vn_remainder NUMBER := 0; -- ��ȯ �� ������
    vn_quotient NUMBER := 0; -- ��

BEGIN
 vn_quotient := FLOOR(num1 / num2); -- ���� �κ��� �ɷ�����
 vn_remainder := num1 - (num2 * vn_quotient); 
 
    RETURN vn_remainder; -- ������ ��ȯ

END;
/

-- ����� ���� �Լ� ȣ��
SELECT my_mod(14, 3) remainder FROM DUAL;


-- ����� ���� �Լ��� ���
-- ���� ���̺��� �о� ������ȣ�� �޾� �������� ��ȯ�ϴ� �Լ�

CREATE OR REPLACE FUNCTION fn_get_country_name( p_country_id NUMBER) -- �Լ��� ����, �Ű����� ����(������ Ÿ�Ե� �����Ѵ�)
    RETURN VARCHAR2 -- ��ȯ�� ������ Ÿ�� (���⼭�� �������̱� ������ VARCHAR2�� ���)
IS
vs_country_name COUNTRIES.COUNTRY_NAME%TYPE;
vn_count NUMBER := 0; -- ������ �ִ��� Ȯ�� COUNT
BEGIN
    SELECT COUNT(*)
    INTO vn_count
    FROM countries
    WHERE country_id = p_country_id;
    
    -- �Ű������� ������ ������ ���� ���
    IF vn_count = 0 THEN
        vs_country_name := '�ش籹�� ����';
    
    ELSE
        SELECT country_name
        INTO vs_country_name
        FROM countries
        WHERE country_id = p_country_id;
    END IF;
    
    RETURN vs_country_name; -- �������� ��ȯ�Ѵ�.
END;
/

--  ����

SELECT fn_get_country_name (52777) COUN1, fn_get_country_name (10000) COUN2 FROM DUAL;

-- �Ű����� ���� �Լ��� ���� �� �ִ�.
-- ���� �α����� ����� �̸��� ��ȯ�ϴ� �Լ�
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

SELECT fn_get_user(), fn_get_user FROM DUAL; -- �Ű������� ���� ��� () �� ���� ����

--���ν���
/*
Ư���� ������ ó���ϱ⸸ �ϰ� ��� ���� ��ȯ���� �ʴ� ���� ���α׷�
�������� ���� ������ �ַ� ���ν����� ������ ó���Ѵ�.
�� ���̺��� �����͸� ������ �Ը��� �°� �����ϰ� �� ����� �ٸ� ���̺� �ٽ� �����ϰų� �����ϴ� �Ϸ��� ó���� �� �� �ַ� ���ν����� ���
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

-- PROCEDURE ����

-- EXEC , EXECUTE �� �� �ϳ� ����

EXEC my_new_job_proc ('SN_JOB1', 'SAMPLE JOB1', 1000, 5000); -- ������ ó���ϱ⸸ �ϰ� ������� ��ȯ���� �ʴ´�.

-- JOBS ���̺� �ݿ��Ǿ����� Ȯ��
SELECT *
FROM JOBS
WHERE JOB_ID = 'SN_JOB1';

EXEC my_new_job_proc ('SN_JOB1', 'SAMPLE JOB1', 1000, 5000); -- job_id �� primary key �� �����ִµ��� ������ job_id �� �� �Է��Ϸ��� �õ��Ͽ� ���� �߻�

-- ������ job_id �� ������ �� �ű� insert ��� �ٸ� ������ �����ϵ��� procedure ����

CREATE OR REPLACE PROCEDURE my_new_job_proc(
    p_job_id IN JOBS.JOB_ID%TYPE,
    p_job_title IN JOBS.JOB_TITLE%TYPE,
    p_min_sal IN JOBS.MIN_SALARY%TYPE := 10, -- ����Ʈ �� ���� �����ϴ�.
    p_max_sal IN JOBS.MAX_SALARY%TYPE:= 100 )
    
    IS
    vn_cnt NUMBER := 0;
    
    BEGIN
    -- ������ job_id ���� üũ
    
    SELECT COUNT(*)
    INTO vn_cnt
    FROM JOBS
    WHERE job_id = p_job_id;
    
    -- ���ٸ� INSERT ����
    IF vn_cnt = 0 THEN
        INSERT INTO JOBS( job_id, job_title, min_salary, max_salary, create_date, update_date)
        VALUES (p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE);
    
    ELSE -- ������ UPDATE
    
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
-- �ٽ� ���� �غ��� (�Ҽ� �޿�, �ִ� �޿� ����)
EXEC my_new_job_proc ('SN_JOB1', 'SAMPLE JOB1', 2000, 6000);

SELECT *
FROM JOBS
WHERE job_id = 'SN_JOB1';

-- �Ű������� �Է� ���� �����ؼ� ����غ���

EXECUTE my_new_job_proc (p_job_id => 'SN_JOB1', p_job_title => 'SAMPLE JOB1', p_min_sal => 2000, p_max_sal => 7000);

SELECT *
FROM JOBS
WHERE job_id = 'SN_JOB1';

-- OUT, IN OUT �Ű�����

CREATE OR REPLACE PROCEDURE my_new_job_proc(
    p_job_id IN JOBS.JOB_ID%TYPE,
    p_job_title IN JOBS.JOB_TITLE%TYPE,
    p_min_sal IN JOBS.MIN_SALARY%TYPE := 10, -- ����Ʈ �� ���� �����ϴ�.
    p_max_sal IN JOBS.MAX_SALARY%TYPE:= 100,
    p_upd_date OUT JOBS.UPDATE_DATE%TYPE)
    
    IS
    vn_cnt NUMBER := 0;
    vn_cur_date JOBS.UPDATE_DATE%TYPE := SYSDATE;
    
    BEGIN
    -- ������ job_id ���� üũ
    
    SELECT COUNT(*)
    INTO vn_cnt
    FROM JOBS
    WHERE job_id = p_job_id;
    
    -- ���ٸ� INSERT ����
    IF vn_cnt = 0 THEN
        INSERT INTO JOBS( job_id, job_title, min_salary, max_salary, create_date, update_date)
        VALUES (p_job_id, p_job_title, p_min_sal, p_max_sal, vn_cur_date, vn_cur_date);
    
    ELSE -- ������ UPDATE
    
    UPDATE JOBS
        SET job_title = p_job_title,
            min_salary = p_min_sal,
            max_salary = p_max_sal,
            update_date = vn_cur_date
        WHERE job_id = p_job_id;
    END IF;
    
    -- OUT �Ű������� ���� �Ҵ�
    p_upd_date := vn_cur_date;
    COMMIT;
END;
/

-- �͸� ��Ͽ��� ���ν����� ���� �� ���� EXEC �� ������ �ʴ´�. �׷��� ������ �߻��� ��.
DECLARE
    vd_cur_date JOBS.UPDATE_DATE%TYPE;
 BEGIN
    EXECUTE my_new_job_proc( 'SN_JOB1', 'SAMPLE JOB1', 2000, 6000, vd_cur_date);
    DBMS_OUTPUT.PUT_LINE (vd_cur_date);
END;
/
-- �͸� ��Ͽ��� EXEC ������ �ʾ��� ��� ���� ����
DECLARE
    vd_cur_date JOBS.UPDATE_DATE%TYPE;
 BEGIN
    my_new_job_proc( 'SN_JOB1', 'SAMPLE JOB1', 2000, 6000, vd_cur_date);
    DBMS_OUTPUT.PUT_LINE (vd_cur_date);
END;
/

-- INOUT �Ű�����
-- ����� ���ÿ� �����
-- OUT �Ű������� �ش� ���ν����� ���������� ������ �Ϸ��� ������ ���� �Ҵ���� �ʴ´�.
-- �׷��� ������ �Ű������� ���� �����ؼ� ����� �� �� �Ű������� ���� �޾ƿ� �����ϰ� ���� ��� IN OUT �� ���

CREATE OR REPLACE PROCEDURE my_parameter_test_proc(
    p_var1 VARCHAR2,
    p_var2 OUT VARCHAR2, -- OUT �Ű������� ���ν����� ���������� ������ �Ϸ��� ������ ���� �Ҵ���� ����
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
    IN �Ű������� ������ �����ϸ� ���� �Ҵ��� �� ����.
    OUT �Ű������� ���� ������ �� ������ �ǹ̴� ����.
    OUT, IN OUT �Ű��������� ����Ʈ ���� ������ �� ����.
    IN �Ű��������� ������ ���, �� ������ ������ ���� ���� ������ �� ������, OUT, IN OUT �Ű������� ���� �� ���� �ݵ�� ���� ���·� ���� �Ѱ��־���Ѵ�.
*/

