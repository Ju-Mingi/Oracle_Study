-- 5 
CREATE OR REPLACE PROCEDURE my_new_job_proc2(
    p_job_id IN JOBS.JOB_ID%TYPE,
    p_job_title IN JOBS.JOB_TITLE%TYPE,
    p_min_sal IN JOBS.MIN_SALARY%TYPE,
    p_max_sal IN JOBS.MAX_SALARY%TYPE)

IS

BEGIN

    MERGE INTO jobs a
    USING (SELECT p_job_id FROM dual) b
    ON (a.job_id = b.p_job_id)
    
    WHEN MATCHED THEN
	   UPDATE SET a.job_title  = p_job_title, 
	              a.min_salary = p_min_sal,
	              a.max_salary = p_max_sal
	 WHEN NOT MATCHED THEN 
	   INSERT ( a.job_id, a.job_title, a.min_salary, a.max_salary, a.create_date, a.update_date )
	   VALUES ( p_job_id, p_job_title, p_min_sal, p_max_sal, SYSDATE, SYSDATE );
	   
	 COMMIT;
END;
/

-- 6

CREATE TABLE ch09_departments
   SELECT DEPARTMENT_ID, DEPARTMENT_NAME, PARENT_ID
     FROM DEPARTMENTS;
     
CREATE OR REPLACE PROCEDURE my_dept_manage_proc
        ( p_department_id IN ch09_departments.department_id%TYPE,
            p_department_name IN ch09_departments.department_name%TYPE,
            p_parent_id IN ch09_departments.parent_id%TYPE,
            p_flag IN VARCHAR2)
IS
    vn_cnt1 NUMBER:= 0;
    vn_cnt2 NUMBER:= 0;

BEGIN
    IF p_flag = 'UPSERT' THEN  
        MERGE INTO ch09_departments a
        USING (SELECT p_department_id FROM dual) b
        ON (a.department_id = b.p_department_id)
        WHEN MATCHED THEN
            UPDATE SET a.department_name = p_department_name,
                                a.parent_id = p_parent_id
        WHEN NOT MATCHED THEN
            INSERT (a.department_id, a.department_name, a.parent_id)
            VALUES (p_department_id, p_department_name, p_parent_id);
        
        ELSIF p_flag = 'DELETE' THEN
        
        SELECT COUNT(*)
        INTO vn_cnt1
        FROM ch09_departments
        WHERE department_id = p_department_id;
        
        IF vn_cnt1 = 0 THEN DBMS_OUTPUT.PUT_LINE('해당 부서가 존재하지 않습니다. 삭제를 할 수 없습니다.');
            RETURN;
        END IF;
        
        SELECT COUNT(*)
        INTO vn_cnt2
        FROM employees
        WHERE department_id = p_department_id;
        
        IF vn_cnt2 = 0 THEN DBMS_OUTPUT.PUT_LINE('해당 부서에 속한 사원이 존재하므로 삭제할 수 없습니다.');
            RETURN;
        END IF;
        
        DELETE ch09_departments WHERE department_id = p_department_id;
        
    END IF;
    COMMIT;
    
END;
/

EXEC my_dept_manage_proc(280, 'IT 기획', 90,'UPDATE' );
EXEC my_dept_manage_proc(280, 'IT 기획', 90,'DELETE' );