USE db_company;

/*
인덱스 특징
 - = 동등 부호 사용 시, 무조건 인덱스를 태움
 - 인덱스의 범위 조건(크기 비교 조건)은 검색 엔진이 데이터 양을 파악해
   적으면 Index Range Scan을, 많으면 Full Table Scan 중 선택해서 동작함 (인덱스를 태울지 여부를 선택해 동작)
 - 인덱스가 설정된 칼럼 WHERE 절을 조작하면 (연산, 함수 등) 더이상 인덱스를 타지 않음
*/

/*
클러스터 인덱스
 - PK에 부여된 인덱스 (테이블 당 1개만 존재)
*/

-- 1. 인덱스 태우기 > 부서번호가 1인 부서 조회하기
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE dept_id = 1; -- 인덱스가 설정된 PK 칼럼으로 조회하여 인덱스 태우기 (성능 향상)
 
 -- 1-1. 인덱스 태우기 > 부서번호가 1인 부서 조회하기
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE dept_id * 2 = 2; -- WHERE 절 왼쪽을 조작해 연산자를 넣어 더이상 인덱스를 타지 않음
 
-- 2. 인덱스 안태우기 > 부서명이 '영업부'인 부서 조회하기
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE dept_name = '영업부'; -- PK가 아닌 칼럼으로 조회하면 인덱스를 태우지 않음 (성능 좋지 않음)

-- 3. 부서번호가 1 이상인 부서 조회하기
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE dept_id >= 1; -- 모든 데이터의 부서 번호가 1 이상임, 데이터 양에 따라 인덱스 태울지 여부를 결정함 / 해당 작업은 인덱스 태움
 
-- 보조 인덱스 만들기

CREATE INDEX ix_name
    ON tbl_employee(emp_name ASC);
    
-- 정상적으로 인덱스 태우기
SELECT emp_id, emp_name, dept_id, position, hire_date, salary, gender
  FROM tbl_employee
 WHERE emp_name = '이은영';

-- Index Range Scan (인덱스 가공이 되지 않아 인덱스 태움)
 SELECT emp_id, emp_name, dept_id, position, hire_date, salary, gender
  FROM tbl_employee
 WHERE emp_name LIKE '이%';

-- Full Table Scan (인덱스가 설정된 칼럼을 함수처리로 가공하여 인덱스 태우지 않음) 
 SELECT emp_id, emp_name, dept_id, position, hire_date, salary, gender
  FROM tbl_employee
 WHERE SUBSTRING(emp_name, 1, 1) = '이'; -- 첫번째 글자 1부터(0이 아님) 한 글자는 '이'이다.