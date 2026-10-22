-- 1. Создаем таблицу
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    department VARCHAR(50),
    salary INT
);

-- 2. Заполняем 500 тысячами строк через генератор
INSERT INTO employees (name, email, department, salary)
SELECT 
    'User ' || i,
    'user' || i || '@example.com',
    CASE (i % 5) 
        WHEN 0 THEN 'IT' 
        WHEN 1 THEN 'HR' 
        WHEN 2 THEN 'Sales' 
        WHEN 3 THEN 'Marketing' 
        ELSE 'Finance' 
    END,
    30000 + (i % 70000)
FROM generate_series(1, 500000) AS i;

Запрос без индекса:
EXPLAIN ANALYZE 
SELECT * FROM employees WHERE email = 'user354821@example.com';

Создание индекса:
CREATE INDEX idx_employees_email ON employees(email);

Запрос с индексом:
EXPLAIN ANALYZE 
SELECT * FROM employees WHERE email = 'user354821@example.com';
