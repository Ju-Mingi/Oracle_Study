CREATE OR REPLACE FUNCTION my_initcap ( ps_string VARCHAR2 )
   RETURN VARCHAR2
IS
   vn_pos1   NUMBER := 1;   -- 각 단어 시작 위치
   vs_temp   VARCHAR2(100) :=  ps_string;
   vs_return VARCHAR2(80);  -- 반환할 대문자로 변환된 문자열 변수
   vn_len   NUMBER; 
BEGIN
   
   WHILE vn_pos1 <> 0 -- 공백문자를 발견하지 못할 때까지 루프
   LOOP
       -- INSTR = 공백 문자 위치를 반환 
       vn_pos1 := INSTR(vs_temp, ' ');
       
       IF vn_pos1 = 0 THEN -- 공백문자를 발견하지 못했을 경우, 즉 맨 마지막 단어일 경우 IF END 실행
          vs_return := vs_return || UPPER(SUBSTR(vs_temp, 1, 1)) || SUBSTR(vs_temp, 2, vn_len -1);
       ELSE 
          vs_return := vs_return || UPPER(SUBSTR(vs_temp, 1, 1)) || SUBSTR(vs_temp, 2, vn_pos1 -2) || ' ';
       END IF;      


       vn_len := LENGTH(vs_temp);
       -- vs_temp 변수는 최초 전체 문자열이 들어오며, 루프를 돌면서 한 단어씩 차례로 없앤다.
       vs_temp := SUBSTR(vs_temp, vn_pos1+1, vn_len - vn_pos1);

   
   END LOOP;
  
   RETURN vs_return;
   COMMIT;
END;
/

SELECT my_initcap('hello world my name is Jumingi')
FROM DUAL;

-- 3 날짜형 SQL함수 중에는 해당 월 마지막 일자를 반환하는 LAST_DAY란 함수가 있다.
-- 매개변수로 문자형으로 일자를 받아, 해당 일자의 월 마지막 날짜를 문자형으로 반환하는 함수를 MY_LAST_DAY라는 이름으로 만들어보기.



CREATE OR REPLACE FUNCTION my_last_day (ps_input_date VARCHAR2)
    RETURN VARCHAR2
    
IS
    vs_input_date VARCHAR2(10) := REPLACE(ps_input_date,'-','');
    vs_return_date VARCHAR2(50);
    vs_month VARCHAR2(2);
    vs_year VARCHAR2(4);

BEGIN
   IF LENGTH(vs_input_date) <> 8 THEN vs_return_date := '입력일자 오류';
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

