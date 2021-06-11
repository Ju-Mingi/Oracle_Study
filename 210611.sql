CREATE OR REPLACE FUNCTION my_initcap ( ps_string VARCHAR2 )
   RETURN VARCHAR2
IS
   vn_pos1   NUMBER := 1;   -- �� �ܾ� ���� ��ġ
   vs_temp   VARCHAR2(100) :=  ps_string;
   vs_return VARCHAR2(80);  -- ��ȯ�� �빮�ڷ� ��ȯ�� ���ڿ� ����
   vn_len   NUMBER; 
BEGIN
   
   WHILE vn_pos1 <> 0 -- ���鹮�ڸ� �߰����� ���� ������ ����
   LOOP
       -- INSTR = ���� ���� ��ġ�� ��ȯ 
       vn_pos1 := INSTR(vs_temp, ' ');
       
       IF vn_pos1 = 0 THEN -- ���鹮�ڸ� �߰����� ������ ���, �� �� ������ �ܾ��� ��� IF END ����
          vs_return := vs_return || UPPER(SUBSTR(vs_temp, 1, 1)) || SUBSTR(vs_temp, 2, vn_len -1);
       ELSE 
          vs_return := vs_return || UPPER(SUBSTR(vs_temp, 1, 1)) || SUBSTR(vs_temp, 2, vn_pos1 -2) || ' ';
       END IF;      


       vn_len := LENGTH(vs_temp);
       -- vs_temp ������ ���� ��ü ���ڿ��� ������, ������ ���鼭 �� �ܾ ���ʷ� ���ش�.
       vs_temp := SUBSTR(vs_temp, vn_pos1+1, vn_len - vn_pos1);

   
   END LOOP;
  
   RETURN vs_return;
   COMMIT;
END;
/

SELECT my_initcap('hello world my name is Jumingi')
FROM DUAL;

-- 3 ��¥�� SQL�Լ� �߿��� �ش� �� ������ ���ڸ� ��ȯ�ϴ� LAST_DAY�� �Լ��� �ִ�.
-- �Ű������� ���������� ���ڸ� �޾�, �ش� ������ �� ������ ��¥�� ���������� ��ȯ�ϴ� �Լ��� MY_LAST_DAY��� �̸����� ������.



CREATE OR REPLACE FUNCTION my_last_day (ps_input_date VARCHAR2)
    RETURN VARCHAR2
    
IS
    vs_input_date VARCHAR2(10) := REPLACE(ps_input_date,'-','');
    vs_return_date VARCHAR2(50);
    vs_month VARCHAR2(2);
    vs_year VARCHAR2(4);

BEGIN
   IF LENGTH(vs_input_date) <> 8 THEN vs_return_date := '�Է����� ����';
   END IF;
   vs_year := SUBSTR(vs_input_date, 1, 4);
   vs_month := SUBSTR(vs_input_date, 5, 2);
   IF vs_month = 12 THEN
    vs_return_date := TO_CHAR(TO_DATE(vs_year + 1 || '01' || '01' , 'YYYY-MM-DD') - 1, 'YYYYMMDD');
   ELSE
    vs_return_date := TO_CHAR(TO_DATE(vs_year || vs_month +1 || '01', 'YYYY-MM-DD') - 1, 'YYYYMMDD');
   END IF;
   RETURN vs_return_date;
END; 
/

SELECT my_last_day('2020-02-31') FROM DUAL;

