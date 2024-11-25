USE db_company;


/* SELECT ~ FROM 절 공부하기*/

-- 1. 부서 테이블의 모든 데이터 조회하기
SELECT * -- * : 모든 칼럼을 의미, 성능 이슈로 실무에서는 사용 금지
  FROM tbl_department;

-- 2. 부서 테이블의 부서 위치만 조회하기
SELECT location 
  FROM tbl_department;
  
-- 3. 부서 테이블의 부서 위치 중복 제거하고 조회하기
SELECT DISTINCT location
  FROM tbl_department;
  
-- 4. 칼럼에 별명 지정하기 (AS 별명)
SELECT
        dept_id AS 부서번호
      , dept_name AS 부서명
      , location AS "부서 위치" -- 별명에 띄어쓰기를 넣고 싶다면 ""로 묶어두기
  FROM
        tbl_department;

-- 5. 오너 명시 (데이터베이스, 테이블)
SELECT
        tbl_department.dept_id -- 테이블명 생략 가능
      , tbl_department.dept_name 
      , tbl_department.location
  FROM
        db_company.tbl_department; -- USE db_company로 인해 데이터베이스 생략 가능

-- 6. 테이블에 별명 지정하기 (AS 별명 or AS 생략 후 별명만 지정)
SELECT
       d.dept_id
     , d.dept_name
     , d.location
  FROM
       tbl_department d;
     
     
/* WHERE 절 공부하기*/

-- 7. 대구에 있는 부서 조회하기
SELECT dept_id, dept_name, location
  FROM tbl_department
 WHERE location = '대구';  -- 비교 연산자 6가지 사용 가능(=, !=, >, >=, <, <=)
 
-- 8. 부서번호가 1이고, 연봉이 3000000 이상인 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE dept_id = 1 AND salary >= 3000000; -- 논리 연산자 (AND, OR, NOT)
 
-- 9. 연봉이 3000000 ~ 5000000 사이인 사원 조회하기 (BETWEEN, AND 조건 사용)
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE salary BETWEEN 3000000 AND 5000000; -- salary >= 3000000 AND salary <= 5000000;

-- 10. 직급이 '과장' 또는 '부장'인 사원 조회하기 (IN / OR 조건 사용)
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE position IN ('과장','부장'); -- position = '과장' OR position = '부장';
 
-- 11. 직급이 '과장' 또는 '부장'이 아닌 사원 조회하기 (NOT, IN 조건 사용)
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE position NOT IN('과장','부장'); -- position <> '과장' AND position != '부장'; -- !=는 <>와 같다.
 
-- 12. 사원명이 '한'으로 시작하는 사원 조회하기 (LIKE 와일드 카드 전용 연산자 사용/ 비교 연산자 사용 불가)
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE emp_name LIKE '한%'; -- % : 와일드 카드(만능 문자), 글자 수 제한이 없는 모든 문자를 의미

-- 13. 사원명에 '민'이 포함되는 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE emp_name LIKE CONCAT('%','민','%'); -- 문자열 함수 CONCAT 사용 : 여러 문자를 한번에 연결시켜 조회함 (= '%민%')

-- 14. (db_menu 스키마) 상위 카테고리코드가 없는 카테고리 조회하기
SELECT category_code, category_name, ref_category_code
  FROM db_menu.tbl_category
 WHERE ref_category_code IS NULL; -- IS NULL : NULL 이다.
 
 -- 15. (db_menu 스키마) 상위 카테고리코드가 있는 카테고리 조회하기
SELECT category_code, category_name, ref_category_code
  FROM db_menu.tbl_category
 WHERE ref_category_code IS NOT NULL; -- IS NOT NULL : NULL이 아니다.


/* GROUP BY ~ HAVING 절 공부하기
    GROUP BY : 아래 5가지 함수를 활용하기 위해 사용, GROUP BY 절에 작성한 칼럼만 SELECT (조회) 가능함
    HAVING : 통계 함수를 이용해 조건식을 사용, 함수를 사용할때에만 HAVING절 사용 가능
*/

/*
    SUM() : 합계
    AVG() : 평균
    MAX() : 최대값
    MIN() : 최소값
    COUNT() : 갯 수
*/

-- 16. 직급 별 그룹화하여 평균 연봉 조회하기
-- GROUP BY : 그룹화하여 통계를 내기 위해 사용
SELECT position, AVG(salary)  -- GROUP BY 절에 작성한 칼럼만 SELECT절에서 조회 가능함
  FROM tbl_employee
 GROUP BY position; -- 직급 별 그룹화 작업
  
 -- 17. 부서 별 사원 수 조회하기
 /*
 count(*) : 모든 칼럼의 갯수를 조회하여 어느 한 칼럼이라도 값을 가지고 있으면 카운트에 포함한다.
 (NULL을 포함하고 있는 칼럼이라도, 칼럼 중 한가지 데이터를 가지고 있으면 카운트에 포함한다.)
 */
SELECT dept_id AS 부서번호, COUNT(*) AS 사원수  
  FROM tbl_employee
 GROUP BY dept_id;
 
 -- 18. 직급 별 평균 연봉이 5000000 이상인 직급 조회하기
 SELECT position, AVG(salary)
   FROM tbl_employee
  GROUP BY position
HAVING AVG(salary) >= 5000000; -- HAVING 절에서 통계 함수를 이용해 조건식을 사용할 수 있다. / 함수를 사용할때에만 HAVING절 사용 가능
 

/* 사용 불가능한 쿼리문
 SELECT position, AVG(salary)
   FROM tbl_employee
  WHERE AVG(salary) >= 5000000 -- 통계 함수는 WHERE 절에서 사용 불가
  GROUP BY position;
*/
 
 -- 19. 직급 별 사원 수 구하기, 직급이 '과장'인 사원 수만 조회
 -- 데이터 수가 많을 경우, 성능 향상을 위해 WHERE 절에 미리 조건을 넣어 데이터를 줄이고, GROUP을 진행함
 SELECT position AS 직급, COUNT(*) AS 사원수
   FROM tbl_employee
  WHERE position = '과장' -- '과장' 데이터 sampling을 통해 조회할 데이터 수를 줄임
  GROUP BY position;

-- 통계 함수를 활용한 잘못된 쿼리문(성능이 좋지 않음)
SELECT position AS 직급, COUNT(*) AS 사원수
  FROM tbl_employee -- sampling 데이터
 GROUP BY position -- sampling 전체 데이터를 조회하여 GROUP을 진행하여 성능이 좋지 않음
 HAVING position = '과장'; 
 
 /* ORDER BY 절 공부하기 */
 
 -- 20. 사원 명 순으로 사원 조회하기
 -- ASCending : 오름차순 정렬 (adc,가나다), 디폴트 값
 -- DESCending : 내림차순 정렬
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 ORDER BY emp_name ASC; 
 
-- 21. 직급의 오름차순, 동일 직급은 고용일의 내림차순으로 정렬
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 ORDER BY position, hire_date DESC; -- = position ASC, hire_date DESC; (ASC는 디폴트 값으로 생략)

/* LIMIT 절 공부하기 */
-- 일반적 패턴 : 원하는 기준으로 정렬한 뒤 일부만 조회
-- 22. 가장 먼저 입사한 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 ORDER BY hire_date -- 입사 순 오름차순 정렬
 LIMIT 0,1; -- 첫 번째 행(0)부터 1개 행 조회 (= LIMIT 1;)

-- 23. 연봉이 2~3번째로 높은 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 ORDER BY salary DESC -- 연봉 순 내림차순 정렬
 LIMIT 1,2; -- 두 번째 행(1)부터 2개 행 조회
 
 
 
 
 