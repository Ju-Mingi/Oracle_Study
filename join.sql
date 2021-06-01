-- ��������
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ���� ���� EQUI JOIN
SELECT a.employee_id, a.emp_name, a.department_id, b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SEMI JOIN

-- ���� ������ �����ϴ� ���� ���� �����Ͱ� ���� �� �����ϴ��� ���� ��ȯ�Ǵ� ���� ���� �����Ϳ��� �ߺ��Ǵ°� ����.

-- EXISTS
SELECT department_id, department_name
FROM departments a
WHERE EXISTS (SELECT * FROM employees b WHERE a.department_id = b.department_id AND b.salary > 3000)
ORDER BY a.department_name;

-- IN
SELECT department_id, department_name
FROM departments a
WHERE a.department_id IN (SELECT b.department_id FROM employees b WHERE b.salary > 3000)
ORDER BY department_name;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- �Ϲ� ������ ������� ���

-- ������ �ߺ��� �߻�

SELECT a.department_id, a.department_name
FROM departments a, employees b
WHERE a.department_id = b.department_id
AND b.salary > 3000
ORDER BY a.department_name;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ��Ƽ����

SELECT a.employee_id, a.emp_name, a.department_id, b.department_name
FROM employees a, departments b
WHERE a.department_id = b.department_id
AND a.department_id NOT IN (SELECT department_id FROM departments WHERE manager_id IS NULL);

SELECT count(*)
FROM employees a
WHERE NOT EXISTS ( SELECT 1 FROM departments c WHERE a.department_id = c.department_id AND manager_id IS NULL);