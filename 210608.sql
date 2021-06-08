DECLARE
    vn_num1 NUMBER := 1;
    vn_num2 NUMBER := 2;
BEGIN
IF vn_num1 >= vn_num2 THEN
    DBMS_OUTPUT.PUT_LINE(vn_num1 || '이 큰 수');
ELSE
    DBMS_OUTPUT.PUT_LINE(vn_num2 || '이 큰 수');
END IF;
END;
/

DECLARE
vn_salary NUMBER := 0;
vn_department_id NUMBER := 0;
BEGIN
vn_department_id := ROUND(DBMS_RANDOM.VALUE (10, 120), -1);
    SELECT salary
    INTO vn_salary
    FROM employees
    WHERE department_id = vn_department_id
    AND ROWNUM = 1;
    
    DBMS_OUTPUT.PUT_LINE(vn_salary);
    
    IF vn_salary BETWEEN 1 AND 3000 THEN
        DBMS_OUTPUT.PUT_LINE('낮음');
    ELSIF vn_salary BETWEEN 3001 AND 6000 THEN
        DBMS_OUTPUT.PUT_LINE('중간');
    ELSIF vn_salary BETWEEN 6001 AND 10000 THEN
        DBMS_OUTPUT.PUT_LINE('높음');
    ELSE
        DBMS_OUTPUT.PUT_LINE('최상위');
    END IF;
END;
/

DECLARE
vn_salary NUMBER := 0;
vn_department_id NUMBER := 0;
vn_commission NUMBER := 0;

BEGIN
vn_department_id := ROUND(DBMS_RANDOM.VALUE (10, 120), -1);

    SELECT salary, commission_pct
    INTO vn_salary, vn_commission
    FROM employees
    WHERE department_id = vn_department_id
    AND ROWNUM = 1;
    
    DBMS_OUTPUT.PUT_LINE(vn_salary);
    
    IF vn_commission > 0 THEN
        IF vn_commission > 0.15 THEN
            DBMS_OUTPUT.PUT_LINE(vn_salary * vn_commission);
        END IF;
    ELSE
        DBMS_OUTPUT.PUT_LINE(vn_salary);
    END IF;
END;
/

DECLARE
    vn_salary NUMBER := 0;
    vn_department_id NUMBER := 0;
BEGIN
    vn_department_id := ROUND(DBMS_RANDOM.VALUE(10, 120), -1);
    SELECT salary
    INTO vn_salary
    FROM employees
    WHERE department_id = vn_department_id
    AND ROWNUM = 1;
DBMS_OUTPUT.PUT_LINE(vn_salary);

    CASE WHEN vn_salary BETWEEN 1 AND 3000 THEN DBMS_OUTPUT.PUT_LINE('낮음');
            WHEN vn_salary BETWEEN 3001 AND 6000 THEN DBMS_OUTPUT.PUT_LINE('중간');
            WHEN vn_salary BETWEEN 6001 AND 10000 THEN DBMS_OUTPUT.PUT_LINE('높음');
            ELSE DBMS_OUTPUT.PUT_LINE('최상위');
    END CASE;
END;
/

-- LOOP

DECLARE
    vn_base_num NUMBER := 3;
    vn_cnt NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE ( vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
        vn_cnt := vn_cnt+1;
        EXIT WHEN vn_cnt > 9;
    END LOOP;
END;
/

--WHILE

DECLARE
    vn_base_num NUMBER := 3;
    vn_cnt NUMBER := 1;
BEGIN
    WHILE vn_cnt <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || vn_cnt || '= ' || vn_base_num * vn_cnt);
--        EXIT WHEN vn_cnt = 5; 특정 조건에 부합한다면 루프를 빠져나올 수 있음.
        vn_cnt := vn_cnt + 1;
    END LOOP;
END;
/

DECLARE
vn_base_num NUMBER := 3;
BEGIN
    FOR i IN 1..9
    LOOP
--        CONTINUE WHEN I=5;
        DBMS_OUTPUT.PUT_LINE(vn_base_num || ' * ' || i || ' = ' || vn_base_num * i);
    END LOOP;
END;
/

-- GOTO

DECLARE
    vn_base_num NUMBER := 3;
BEGIN
    <<third>>
    FOR i IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
        IF i = 3 THEN
            GOTO fourth;
        END IF;
    END LOOP;

<<fourth>>
vn_base_num := 4;
    FOR i IN 1..9
    LOOP
        DBMS_OUTPUT.PUT_LINE (vn_base_num || '*' || i || '= ' || vn_base_num * i);
    END LOOP;
END;
/

-- NULL
/*
IF vn_variable = 'A' THEN DBMS_OUTPUT.PUT_LINE('처리로직1');
ELSIF vn_variable = 'B' THEN DBMS_OUTPUT.PUT_LINE('처리로직2');
ELSE NULL;
END IF;
CASE WHEN vn_variable = 'A' THEN DBMS_OUTPUT.PUT_LINE('처리로직1');
        WHEN vn_variable = 'B' THEN DBMS_OUTPUT.PUT_LINE('처리로직2');
        ELSE NULL;
END CASE;
*/