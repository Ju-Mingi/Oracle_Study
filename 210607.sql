-- 21.06.07
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*
PL/SQL
 BLOCK PL/SQL �ҽ� ���α׷��� �⺻ ����
 �����, �����, ���� ó���η� �����Ǿ��ִ�.
 */
 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 /*
 [����]
 �̸��� -- ����� ��Ģ ���� �� �͸� ����� ��
 IS(AS)
 ����� -- DECLARE ���� ����ο� ���� ó���ο��� ����� ���� ����, ���, Ŀ������ ���� , �ݵ�� �����ݷ� �ٿ�����. ����� ������ ����� ������ ���� ����
 BEGIN
 ����� -- ���� ���� ó�� SQL ���� �� DDL ��� �Ұ�, DML�� ��� ����, �����ݷ��� �ٿ�����.
 EXCEPTION
 ����ó���� -- ���� ó�� �� ���� �߻��� ó���� ������ ���, ���� ����
END;
*/
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- �͸����� ����

DECLARE vi_num NUMBER;
BEGIN vi_num := 100; -- PL/SQL ���� ���� �Ҵ��� = �� �ƴ� := �� ����Ѵ�.
DBMS_OUTPUT.PUT_LINE(vi_num);
END;
/

-- ����ϱ�

SET SERVEROUTPUT ON
DECLARE
        vi_num NUMBER;
BEGIN
        vi_num := 100;
        DBMS_OUTPUT.PUT_LINE(vi_num);
END;
/


-- ����� �����ϴµ� �ҿ�Ǵ� �ð� Ȯ���ϱ�

SET SERVEROUTPUT ON
SET TIMING ON
DECLARE
vi_num NUMBER;
BEGIN
vi_num := 100;
DBMS_OUTPUT.PUT_LINE(vi_num);
END;
/
-- SQL DEV ���� / �� ������� �ʾƵ� ��

-- SQL PLUS
-- PL / SQL���� ���� ���α׷� (DECLARE, BEGIN, END)���ִ� ��� ��� �� �����ݷ��� ���� ���α׷��� �Ϻη� ���ֵǹǷ� �����ø� ����ؾ��մϴ�.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ����
-- ���� ���� ��� : DATATYPE := �ʱⰪ;
-- �ٸ� ���α׷��� ���� ����ϴ� ������ ������ ����.
-- �ʱⰪ�� �Ҵ����� �ʴ� ��� NULL ���� �Ҵ�ȴ�.
-- SQL Ÿ��, PL/SQL Ÿ�� 2 ������ �ִ�.

-- PL/SQL ������ Ÿ�����δ� BOOLEAN, PLS_INTEGER, BINARY_INTEGER ���� �ִ�.

/* PLS_INTEGER ���� Ÿ��
NATURAL                    ���� ���� (0 ����)
NATURALN                  ���� ���������� NULL �Ҵ� �Ұ�, �ݵ�� ���� �� �ʱ�ȭ �ʿ� 
POSITIVE                     ��� (0 ������)
POSITIVEN                   ��������� NULL �Ҵ� �Ұ�, �ݵ�� ���� �� �ʱ�ȭ �ʿ�
SIGNTYPE                    -1,0,1
SIMPLE_INTEGER      NULL �� �ƴ� ��� ��, �ݵ�� ���� �� �ʱ�ȭ �ʿ�
*/
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ��� CONSTANT

-- ���� CONSTANT DATATYPE := ��� ��;
-- �� �� ���� �Ҵ��ϸ� ������ �ʰ� SQL Ÿ�԰� PL/SQL Ÿ�� ��� ��� �����ϴ�.
-- Ư�� ���� �Ҵ��ϰ� ����ο��� ����ϰ��� �� �� ��� �ȴ�.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ������
-- PL/SQL ��Ͽ����� ��� SQL �����ڸ� ����� �� �ִ�.

DECLARE
    a INTEGER := 2**2*3**2;
 BEGIN
    DBMS_OUTPUT.PUT_LINE('a = ' || TO_CHAR(a));
 END;
 /
 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DML ��
-- SELECT INTO ���̺��� Ư�� ���� ������ ������ �Ҵ��� ��� ���
DECLARE
vs_emp_name VARCHAR2(80); -- ����� ���� 
vs_dep_name VARCHAR2(80); -- �μ��� ����
BEGIN
SELECT a.emp_name, b.department_name -- Ư�� �� ����
INTO vs_emp_name, vs_dep_name -- vs_~~ ������ �Ҵ�
FROM employees a, departments b
WHERE a.department_id = b.department_id
AND a.employee_id = 100;

-- ����� ���� !!     || <- ���ڿ� ���� ������
DBMS_OUTPUT.PUT_LINE(vs_emp_name || ' - ' || vs_dep_name);
END;
/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- %TYPE
-- ������ ���̺��.�÷���%TYPE �ش� ������ �÷� Ÿ���� �ڵ����� �����´�. 

DECLARE
vs_emp_name employees.emp_name%TYPE;
vs_dep_name departments.department_name%TYPE;
BEGIN
SELECT a.emp_name, b.department_name -- Ư�� �� ����
INTO vs_emp_name, vs_dep_name -- vs_~~ ������ �Ҵ�
FROM employees a, departments b
WHERE a.department_id = b.department_id
AND a.employee_id = 100;
DBMS_OUTPUT.PUT_LINE(vs_emp_name || ' - ' || vs_dep_name);
END;
/

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LABEL Ư�� �κп� �̸��� �ο�
-- <<�󺧸�>> ����
-- GOTO ���� ����ϸ� �ش� �󺧷� �̵� ���� GOTO �󺧸�;

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

--SQL �� PL/SQL�� ������ Ÿ�Ժ� ���� ����
CREATE  TABLE ch08_varchar2(
VAR1 VARCHAR(4000));

INSERT INTO ch08_varchar2 (VAR1)
VALUES ('tQbADHDjqtRCvosYCLwzbyKKrQCdJubDPTHnzqvjRwGxhQJtrVbXsLNlgeeMCemGMYpvfoHUHDxIPTDjleABGoowxlzCVipeVwsMFRNzZYgHfQUSIeOITaCKJpxAWwydApVUlQiKDgJlFIOGPOKoJsoemqNbOLdZOBcQhDcMLXuYjRQZDIpgpmImgiwzcLkSilCmLrSbmFNsKEEpzCHDylMvkYPKPNeuJxLvJiApNCYzrMcflECbxwNTKSxaEwVvCYnTnFfMFgDqxobWcSmMJrNTQIVOeWlPaMTfRHsrlFSukppmljmOojPSgJiSbQcgtWWOwUNNYFGtgCGBsIcTGAiHWBxtYVXecoJgJCAJptIVmVTZSKliRLoPYTIUpksBuQaqFHLhCkosWChoMjbqgLtBIRBynsKjKiLrdeHVvZanNVElDjLWwlCDhbpsAVQMTzjzhoKIJBdthynMBMVjeNmsKAjdAYhPZKmuKOuMloQdkqPjoKbfjDEeATciMrXiMQorMhYmBlMODBbyLLIkbmtZdPcWGSuxFEUwXnWpvnunEgcLelSneRIpgRNTzTkHqgLbpxoHzCYgSWlIAvKljCnmWiPWGGwlUFOudRSdoqUxntyhNYEiVXtMObywEltTImawnElpmeiWwlTjGTFceqyjhNqiDLxwduubykWzDmFSJNvVvDZibrCpAReqQjlQZcxuVqjKGKvoDuEcQPQeDzmdMYSOTIQdPDNfDffCOUWflHSQhvVTiYumBQIoyznWNITGZkefknJpGEutUnhBgLPQTWTBeTYccqlLrxvRjfJpdpfVDqqfKCngemIEDDHNdvBxCqKDTrrJAumXMKgpWLIHctQuACeNaKnffpYXiioLxZDrxpuZPPUGpRsCtoQuBfogkKuusVATkMyajKTPSyTQbfhZepRjNdrhkymqKvsAcThYbMSMnkKcLWFPAMeGysBVKkQtFMPvRBoDszlSZcMYzwxkKQwJnuVnDxShYiHFlzgDWqhZoqeypyFVBNDtHkiVzHkQisYLbsbVneJyHbHdtaIFLVbfTqbkGQTEjFlPiGUddPUIoLWALrbKcLwBizwhJvaXkvOphcGWpdNAhxgehCvjcQFSFhxrBuANKjyWncWAUpKKJcfQCsQlLfpqdMhjWGkAMMWUaDfCrGtmtkiIZOdNapEnvfFKiHAhBhejgKSuyKXFQXyCaLwwvonHsceJKgjtnYVZvBCYYBSqNCqVqCGewootJJsqrCnmiteMZBbyMPnIrdcielnGUYmwiOPmEqKGvxDmDRTDRumnSRcnvgxLbaiQIuzdslEIMquvvwmvgaumqPkduNyfRtXErCPvDYLelhjNNOjbGryRpTtDHxIJebMEtKryUyZRIdADeTEBExwHMRHzAYFizYiesaMhNIsOUzUTmyEMuFQrsUEtjwhUWIvADNlrcxPZwRazPMMvdVZssmXbXuCkRoPYNGLPwUmrWrrIgQoMSGMPvTcbHnbtleyKYmOMgymANQBZDMoqAOzMHrAVunIiykCudFVNObNgXOoyfQRICbFsWygSZXufipvrWWmRnBWYdoKmIRewOObUjiNDdQsxQIXtlbPSSngfQPfeQKOolVASXIuAmeODKtSOPaEaFKcedGzzsbrPlsPnRRuYFeVdhyufpjFVVrTPczSQkmPYXercLMmVEaDmJXKTqEVNSKeOshDCDJwdINFsLhAuKIIfOdjSEndDwumQLvePVjzNoIfUELOANeshoNgwVhFADjtUIjIhQAIyRnzSoxSRSWklITMgdjQZTthwsnBVLWyfSsAdLzOnEqmMCGBlTYGjtqvKbBoATRwkPkOTSbUhZClVzjiLLIFEMuptuodeRKXUaBfUhVTtasFsZdVnKtEfLldJYsxjlrBADRqhEBEmBKxlXKgEhiKcwAdztcETMUteJwadfaZLEBRjwJOGaIMhsfAxtuBQWyQLGXPDlFQmkcMsKsGUlQBEAubDqbuBYqXLZgmhPftLkYaCYGReLCVXssOxzJFJwnxKJzaaYzfVpbHYBtiBeQZRilJZqrrMTrVtYAcwGxAAddwtlxzdZebfZHjzqRmrrBPNbkVHqjCHtVKUjIDPVSrtyEsPRPoyyPOFOSBcgClTzlAIPmPMkdlpFHctzKGpyQMInMwPKojVErCOrHbCsZoEXqyOcHReSybmxwYabyioVnDxPEvskutVHLWQTNudmKICoaoSGKqONrBmvtGNBKAaJxCRKTDOIqrJOsQVOmGxmuIDEddVYvDwILTyushOAiXbkRIKgNLnFJdOagmiOHKRBKIIkxkOUeZWMRNlqpJdFgKjrGhIzrgBtgjVOtZAskKRbqzRVwLUoUAtRpRkoRQNLIrbLmmjZTugXJBNCscnMguKVAFDKpODtCsmdlBvQGALeBGUitYBxLYhJxeVcAnTWmTAvCITzdzqiBfEudEIBmkDAXIFmoOmsTMZDOnhXYrgMDlDbjednYWWJbGhrXFrxMQmQSmRBwoOqWGbGmjZNlJCvSHvmtZUkIScWXVdfSsdvdyQNpGFIOuteXhCMLmmEHrMucEmFbCIOHTJINAuIUOPfAfijIPkZjppGCCSRJNXWNCmliwUgABkHWuelUWeLsyVKVcZWOSeiQBQibCQJQUgGkTrXZxdBLsgjeMIwOyORDBpywuvlrLScRNhvaCYaKKRvOZeqBebUWWFhNnIRJvedFNfFPgWZJgNRaUpyYWFNiXJfAqNjyCEQYwAdFBQKKolwrufmJOfrToJFEsoNjaphcNvfWGIjKrKZSoSJEsbRqNVcoprpcGrnBgcNAnWUFpRldcPJkPfaoLKRCmVyMAWMXmnScodKisCTqllZEWQQSCFETxLNntgdcFEFRsTSIhuewwrHIlOeCcRqkzgQhKnKyHZHdFsMEKvPywLbjaspVxUMEkVzCGcGoTmaBjUMwJuAYdSTaYGDHHWDrvGgMVTtehpzfgofkmqtamffJbCKOzJgPsHNEnFarjADJGyKLwwitCiBXIraUdZtZwNjUtGbWqxksepVYztIBrimByoYQfUQgOndzFmhnuSmhYWvHliWUHgbvBIkYasDElNsjcCLtMvjQEhJjWvlnAscPwOYfelrfgfRAZGBxdFlMNkfYEWLbkfUhbRPHoDZsaAQdoKhAAWzOcHoAkkHPQMNIxgHNJaqEFBqCuMYEtLpMnIiMCWWEPnBYgYrxlXFGYpQWUNFevwcEUvUzDeSZNrdmahAfjeLSAGjHVnqyTzJkiVXjDJXzOiszXQCErQwwDMMqjLxWebJwNAVdrXeyMDRYXmLMDnuWLVaShVGhlgvbjOdOnhCDTNVazYDnzstqxjOuWbLcDaavRumKUOQXBQwKtdFgOzXiQKWFporrIcylIHlTmTKAIpBqNUbkajLTlwAHieCcqPIJYhegwQhWpYZdfxpQXDKtYzsrmnvdiTKgXfXKlIHPHlxQtqXGhMVPOBAKVZJfkrDNEwnQFwgfoHJSqQxTzRswVLrtFgpVzKcLilgznElWUfhERyeUrCcFCuGJddlFHJrXsqRdUjqUwaBmJVNwjRbCFiVMOSFuNctNVzhmhUpoddsMPUFMvNIMsMjHIWYiLjhSajZqpDkMvUOUCbYKfNHGpdUeWGUtDXHDNSCEXqYrhWhvnISnjfoBMCwwptksarPImRZaRxBMjoBdlmRGlIuQZDzCLnxxioATnGVFFTATUpeypOCaCeJAvPLxEXYzlCgXvXirGSZFyZPPSCdOSHxeELRsetFrWgqPNNpwgbgBEYPOSpLWeVdqOxPaQnidyPVMmELzeJPWgNsWBdPJPjhkdGpeAYZfrBNqdbOwzbtLiWMPafjgWQNcWKqmcleWLcMJoGSAEIUyFuzElZKXonHOMDdGMtSKEFUWdfPfnDecKNhIjAKRYmkXgpPAzlKIOpViZPkZdozzAoWwDnXkfDikvkXcQaoBtzKkcRhNpJRYaGTkdnlfotsJZsLqpYaWoK')
;

DECLARE
    vs_sql_varchar2 VARCHAR2(4000);
    vs_plsql_varchar2 VARCHAR2(32767);
BEGIN
--ch08_varchar2 ���̺��� ���� ������ ��´�.
    SELECT VAR1
    INTO vs_sql_varchar2
    FROM ch08_varchar2;

-- PL/SQL ������ 4000BYTE �̻� ũ���� ���� �ִ´�.
    vs_plsql_varchar2 := vs_sql_varchar2 || ' - ' || vs_sql_varchar2 || ' - ' || vs_sql_varchar2;

-- �� ���� ũ�� ���
DBMS_OUTPUT.PUT_LINE('SQL VARCHAR2 ���� : ' || LENGTHB(vs_sql_varchar2)); 
DBMS_OUTPUT.PUT_LINE('PL/SQL VARCHAR2 ���� : ' || LENGTHB(vs_plsql_varchar2));
END;
/
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ������ 3��

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

-- �ݺ����� ����ϱ�

BEGIN
FOR i IN 1..9 LOOP
DBMS_OUTPUT.PUT_LINE('3 * ' || i || ' = ' || 3*i);
END LOOP;
END;
/

-- ������̺��� 201�� ����� �̸��� �̸��� �ּҸ� ����ϴ� �͸� ��� �����

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

--CHR(10) : line feed(new line) Ŀ���� ��ġ�� ���� �Ʒ��� �̵�
--CHR(13) : carriage return ���� Ŀ���� ��ġ�� ���� �� ������ Ŀ�� �̵�

DBMS_OUTPUT.PUT_LINE('201��' || CHR(10) || CHR(13) || '����� : '|| vs_emp_name || CHR(10)|| CHR(13) || '�̸��� ' || vs_emp_email);
END;
/

-- ������̺��� �����ȣ�� ���� ū ����� ã�Ƴ� ��, �� '��ȣ+1'������ �Ʒ��� ����� ��� ���̺� �ű� �Է��ϴ� �͸� ����� ����� ����
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

-- Ȯ�� �ϱ�
SELECT *
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID DESC;