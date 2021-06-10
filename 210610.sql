CREATE OR REPLACE PROCEDURE my_new_job_proc(
    p_job_id IN JOBS.JOB_ID%TYPE,
    p_job_title IN JOBS.JOB_TITLE%TYPE,
    p_min_sal IN JOBS.MIN_SALARY%TYPE := 10,
    p_max_sal IN JOBS.MAX_SALARY%TYPE := 100
    --  p_upd_date OUT JOBS.UPDATE_DATE%TYPE
    )
IS
    vn_cnt NUMBER := 0;
    vn_cur_date JOBS.UPDATE_DATE%TYPE := SYSDATE;

BEGIN
    --1000 ���� ������ �޼��� ��� �� ��������
    IF p_min_sal < 1000 THEN
        DBMS_OUTPUT.PUT_LINE( '�ּ� �޿����� 1000�̻��̾�� �մϴ�.');
        RETURN;
    END IF;
    
    -- ������ ����� �ִ��� üũ
    SELECT COUNT(*)
    INTO vn_cnt
    FROM JOBS
    WHERE job_id = p_job_id;
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
    COMMIT;
END;
/

EXEC my_new_job_proc ('SM_JOB1', 'SAMPLE JOB1', 999, 6000);

DECLARE
    vs_emp_name VARCHAR2(80); -- �����Ҵ�
BEGIN
    vs_emp_name := 'minky'; -- ������ �� �Ҵ�
    
    UPDATE employees
    SET emp_name = vs_emp_name
    WHERE employee_id = 100; -- emp_name �� ������ ���������� ����Ŭ�� ������ �ƴ� �÷������� �����Ͽ� �߸��� ������ ��
    
    SELECT emp_name
    INTO vs_emp_name
    FROM employees
    WHERE employee_id = 100;
    DBMS_OUTPUT.PUT_LINE(vs_emp_name);
END;
/
-- Self-Check

DECLARE
vn_base_num NUMBER := 3;
BEGIN
    FOR i IN REVERSE 9..1 -- (REVERSE �ʱⰪ..������) ���������� �ʱ� ������ -1�� �����ϴµ� �������� 1�̱� ������ ������ ���� ����
    LOOP
        DBMS_OUTPUT.PUT_LINE( vn_base_num || '*' || i || '= ' || vn_base_num * i);
    END LOOP;
END;
/
-- REVERSE �� �ʱⰪ�� �������� �˸°� ����
DECLARE
vn_base_num NUMBER := 3;
BEGIN
    FOR i IN REVERSE 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE( vn_base_num || '*' || i || '= ' || vn_base_num * i);
    END LOOP;
END;
/

-- ���� Ǯ���

--CREATE OR REPLACE FUNCTION my_initcap ( ps_string VARCHAR2 )
--   RETURN VARCHAR2
--IS
--   vn_pos   NUMBER := 1;
--   vs_temp   VARCHAR2(100) :=  ps_string;
--   vs_return VARCHAR2(80);
--   vn_len NUMBER;
--   
--BEGIN
--    WHILE vn_pos <> 0 LOOP
--        vn_len := LENGTH(vs_temp);
--        vn_pos := INSTR(vs_temp, ' ');
--        IF vn_pos = 0 THEN
--            vs_return := UPPER(SUBSTR(vs_temp,1,1)) || SUBSTR(vs_temp,2,vn_pos-1);
--        ELSE
--            vs_return := UPPER(SUBSTR(vs_temp,1,1)) || SUBSTR(vs_temp,2,vn_pos-1);
--        END IF;
--        vn_len := LENGTH(vs_temp);
--        vs_temp := SUBSTR(vs_temp, vn_pos+1, vn_len - vn_pos);
--        END LOOP;
--        RETURN vs_return;
--END;
--/
--
--SELECT my_initcap('hello world my')
--FROM DUAL;